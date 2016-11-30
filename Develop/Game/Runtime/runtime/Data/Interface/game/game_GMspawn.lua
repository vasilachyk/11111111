--[[
	Game GMSpawn LUA script
--]]


-- Global instance
luaGMSpawn = {};
luaGMSpawn.TAB			= { TAB_CONTANTS = 0, TAB_PC = 1 };
luaGMSpawn.SpawnSetMax	= 5;

-- ShowGMSpawnTab
function luaGMSpawn:ShowGMSpawnTab()
	
	pnlSpawnSearch:Show( true );
	pnlSpawnWorks:Show( true );
	pnlpnlSpawnBottom:Show( true );
	
end

-- HideGMSpawnTab
function luaGMSpawn:HideGMSpawnTab()
	
	pnlSpawnSearch:Show( false );
	pnlSpawnWorks:Show( false );
	pnlpnlSpawnBottom:Show( false );
	
end

-- OnLoadedGMSpawnSearchTab( 소환 검색창탭 설정 )
function luaGMSpawn:OnLoadedGMSpawnSearchTab()
	
	tbcSpawnSearch:SetTabName( luaGMSpawn.TAB.TAB_CONTANTS,	STR( "UI_GMTOOL_NPC" )		);
    --tbcSpawnSearch:SetTabName( luaGMSpawn.TAB.TAB_PC,			STR( "UI_GMTOOL_PC" )	);
    
    local px		= 0;
    for i=0, 1	do
    
		local x, y, w, h	= tbcSpawnSearch:GetTabRect( i );
		w	= gamedraw:GetTextWidth( "fntScript", tbcSpawnSearch:GetTabName( i ) ) + 50;
		tbcSpawnSearch:SetTabRect( i, px, y, w, h );
		
		px	= px + w;
    end
    
end

-- OnSelChangeGMSpawnSearchTab( 검색탭 전환 )
function luaGMSpawn:OnSelChangeGMSpawnSearchTab()
	
	if ( false == frmGMTool:GetShow() )  then
	  return;
	end
	
end

-- GMSpawn_SearchNpc
function luaGMSpawn:GMSpawn_SearchNpc()

	luaGMSpawn:OnRefreshGMSpawn_SearchList();
	
end

-- OnRefreshGMSpawn_SearchList
function luaGMSpawn:OnRefreshGMSpawn_SearchList()

	lcGMSpawn_SearchNpc:DeleteAllItems();
	
	local strSearch	= edtGMSpawnSearch:GetText();
	if( ( nil == strSearch ) or ( "" == strSearch ) )	then
		return ;
	end

	local nIndex	= tbcGMSearch:GetSelIndex();
	local ItemTable;
	local wndList;
	
	if( luaGMSpawn.TAB.TAB_CONTANTS == nIndex )		then
		ItemTable	= gamefunc:GMSearchContants_NPC( strSearch );
		wndList		= lcGMSpawn_SearchNpc;
	else
		return ;
	end
	
	local Item, nIndex, nID;
	for  i, v in pairs( ItemTable )  do
		
		nID		= tonumber( ItemTable[ i ] );
		Item	= " [ " .. ItemTable[ i ] .. " ] " .. " " .. gamefunc:GetNPCName( nID );
		nIndex	= wndList:AddItem( Item, "" );
		
		wndList:SetItemData( nIndex, nID );
		
	end
	
end

-- OnLoadedGMSpawnSet( 소환 리스트 탭 )
function luaGMSpawn:OnLoadedGMSpawnSet()

	local px		= 0;
	local strTab;
	local nIdx		= 0;
	for i=1, luaGMSpawn.SpawnSetMax	do
	
		nIdx		= i - 1;
		strTab		= STR( "UI_GMSPAWN" ) .. i;
		tbcSpawnSet:SetTabName( nIdx, strTab );
		
		local x, y, w, h	= tbcSpawnSet:GetTabRect( nIdx );
		w	= gamedraw:GetTextWidth( "fntScript", tbcSpawnSet:GetTabName( nIdx ) ) + 50;
		tbcSpawnSet:SetTabRect( nIdx, px, y, w, h );
		
		px	= px + w;
		
	end

end

-- SearchNpcListItemRClick( 검색 리스트 우클릭 처리 )
function luaGMSpawn:SearchNpcListItemRClick()

	local nCurSel	= lcGMSpawn_SearchNpc:GetCurSel();
	if( 0 > nCurSel )	then
		return ;
	end
	
	local nID		= lcGMSpawn_SearchNpc:GetItemData( nCurSel );
	
	luaGMSpawn:AddSpawnList( nID );
	
end

-- AddSpawnList( 검색 리스트에서 소환 리스트에 추가 )
function luaGMSpawn:AddSpawnList( nID )
	
	local nCurSel		= tbcSpawnSet:GetSelIndex();
	if( 0 > nCurSel )	then
		return ;
	end
	
	local wndSpawnList	= rawget( _G, "lcGMSpawn_list" .. nCurSel+1 );
	if( nil == wndSpawnList )	then
		return ;
	end
	
	local Item			= " [ " .. nID .. " ] " .. " " .. gamefunc:GetNPCName( nID );
	local nIndex		= wndSpawnList:AddItem( Item, "" );
	wndSpawnList:SetItemData( nIndex, nID );
end

-- NpcListItemRClick( 소환 리스트 우클릭 처리 )
function luaGMSpawn:NpcListItemRClick()

	local nSelIndex		= tbcSpawnSet:GetSelIndex();
	if( 0 > nSelIndex )	then
		return ;
	end
	
	local wndSpawnList	= rawget( _G, "lcGMSpawn_list" .. nSelIndex+1 );
	if( nil == wndSpawnList )	then
		return ;
	end
	
	local nCurSel		= wndSpawnList:GetCurSel();
	
	if( 0 > nCurSel )	then
		return ;
	end
	
	wndSpawnList:DeleteItem( nCurSel );
	wndSpawnList:SetCurSel( 0 );
	
end

-- luaGMSpawn:DeleteAllSpawnList( 소환 리스트 전부 삭제 )
function luaGMSpawn:DeleteAllSpawnList()
	
	local nSelIndex		= tbcSpawnSet:GetSelIndex();
	if( 0 > nSelIndex )	then
		return ;
	end
	
	local wndSpawnList	= rawget( _G, "lcGMSpawn_list" .. nSelIndex+1 );
	if( nil == wndSpawnList )	then
		return ;
	end
	
	wndSpawnList:DeleteAllItems();
	
	--gamefunc:GetNPCSpawn(nID);	
end

--luaGMSpawn:SpawnNpcList( 리스트 소환 )
function luaGMSpawn:SpawnNpcList()
	
	local nSelIndex		= tbcSpawnSet:GetSelIndex();
	if( 0 > nSelIndex )	then
		return ;
	end
	
	local wndSpawnList	= rawget( _G, "lcGMSpawn_list" .. nSelIndex+1 );
	if( nil == wndSpawnList )	then
		return ;
	end
	
	local nCount	= wndSpawnList:GetItemCount();
	local nID		= 0;
	for i=1, nCount	do
	
		nID		= wndSpawnList:GetItemData( i-1 );
		gamefunc:GetNPCSpawn( nID );
		--gamedebug:Log( "luaGMSpawn:SpawnNpcList() " .. nID );
		
	end	
	
end

-- OnLoadededDespawnRange
function luaGMSpawn:OnLoadededDespawnRange()

	local Range		= gamefunc:GetRangeDespawn();
	edtGMSpawn_DespawnRange:SetText( Range );	
	
end

-- OnClickDespawn
function luaGMSpawn:OnClickDespawn()
	
	local range	= edtGMSpawn_DespawnRange:GetText();
	if( ( nil == range ) or ( "" == range ) )	then
		return ;
	end
	
	gamefunc:Despawn( range );
	
end