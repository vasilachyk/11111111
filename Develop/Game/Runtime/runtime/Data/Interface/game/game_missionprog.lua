--[[
	Game mission progress LUA script
--]]


-- Global instance
luaMissionProgress = {};


-- Type of mission
luaMissionProgress.nType = MISSION_TYPE.NONE;


-- Parameters of mission
luaMissionProgress.nParam1 = 0;
luaMissionProgress.nParam2 = 0;





-- OpenMissionProgressFrame
function luaMissionProgress:OpenMissionProgressFrame( nType, nParam1, nParam2)

	luaMissionProgress.nType = nType;
	luaMissionProgress.nParam1 = nParam1;
	luaMissionProgress.nParam2 = nParam2;

	luaMissionProgress:RefreshMissionProgressMessage();
	

	frmMissionProgress:Show( true);
	frmMissionProgress:SetTimer( 200, 0);
end





-- CloseMissionProgressFrame
function luaMissionProgress:CloseMissionProgressFrame()

	if ( frmMissionProgress:GetShow() == false)  then  return
	end


	luaMissionProgress.nType = MISSION_TYPE.NONE;
	luaMissionProgress.nParam1 = 0;
	luaMissionProgress.nParam2 = 0;


	frmMissionProgress:Show( false);
	frmMissionProgress:KillTimer();
end





-- OnTimerMissionProgressFrame
function luaMissionProgress:OnTimerMissionProgressFrame()

	luaMissionProgress:RefreshMissionProgressMessage();
end





-- OnNcHitTestMissionProgressFrame
function luaMissionProgress:OnNcHitTestMissionProgressFrame()

	EventArgs.hittest = HITTEST.NOWHERE;
	
	local x, y, w, h = frmMissionProgress:GetWindowRect();
	local px, py = gamefunc:GetCursorPos();
	
	if ( px >= x)  and  ( px < (x + w))  and  ( py >= y)  and  ( py < (y + h))  then

		EventArgs.hittest = HITTEST.CAPTION;
	end

	return true;
end





-- RefreshMissionProgressMessage
function luaMissionProgress:RefreshMissionProgressMessage()

	local strTitle, strText;

	
	-- Compose text	
	if ( luaMissionProgress.nType == MISSION_TYPE.TIMELIMIT)  then			strTitle, strText = luaMissionProgress:GetTimeLimitText();
	elseif ( luaMissionProgress.nType == MISSION_TYPE.QUESTPVP)  then		strTitle, strText = luaMissionProgress:GetQuestPvpText();
	end
	
	local strString = "{ALIGN hor=\"center\"}{LINESPC spacing=2}{FONT name=\"fntScript\"}{COLOR r=230 g=230 b=230}" .. strTitle .. "{CR}{FONT name=\"fntHeadline\"}" .. strText;
	tvwMissionProgressMsg:SetText( strString);
end





-- GetTimeLimitText
function luaMissionProgress:GetTimeLimitText()

	local nRemained = math.max( 0, luaMissionProgress.nParam1 - gamefunc:GetUpdateTime());

	local nHour = math.floor( nRemained / 3600000);
	local nMin = math.floor( math.floor( nRemained / 60000) % 60);
	local nSec = math.floor( math.floor( nRemained / 1000) % 60);
		
	local strText;
	strText = string.format( "%d:%02d:%02d", nHour, nMin, nSec);

	if ( nRemained < 180000)  then  strText = "{COLOR r=255 g=60 b=60}" .. strText;
	end
		
	return STR( "UI_MISSIONPROG_REMAINEDTIME"), strText;
end





-- GetQuestPvpText
function luaMissionProgress:GetQuestPvpText()

	local strTeamName = gamefunc:GetPvpTeamName();
	local strText = "{ALIGN ver=\"bottom\"}{COLOR r=60 g=120 b=180}" .. luaMissionProgress.nParam1 .. "{/COLOR}{FONT name=\"fntRegularStrong\"} VS {/FONT}{COLOR r=160 g=60 b=60}" .. luaMissionProgress.nParam2;
	
	return strTeamName, strText;
end
