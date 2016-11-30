--[[
	Expo (E3) LUA script
--]]


-- Global instance
luaExpo = {};


function luaExpo:IsServerModeExpo()
	return (gamefunc:IsServerModeExpo());
end

function luaExpo:OnGameEvent( strMsg, sParam, nParam1, nParam2)

	if (gamefunc:IsServerModeExpo() == false) then
		return
	end

	-- UI event
	if ( strMsg == "UI")  then
		if ( sParam == "LOADED")  then
			luaExpo:RefreshMiniMapRefreshField();
		end
	-- Party
	elseif ( strMsg == "PARTY" )  then				luaExpo:OnEventParty( sParam, nParam1, nParam2)

	-- Interaction
	elseif ( strMsg == "INTERACTION_PC")  then		luaExpo:OnEventInteractionPC( sParam, nParam1, nParam2);
	-- 	

	end
end






-- OnEventParty
function luaExpo:OnEventParty( sParam, nParam1, nParam2)

	-- sParam : REFRESH, INVITED
	
	if ( sParam == "REFRESH")  then
		luaExpo:RefreshParty();
	elseif ( sParam == "INVITED")  then
	
		
	elseif ( sParam == "CANCELED")  then

	end

	return true;
end

function luaExpo:RefreshParty()

	if (gamefunc:IsServerModeExpo() == false) then
		return
	end

	btnDisbandPartyMember:Enable( false);
	btnPartySetting:Enable( false);
	btnLeaveParty:Enable( false);

end

-- Quest
-- OnEventQuest
function luaExpo:OnEventQuest( sParam, nParam1, nParam2)

	if (gamefunc:IsServerModeExpo() == false) then
		return
	end
	
	luaExpo:RefreshQuest();
end

function luaExpo:RefreshQuest()

	if (gamefunc:IsServerModeExpo() == false) then
		return
	end

	btnShareQuest:Enable( false);
	btnGiveupQuest:Enable( false);

end


-- OnEventInteractionPC
function luaExpo:OnEventInteractionPC( sParam, nParam1, nParam2)

	if (gamefunc:IsServerModeExpo() == false) then
		return
	end

	-- sParam : BEGIN, END
	
	if ( sParam == "BEGIN")  then
		luaExpo:RefreshInteractionPc();
	elseif ( sParam == "END")  then
	end
	
	return true;
end



-- RefreshInteraction
-- luaInteractionPc:RefreshInteractionPc() 에서 복사해서 사용
function luaExpo:RefreshInteractionPc()

	if (gamefunc:IsServerModeExpo() == false) then
		return
	end

	if ( frmInteractionPc:GetShow() == false)  then  return;
	end
	

	-- Message
	local strName = gamefunc:GetInteractionPlayerName();
	frmInteractionPc:SetText( strName);
	
	local strMessage = "{INDENT}{ALIGN ver=\"center\"}" .. STR( "UI_INTERACTIONPC_WELCOME") .. "\n{CR h=12}{BITMAP name=\"bmpHorizonBar\" w=390 h=3}{CR h=10}{COLOR r=180 g=140 b=80}{SECONDENT dent=10}";
	
	if (gamefunc:IsCurrentPvPField() ~= true ) then
		strMessage = strMessage .. "{REF text=\"menu://challenge_to_duel\"}{BITMAP name=\"iconAnswer\" w=14 h=14}" .. STR( "UI_INTERACTIONPC_REQUESTDUEL") .. "{/REF}\n";
		
		if (gamefunc:AmIPartyLeader() == true) and (gamefunc:IsInteractionPlayerPartyLeader() == true) then
			strMessage = strMessage .. "{REF text=\"menu://challenge_to_partyduel\"}{BITMAP name=\"iconAnswer\" w=14 h=14}" .. STR( "UI_INTERACTIONPC_REQUESTPARTYDUEL") .. "{/REF}\n";
		end
	end
		
	tvwInteractionPc:SetText( strMessage);
	
	
	-- Resize frame
	local x, y = tvwInteractionPc:GetPosition();
	local w, h = tvwInteractionPc:GetPageSize();
	h = math.min( 500,  y + h);
	frmInteractionPc:SetSize( frmInteractionPc:GetWidth(), h);
end

-- RefreshRebirth
function luaExpo:RefreshRebirth()

	luaRebirth.nItemCount = 1;
	
	pnlNearSoulBinding:Show( false);
	pnlSoulBinding:Show( false);
	pnlSafetyZone:Show( false);
	
	pnlCurrentPosition:Show( true);
	pnlCurrentPosition:SetPosition( 10, luaRebirth.HEIGHT_POSITION[ luaRebirth.nItemCount]);
	
	-- Set marker
	luaRebirth.m_nCurSelRebirth = pnlCurrentPosition;
	
	local x, y, w, h = luaRebirth.m_nCurSelRebirth:GetRect();
	boxSelMarkerRebirth:SetRect( x, y, w, h);

	-- Reposition
	local x, y = btnRebirth:GetPosition();
	y = luaRebirth.HEIGHT_POSITION[ luaRebirth.nItemCount] + 100;
	btnRebirth:SetPosition( x, y);

	
	local w, h = frmRebirth:GetSize();
	h = luaRebirth.HEIGHT_POSITION[ luaRebirth.nItemCount] + 100 + 45;
	frmRebirth:SetSize( w, h);
	
end


function luaExpo:OnClickRebirthBtn()
	gamefunc:RequireRebirth( 5);
end



function luaExpo:RefreshMiniMapRefreshField()
	if (gamefunc:IsServerModeExpo() == false) then
		return
	end
	
	pnlChannel:Show(false);
end
