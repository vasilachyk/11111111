--[[
	Game party setting LUA script
--]]


-- Global instance
luaPartySetting = {};
luaPartySetting.RuleCommon	= { STR( "LOOTINGRULE_FREEFORALL"), STR( "LOOTINGRULE_ROUNDROBIN") };
luaPartySetting.RuleRare	= { STR( "LOOTINGRULE_FREEFORALL"), STR( "LOOTINGRULE_ROLLDICE") };
luaPartySetting.RuleRarefor = { STR( "RAREFOR_RAREORBETTER"), STR( "RAREFOR_LEGENDARYORBETTER"), STR( "RAREFOR_EPIC") };
luaPartySetting.SetQuestID = 0;

function luaPartySetting:OnShowPartySettingFrame()

	if ( frmPartySetting:GetShow() == true)  then
		
		local x = ( frmSocial:GetWidth() - frmPartySetting:GetWidth()) * 0.5;
	    local y = ( frmSocial:GetHeight() - frmPartySetting:GetHeight()) * 0.5;
		frmPartySetting:SetPosition( x, y);

		luaPartySetting:Refresh()
	end
end







function luaPartySetting:Refresh()

	--edtPartyName:Enable( false)
	cmbLootingRuleCommon:Enable(false)
	cmbLootingRuleRare:Enable(false)
	cmbLootingRuleRareFor:Enable(false)
	cmbPartyLeader:Enable(false)
	btnParty:Enable(false);

	-- 
	cmbLootingRuleCommon:ResetContent();
	local count = table.getn(luaPartySetting.RuleCommon);
	for  i = 1, count do
		cmbLootingRuleCommon:AddString(luaPartySetting.RuleCommon[i])
	end
	
	cmbLootingRuleCommon:SetCurSel(gamefunc:GetLootingRuleCommon()-1);
	
	-- 
	cmbLootingRuleRare:ResetContent();
	
	local count = table.getn(luaPartySetting.RuleRare);
	for  i = 1, count do
		cmbLootingRuleRare:AddString(luaPartySetting.RuleRare[i])
	end
	
	cmbLootingRuleRare:SetCurSel(gamefunc:GetLootingRuleRare()-1);

	--
	cmbLootingRuleRareFor:ResetContent();
	
	local count = table.getn(luaPartySetting.RuleRarefor);
	for  i = 1, count do
		cmbLootingRuleRareFor:AddString(luaPartySetting.RuleRarefor[i])
	end
	
	cmbLootingRuleRareFor:SetCurSel(gamefunc:GetLootingRuleRareFor()-1);
	
	--
	cmbPartyLeader:ResetContent();
	
	local nCount = gamefunc:GetPartyMemberCount();
	for  i = 0, (nCount - 1)  do
		local strName = gamefunc:GetPartyMemberName( i);
		cmbPartyLeader:AddString(strName)
		
		local bIsPartyLeader = gamefunc:IsPartyLeader( i);
		if ( bIsPartyLeader == true)  then	cmbPartyLeader:SetCurSel(i);
		end
	end
	
	if(gamefunc:AmIPartyLeader() == true) then
		--edtPartyName:Enable( true)
		cmbLootingRuleCommon:Enable(true)
		cmbLootingRuleRare:Enable(true)
		cmbLootingRuleRareFor:Enable(true)
		cmbPartyLeader:Enable(true)
		btnParty:Enable(false);		
	end
	
end





function luaPartySetting:ChangePartySetting()

	if(gamefunc:AmIPartyLeader() == false) then	return;
	end
	
	--local strPartyName = edtPartyName:GetText();
	--if ( strPartyName == "이름 없음") then strPartyName = "";
	--end
	
	local nRuleCommon = cmbLootingRuleCommon:GetCurSel()+1;
	local nRuleRare = cmbLootingRuleRare:GetCurSel()+1;
	local nRuleRareFor = cmbLootingRuleRareFor:GetCurSel()+1;
	local nLeaderIndex = cmbPartyLeader:GetCurSel()
	
	--local nQuestID = 0
	--local nCurSel = cmbQuestName:GetCurSel();
	--if (nCurSel >= 0) then	nQuestID = cmbQuestName:GetItemData( nCurSel);
	--end

	gamefunc:ChangePartySetting(nRuleCommon, nRuleRare, nRuleRareFor, nLeaderIndex)

	frmPartySetting:Show(false);
end