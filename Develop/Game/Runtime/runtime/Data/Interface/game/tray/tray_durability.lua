--[[
	Game messenger LUA script
--]]


-- Override base tray script instance
luaTrayDurability = luaTrayBase:new();


-- Item category
luaTrayDurability.m_ItemCategory = 
{
	ITEM_SLOT.BODY,
	ITEM_SLOT.HEAD,
	ITEM_SLOT.LEG,
	ITEM_SLOT.HANDS,
	ITEM_SLOT.FEET,
	ITEM_SLOT.FACE,
	ITEM_SLOT.RWEAPON,
	ITEM_SLOT.LWEAPON,
	ITEM_SLOT.RWEAPON2,
	ITEM_SLOT.LWEAPON2
};


-- Durability ratio
luaTrayDurability.m_fDurabilityRatio = 0.0;


-- Current item index
luaTrayDurability.m_ItemIndex = 0;


-- Timer
luaTrayDurability.m_Timer = 0;





-- OnUpdate
function luaTrayDurability:OnUpdate( _wnd)

	local nCurTime = gamefunc:GetUpdateTime();
	local nElapsed = nCurTime - luaTrayDurability.m_Timer;
	
	if ( nElapsed > 3000)  then
	
		local nIndex = 0;
	
		for  i, nSlot  in pairs( luaTrayDurability.m_ItemCategory)  do
		
			local nID = gamefunc:GetEquippedItemID( nSlot);
			if ( nID > 0)  then
			
				local nDurability = gamefunc:GetEquippedItemDurability( nSlot);
				local nMaxDurability = gamefunc:GetItemMaxDurability( nID);
				luaTrayDurability.m_fDurabilityRatio = nDurability / nMaxDurability;
				
				if ( luaTrayDurability.m_fDurabilityRatio < 0.2)  then
				
					if ( nIndex == 0)  then  nIndex = i;
					end
					
					if ( i > luaTrayDurability.m_ItemIndex)  then
				
						nIndex = i;
						break;
					end
				end
			end
		end
		
		
		luaTrayDurability.m_ItemIndex = nIndex;
		luaTrayDurability.m_Timer = nCurTime;
	end
end





-- OnDraw
function luaTrayDurability:OnDraw( _wnd)

	local x, y, w, h = _wnd:GetClientRect();
	
	-- Show item durability
	if ( luaTrayDurability.m_ItemIndex > 0)  then
	
		local nSlot = luaTrayDurability.m_ItemCategory[ luaTrayDurability.m_ItemIndex];
		local nID = gamefunc:GetEquippedItemID( nSlot);
		if ( nID > 0)  then
		
			local strImage = gamefunc:GetItemImage( nID);
			gamedraw:SetBitmap( strImage);

			local _col = math.min( 255, 255 + 128.0 * math.sin( gamefunc:GetUpdateTime() * 0.007));
			local _r, _g, _b, _a = gamedraw:SetBitmapColor( 255, _col, _col);
			gamedraw:Draw( x, y, w, h);
			gamedraw:SetBitmapColorEx( _r, _g, _b, _a);


			local nDurability = gamefunc:GetEquippedItemDurability( nSlot);
			local nMaxDurability = gamefunc:GetItemMaxDurability( nID);

			gamedraw:SetFont( "fntScriptStrong");
			gamedraw:SetColor( 255, 255, 255);
			gamedraw:SetTextAlign( "right", "bottom");
			gamedraw:TextEx( x, y, w - 2, h - 2, "/" .. nMaxDurability);

			gamedraw:SetColor( 255, 32, 0);
			gamedraw:SetTextAlign( "right", "bottom");
			gamedraw:TextEx( x, y, w - 2, h - 15, nDurability);
			
			return;
		end
	end
	
	gamedraw:SetBitmap( "iconDurability");
	gamedraw:Draw( x, y, w, h);
	
	gamedraw:SetBitmap( "bmpGauges");
	local _r, _g, _b, _a = gamedraw:SetBitmapColor( 0, 0, 0);
	gamedraw:DrawEx( x + 3, y + 3, w - 6, 4, 0, 40, 32, 20);
	gamedraw:SetBitmapColorEx( _r, _g, _b, _a);
	gamedraw:DrawEx( x + 3, y + 3, (w - 6) * luaTrayDurability.m_fDurabilityRatio, 4, 0, 40, 32, 20);
end





-- OnClick
function luaTrayDurability:OnClick( _wnd)

	local strString = "{FONT name=\"fntScript\"}";
	local nCount = 0;
	local nSumDurability = 0;
	local nSumMaxDurability = 0;
	
	for index, slot in pairs( luaTrayDurability.m_ItemCategory)  do
	
		local nID = gamefunc:GetEquippedItemID( slot);
		if ( nID > 0)  then
		
			local strName = gamefunc:GetItemName( nID);
			local strImage = gamefunc:GetItemImage( nID);
			local nDurability = gamefunc:GetEquippedItemDurability( slot);
			local nMaxDurability = gamefunc:GetItemMaxDurability( nID);
			
			strString = strString .. "{CR h=20}{/INDENT}{BITMAP name=\"" .. strImage .. "\" w=24 h=24}{CR h=0}" ..
				"{INDENT dent=25}" .. strName .. "{CR h=15}{FONT name=\"fntSmall\"}";
		
			local fDurabilityRatio = nDurability / nMaxDurability;
			if ( fDurabilityRatio < 0.2)  then			strString = strString .. "{COLOR r=230 g=0 b=0}";
			elseif ( fDurabilityRatio < 0.5)  then		strString = strString .. "{COLOR r=230 g=160 b=0}";
			end
			
			strString = strString .. nDurability .. "{/COLOR} / " .. nMaxDurability .. "  (" .. math.floor( fDurabilityRatio * 100.0) .. "%){/FONT}{SPACE w=100}";
		
		
			nCount = nCount + 1;
			nSumDurability = nSumDurability + nDurability;
			nSumMaxDurability = nSumMaxDurability + nMaxDurability;
		end
	end
	
	if ( nCount == 0)  then  return;
	end	
	

	-- Total durability
	local fSumDurabilityRatio = nSumDurability / nSumMaxDurability;
	if ( fSumDurabilityRatio < 0.2)  then			strString = strString .. "{COLOR r=230 g=0 b=0}";
	elseif ( fSumDurabilityRatio < 0.5)  then		strString = strString .. "{COLOR r=230 g=160 b=0}";
	end
	
	strString = nSumDurability .. "{/COLOR} / " .. nSumMaxDurability .. " (" .. math.floor( fSumDurabilityRatio * 100.0) .. "%){CR h=10}" .. strString;

	strString = "전체 내구도" .. " : " .. strString;



	tvwTrayDurability:SetText( strString);

	_wnd:TrackPopupMenu( "pmTrayDurabilityPopupMenu");
end





-- OnToolTip
function luaTrayDurability:OnToolTip( _wnd)

	if ( luaTrayDurability.m_ItemIndex > 0)  then	_wnd:SetToolTip( "수리가 필요한 아이템이 있습니다.");
	else											_wnd:SetToolTip( "내구도");
	end
end
