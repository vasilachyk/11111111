--[[
	Game PopupHelp LUA script
--]]


-- Global instance
luaPopupHelp	= {};

-- Variables PopupHelp
luaPopupHelp.m_nHelpID			= 0;
luaPopupHelp.FIRSTHEIGHT		= 45;
luaPopupHelp.STATE				= { NONE = 0, EXPAND = 1, SHOW = 2, HIDE = 3 }
luaPopupHelp.m_nState			= luaPopupHelp.STATE.NONE;
luaPopupHelp.m_nWidth			= 0;
luaPopupHelp.m_nHeight			= 0;
luaPopupHelp.m_nUpdateTimer		= 0;
luaPopupHelp.m_MessageBuffer	= {};
luaPopupHelp.m_strHelpType		= {};

-- OpenPopupHelpFrame
function luaPopupHelp:OpenPopupHelpFrame( strHelpType, nHelpID )

	-- ID 검사
	if( 0 == nHelpID )	then return;
	end
	
	-- ID 중복검사
	if( nHelpID == luaPopupHelp.m_nHelpID )		then return ;
	end
	
	-- 이미 다른게 떠있으면 없애고
	if( luaPopupHelp.STATE.NONE ~= luaPopupHelp.m_nState )	then
		luaPopupHelp:KillPopupHelpFrame();
	end
	
	luaPopupHelp.m_nHelpID		= nHelpID;
	
	-- String Setting
	tvwPopupHelpMsg:SetOpacity( 0.0 );
	local strMsg = "{FONT name=\"fntScriptStrong\"}{COLOR r=240 g=240 b=240}" .. gamefunc:GetHelpMsg( luaPopupHelp.m_nHelpID );
	tvwPopupHelpMsg:SetText( strMsg );
	

	-- Size 계산
	local sw, sh = pnlPopupHelpFrame:GetSize();
	local tw, th = tvwPopupHelpMsg:GetSize();
	local pw, ph = tvwPopupHelpMsg:GetPageSize();
	ph = math.max( ph, 80);
	
	luaPopupHelp.m_nState = luaPopupHelp.STATE.EXPAND;
	luaPopupHelp.m_nWidth = 400;
	luaPopupHelp.m_nHeight = ph + ( sh - th );
	luaPopupHelp.m_nUpdateTimer = gamefunc:GetUpdateTime();

	pnlPopupHelpFrame:SetSize( luaPopupHelp.m_nWidth, luaPopupHelp.FIRSTHEIGHT );
	pnlPopupHelpFrame:SetOpacity( 0.0 );
	pnlPopupHelpFrame:Show( true );
	
	-- Help Type에 따른 위치 조정
	luaPopupHelp.m_strHelpType	= strHelpType;
	
	local px, py;
	local wh	= gamefunc:GetWindowHeight();
	px			= 0;
	py			= wh * 0.2;
	
	pnlPopupHelpFrame:SetPosition( px, py );
	
	-- Timer
	local Timer		= gamefunc:GetHelpTimer( luaPopupHelp.m_nHelpID );
	if( 0 ~= Timer )	then
		pnlPopupHelpFrame:SetTimer( Timer, 0);
	end
	
end


-- ClosePopupHelpFrame
function luaPopupHelp:ClosePopupHelpFrame()

	if ( luaPopupHelp.m_nState == luaPopupHelp.STATE.HIDE )  then  return;
	end
	
	luaPopupHelp.m_nState = luaPopupHelp.STATE.HIDE;
	luaPopupHelp.m_nUpdateTimer = gamefunc:GetUpdateTime();
	
	pnlPopupHelpFrame:KillTimer();
end


-- FinishPopupHelpFrame
function luaPopupHelp:FinishPopupHelpFrame()

	local nID						= luaPopupHelp.m_nHelpID;
	
	pnlPopupHelpFrame:Show( false);
	luaPopupHelp.m_nState			= luaPopupHelp.STATE.NONE;
	luaPopupHelp.m_nHelpID			= 0;
	luaPopupHelp.m_nWidth			= 0;
	luaPopupHelp.m_nHeight			= 0;
	luaPopupHelp.m_nUpdateTimer		= 0;
					
	if ( table.getn( luaPopupHelp.m_MessageBuffer) > 0)  then
		luaPopupHelp:OpenPopupHelpFrame( luaPopupHelp.m_MessageBuffer[ 1]);
		table.remove( luaPopupHelp.m_MessageBuffer, 1);
	end
	
	-- Game에 종료 알려주기
	gamefunc:FinishedHelp( nID );
end


-- KillPopupHelpFrame
function luaPopupHelp:KillPopupHelpFrame()

	if ( luaPopupHelp.m_nState ~= luaPopupHelp.STATE.EXPAND)  then  return;
	end
	
	pnlPopupHelpFrame:Show( false);
	luaPopupHelp.m_nState = luaPopupHelp.STATE.NONE;
			
	pnlPopupHelpFrame:KillTimer();
end



-- OnShowPopupHelpFrame
function luaPopupHelp:OnShowPopupHelpFrame()

	-- Hide
	if ( pnlPopupHelpFrame:GetShow() == false)  then  luaPopupHelp:ClosePopupHelpFrame();
	end
end

-- OnExpandPopupHelpFrame
function luaPopupHelp:OnExpandPopupHelpFrame()

	local w, h = pnlPopupHelpFrame:GetSize();
	local nElapsed = gamefunc:GetUpdateTime() - luaPopupHelp.m_nUpdateTimer;
	
	if ( nElapsed >= 1000)  then
	
		pnlPopupHelpFrame:SetOpacity( 1.0 );
		pnlPopupHelpFrame:SetSize( w, luaPopupHelp.m_nHeight );
		tvwPopupHelpMsg:SetOpacity( 0.7 );
		luaPopupHelp.m_nState = luaPopupHelp.STATE.SHOW;
		
	elseif ( nElapsed >= 800)  then
	
		pnlPopupHelpFrame:SetOpacity( 1.0);
		pnlPopupHelpFrame:SetSize( luaPopupHelp.m_nWidth, luaPopupHelp.m_nHeight);
		tvwPopupHelpMsg:SetOpacity( 0.7 * ( nElapsed - 800) / 200.0);
		
	elseif ( nElapsed >= 500 )  then
	
		pnlPopupHelpFrame:SetOpacity( 1.0);
		local fRatio = math.min( 1.0, (nElapsed - 500) / 200.0 );
		pnlPopupHelpFrame:SetSize( luaPopupHelp.m_nWidth, luaPopupHelp.FIRSTHEIGHT + (luaPopupHelp.m_nHeight - luaPopupHelp.FIRSTHEIGHT) * ( 1.0 - math.pow( 1.0 - fRatio, 3)) );
		
	else
	
		pnlPopupHelpFrame:SetOpacity( math.min( 1.0, nElapsed / 200.0));
		pnlPopupHelpFrame:SetSize( luaPopupHelp.m_nWidth * math.min( 1.0, nElapsed / 200.0), h);
		
	end
	
end

-- OnHidePopupHelpFrame
function luaPopupHelp:OnHidePopupHelpFrame()

	local w, h = pnlPopupHelpFrame:GetSize();
	local nElapsed = gamefunc:GetUpdateTime() - luaPopupHelp.m_nUpdateTimer;
	
	if ( nElapsed >= 500)  then
		
			luaPopupHelp:FinishPopupHelpFrame();
					
		elseif ( nElapsed >= 300)  then

			tvwPopupHelpMsg:SetOpacity( 0.0);
			pnlPopupHelpFrame:SetSize( luaPopupHelp.m_nWidth, luaPopupHelp.FIRSTHEIGHT);
			pnlPopupHelpFrame:SetOpacity( 1.0 - ( ( nElapsed - 300) / 200.0));

		elseif ( nElapsed >= 200)  then

			tvwPopupHelpMsg:SetOpacity( 0.0);
			pnlPopupHelpFrame:SetSize( luaPopupHelp.m_nWidth, luaPopupHelp.m_nHeight - (luaPopupHelp.m_nHeight - luaPopupHelp.FIRSTHEIGHT) * ( (nElapsed - 200) / 200.0));
			
		else
		
			tvwPopupHelpMsg:SetOpacity( 0.7 * ( 1.0 - ( nElapsed / 200.0)) );
		end

end

-- OnUpdatePopupHelpFrame
function luaPopupHelp:OnUpdatePopupHelpFrame()

	if ( luaPopupHelp.m_nState == luaPopupHelp.STATE.NONE)  then  return;
	end
	

	local w, h = pnlPopupHelpFrame:GetSize();
	local nElapsed = gamefunc:GetUpdateTime() - luaPopupHelp.m_nUpdateTimer;
	
	if ( luaPopupHelp.m_nState == luaPopupHelp.STATE.EXPAND)  then
	
		luaPopupHelp:OnExpandPopupHelpFrame();
		
	elseif ( luaPopupHelp.m_nState == luaPopupHelp.STATE.HIDE)  then
	
		luaPopupHelp:OnHidePopupHelpFrame();
		
	elseif ( luaPopupHelp.m_nState == luaPopupHelp.STATE.SHOW )  then
			
	end	
end


-- OnTimerPopupHelpFrame
function luaPopupHelp:OnTimerPopupHelpFrame()

	luaPopupHelp:ClosePopupHelpFrame();
end




