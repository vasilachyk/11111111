--[[
	Game AutoParty LUA script
--]]


-- Override base tray script instance
luaTrayAutoParty = luaTrayBase:new();

luaTrayAutoParty.m_nState = AUTOPARTY_STATE.AS_STANDBY;

function luaTrayAutoParty:OnDraw( _wnd)

	local x, y, w, h = _wnd:GetClientRect();
	local dx, sy, dw, dh = 0, 0, 64, 64;
	local nAniFrame = math.floor((gamefunc:GetUpdateTime() * 0.01) % 10);
	luaTrayAutoParty.m_nState = gamefunc:GetAutoPartyState();
	
	gamedraw:SetBitmap( "iconAutoPartyState" );
	
	local bSolo = gamefunc:IsPartyJoined();
	local bLeader = gamefunc:AmIPartyLeader();
	
	-- 솔로잉이나 파티장일경우
	if ( bSolo == false) or ( bLeader == true)  then
	
		if (luaTrayAutoParty.m_nState == AUTOPARTY_STATE.AS_LOOKUP) then
			dx, dy = 64*nAniFrame, 64;
		else
			dx, dy = 64*luaTrayAutoParty.m_nState, 0;
		end	

	-- 파티원일 경우
	else
		if (luaTrayAutoParty.m_nState == AUTOPARTY_STATE.AS_LOOKUP) then
		
			dx, dy = 64*nAniFrame, 192;
		else
			dx, dy = 64*luaTrayAutoParty.m_nState, 128;
		end	
	end
	
	gamedraw:DrawEx( x, y, w, h, dx, dy, dw, dh);
	
	
	
	-- 파티원일 경우
--	if (gamefunc:IsPartyJoined() == true) then
--		if (gamefunc:AmIPartyLeader() == false) then
--			
--			if (luaTrayAutoParty.m_nState == 2) and (luaAutoParty.bEnterSensor == true) then
--			
--				local nS = math.floor((gamefunc:GetUpdateTime() * 0.03) % 10);
--				gamedraw:DrawEx( x, y, w, h, 64*nS, 192, dw, dh);
--			else
--				gamedraw:DrawEx( x, y, w, h, 0+(64*luaTrayAutoParty.m_nState), 128, dw, dh);
--			end	
--			
--			return;
--		end
--	end
	
	-- 솔로잉이나 파티장일경우
--	if (luaTrayAutoParty.m_nState == 2) and (luaAutoParty.bEnterSensor == true) then
--	
--		local nS = math.floor((gamefunc:GetUpdateTime() * 0.03) % 10);
--		gamedraw:DrawEx( x, y, w, h, 64*nS, 64, dw, dh);
--	else
--		gamedraw:DrawEx( x, y, w, h, 0+(64*luaTrayAutoParty.m_nState), 0, dw, dh);
--	end	
end




function luaTrayAutoParty:OnClick( _wnd)

	if (gamefunc:IsPartyJoined() == true) and (gamefunc:AmIPartyLeader() == false) then return
	end
	
	luaTrayAutoParty.m_nState = (luaTrayAutoParty.m_nState + 1) % 4;
	
	if (luaTrayAutoParty.m_nState == AUTOPARTY_STATE.AS_PAUSE) then
	
		luaTrayAutoParty.m_nState = AUTOPARTY_STATE.AS_STANDBY;
		
		if (luaAutoParty.bEnterSensor == true) then
			luaTrayAutoParty.m_nState = AUTOPARTY_STATE.AS_LOOKUP;
		end
	elseif (luaTrayAutoParty.m_nState == AUTOPARTY_STATE.AS_STANDBY) then
	
		if (luaAutoParty.bEnterSensor == true) then
			luaTrayAutoParty.m_nState = AUTOPARTY_STATE.AS_LOOKUP;
		end
	elseif (luaTrayAutoParty.m_nState == AUTOPARTY_STATE.AS_LOOKUP) then
	
		luaTrayAutoParty.m_nState = AUTOPARTY_STATE.AS_OFF;
	end
	
	if (luaTrayAutoParty.m_nState == AUTOPARTY_STATE.AS_OFF) then
		btnAutoParty:SetCheck( gameoption:AutoPartyMatch( false ));
	else
		btnAutoParty:SetCheck( gameoption:AutoPartyMatch( true));
	end


	gamefunc:SetAutoPartyState(luaTrayAutoParty.m_nState);
end




function luaTrayAutoParty:OnEnter( _wnd)

	if (luaAutoParty.bEnterSensor == false) then
		luaAutoParty:OpenAutoPartyNoticeFrame(0);
	end
end




function luaTrayAutoParty:OnLeave( _wnd)

	if (luaAutoParty.bEnterSensor == false) then
		luaAutoParty:CloseAutoPartyNoticeFrame();
	end
end
