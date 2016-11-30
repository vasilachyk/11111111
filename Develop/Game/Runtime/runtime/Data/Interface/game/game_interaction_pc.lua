--[[
	Game interaction with PC LUA script
--]]


-- Global instance
luaInteractionPc = {};





-- OnShowInteractionPcFrame
function luaInteractionPc:OnShowInteractionPcFrame()

	-- Show
	if ( frmInteractionPc:GetShow() == true)  then
	
		luaInteractionPc:RefreshInteractionPc();
		
	-- Hide
	else
	
		gamefunc:ReleaseHoldMyCharacter();
	end
	
	
	luaGame:ShowWindow( frmInteractionPc);
end





-- RefreshInteraction
function luaInteractionPc:RefreshInteractionPc()

	if (luaExpo:IsServerModeExpo()) then
		luaExpo:RefreshInteractionPc();
		return;
	end

	if ( frmInteractionPc:GetShow() == false)  then  return;
	end
	

	-- Message
	local strName = gamefunc:GetInteractionPlayerName();
	frmInteractionPc:SetText( strName);
	
	local strMessage = "{INDENT}{ALIGN ver=\"center\"}" .. STR( "UI_INTERACTIONPC_WELCOME") .. "\n{CR h=12}{BITMAP name=\"bmpHorizonBar\" w=390 h=3}{CR h=10}{COLOR r=180 g=140 b=80}{SECONDENT dent=10}";
	--strMessage = strMessage .. "{REF text=\"menu://show_char_info\"}{BITMAP name=\"iconAnswer\" w=14 h=14}" .. STR( "UI_INTERACTIONPC_VIEWPLAYERINFO") .. "{/REF}\n";
	strMessage = strMessage .. "{REF text=\"menu://invite_to_party\"}{BITMAP name=\"iconAnswer\" w=14 h=14}" .. STR( "UI_INTERACTIONPC_INVITEPARTY") .. "{/REF}\n";
	strMessage = strMessage .. "{REF text=\"menu://invite_to_guild\"}{BITMAP name=\"iconAnswer\" w=14 h=14}" .. STR( "UI_INTERACTIONPC_INVITEGUILD") .. "{/REF}\n";
	strMessage = strMessage .. "{REF text=\"menu://request_to_trade\"}{BITMAP name=\"iconAnswer\" w=14 h=14}" .. STR( "UI_INTERACTIONPC_REQUESTTRADE") .. "{/REF}\n";
	
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





-- OnItemClickInteractionPc
function luaInteractionPc:OnItemClickInteractionPc()

	-- Get reference text
	local nItemIndex = EventArgs:GetItemIndex();
	if ( nItemIndex < 0)  then  return;
	end
	
	local strRefText = tvwInteractionPc:GetRefText( nItemIndex);
	if (strRefText == nil)  or  (strRefText == "")  then  return;
	end


	-- Get menu
	local _first, _end = string.find( strRefText, "://");
	if (_first == nil)  then  return;
	end
	
	local strType = string.sub( strRefText,  0, _first - 1);
	if ( strType ~= "menu")  then  return;
	end


	-- Play sound
	gamefunc:PlaySound( "button_agree");


	local strData = string.sub( strRefText, _end + 1, string.len( strRefText));
	
	--if ( strData == "show_char_info")  then			gamefunc:ShowCharacterInfo();
	if( strData == "invite_to_party")  then				gamefunc:InviteToParty();
	elseif( strData == "invite_to_guild")  then			gamefunc:InviteToGuild();
	elseif( strData == "request_to_trade")  then		gamefunc:RequestToTrade();
	elseif( strData == "challenge_to_duel")  then		gamefunc:ChallengeToDuel();
	elseif( strData == "challenge_to_partyduel")  then	gamefunc:ChallengeToPartyDuel();
	end

	frmInteractionPc:Show( false);
end
