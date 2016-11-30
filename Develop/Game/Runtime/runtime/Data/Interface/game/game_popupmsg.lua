--[[
	Game Popup messagebox LUA script
--]]


-- Global instance
luaPopupMsg = {};


-- Variables
luaPopupMsg.STATE = { HIDE = 0, FADEIN = 1, SHOW = 2, FADEOUT = 3 }
luaPopupMsg.m_nState = luaPopupMsg.STATE.HIDE;
luaPopupMsg.m_nTimer = 0;
luaPopupMsg.m_cbClickCallback = nil;
luaPopupMsg.m_hBufferedWnd = nil;
luaPopupMsg.m_strBufferedMsg = nil;
luaPopupMsg.m_cbBufferedCallback = nil;






-- PopupMsg
function luaPopupMsg:PopupMsg( _wnd, strMsg, cbCallback)

	if ( _wnd == 0)  or  ( strMsg == nil)  or  ( string.len( strMsg) == 0)  then  return;
	end
	
	if ( _wnd:IsVisibled() == false)  then  return;
	end
	
	
	if ( tvwPopupMsg:GetShow() == true)  then
	
		luaPopupMsg.m_hBufferedWnd = _wnd;
		luaPopupMsg.m_strBufferedMsg = strMsg;
		luaPopupMsg.m_cbBufferedCallback = cbCallback;
		
		if ( luaPopupMsg.m_nState ~= luaPopupMsg.STATE.FADEOUT)  then
		
			tvwPopupMsg:KillTimer();

			luaPopupMsg.m_nState = luaPopupMsg.STATE.FADEOUT;
			luaPopupMsg.m_nTimer = gamefunc:GetUpdateTime();
		end
		
		return;
	end


	local nLifeTime = math.max( 3000, string.len( strMsg) * 100);	
	
	tvwPopupMsg:SetSize( 250, 100);
	tvwPopupMsg:SetText( strMsg);
	
	picPopupMsgTail:ResetRotate();


	local pw, ph = tvwPopupMsg:GetPageSize();
	pw = math.max( pw, 50);
	tvwPopupMsg:SetSize( pw, ph);
	
	local width, height = gamefunc:GetWindowWidth(), gamefunc:GetWindowHeight();
	local x, y, w, h = _wnd:GetWindowRect();
	local tw, th = picPopupMsgTail:GetSize();
	local tx, ty = x + ( w - tw) * 0.5, y + h + 3;
	
	if ( ( x + w * 0.5) > ( width * 0.66))  then		x = x + w - pw - 10;
	elseif ( ( x + w * 0.5) > ( width * 0.33))  then	x = x + ( w - pw) * 0.5;
	else												x = x + 10;
	end
	
	if ( ( y - ph) < 20)  then
		
		y = y + h + th + 3;
		
	else
		
		ty = y - th - 3;
		picPopupMsgTail:SetFlipVertical();

		y = y - ph - th - 3;
	end

	tvwPopupMsg:SetPosition( x, y);
	picPopupMsgTail:SetPosition( tx, ty);

	
	luaPopupMsg.m_nState = luaPopupMsg.STATE.FADEIN;
	luaPopupMsg.m_nTimer = gamefunc:GetUpdateTime();
	luaPopupMsg.m_cbClickCallback = cbCallback;
	
	tvwPopupMsg:SetOpacity( 0.0);
	tvwPopupMsg:Show( true);
	tvwPopupMsg:SetTimer( nLifeTime + 200);
	picPopupMsgTail:SetOpacity( 0.0);
	picPopupMsgTail:Show( true);
end





-- OnUpdatePopupMsg
function luaPopupMsg:OnUpdatePopupMsg()

	if ( luaPopupMsg.m_nState == luaPopupMsg.STATE.FADEIN)  then
	
		local fOpacity = ( gamefunc:GetUpdateTime() - luaPopupMsg.m_nTimer) / 200;
		tvwPopupMsg:SetOpacity( math.min( 1.0, fOpacity));
		picPopupMsgTail:SetOpacity( math.min( 1.0, fOpacity));
		
		if ( fOpacity > 1.0)  then  luaPopupMsg.m_nState = luaPopupMsg.STATE.SHOW;
		end

	elseif ( luaPopupMsg.m_nState == luaPopupMsg.STATE.FADEOUT)  then
	
		local fOpacity = 1.0 - ( gamefunc:GetUpdateTime() - luaPopupMsg.m_nTimer) / 200;
		tvwPopupMsg:SetOpacity( math.max( 0.0, fOpacity));
		picPopupMsgTail:SetOpacity( math.max( 0.0, fOpacity));
		
		if ( fOpacity < 0.0)  then
		
			luaPopupMsg.m_nState = luaPopupMsg.STATE.HIDE;
			tvwPopupMsg:Show( false);
			picPopupMsgTail:Show( false);
			
			if ( luaPopupMsg.m_hBufferedWnd ~= nil)  and  ( luaPopupMsg.m_strBufferedMsg ~= nil)  then

				luaPopupMsg:PopupMsg( luaPopupMsg.m_hBufferedWnd, luaPopupMsg.m_strBufferedMsg, luaPopupMsg.m_cbBufferedCallback);
				luaPopupMsg.m_hBufferedWnd = nil;
				luaPopupMsg.m_strBufferedMsg = nil;
				luaPopupMsg.m_cbBufferedCallback = nil;
			end
		end
	end
end





-- OnTimerPopupMsg
function luaPopupMsg:OnTimerPopupMsg()

	tvwPopupMsg:KillTimer();

	luaPopupMsg.m_nState = luaPopupMsg.STATE.FADEOUT;
	luaPopupMsg.m_nTimer = gamefunc:GetUpdateTime();
end
