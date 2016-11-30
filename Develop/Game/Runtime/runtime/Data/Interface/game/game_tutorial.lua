--[[
	Game tutorial LUA script
--]]


-- Global instance
luaPopupTutorial	= {};

-- Variables PopupHelp
luaPopupTutorial.m_nHelpID			= 0;
luaPopupTutorial.STATE				= { NONE = 0, EXPAND = 1, SHOW = 2, HIDE = 3 }
luaPopupTutorial.m_nState			= luaPopupTutorial.STATE.NONE;
luaPopupTutorial.m_nWidth			= 0;
luaPopupTutorial.m_nHeight			= 0;
luaPopupTutorial.m_nUpdateTimer		= 0;
luaPopupTutorial.m_MessageBuffer	= {};
luaPopupTutorial.m_strHelpType		= {};
luaPopupTutorial.m_nExpandTime		= 500;
luaPopupTutorial.m_nHideTime		= 1000;

-- OpenPopupTutorialFrame
function luaPopupTutorial:OpenPopupTutorialFrame( strHelpType, nHelpID )

	-- ID 검사
	if( 0 == nHelpID )	then return;
	end
	
	-- ID 중복검사
	if( nHelpID == luaPopupTutorial.m_nHelpID )		then return ;
	end
	
	-- 이미 다른게 떠있으면 없애고
	if( luaPopupTutorial.STATE.NONE ~= luaPopupTutorial.m_nState )	then
		luaPopupTutorial:KillPopupTutorialFrame();
	end
	
	luaPopupTutorial.m_nHelpID		= nHelpID;
	
	-- String Setting
	tvwPopupTutorialMsg:SetOpacity( 0.0 );
	local strMsg = "{FONT name=\"fntBoldStrong\"}{COLOR r=255 g=255 b=255}" .. gamefunc:GetHelpMsg( luaPopupTutorial.m_nHelpID );
	tvwPopupTutorialMsg:SetText( strMsg );
	
	-- img Setting
	ImgTutorial:SetOpacity( 0.0 );
	ImgTutorial:SetText( gamefunc:GetHelpImg( luaPopupTutorial.m_nHelpID, 0 ) );
	ImgTutorial2:SetOpacity( 0.0 );
	ImgTutorial2:SetText( gamefunc:GetHelpImg( luaPopupTutorial.m_nHelpID, 1 ) );

	-- Size 계산
	local sw, sh = pnlPopupTutorialFrame:GetSize();
	local tw, th = tvwPopupTutorialMsg:GetSize();
	local pw, ph = tvwPopupTutorialMsg:GetPageSize();
	local iw, ih = ImgTutorial:GetSize();
	ph = math.max( ph, 80 );
	ph = math.max( ph, ih );
	
	luaPopupTutorial.m_nState = luaPopupTutorial.STATE.EXPAND;
	luaPopupTutorial.m_nWidth = sw;
	luaPopupTutorial.m_nHeight = sh;
	luaPopupTutorial.m_nUpdateTimer = gamefunc:GetUpdateTime();

	pnlPopupTutorialFrame:SetOpacity( 0.0);
	pnlPopupTutorialFrame:Show( true );
	
	-- Help Type에 따른 위치 조정
	luaPopupHelp.m_strHelpType	= strHelpType;
	local ww	= gamefunc:GetWindowWidth();
	local wh	= gamefunc:GetWindowHeight();
	local px, py;
	px	= ( ww - luaPopupTutorial.m_nWidth ) * 0.5;
	py	= wh * 0.6;
	
	pnlPopupTutorialFrame:SetPosition( px, py );
	
	-- Timer
	local Timer		= gamefunc:GetHelpTimer( luaPopupTutorial.m_nHelpID );
	if( 0 ~= Timer )	then
		pnlPopupTutorialFrame:SetTimer( Timer, 0);
	end
	
end


-- ClosePopupTutorialFrame
function luaPopupTutorial:ClosePopupTutorialFrame()

	if ( luaPopupTutorial.m_nState == luaPopupTutorial.STATE.HIDE )  then  return;
	end
	
	luaPopupTutorial.m_nState = luaPopupTutorial.STATE.HIDE;
	luaPopupTutorial.m_nUpdateTimer = gamefunc:GetUpdateTime();
	
	pnlPopupTutorialFrame:KillTimer();
end


-- FinishPopupTutorialFrame
function luaPopupTutorial:FinishPopupTutorialFrame()

	local nID						= luaPopupTutorial.m_nHelpID;
	
	pnlPopupTutorialFrame:Show( false);
	luaPopupTutorial.m_nState			= luaPopupTutorial.STATE.NONE;
	luaPopupTutorial.m_nHelpID			= 0;
	luaPopupTutorial.m_nWidth			= 0;
	luaPopupTutorial.m_nHeight			= 0;
	luaPopupTutorial.m_nUpdateTimer		= 0;
	
	ImgTutorial:SetText();
	ImgTutorial2:SetText();
					
	if ( table.getn( luaPopupTutorial.m_MessageBuffer) > 0)  then
		luaPopupTutorial:OpenPopupTutorialFrame( luaPopupTutorial.m_MessageBuffer[ 1]);
		table.remove( luaPopupTutorial.m_MessageBuffer, 1);
	end
	
	-- Game에 종료 알려주기
	gamefunc:FinishedHelp( nID );
	
end


-- KillPopupTutorialFrame
function luaPopupTutorial:KillPopupTutorialFrame()

	if ( luaPopupTutorial.m_nState ~= luaPopupTutorial.STATE.EXPAND)  then  return;
	end
	
	pnlPopupTutorialFrame:Show( false);
	luaPopupTutorial.m_nState = luaPopupTutorial.STATE.NONE;
			
	pnlPopupTutorialFrame:KillTimer();
end



-- OnShowPopupTutorialFrame
function luaPopupTutorial:OnShowPopupTutorialFrame()

	-- Hide
	if ( pnlPopupTutorialFrame:GetShow() == false)  then  luaPopupTutorial:ClosePopupTutorialFrame();
	end
end

-- OnExpandPopupTutorialFrame
function luaPopupTutorial:OnExpandPopupTutorialFrame()

	local nElapsed	= gamefunc:GetUpdateTime() - luaPopupTutorial.m_nUpdateTimer;
	local nOpacity	= 0;

	if( nElapsed < luaPopupTutorial.m_nExpandTime )		then
		nOpacity			= math.min( 1.0, nElapsed / luaPopupTutorial.m_nExpandTime );
	else
		nOpacity			= 1.0;
		luaPopupTutorial.m_nState = luaPopupTutorial.STATE.SHOW;
	end
	
	pnlPopupTutorialFrame:SetOpacity( nOpacity );
	pnlPopupTutorialFrame:SetOpacity( nOpacity );
	tvwPopupTutorialMsg:SetOpacity( nOpacity );
	ImgTutorial:SetOpacity( nOpacity );
	ImgTutorial2:SetOpacity( nOpacity );
	
end

-- OnHidePopupTutorialFrame
function luaPopupTutorial:OnHidePopupTutorialFrame()

	local nElapsed	= gamefunc:GetUpdateTime() - luaPopupTutorial.m_nUpdateTimer;
	local nOpacity	= 0;

	if( nElapsed < luaPopupTutorial.m_nHideTime )		then
		nOpacity			= 1.0 - math.min( 1.0, nElapsed / luaPopupTutorial.m_nExpandTime );
		pnlPopupTutorialFrame:SetOpacity( nOpacity );
		pnlPopupTutorialFrame:SetOpacity( nOpacity );
		tvwPopupTutorialMsg:SetOpacity( nOpacity );
		ImgTutorial:SetOpacity( nOpacity );
		ImgTutorial2:SetOpacity( nOpacity );
	else
		pnlPopupTutorialFrame:SetOpacity( 0 );
		pnlPopupTutorialFrame:SetOpacity( 0 );
		tvwPopupTutorialMsg:SetOpacity( 0 );
		ImgTutorial:SetOpacity( 0 );
		ImgTutorial2:SetOpacity( 0 );
		luaPopupTutorial:FinishPopupTutorialFrame();
	end

end

-- OnUpdatePopupTutorialFrame
function luaPopupTutorial:OnUpdatePopupTutorialFrame()

	if ( luaPopupTutorial.m_nState == luaPopupTutorial.STATE.NONE)  then  return;
	end
	
	local w, h = pnlPopupTutorialFrame:GetSize();
	local nElapsed = gamefunc:GetUpdateTime() - luaPopupTutorial.m_nUpdateTimer;
	
	if ( luaPopupTutorial.m_nState == luaPopupTutorial.STATE.EXPAND)  then
	
		luaPopupTutorial:OnExpandPopupTutorialFrame();
		
	elseif ( luaPopupTutorial.m_nState == luaPopupTutorial.STATE.HIDE)  then
	
		luaPopupTutorial:OnHidePopupTutorialFrame();
		
	elseif ( luaPopupTutorial.m_nState == luaPopupTutorial.STATE.SHOW )  then
			
	end	
end


-- OnTimerPopupTutorialFrame
function luaPopupTutorial:OnTimerPopupTutorialFrame()

	luaPopupTutorial:ClosePopupTutorialFrame();
end




--------------------------------------------------------------------------------------------
--[[
	Help Trigger Manager
--]]

luaTutorialHelpTrigger = {};
luaTutorialHelpTrigger.m_nLastDefSpentTP = 0;
luaTutorialHelpTrigger.m_nLastBerSpentTP = 0;
luaTutorialHelpTrigger.m_nLastCleSpentTP = 0;

function luaTutorialHelpTrigger:_InitSpentTP()

	gamefunc:HelpTriggerString("LevelUp");
end

-- OnLevelUp
function luaTutorialHelpTrigger:OnLevelUp()
	gamefunc:HelpTriggerString("LevelUp");
	gamefunc:HelpTrigger(112);		--			[튜토리얼 도움말] 레벨 업
	luaTutorialHelpTrigger.m_nLastDefSpentTP = gamefunc:GetSpentTalentPoint( TALENT_TYPE.DEFENDER);
	luaTutorialHelpTrigger.m_nLastBerSpentTP = gamefunc:GetSpentTalentPoint( TALENT_TYPE.BERSERKER);
	luaTutorialHelpTrigger.m_nLastCleSpentTP = gamefunc:GetSpentTalentPoint( TALENT_TYPE.CLERIC);

end

-- OnDie
function luaTutorialHelpTrigger:OnDie()

	gamefunc:HelpTriggerString("Die");
end

-- OnLearnTalent
function luaTutorialHelpTrigger:OnTrainTalent()
	local nDefenderSpentTP = gamefunc:GetSpentTalentPoint( TALENT_TYPE.DEFENDER);
	local nBerserkerSpentTP = gamefunc:GetSpentTalentPoint( TALENT_TYPE.BERSERKER);
	local nClericSpentTP = gamefunc:GetSpentTalentPoint( TALENT_TYPE.CLERIC);

	--local strString = string.format( "m_nLastDefSpentTP = %d , nDefenderSpentTP = %d", luaTutorialHelpTrigger.m_nLastDefSpentTP, nDefenderSpentTP);
	--gamedebug:Log(strString);
	
	-- Defender Style
	if (luaTutorialHelpTrigger.m_nLastDefSpentTP ~= nDefenderSpentTP) then
		if (nDefenderSpentTP == 5) then
			gamefunc:HelpTriggerString("Def_TP5");
		elseif (nDefenderSpentTP == 15) then
			gamefunc:HelpTriggerString("Def_TP15");
		elseif (nDefenderSpentTP == 30) then
			gamefunc:HelpTriggerString("Def_TP30");
		end
		
		luaTutorialHelpTrigger.m_nLastDefSpentTP = nDefenderSpentTP;
	end

	-- Berserker Style
	if (luaTutorialHelpTrigger.m_nLastBerSpentTP ~= nBerserkerSpentTP) then
		if (nBerserkerSpentTP == 5) then
			gamefunc:HelpTriggerString("Ber_TP5");
		elseif (nBerserkerSpentTP == 15) then
			gamefunc:HelpTriggerString("Ber_TP15");
		elseif (nBerserkerSpentTP == 30) then
			gamefunc:HelpTriggerString("Ber_TP30");
		end
		
		luaTutorialHelpTrigger.m_nLastBerSpentTP = nBerserkerSpentTP;
	end

	-- Cleric Style
	if (luaTutorialHelpTrigger.m_nLastCleSpentTP ~= nClericSpentTP) then
		if (nClericSpentTP == 5) then
			gamefunc:HelpTriggerString("Cle_TP5");
		elseif (nClericSpentTP == 15) then
			gamefunc:HelpTriggerString("Cle_TP15");
		elseif (nClericSpentTP == 30) then
			gamefunc:HelpTriggerString("Cle_TP30");
		end
		
		luaTutorialHelpTrigger.m_nLastCleSpentTP = nClericSpentTP;
	end
	
	
end
