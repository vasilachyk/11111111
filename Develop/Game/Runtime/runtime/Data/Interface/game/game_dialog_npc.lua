--[[
	Game dialog with NPC LUA script
--]]


-- Global instance
luaDialogNpc = {};


-- Flag to maintain dialog state
luaDialogNpc.m_bContinuedNpcDialog = false;





-- OnShowDialogFrame
function luaDialogNpc:OnShowDialogNpcFrame()

	-- Show
	if ( frmDialogNpc:GetShow() == true)  then
	
		luaDialogNpc.m_bContinuedNpcDialog = false;
		
		luaDialogNpc:RefreshDialogNpc();
		

	-- Hide
   	elseif ( luaDialogNpc.m_bContinuedNpcDialog == false)  then
	
		gamefunc:RequestNpcInteractionEnd();
	end
	

	luaGame:ShowWindow( frmDialogNpc);
end





-- RefreshDialog
function luaDialogNpc:RefreshDialogNpc()

	if ( frmDialogNpc:GetShow() == false)  then  return;
	end
	
	
	-- Message
	local strName = gamefunc:GetNpcName();
	frmDialogNpc:SetText( strName);
		
	local strMessage = "{INDENT}{ALIGN ver=\"center\"}" .. gamefunc:GetNpcDialogMessage() .. "\n{CR h=12}{BITMAP name=\"bmpHorizonBar\" w=375 h=3}{CR h=10}{COLOR r=180 g=140 b=80}{SECONDENT dent=10}";
	for  i = 0, (gamefunc:GetCountNpcDialogAnswer() - 1)  do
	
		local strAnswer = gamefunc:GetNpcDialogAnswer( i);
		strMessage = strMessage .. "{REF text=\"answer://" .. i .. "\"}{BITMAP name=\"iconAnswer\" w=14 h=14}" .. strAnswer .. "{/REF}\n";
	end

	tvwDialgMessageNpc:SetText( luaGame:ConvertStrToDialogSentence( strMessage));
	
	
	-- Resize frame
	local sx, sy, sw, sh = frmDialogNpc:GetRect();
	local tw, th = tvwDialgMessageNpc:GetSize();
	local pw, ph = tvwDialgMessageNpc:GetPageSize();
	frmDialogNpc:SetRect( sx, sy, sw, math.min( 400, ph) + ( sh - th));
end





-- OnItemClickAnswer
function luaDialogNpc:OnItemClickAnswer()

	-- Get reference text
	local nItemIndex = EventArgs:GetItemIndex();
	if ( nItemIndex < 0)  then  return;
	end
	
	local strRefText = tvwDialgMessageNpc:GetRefText( nItemIndex);
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
			gamefunc:SelectNpcDialogAnswer( nIndex);
			
			luaDialogNpc.m_bContinuedNpcDialog = true;
			frmDialogNpc:Show( false);
		end
	end
end
