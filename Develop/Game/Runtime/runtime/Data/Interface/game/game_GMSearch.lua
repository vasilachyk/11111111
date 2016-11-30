--[[
	Game GMSearch LUA script
--]]


-- Global instance
luaGMSearch				= {};
luaGMSearch.TAB			= { TAB_CONTANTS = 0, TAB_PC = 1 };
luaGMSearch.CurrTab		= -1;
luaGMSearch.strSearch	= "";

-- ShowGMSearchTab
function luaGMSearch:ShowGMSearchTab()

	if ( false == frmGMTool:GetShow() )  then
	  return;
	end
	
	pnlSearchMain:Show( true );
	pnlSearchInfoBase:Show( true );
	pnlSearchInfoContants:Show( false );
	pnlSearchInfoPC:Show( false );
	
	luaGMSearch.CurrTab	= -1;	
	luaGMSearch:OnSelChangeGMSearchTabCtrl();
	
end

-- HideGMSearchTab
function luaGMSearch:HideGMSearchTab()

	if ( false == frmGMTool:GetShow() )  then
	  return;
	end
	
	pnlSearchMain:Show( false );
	pnlSearchInfoBase:Show( false );
	pnlSearchInfoContants:Show( false );
	pnlSearchInfoPC:Show( false );
	
end

-- OnLoadedGMSearchTabCtrl
function luaGMSearch:OnLoadedGMSearchTabCtrl()
	
	tbcGMSearch:SetTabName( luaGMSearch.TAB.TAB_CONTANTS,	STR( "UI_GMTOOL_CONTANTS" )	);
    tbcGMSearch:SetTabName( luaGMSearch.TAB.TAB_PC,			STR( "UI_GMTOOL_PC" )		);
    
    local px		= 0;
    for i=0, 2	do
    
		local x, y, w, h	= tbcGMSearch:GetTabRect( i );
		w	= gamedraw:GetTextWidth( "fntScript", tbcGMSearch:GetTabName( i ) ) + 50;
		tbcGMSearch:SetTabRect( i, px, y, w, h );
		
		px	= px + w;
    end
    
end

-- OnSelChangeGMSearchTabCtrl
function luaGMSearch:OnSelChangeGMSearchTabCtrl()
	
	if ( false == frmGMTool:GetShow() )  then
	  return;
	end
	
	local nIndex = tbcGMSearch:GetSelIndex();	
	
	if( nIndex == luaGMSearch.CurrTab )	then
		return ;
	end
	
	luaGMSearch.CurrTab		= nIndex;

	luaGMSearch:HideAllpnlInfo();
	
	if( luaGMSearch.TAB.TAB_CONTANTS == luaGMSearch.CurrTab )		then
		pnlSearchInfoContants:Show( true );
	elseif( luaGMSearch.TAB.TAB_PC == luaGMSearch.CurrTab )			then
		pnlSearchInfoPC:Show( true );
	end

end

-- HideAllpnlInfo
function luaGMSearch:HideAllpnlInfo()
	
	pnlSearchInfoContants:Show( false );
	pnlSearchInfoPC:Show( false );
	
end

-- OnClickGMSearch
function luaGMSearch:OnClickGMSearch()

	local nIndex	= tbcGMSearch:GetSelIndex();
	local strSearch	= "";
	if( luaGMSearch.TAB.TAB_CONTANTS == luaGMSearch.CurrTab )		then
		strSearch	= edtGMSearch_Contants:GetText();
	elseif( luaGMSearch.TAB.TAB_PC == luaGMSearch.CurrTab )			then
		strSearch	= edtGMSearch_PC:GetText();
	else
		return ;
	end
	
	if( ( nil == strSearch ) or ( "" == strSearch ) )	then
		return ;
	end
	
	luaGMSearch.strSearch		= strSearch;
	
	luaGMSearch:OnRefreshGMSearchContantsList();
	
	--gamedebug:Log( "luaGMTool:OnClickGMSearch() : " .. nIndex .. " " .. luaGMSearch.strSearch );
	
end

-- OnRefreshGMSearchContantsList
function luaGMSearch:OnRefreshGMSearchContantsList()

	--gamedebug:Log( "luaGMTool:OnRefreshGMSearchContantsList()" );
	
	lcGMSearch_Item:DeleteAllItems();
	lcGMSearch_NPC:DeleteAllItems();
	lcGMSearch_Recipe:DeleteAllItems();
	
	if( ( nil == luaGMSearch.strSearch ) or ( "" == luaGMSearch.strSearch ) )	then
		return ;
	end

	local Item, nIndex, nID;
	-- SearchItem	
	local Contants_ItemTable		= gamefunc:GMSearchContants_Item( luaGMSearch.strSearch );
	for  i, v in pairs( Contants_ItemTable )  do
		
		nID		= tonumber( Contants_ItemTable[ i ] );
		Item	= " [ " .. Contants_ItemTable[ i ] .. " ] " .. " " .. gamefunc:GetItemName( nID );
		nIndex	= lcGMSearch_Item:AddItem( Item, "" );
		
		lcGMSearch_Item:SetItemData( nIndex, nID );
		
	end
	
	-- SearchNPC
	local Contants_NPCTable		= gamefunc:GMSearchContants_NPC( luaGMSearch.strSearch );
	for  i, v in pairs( Contants_NPCTable )  do
		
		nID		= tonumber( Contants_NPCTable[ i ] );
		Item	= " [ " .. Contants_NPCTable[ i ] .. " ] " .. " " .. gamefunc:GetNPCName( nID );
		nIndex	= lcGMSearch_NPC:AddItem( Item, "" );
		
		lcGMSearch_NPC:SetItemData( nIndex, nID );
		
	end
	
	-- SearchRecipe
	local Contants_RecipeTable		= gamefunc:GMSearchContants_Recipe( luaGMSearch.strSearch );
	for  i, v in pairs( Contants_RecipeTable )  do
	
		nID		= tonumber( Contants_RecipeTable[ i ] );
		Item	= " [ " .. Contants_RecipeTable[ i ] .. " ] " .. " " .. gamefunc:GetRecipeName( nID );
		nIndex	= lcGMSearch_Recipe:AddItem( Item, "" );
		
		lcGMSearch_Recipe:SetItemData( nIndex, nID );
		
	end
	
end