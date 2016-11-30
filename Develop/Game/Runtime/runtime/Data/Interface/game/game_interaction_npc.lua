--[[
	Game interaction with NPC LUA script
--]]


-- Global instance
luaInteractionNpc = {};


-- Flag to maintain interaction state
luaInteractionNpc.m_bContinuedInteraction = false;





-- OnShowInteractionFrame
function luaInteractionNpc:OnShowInteractionNpcFrame()

	-- Show
	if ( frmInteractionNpc:GetShow() == true)  then
	
		luaInteractionNpc.m_bContinuedInteraction = false;
		
		luaInteractionNpc:RefreshInteractionNpc();


	-- Hide
   	else
   	
   		if ( luaInteractionNpc.m_bContinuedInteraction == false)  then  gamefunc:RequestNpcInteractionEnd();
   		end
	end
	
	
	luaGame:ShowWindow( frmInteractionNpc);
end





-- RefreshInteraction
function luaInteractionNpc:RefreshInteractionNpc()

	if ( frmInteractionNpc:GetShow() == false)  then  return;
	end
	

	-- Message
	local strName = gamefunc:GetNpcName();
	frmInteractionNpc:SetText( strName);
	
	local strMessage = "{INDENT}{ALIGN ver=\"center\"}" .. gamefunc:GetNpcWelcomeMsg() .. "\n{CR h=12}{BITMAP name=\"bmpHorizonBar\" w=390 h=3}{CR h=10}{COLOR r=180 g=140 b=80}{SECONDENT dent=10}";
	for  i = 0, (gamefunc:GetCountNpcAnswer() - 1)  do
	
		local strAnswer = gamefunc:GetNpcAnswer( i);
		strMessage = strMessage .. "{REF text=\"answer://" .. i .. "\"}{BITMAP name=\"iconAnswer\" w=14 h=14}" .. strAnswer .. "{/REF}\n";
	end
	
	tvwInteractionNpc:SetText( luaGame:ConvertStrToDialogSentence( strMessage));

	
	-- Resize frame
	local x, y = tvwInteractionNpc:GetPosition();
	local w, h = tvwInteractionNpc:GetPageSize();
	h = math.min( 500,  y + h);
	frmInteractionNpc:SetSize( frmInteractionNpc:GetWidth(), h);
end





-- OnItemClickInteractionNpc
function luaInteractionNpc:OnItemClickInteractionNpc()

	-- Get reference text
	local nItemIndex = EventArgs:GetItemIndex();
	if ( nItemIndex < 0)  then  return;
	end
	
	local strRefText = tvwInteractionNpc:GetRefText( nItemIndex);
	if (strRefText == nil)  or  (strRefText == "")  then  return;
	end


	-- Get answer
	local _first, _end = string.find( strRefText, "://");
	if (_first == nil)  then  return;
	end
	
	local strType = string.sub( strRefText,  0, _first - 1);
	local strData = string.sub( strRefText, _end + 1, string.len( strRefText));
	
	
	if ( strType == "answer")  then
	
		local nIndex = tonumber( strData);
		if ( nIndex >= 0)  then

			gamefunc:PlaySound( "button_agree");
			gamefunc:SelectNpcAnswer( nIndex);
			
			luaInteractionNpc.m_bContinuedInteraction = true;
			frmInteractionNpc:Show( false);
		end
	end
end
