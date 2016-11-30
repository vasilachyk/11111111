--[[
	Game Change Name LUA script
--]]


-- Global instance
luaChangeName = {};
luaChangeName.nSlotIndex = -1;
luaChangeName.szName = "";



function luaChangeName:OnShowfrmChangeNameCheck(nIndex)

	if (nIndex < 0) then return
	end

	luaChangeName.nSlotIndex = nIndex;	

	local w, h = frmConfirmCheckChangeName:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmConfirmCheckChangeName:SetPosition( (width - w) * 0.5, (height - h) * 0.5);
	frmConfirmCheckChangeName:DoModal();
	
end





function luaChangeName:CloseConfirmCheckChangeName()

	frmConfirmCheckChangeName:Show(false);
	
end





function luaChangeName:OnCheckChangeNameOK()

	luaChangeName:CloseConfirmCheckChangeName();
	
	luaChangeName:OnShowfrmChangeName();
end





function luaChangeName:OnShowfrmChangeName()

	local w, h = frmChangeName:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmChangeName:SetPosition( (width - w) * 0.5, (height - h) * 0.5);
	frmChangeName:DoModal();
	
	edtCharacterName:SetText( "");
	edtCharacterName:SetFocus();
	
	tvwAvableUserName:SetText("");
	btnChangeNameOK:Enable(false);	
end




function luaChangeName:CheckCharacterNameValidate()

	local strName = edtCharacterName:GetText();
	local bValidate = gamefunc:IsValidateCharName( strName);

	if ( bValidate == true)  then
	
		btnDuplicate:Enable(true);	
		
	else
	
		btnDuplicate:Enable(false);	
	
	end

	local strString = "{ALIGN hor=\"right\" ver=\"center\"}{BITMAP name=\"iconDefExclamation\" w=16 h=16}{SPACE w=5 h=23}{CR h=0}{ALIGN hor=\"left\"}{SPACE w=5 h=23}";
	if ( edtCharacterName:IsFocus() == true)  then
	
		if ( bValidate == true)  then
		
			twvCharacterNameValidate:Show( false);
		
		else
		
			twvCharacterNameValidate:Show( true);
			twvCharacterNameValidate:SetText( strString);
		
		end
		
	else
	
		if ( bValidate == true)  then
		
			twvCharacterNameValidate:Show( false);
			
		elseif ( strName == "")  then
			
			twvCharacterNameValidate:Show( true);
			twvCharacterNameValidate:SetText( strString .. "{FONT name=\"fntScript\"}{COLOR r=128 g=0 b=0}" .. STR( "UI_SELCHAR_ENTERNAME"));
			
		else
		
			twvCharacterNameValidate:Show( true);
			twvCharacterNameValidate:SetText( strString);
		end
	end
end




function luaChangeName:FindMatchUser(strName)

	local bValidate = gamefunc:IsValidateCharName( strName);
	if ( bValidate == false) then
		tvwAvableUserName:SetText(STR("UI_CASHSHOP_MATCH_USER"));
		return;
	end

	gamefunc:FindMatchUser(strName);
end




function luaChangeName:RefreshMatchUser(sParam1, nParam2)

	if ( nParam2 == 1)  then
		tvwAvableUserName:SetText(STR("UI_CHANGENAME_DISUSABLE"));
		btnChangeNameOK:Enable(false);
		
	elseif ( nParam2 == 0)  then
	
		tvwAvableUserName:SetText(STR("UI_CHANGENAME_USABLE"));
		btnChangeNameOK:Enable(true);
		
	end
end




function luaChangeName:OnOK()

	local strName = edtCharacterName:GetText()
	local bValidate = gamefunc:IsValidateCharName( strName);

	if (bValidate == false) then return;
	end

	luaChangeName.szName = strName;
	frmChangeName:Show( false);

	local w, h = frmConfirmChangeName:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmConfirmChangeName:SetPosition( (width - w) * 0.5, (height - h) * 0.5);
    tvwChangeNameID:SetText("{COLOR r=0 g=250 b=0}'" .. strName .. "'{/COLOR}");
	frmConfirmChangeName:DoModal();
end




function luaChangeName:OnConfirmOK()

	frmConfirmChangeName:Show( false);

	gamefunc:UseInvenItem( luaChangeName.nSlotIndex, luaChangeName.szName);

	-- Clear
	luaChangeName.nSlotIndex = -1;
	luaChangeName.szName = "";
end





function luaChangeName:OnShowfrmChangeNameSucess()

	if ( frmChangeNameSucess:GetShow() == true)  then

		local x = ( gamefunc:GetWindowWidth() - frmChangeNameSucess:GetWidth()) * 0.5;
		local y = ( gamefunc:GetWindowHeight() - frmChangeNameSucess:GetHeight()) * 0.5;
		frmChangeNameSucess:SetPosition( x, y);
	else
	
		gamefunc:ExitToCharSelection();
	end

	luaGame:ShowWindow( frmChangeNameSucess);
end