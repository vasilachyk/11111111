--[[
	Game randombox_effect LUA script
--]]


luaRandomBoxEffect = {};

luaRandomBoxEffect.nSlotIndex = -1;
luaRandomBoxEffect.nRandomBoxID = 0;
luaRandomBoxEffect.nShowItemIndex = 0;
luaRandomBoxEffect.nItemResetTimeMs = 0;
luaRandomBoxEffect.nItemResetSoundTimeMs = 0;
luaRandomBoxEffect.nShowResultFrameTimeMs = 0;
luaRandomBoxEffect.m_fProgressTimer = 0.0;
luaRandomBoxEffect.bShowResultFrame = false;


-- OnShowInventoryFrame
function luaRandomBoxEffect:OpenRandomBox(nIndex)

	if (frmRandomBoxEffect:GetShow() == true) then	return;
	end

	if (gamefunc:IsMyActionIdle() == false) then	return;
	end

	if(gamefunc:IsArenaField() == true) then
		luaGame:OnEventChattingMsg( STR( "ARENA_CANNOT_USE_ITEM" ), CHATFILTER_TYPE.SYSTEM );
		return;
	end

	if ( nIndex < 0)  then  return;
	end

	local nID = gamefunc:GetInvenItemID( nIndex);
	if ( nID <= 0)  then  return;
	end

	local nUsableType = gamefunc:GetItemUsableType( nID);
	if ( nUsableType ~= USABLE_TYPE.RANDOM_BOX)  then	return;
	end


	-- 아이템 사용 레벨 제한
	local nReqLevel = gamefunc:GetItemEquipReqLevel( nID);
	if ( nReqLevel > 0)  and  ( gamefunc:GetLevel() < nReqLevel) then
		luaGame:OnEventChattingMsg( STR( "UI_TOOLTIP_INVALIDLEVELUSABLE" ), CHATFILTER_TYPE.SYSTEM );
		return;
	end


	if(gamefunc:IsRandomBoxEffect(nID) == true) then
		
		luaRandomBoxEffect.nSlotIndex = nIndex;
		luaRandomBoxEffect.nRandomBoxID = nID;
		luaRandomBoxEffect.nShowItemIndex = 0;
		luaRandomBoxEffect.nItemResetTimeMs = gamefunc:GetUpdateTime();
		luaRandomBoxEffect.nItemResetSoundTimeMs = gamefunc:GetUpdateTime();
		frmRandomBoxEffect:SetText(gamefunc:GetItemName(nID));
		luaRandomBoxEffect.m_fProgressTimer = gamefunc:GetUpdateTime();
		picRandomBoxItemHide1:SetOpacity(0.0);
		picRandomBoxItemHide2:SetOpacity(0.0);
		picRandomBoxItemShape:SetOpacity( 1.0);
		picRandomBoxItemImg:SetOpacity( 1.0);
		tvwRandomBoxItemName:SetOpacity( 1.0);
		lcRandomBoxResult:DeleteAllItems();
		lcRandomBoxResult:SetSize(380, 6);
		
		gamefunc:PlaySound( "randombox_process");

		local w, h = frmRandomBoxEffect:GetSize();
		local width, height = gamefunc:GetWindowSize();
		frmRandomBoxEffect:SetPosition( width*0.5 - w*0.5, height*0.5 - h*0.5);
		frmRandomBoxEffect:DoModal();
		frmRandomBoxResult:Show( false);
		pcRandomBoxProgress:Show(true);
	else
		luaRandomBoxEffect.nRandomBoxID = nID;
		gamefunc:UseInvenItem( nIndex);
	end
end

function luaRandomBoxEffect:UpdateRandomBoxEffect()

	local nID = gamefunc:GetInvenItemID( luaRandomBoxEffect.nSlotIndex);
	if ( nID <= 0 or nID ~= luaRandomBoxEffect.nRandomBoxID)  then
		pcRandomBoxProgress:Show(false);
		frmRandomBoxEffect:Show(false);
	end

	local nItemTotalCount = gamefunc:GetRandomBoxItemCount( luaRandomBoxEffect.nRandomBoxID);
	
	if( gamefunc:GetUpdateTime() - luaRandomBoxEffect.nItemResetSoundTimeMs > 120 ) then
		gamefunc:PlaySound( "randombox_process");
		luaRandomBoxEffect.nItemResetSoundTimeMs = gamefunc:GetUpdateTime();
	end
	
	if( gamefunc:GetUpdateTime() - luaRandomBoxEffect.nItemResetTimeMs > 60) then
		
		luaRandomBoxEffect.nItemResetTimeMs = gamefunc:GetUpdateTime();
		luaRandomBoxEffect.nShowItemIndex = luaRandomBoxEffect.nShowItemIndex + 1;
		
		if( luaRandomBoxEffect.nShowItemIndex >= nItemTotalCount) then
			luaRandomBoxEffect.nShowItemIndex = 0;
		end
	end
	

	local nTime = gamefunc:GetUpdateTime() - luaRandomBoxEffect.m_fProgressTimer;
	local fOpacity = (nTime - 4800) * 0.007;
	picRandomBoxItemHide1:SetOpacity(math.min( 0.8, fOpacity * 0.8));

	fOpacity = (nTime - 3500) * 0.0007;
	picRandomBoxItemHide2:SetOpacity(math.min( 0.8, fOpacity * 0.8));


	fOpacity = 1.0 - math.max( 0.0, (nTime - 3500) * 0.0007);
	picRandomBoxItemShape:SetOpacity(fOpacity);
	picRandomBoxItemImg:SetOpacity(fOpacity);
	tvwRandomBoxItemName:SetOpacity(fOpacity);


	local nItemID = gamefunc:GetRandomBoxItemIDWithIndex( luaRandomBoxEffect.nRandomBoxID, luaRandomBoxEffect.nShowItemIndex);
	local strItemName = "{FONT name=\"fntRegular\"}{ALIGN hor=\"center\" ver=\"center\"}" .. GetItemColorStr( nItemID ) .. gamefunc:GetItemName( nItemID ) .. "{/COLOR}";
	picRandomBoxItemImg:SetImage(gamefunc:GetItemImage(nItemID));
	tvwRandomBoxItemName:SetText(strItemName);

end

function luaRandomBoxEffect:OnUpdateRandomBoxProgress()
	
	local nPos = gamefunc:GetUpdateTime() - luaRandomBoxEffect.m_fProgressTimer;
	pcRandomBoxProgress:SetPos( nPos);

	if ( nPos >= 5000)  then
		pcRandomBoxProgress:Show(false);

	local nID = gamefunc:GetInvenItemID( luaRandomBoxEffect.nSlotIndex);
	if ( nID <= 0 or nID ~= luaRandomBoxEffect.nRandomBoxID)  then
		frmRandomBoxEffect:Show(false);
		return;
	end

		luaRandomBoxEffect.bShowResultFrame = true;
		gamefunc:UseInvenItem( luaRandomBoxEffect.nSlotIndex);
	end
end


function luaRandomBoxEffect:ShowRandomBoxResultFrame()
	
	if(gamefunc:IsRandomBoxEffect(luaRandomBoxEffect.nRandomBoxID) == false) then	return;
	end

	frmRandomBoxEffect:Show( false);

	gamefunc:PlaySound( "randombox_open");
	local w, h = frmRandomBoxResult:GetSize();
	local width, height = gamefunc:GetWindowSize();
	frmRandomBoxResult:SetPosition( width*0.5 - w*0.5, height*0.5 - h*0.5);
	frmRandomBoxResult:Show(true);
	picRandomBoxResultHide1:SetOpacity(0.8);
	picRandomBoxResultHide2:SetOpacity(0.8);
	lcRandomBoxResult:SetOpacity(0.0);
	tvwRandomBoxResult:SetOpacity(0.0);
	luaRandomBoxEffect.nShowResultFrameTimeMs = gamefunc:GetUpdateTime();
end

function luaRandomBoxEffect:UpdateRandomBoxResultEffect()
	
	local nTime = gamefunc:GetUpdateTime() - luaRandomBoxEffect.nShowResultFrameTimeMs;
	local fOpacity = 1.2 - nTime * 0.001;
	picRandomBoxResultHide1:SetOpacity(math.min( 0.8, fOpacity * 0.8));

	local fOpacity = 1.2 - nTime * 0.0007;
	picRandomBoxResultHide2:SetOpacity(math.min( 0.8, fOpacity * 0.8));


	fOpacity = nTime * 0.0007 - 0.1;
	lcRandomBoxResult:SetOpacity(math.min( 1.0, fOpacity));
	tvwRandomBoxResult:SetOpacity(math.min( 1.0, fOpacity));
end

function luaRandomBoxEffect:EndAddRandomBoxResultItem()

	luaRandomBoxEffect.bShowResultFrame = false;
	frmRandomBoxEffect:Show( false);
end


function luaRandomBoxEffect:AddRandomBoxItem(nSlotID, nQuantity)

	if(luaRandomBoxEffect.bShowResultFrame == false) then	return;
	end

	local nID = gamefunc:GetInvenItemID( nSlotID);
	if ( nID <= 0)  then  return false;
	end

	if(luaRandomBoxEffect:CheckRandomBoxItem(nID) == false) then	return;
	end

	local strName = gamefunc:GetItemName( nID);
	local strImage = gamefunc:GetItemImage( nID);
	if ( strImage == nil)  or  ( strImage == "")  then  strImage = "iconUnknown"
	end

	local nIndex = lcRandomBoxResult:AddItem( strName, strImage);
	local r, g, b = GetItemColor(nID);
	lcRandomBoxResult:SetItemColor(nIndex, 0, r, g, b);

	lcRandomBoxResult:SetItemText( nIndex, 1, STR( "QUANTITY") .. " : " .. nQuantity);
	lcRandomBoxResult:SetItemData( nIndex, nID);
	lcRandomBoxResult:SetItemColor(nIndex, 1, 128, 128, 128);
		
	local strTier = GetItemTierString( nID);
	lcRandomBoxResult:SetItemText( nIndex, 2, strTier);
	lcRandomBoxResult:SetItemColor(nIndex, 2, r, g, b);


	local w, h = lcRandomBoxResult:GetSize();
	lcRandomBoxResult:SetSize(w, math.min( 96, h+45));

end

function luaRandomBoxEffect:CheckRandomBoxItem(nID)

	local nItemTotalCount = gamefunc:GetRandomBoxItemCount( luaRandomBoxEffect.nRandomBoxID);

	for  i = 0, (nItemTotalCount - 1)  do
		
		local nItemID = gamefunc:GetRandomBoxItemIDWithIndex( luaRandomBoxEffect.nRandomBoxID, i);
		if(nItemID == nID) then
			return true;
		end
	end

	return false;
end

function luaRandomBoxEffect:OnToolTipRandomBoxResultCtrl()
	
	local strToolTip = "";

	local nCurSel = lcRandomBoxResult:GetMouseOver();
	if ( nCurSel >= 0)  then

		local nID = lcRandomBoxResult:GetItemData( nCurSel);
		if ( nID > 0)  then
			strToolTip = luaToolTip:GetItemToolTip( nID, nil, nil);
		end
	end
	
	lcRandomBoxResult:SetToolTip( strToolTip);
end
	