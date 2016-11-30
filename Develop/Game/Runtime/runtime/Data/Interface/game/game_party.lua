--[[
	Game party LUA script
--]]


-- Global instance
luaParty = {};




-- RefreshParty
function luaParty:RefreshParty()

	frmConfirmLeaveParty:Show( false);


	luaParty:RefreshPartyMemberList();
	luaParty:RefreshControls();
end





-- RefreshPartyMemberList
function luaParty:RefreshPartyMemberList()

	if ( frmSocial:GetShow() == false)  or  ( tbcSocialTabCtrl:GetSelIndex() ~= 0)  then  return;
	end
	
	
	local nCurSel = math.max( 0, lcPartyList:GetCurSel());
	
	lcPartyList:DeleteAllItems();
	

	local nCount = gamefunc:GetPartyMemberCount();
	if ( nCount == 0)  then
	
		--labPartyName:SetText( "-");
		labPartyLeader:SetText( "-");
		labPartyMemberCount:SetText( "-");
		return;
	end
	
	
	-- Member list
	for i = 0, (nCount - 1)  do
	
		local strMemberName = gamefunc:GetPartyMemberName( i);
		local bIsLeader = gamefunc:IsPartyLeader( i);
		local bMemberOffline = gamefunc:IsPartyMemberOffline( i);
		local bMemberDead = gamefunc:IsPartyMemberDead( i);

		local strTalentImage = "";
	
		local strGrade = STR( "PARTYMEMBER");
		if ( bIsLeader == true)  then			strGrade = STR( "PARTYLEADER");
		end

		local strState = STR( "UI_ONLINE");
		if ( bMemberOffline == true)  then		strState = STR( "UI_OFFLINE");
		elseif ( bMemberDead == true)  then		strState = STR( "UI_DIE");
		end
		
		
		local nIndex = lcPartyList:AddItem( strMemberName, strTalentImage);
		lcPartyList:SetItemText( nIndex, 1, strGrade);
		lcPartyList:SetItemText( nIndex, 2, strState);
		lcPartyList:SetItemData( nIndex, i);
		
		if ( bMemberOffline == true)  or  ( bMemberDead == true)  then  lcPartyList:Enable( nIndex, false);
		end
		
		
		-- Party leader
		if ( bIsLeader == true)  then  labPartyLeader:SetText( strMemberName);
		end
	end
	
	lcPartyList:SetCurSel( nCurSel);


	-- Member count
	labPartyMemberCount:SetText( tostring( nCount));
end





-- RefreshControls
function luaParty:RefreshControls()

	if ( frmSocial:GetShow() == false)  or  ( tbcSocialTabCtrl:GetSelIndex() ~= 0)  then  return;
	end
	

	local nMemberCount = gamefunc:GetPartyMemberCount();
	if ( nMemberCount == 0)  then
	
		btnPartySetting:Enable( false);
		btnDisbandPartyMember:Enable( false);
		btnLeaveParty:Enable( false);
		return;
	end
	

	if ( gamefunc:AmIPartyLeader() == true)  then
	
		btnPartySetting:Enable( true);

		local bEnable = false;
		local nCurSel = lcPartyList:GetCurSel();
		if ( nCurSel >= 0)  then
		
			local nIndex = lcPartyList:GetItemData( nCurSel);
			if ( nIndex >= 0)  then
			
				if ( gamefunc:IsPartyMemberMe( nIndex) == false)  then  bEnable = true;
				end
			end
		end
		
		btnDisbandPartyMember:Enable( bEnable);

	else
	
		btnPartySetting:Enable( false);
		btnDisbandPartyMember:Enable( false);
	end
	

	btnLeaveParty:Enable( true);
	
	luaExpo:RefreshParty();
	
end





-- OnClickPartySetting
function luaParty:OnClickPartySetting()

	frmPartySetting:DoModal();
end






-- OnClickDisbandPartyMember
function luaParty:OnClickDisbandPartyMember()

	if ( gamefunc:AmIPartyLeader() == false)  then  return;
	end
	
	
	local nCurSel = lcPartyList:GetCurSel();
	if ( nCurSel >= 0)  then
	
		local nIndex = lcPartyList:GetItemData( nCurSel);
		if ( nIndex >= 0)  then
		
			gamefunc:DisbandPartyMember( nIndex);
		end
	end
end
