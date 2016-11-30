--[[
	Game GMChar LUA script
--]]


-- Global instance
luaGMChar = {};
luaGMChar.TAB			= { TAB_ITEM = 0, TAB_SKILL = 1, TAB_ADDQUEST = 2, TAB_COMPLETEQUEST = 3 };
luaGMChar.PLAYERGRADE	= { NORMAL = 0, GM = 1, TESTER = 2, DEVELOPER = 3 };

-- ShowGMCharTab
function luaGMChar:ShowGMCharTab()
	
	pnlCharMain:Show( true );
	pnlCharWorks:Show( true );
	pnlCharBottom:Show( true );

	luaGMChar:InitGMChar();
		
	luaGMChar:OnSelChangeGMCharListTab();
	
end

-- HideGMCharTab
function luaGMChar:HideGMCharTab()
	
	pnlCharMain:Show( false );
	pnlCharWorks:Show( false );
	pnlCharBottom:Show( false );
	
end

-- OnLoadedCharListTab()
function luaGMChar:OnLoadedCharListTab()
	
	tbcCharListTab:SetTabName( luaGMChar.TAB.TAB_ITEM,			STR( "ITEM" )						);
	tbcCharListTab:SetTabName( luaGMChar.TAB.TAB_SKILL,			STR( "TALENT" )						);
	tbcCharListTab:SetTabName( luaGMChar.TAB.TAB_ADDQUEST,		STR( "ADDQUEST" )					);
	tbcCharListTab:SetTabName( luaGMChar.TAB.TAB_COMPLETEQUEST,	STR( "UI_GMTOOL_COMPLETEQUEST" )	);
	
    local px		= 0;
    for i=luaGMChar.TAB.TAB_ITEM, luaGMChar.TAB.TAB_COMPLETEQUEST	do
    
		local x, y, w, h	= tbcCharListTab:GetTabRect( i );
		w	= gamedraw:GetTextWidth( "fntScript", tbcCharListTab:GetTabName( i ) ) + 50;
		tbcCharListTab:SetTabRect( i, px, y, w, h );
		
		px	= px + w;
    end
    
end

-- OnSelChangeGMCharListTab()
function luaGMChar:OnSelChangeGMCharListTab()

	local SelIndex	= tbcCharListTab:GetSelIndex();
	if( SelIndex == luaGMChar.TAB.TAB_COMPLETEQUEST )	then
		
		luaGMChar:GMCharSearchMyQuest();
		
	end
	

end

-- InitGMChar()
function luaGMChar:InitGMChar()
	
	luaGMChar:RefreshGMCharInfo();
	luaGMChar:RefreshGMCharGrade();
	
end

-- RefreshGMCharInfo()
function luaGMChar:RefreshGMCharInfo()
	
	-- SetName
	local name		= gamefunc:GetName();
	edtGMChar_Name:SetText( name );
	-- SetLevel
	local nLevel	= gamefunc:GetLevel();
	edtGMChar_Level:SetText( nLevel );
	-- SetTP
	local nTP		= gamefunc:GetTalentPoint();
	edtGMChar_TP:SetText( nTP );
	-- SetMoney
	local nMoney	= gamefunc:GetMoney();
	edtGMChar_Money:SetText( nMoney );
	
end

-- RefreshGMCharGrade()
function luaGMChar:RefreshGMCharGrade()
	
	-- Grade
	local nGrade	= gamefunc:GetMyGrade();
	selGMChar_Grade:SetCurSel( nGrade );
	
	-- ghost
	btnFilterGhost:SetCheck( gamefunc:AmIGhost() );
	
end

-- GMCharSetLevel()
function luaGMChar:GMCharSetLevel()
	
	local Level	= edtGMChar_Level:GetText();
	if( ( nil == Level ) or ( "" == Level ) )		then
		return ;
	end
	
	local nLevel	= tonumber( Level );	
	if( 1 > nLevel )	then
		return ;
	end
	
	gamefunc:OnGMSetMe( "level", nLevel );
	
end

-- GMCharSetTP()
function luaGMChar:GMCharSetTP()

	local TP	= edtGMChar_TP:GetText();
	if( ( nil == TP ) or ( "" == TP ) )		then
		return ;
	end
	
	local nTP	= tonumber( TP );	
	if( 1 > nTP )	then
		return ;
	end
	
	gamefunc:OnGMSetMe( "tp", nTP );
	
end

-- GMCharSetMoney()
function luaGMChar:GMCharSetMoney()
	
	local money	= edtGMChar_Money:GetText();
	if( ( nil == money ) or ( "" == money ) )		then
		return ;
	end
	
	local nMoney	= tonumber( money );	
	if( 1 > nMoney )	then
		return ;
	end
	
	gamefunc:OnGMSetMe( "money", nMoney );
	
end

-- OnLoadedselGMChar_Grade()
function luaGMChar:OnLoadedselGMChar_Grade()
	
	selGMChar_Grade:ResetContent();
	selGMChar_Grade:AddItem( STR( "UI_GMTOOL_USERGRADE" ),    luaGMChar.PLAYERGRADE.NORMAL    );
	selGMChar_Grade:AddItem( STR( "UI_GMTOOL_GMGRADE" ),      luaGMChar.PLAYERGRADE.GM        );
	selGMChar_Grade:AddItem( STR( "UI_GMTOOL_TESTERGRADE" ),  luaGMChar.PLAYERGRADE.TESTER    );
	selGMChar_Grade:AddItem( STR( "UI_GMTOOL_DEVGRADE" ),     luaGMChar.PLAYERGRADE.DEVELOPER );
	selGMChar_Grade:SetCurSel( 0 );
            
end

-- OnSelChangeselGMChar_Grade()
function luaGMChar:OnSelChangeselGMChar_Grade()

	local nCurSel	= selGMChar_Grade:GetCurSel();
	if( ( nCurSel < luaGMChar.PLAYERGRADE.NORMAL ) or ( nCurSel > luaGMChar.PLAYERGRADE.DEVELOPER ) )	then
		return ;
	end
	
	gamefunc:OnGMSetMe( "Grade", nCurSel );
		
end

-- GMCharSetGhost()
function luaGMChar:GMCharSetGhost()
	
	gamefunc:SetGhost();
	
end

-- GMCharSearchItem()
function luaGMChar:GMCharSearchItem()
	
	local strItem		= edtGMChar_ItemSearch:GetText();
	if( ( nil == strItem ) or ( "" == strItem ) )	then
		return ;
	end
	
	lcGMChar_SearchItem:DeleteAllItems();
	
	-- SearchItem	
	local Contants_ItemTable		= gamefunc:GMSearchContants_Item( strItem );
	for  i, v in pairs( Contants_ItemTable )  do
		
		nID		= tonumber( Contants_ItemTable[ i ] );
		Item	= " [ " .. Contants_ItemTable[ i ] .. " ] " .. " " .. gamefunc:GetItemName( nID );
		
		nIndex	= lcGMChar_SearchItem:AddItem( Item, "" );
		lcGMChar_SearchItem:SetItemData( nIndex, nID );
		
	end
	
end

-- GMChar_SearchItemRClick()
function luaGMChar:GMChar_SearchItemRClick()

	local nCurSel	= lcGMChar_SearchItem:GetCurSel();
	if( 0 > nCurSel )	then
		return ;
	end
	
	local nID		= lcGMChar_SearchItem:GetItemData( nCurSel );
	local Item		= lcGMChar_SearchItem:GetItemText( nCurSel );
	
	local nIndex	= lcGMChar_AddItem:AddItem( Item, "" );
	lcGMChar_AddItem:SetItemData( nIndex, nID );
	
end

-- GMChar_DeleteAddItem()
function luaGMChar:GMChar_DeleteAddItem()
	
	local nCurSel	= lcGMChar_AddItem:GetCurSel();
	if( 0 > nCurSel )	then
		return ;
	end
	
	lcGMChar_AddItem:DeleteItem( nCurSel );
	lcGMChar_AddItem:SetCurSel( 0 );
	
end

-- GiveItem()
function luaGMChar:GiveItem()
	
	local nCount	= lcGMChar_AddItem:GetItemCount();
	local nID		= 0;
	for i=1, nCount	do
	
		nID		= lcGMChar_AddItem:GetItemData( i-1 );
		gamefunc:OnGiveitem( nID );
		
	end
	
end

-- GMChar_DeleteAddItem()
function luaGMChar:InvenClear()
	
	gamefunc:OnClearInven();
	
end

-- GMCharSearchSkill()
function luaGMChar:GMCharSearchSkill()
	
	local strSkill		= edtGMChar_SkillSearch:GetText();
	if( ( nil == strSkill ) or ( "" == strSkill ) )	then
		return ;
	end
	
	lcGMChar_SearchSkill:DeleteAllItems();
	
	-- SearchItem	
	local Contants_SkillTable		= gamefunc:GMSearchContants_Skill( strSkill );
	for  i, v in pairs( Contants_SkillTable )  do
		
		nID		= tonumber( Contants_SkillTable[ i ] );
		
		
		Item	= " [ " .. Contants_SkillTable[ i ] .. " ] " .. " " .. gamefunc:GetTalentName( nID ) .. " " .. gamefunc:GetTalentRank( nID );
		
		nIndex	= lcGMChar_SearchSkill:AddItem( Item, "" );
		lcGMChar_SearchSkill:SetItemData( nIndex, nID );
		
	end
	
end

-- GMChar_SearchSkillRClick()
function luaGMChar:GMChar_SearchSkillRClick()

	local nCurSel	= lcGMChar_SearchSkill:GetCurSel();
	if( 0 > nCurSel )	then
		return ;
	end
	
	local nID		= lcGMChar_SearchSkill:GetItemData( nCurSel );
	local Item		= lcGMChar_SearchSkill:GetItemText( nCurSel );
	
	local nIndex	= lcGMChar_AddSkill:AddItem( Item, "" );
	lcGMChar_AddSkill:SetItemData( nIndex, nID );
	
end

-- GMChar_DeleteAddSkill()
function luaGMChar:GMChar_DeleteAddSkill()
	
	local nCurSel	= lcGMChar_AddSkill:GetCurSel();
	if( 0 > nCurSel )	then
		return ;
	end
	
	lcGMChar_AddSkill:DeleteItem( nCurSel );
	lcGMChar_AddSkill:SetCurSel( 0 );
	
end

-- AddTalent()
function luaGMChar:AddTalent()
	
	local nCount	= lcGMChar_AddSkill:GetItemCount();
	local nID		= 0;
	for i=1, nCount	do
	
		nID		= lcGMChar_AddSkill:GetItemData( i-1 );
		gamefunc:OnGMSetMe( "talent", nID );
		
	end
	
end

-- ResetTalent()
function luaGMChar:ResetTalent()

	gamefunc:OnGMSetMe( "talent", "reset" );
	
end

-- GMCharSearchQuest()
function luaGMChar:GMCharSearchQuest()
	
	local strQuest		= edtGMChar_QuestSearch:GetText();
	if( ( nil == strQuest ) or ( "" == strQuest ) )	then
		return ;
	end
	
	lcGMChar_SearchQuest:DeleteAllItems();
	
	-- Search
	local Contants_QuestTable		= gamefunc:GMSearchContants_Quest( strQuest );
	for  i, v in pairs( Contants_QuestTable )  do
		
		nID		= tonumber( Contants_QuestTable[ i ] );
		Item	= " [ " .. Contants_QuestTable[ i ] .. " ] " .. " " .. gamefunc:GetQuestName( nID );
		
		nIndex	= lcGMChar_SearchQuest:AddItem( Item, "" );
		lcGMChar_SearchQuest:SetItemData( nIndex, nID );
		
	end
	
end

-- GMChar_SearchQuestRClick()
function luaGMChar:GMChar_SearchQuestRClick()

	local nCurSel	= lcGMChar_SearchQuest:GetCurSel();
	if( 0 > nCurSel )	then
		return ;
	end
	
	local nID		= lcGMChar_SearchQuest:GetItemData( nCurSel );
	local Item		= lcGMChar_SearchQuest:GetItemText( nCurSel );
	
	local nIndex	= lcGMChar_AddQuest:AddItem( Item, "" );
	lcGMChar_AddQuest:SetItemData( nIndex, nID );
	
end

-- GMChar_DeleteAddQuest()
function luaGMChar:GMChar_DeleteAddQuest()
	
	local nCurSel	= lcGMChar_AddQuest:GetCurSel();
	if( 0 > nCurSel )	then
		return ;
	end
	
	lcGMChar_AddQuest:DeleteItem( nCurSel );
	lcGMChar_AddQuest:SetCurSel( 0 );
	
end

-- AddQuest()
function luaGMChar:AddQuest()
	
	local nCount	= lcGMChar_AddQuest:GetItemCount();
	local nID		= 0;
	for i=1, nCount	do
	
		nID		= lcGMChar_AddQuest:GetItemData( i-1 );
		gamefunc:GiveQuest( nID );
		
	end
	
end

-- ResetQuest()
function luaGMChar:ResetQuest()

	gamefunc:ResetQuest();
	
end

-- GMCharSearchMyQuest()
function luaGMChar:GMCharSearchMyQuest()

	local nCount = gamefunc:GetPlayerQuestCount();
	for  i = 0, (nCount - 1)  do
	
		local nID = gamefunc:GetPlayerQuestID( i );
		local strName = gamefunc:GetQuestName( nID );
		
		Item	= " [ " .. nID .. " ] " .. " " .. strName;
		
		nIndex	= lcGMChar_SearchMyQuest:AddItem( Item, "" );
		lcGMChar_SearchMyQuest:SetItemData( nIndex, nID );
		
	end	

end

-- GMChar_SearchMyQuestRClick()
function luaGMChar:GMChar_SearchMyQuestRClick()

	local nCurSel	= lcGMChar_SearchMyQuest:GetCurSel();
	if( 0 > nCurSel )	then
		return ;
	end
	
	local nID		= lcGMChar_SearchMyQuest:GetItemData( nCurSel );
	local Item		= lcGMChar_SearchMyQuest:GetItemText( nCurSel );
	
	local nIndex	= lcGMChar_AddMyQuest:AddItem( Item, "" );
	lcGMChar_AddMyQuest:SetItemData( nIndex, nID );
	
end

-- GMChar_DeleteAddMyQuest()
function luaGMChar:GMChar_DeleteAddMyQuest()
	
	local nCurSel	= lcGMChar_AddMyQuest:GetCurSel();
	if( 0 > nCurSel )	then
		return ;
	end
	
	lcGMChar_AddMyQuest:DeleteItem( nCurSel );
	lcGMChar_AddMyQuest:SetCurSel( 0 );
	
end

-- CompleteQuest()
function luaGMChar:CompleteQuest()
	
	local nCount	= lcGMChar_AddMyQuest:GetItemCount();
	local nID		= 0;
	for i=1, nCount	do
	
		nID		= lcGMChar_AddMyQuest:GetItemData( i-1 );
		gamefunc:CompleteQuest( nID );
		
	end
	
end