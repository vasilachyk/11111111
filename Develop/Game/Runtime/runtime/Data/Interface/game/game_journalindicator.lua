--[[
	Game journal indicator panel LUA script
--]]


-- Global instance
luaJournalIndicator = {};





-- OnNcHitTestJournalIndicator
function luaJournalIndicator:OnNcHitTestJournalIndicator()

	local x, y, w, h = frmJournalIndicator:GetWindowRect();
	x = x + 5;
	y = y + 5;
	w = w - 10;
	h = h - 10;

	local px, py = gamefunc:GetCursorPos();
	if ( px >= x)  and  ( px < (x + w))  and  ( py >= y)  and  ( py < (y + h))  then

		EventArgs.hittest = HITTEST.CAPTION;
		return true;

	else

		EventArgs.hittest = HITTEST.NOWHERE;
	end

	return false;
end





-- RestoreUIPosition
function luaJournalIndicator:RestoreUIPosition()

	luaGame:RestoreUIPosition( frmJournalIndicator);
	
	local strName = frmJournalIndicator:GetName();
	local w, h = gamefunc:GetAccountParam( strName, "w"), gamefunc:GetAccountParam( strName, "h");
	if ( w == nil)  or  ( h == nil)  then  return;
	end
	
	w, h = tonumber( w), tonumber( h);
	frmJournalIndicator:SetSize( w, h);
end





-- RecordUIPosition
function luaJournalIndicator:RecordUIPosition()

	luaGame:RecordUIPosition( frmJournalIndicator);
	
	local strName = frmJournalIndicator:GetName();
	local w, h = frmJournalIndicator:GetSize();
	
	gamefunc:SetAccountParam( strName, "w", w);
	gamefunc:SetAccountParam( strName, "h", h);
end





-- OnLoadedJournalIndicator
function luaJournalIndicator:OnLoadedJournalIndicator()

	jiJournalIndicator:Clear();
	

	local nCount = gamefunc:GetJournalCount();
	
	for  i = 0, (nCount - 1)  do
	
		local nType = gamefunc:GetJournalType( i);
		local nID = gamefunc:GetJournalID( i);
		
		jiJournalIndicator:AddItem( nType, nID);
	end
end





-- OnItemRClickJournalIndicator
function luaJournalIndicator:OnItemRClickJournalIndicator()

	local nType, nID = jiJournalIndicator:GetFocused();
	if ( nType <= 0)  or  ( nID <= 0)  then  return;
	end
	
	luaJournal:DirectView( nType, nID);
end
