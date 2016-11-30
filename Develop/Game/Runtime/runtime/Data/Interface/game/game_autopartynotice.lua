--[[
	Game party LUA script
--]]


-- Global instance
luaAutoParty = {};
luaAutoParty.nQuestID = 0;			-- 센서의 퀘스트ID
luaAutoParty.bEnterSensor = false;	-- 센서 안이냐




function luaAutoParty:OpenAutoPartyNoticeFrame( nQuestID)

	luaAutoParty.nQuestID = nQuestID;
	luaAutoParty:AutoPartyNoticeFrameDesc(luaAutoParty.nQuestID);
	frmAutoPartyNotice:Show( true);
	frmAutoPartyNotice:SetTimer( 200, 0);
end




function luaAutoParty:AutoPartyNoticeFrameDesc(nQuestID)

	local strName = "[자동파티] " .. gamefunc:GetQuestName( nQuestID);
	local nState = gamefunc:GetAutoPartyState();


	local strString = "{ALIGN hor=\"center\"}{LINESPC spacing=2}{FONT name=\"fntScript\"}{COLOR r=230 g=230 b=230}" ..
						strName;
						
	if (nState == AUTOPARTY_STATE.AS_OFF) then
		strString = strString .. "   사용안함";
	elseif (nState == AUTOPARTY_STATE.AS_PAUSE) then
		strString = strString .. "   정지";
	elseif (nState == AUTOPARTY_STATE.AS_STANDBY) then
		strString = strString .. "   검색대기";
	elseif (nState == AUTOPARTY_STATE.AS_LOOKUP) then
		strString = strString .. "   검색중";
	end
	
	tvwAddPartyMemberMsg:SetText( strString);
end




function luaAutoParty:CloseAutoPartyNoticeFrame()

	frmAutoPartyNotice:Show( false);
	frmAutoPartyNotice:KillTimer();
end






function luaAutoParty:OnTimerAutoPartyNoticeFrame()
	luaAutoParty:AutoPartyNoticeFrameDesc(luaAutoParty.nQuestID)
end






function luaAutoParty:OnNcHitTestAutoPartyNoticeFrame()

	EventArgs.hittest = HITTEST.NOWHERE;
	
	local x, y, w, h = frmAutoPartyNotice:GetWindowRect();
	local px, py = gamefunc:GetCursorPos();
	
	if ( px >= x)  and  ( px < (x + w))  and  ( py >= y)  and  ( py < (y + h))  then

		EventArgs.hittest = HITTEST.CAPTION;
	end

	return true;
end




function luaAutoParty:EnterSensor(nParam1)

	gamefunc:PlaySound( "autoparty_in");

	luaAutoParty.bEnterSensor = true;
	luaAutoParty:OpenAutoPartyNoticeFrame( nParam1);
	
	if (gamefunc:IsPartyJoined() == false) or (gamefunc:AmIPartyLeader() == true)  then
		if (AUTOPARTY_STATE.AS_STANDBY == gamefunc:GetAutoPartyState()) then
			gamefunc:SetAutoPartyState(AUTOPARTY_STATE.AS_LOOKUP);
		end
	end
end




function luaAutoParty:LeaveSensor(nParam1)
	
	gamefunc:PlaySound( "autoparty_out");

	luaAutoParty.bEnterSensor = false;
	luaAutoParty:CloseAutoPartyNoticeFrame();
	
	if (gamefunc:IsPartyJoined() == false) or (gamefunc:AmIPartyLeader() == true)  then
		if (AUTOPARTY_STATE.AS_LOOKUP == gamefunc:GetAutoPartyState()) then
			gamefunc:SetAutoPartyState(AUTOPARTY_STATE.AS_STANDBY);
		end
	end
end