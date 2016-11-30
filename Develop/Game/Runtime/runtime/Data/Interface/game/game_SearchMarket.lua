--[[
	Game SearchMarket LUA script
--]]


-- Global instance
luaSearchMarket						= {};
luaSearchMarket.SEARCHSTEP			= { STEP_RESULT = 1, STEP_ITEMCATAGORY = 2, STEP_LIST = 3, STEP_NONE = 4 };
luaSearchMarket.COLUMN				= { NAME = 0, LEVEL = 1, QUANTITY = 2, PRICE = 3 };
luaSearchMarket.REFRESHSTEP			= { REFRESHTAB = 1, REFRESHLIST = 2 };
luaSearchMarket.Step				= luaSearchMarket.SEARCHSTEP.STEP_RESULT;
luaSearchMarket.ListSort			= luaTradeMarket.SORT.SORT_NONE;
luaSearchMarket.BuyItemIndex		= -1;
luaSearchMarket.BuyItemID			= -1;
luaSearchMarket.BuyItemAmount		= 0;
luaSearchMarket.BuyItemUnitPrice	= 0;
luaSearchMarket.nListStartIndex		= 0;
luaSearchMarket.ItemListMax			= 0;
luaSearchMarket.strSearchName		= "";
luaSearchMarket.nSearchLvMin		= 0;
luaSearchMarket.nSearchLvMax		= 0;
luaSearchMarket.nSearchTextLimit	= 2;


-- InitSearchMarket
function luaSearchMarket:InitSearchMarket()
	
	luaSearchMarket.Step				= luaSearchMarket.SEARCHSTEP.STEP_NONE;
	
	luaSearchMarket.ItemListMax			= gamefunc:GetSearchListMax();
	luaSearchMarket.BuyItemIndex		= -1;
	luaSearchMarket.BuyItemID			= -1;
	luaSearchMarket.BuyItemAmount		= 0;
	luaSearchMarket.BuyItemUnitPrice	= 0;
	luaSearchMarket.strSearchName		= "";
	luaSearchMarket.nSearchLvMin		= 0;
	luaSearchMarket.nSearchLvMax		= 0;
	
	luaSearchMarket:InitSearchStep();
	luaSearchMarket:InitSearchMarketControl();
	
end

-- InitSearchMarketControl
function luaSearchMarket:InitSearchMarketControl()	
	
	--luaTradeMarket:InitPage();
	luaSearchMarket:InitSearch();
	
	luaSearchMarket.ItemListMax			= gamefunc:GetSearchListMax();
	luaSearchMarket.ListSort			= luaTradeMarket.SORT.SORT_NONE;

	luaSearchMarket:InitSortArea();
	luaSearchMarket:RefreshListSearchItem();
	luaSearchMarket:InitpnlTradeMarketSearch();
	
	frmConfirmBuyItem:Show( false );
	
end

-- InitSearchStep
function luaSearchMarket:InitSearchStep()
	
	lcSearchItemsList:DeleteAllItems();

	tvwSearchResult:Show( false );
	
	luaSearchMarket.nListStartIndex		= 0;
	
	luaSearchMarket:SetPage( 0 );
	
	luaSearchMarket:InitSearchListBtn();
	
	if( luaSearchMarket.SEARCHSTEP.STEP_NONE == luaSearchMarket.Step )					then
		luaSearchMarket:InitSearchItemStart();
	elseif( luaSearchMarket.SEARCHSTEP.STEP_RESULT == luaSearchMarket.Step )			then
		luaSearchMarket:InitSearchItemNoneList();
	elseif( luaSearchMarket.SEARCHSTEP.STEP_ITEMCATAGORY == luaSearchMarket.Step )		then
		luaSearchMarket:InitSearchItemCatagoryList();
	elseif( luaSearchMarket.SEARCHSTEP.STEP_LIST == luaSearchMarket.Step )				then
		luaSearchMarket:InitSearchItemList();
	end
	
end

-- InitlcSearchItemsListUI
function luaSearchMarket:InitlcSearchItemsListUI()

	lcSearchItemsList:SetColumnText( luaSearchMarket.COLUMN.NAME, STR( "ITEM" ) );
	lcSearchItemsList:SetColumnWidth( luaSearchMarket.COLUMN.NAME, 480 );
    lcSearchItemsList:SetColumnText( luaSearchMarket.COLUMN.LEVEL, STR( "LEVEL" ) );
    lcSearchItemsList:SetColumnText( luaSearchMarket.COLUMN.QUANTITY, STR( "QUANTITY" ) );
    lcSearchItemsList:SetColumnText( luaSearchMarket.COLUMN.PRICE, STR( "PRICE" ) );
    
end

-- InitSortArea
function luaSearchMarket:InitSortArea()
	
	-- 정렬용위치 셋팅
    local nX, nY		= lcSearchItemsList:GetPosition();
    local nWidth		= lcSearchItemsList:GetColumnWidth( luaSearchMarket.COLUMN.NAME );
    local nHeight		= 25;
    
    -- NameSort
    tvwSearchSortName:SetPosition( nX, nY );
	tvwSearchSortName:SetSize( nWidth, nHeight );
    
    -- LevelSort
    nX			= nX + nWidth;
    nWidth		= lcSearchItemsList:GetColumnWidth( luaSearchMarket.COLUMN.LEVEL );
    tvwSearchSortLevel:SetPosition( nX, nY );
    tvwSearchSortLevel:SetSize( nWidth, nHeight );
    
    -- Amount
    nX			= nX + nWidth;
    nWidth		= lcSearchItemsList:GetColumnWidth( luaSearchMarket.COLUMN.QUANTITY );
    tvwSearchSortAmount:SetPosition( nX, nY );
    tvwSearchSortAmount:SetSize( nWidth, nHeight );
    
    -- Price
    nX			= nX + nWidth;
    nWidth		= lcSearchItemsList:GetColumnWidth( luaSearchMarket.COLUMN.PRICE );
    tvwSearchSortPrice:SetPosition( nX, nY );
    tvwSearchSortPrice:SetSize( nWidth, nHeight );
    
end

-- InitSearchItemStart
function luaSearchMarket:InitSearchItemStart()
	
	tvwSearchResult:Show( true );
	tvwSearchResult:SetText( "{FONT name=\"fntBold\"}{COLOR r=160 g=120 b=55}{ALIGN hor=\"center\" ver=\"center\"}" .. STR( "UI_TRADEMAKET_SEARCH_NONE_TEXT" ) );
	
	lcSearchItemsList:SetColumnText( luaSearchMarket.COLUMN.PRICE, STR( "PRICE" ) );
		
end

-- InitSearchItemNoneList
function luaSearchMarket:InitSearchItemNoneList()
	
	tvwSearchResult:Show( true );
	tvwSearchResult:SetText( "{FONT name=\"fntBold\"}{COLOR r=160 g=120 b=55}{ALIGN hor=\"center\" ver=\"center\"}" .. STR( "UI_TRADEMAKET_SEARCH_RESULT_TEXT" ) );
	
	lcSearchItemsList:SetColumnText( luaSearchMarket.COLUMN.PRICE, STR( "PRICE" ) );
		
end

-- InitSearchItemCatagoryList
function luaSearchMarket:InitSearchItemCatagoryList()
	
	lcSearchItemsList:SetColumnText( luaSearchMarket.COLUMN.PRICE, STR( "UI_TRADEMAKET_SEARCH_PRICEMIN" ) );
	
end

-- InitSearchItemList
function luaSearchMarket:InitSearchItemList()

	lcSearchItemsList:SetColumnText( luaSearchMarket.COLUMN.PRICE, STR( "UI_TRADEMAKET_UNITPRICE" ) );
	
end

-- RefreshSearchMarket
function luaSearchMarket:RefreshSearchMarket( nStep, nRefreshList )
	
	local nIndex = tbcTradeMarketTabCtrl:GetSelIndex();	
	if( luaTradeMarket.TABCTRL.SEARCH_ITEM ~= nIndex )				then
		return ;	
	end
	
	if( nStep ~= luaSearchMarket.Step )		then
		-- Step 상태 초기화
		luaSearchMarket.Step		= nStep;
		
		luaSearchMarket:InitSearchStep();

		if( nStep == luaSearchMarket.SEARCHSTEP.STEP_RESULT )		then
			return ;
		end
		
	end
	
	if( nRefreshList == luaSearchMarket.REFRESHSTEP.REFRESHTAB )	then
		
		if( gamefunc:GetSearchItemsCnt( luaSearchMarket.Step ) < 1 )		then
			luaSearchMarket:RefreshSearchMarket( luaSearchMarket.SEARCHSTEP.STEP_RESULT );
			return ;
		end
	
		luaSearchMarket.nListStartIndex		= 0;

	end
	
	luaSearchMarket:RefreshListSearchItem();
	
end

-- RefreshListSearchItem
function luaSearchMarket:RefreshListSearchItem()

	-- PageSetting
	local nListCount		= gamefunc:GetSearchItemsCnt( luaSearchMarket.Step );
	if( luaSearchMarket.nListStartIndex	> nListCount - 1 )	then
		luaSearchMarket.nListStartIndex	= luaSearchMarket.nListStartIndex - luaSearchMarket.ItemListMax;
	end
	luaSearchMarket:SetPage( nListCount );
	
	-- 클라이언트에 StartIndex, EndIndex 데이타가 유효한지 확인
	if( false == gamefunc:CheckSearchListIndex( luaSearchMarket.Step, luaSearchMarket.nListStartIndex ) )	then
		return ;
	end
	
	lcSearchItemsList:DeleteAllItems();
	-- 구입 버튼 초기화
	luaSearchMarket:InitSearchListBtn();
	
	local nID;
	local nEnchantGrade;
	local nEndIndex		= ( luaSearchMarket.nListStartIndex + luaSearchMarket.ItemListMax ) - 1;
	for i=luaSearchMarket.nListStartIndex,		nEndIndex			do
	
		nID				= gamefunc:GetSearchItemID( luaSearchMarket.Step, i );	-- Index
		nEnchantGrade	= gamefunc:GetSearchItemEnchantGrade( luaSearchMarket.Step, i );
		if( nID < 0 )		then
			return;
		end
		
		local strName = gamefunc:GetItemName( nID, nEnchantGrade );
		local strImage = gamefunc:GetItemImage( nID );
		
		if ( nil == strImage )  or  ( "" == strImage )	then
			strImage = "iconUnknown"
		end
		
		local r, g, b	= GetItemColor( nID );
		
		-- ItemName
		local nIndex = lcSearchItemsList:AddItem( strName, strImage );
		
		lcSearchItemsList:SetItemData( nIndex, i );
		lcSearchItemsList:SetItemColor( nIndex, luaSearchMarket.COLUMN.NAME, r, g, b );
		
		-- Level
		local nItemLevel		= gamefunc:GetItemEquipReqLevel( nID );
		if( 1 > nItemLevel )	then
			nItemLevel			= 1;
		end
			
		lcSearchItemsList:SetItemText( nIndex, luaSearchMarket.COLUMN.LEVEL, nItemLevel );
		lcSearchItemsList:SetItemColor( nIndex, luaSearchMarket.COLUMN.LEVEL, r, g, b );

		-- QuanTity
		local nQuanTity	= gamefunc:GetSearchItemAmount( luaSearchMarket.Step, i );
		lcSearchItemsList:SetItemText( nIndex, luaSearchMarket.COLUMN.QUANTITY, nQuanTity );
		lcSearchItemsList:SetItemColor( nIndex, luaSearchMarket.COLUMN.QUANTITY, 230, 230, 230 );

		-- Price
		local nUnitPrice	= gamefunc:GetSearchItemPrice( luaSearchMarket.Step, i );
		lcSearchItemsList:SetItemText( nIndex, luaSearchMarket.COLUMN.PRICE, nUnitPrice );
		
		luaSearchMarket:ShowSearchBtn( true, nIndex );
		
		if( luaSearchMarket.SEARCHSTEP.STEP_ITEMCATAGORY == luaSearchMarket.Step )	then
			if( 1 > nQuanTity )	then
				luaSearchMarket:SetSearchEnableBtn( nIndex );
			end
		elseif( luaSearchMarket.SEARCHSTEP.STEP_LIST == luaSearchMarket.Step )	then
			-- 내가 올린 아이템인가?
			if( true == gamefunc:IsMyRegisterItem( i ) )	then
				luaSearchMarket:SetSearchEnableBtn( nIndex );
			end
			
		end
		
	end
	
end

-- OnTradeMarketSearch
function luaSearchMarket:OnTradeMarketSearch( nvecIndex )
	
	local nID				= gamefunc:GetSearchItemID( luaSearchMarket.Step, nvecIndex );	-- Index
	-- 1차검색 닫기
	-- 2차검색 열기
	luaSearchMarket.Step		= luaSearchMarket.SEARCHSTEP.STEP_LIST;
	luaSearchMarket:InitSearchStep();
	
	-- 요청
	luaSearchMarket.ListSort		= luaTradeMarket.SORT.SORT_PRICE;
	gamefunc:TradeMarketSearch( nID, luaSearchMarket.ListSort );
	
end

-- InitSearchListBtn
function luaSearchMarket:InitSearchListBtn()
	
	local strText	= STR( "UI_TRADEMAKET_BTN_SEARCH" );
	if( luaSearchMarket.SEARCHSTEP.STEP_LIST == luaSearchMarket.Step )			then
		strText		= STR( "UI_SHOP_BUY" );
	end
	
	-- 처음에는 무조건 Hiden
	btnBuy1:Show( false );
	btnBuy1:SetText( strText );
	btnBuy1:Enable( true );
	btnBuy2:Show( false );
	btnBuy2:SetText( strText );
	btnBuy2:Enable( true );
	btnBuy3:Show( false );
	btnBuy3:SetText( strText );
	btnBuy3:Enable( true );
	btnBuy4:Show( false );
	btnBuy4:SetText( strText );
	btnBuy4:Enable( true );
	btnBuy5:Show( false );
	btnBuy5:SetText( strText );
	btnBuy5:Enable( true );
	btnBuy6:Show( false );
	btnBuy6:SetText( strText );
	btnBuy6:Enable( true );
	btnBuy7:Show( false );
	btnBuy7:SetText( strText );
	btnBuy7:Enable( true );
	btnBuy8:Show( false );
	btnBuy8:SetText( strText );
	btnBuy8:Enable( true );
	btnBuy9:Show( false );
	btnBuy9:SetText( strText );
	btnBuy9:Enable( true );
	btnBuy10:Show( false );
	btnBuy10:SetText( strText );
	btnBuy10:Enable( true );
	
end

-- ShowSearchBtn
function luaSearchMarket:ShowSearchBtn( bShow, nIndex )
	
	if( ( nil == nIndex ) or ( 0 > nIndex ) )		then
		return ;
	end
	
	if( 0 == nIndex )			then
		btnBuy1:Show( bShow );
	elseif( 1 == nIndex )		then
		btnBuy2:Show( bShow );
	elseif( 2 == nIndex )		then
		btnBuy3:Show( bShow );
	elseif( 3 == nIndex )		then
		btnBuy4:Show( bShow );
	elseif( 4 == nIndex )		then
		btnBuy5:Show( bShow );
	elseif( 5 == nIndex )		then
		btnBuy6:Show( bShow );
	elseif( 6 == nIndex )		then
		btnBuy7:Show( bShow );
	elseif( 7 == nIndex )		then
		btnBuy8:Show( bShow );
	elseif( 8 == nIndex )		then
		btnBuy9:Show( bShow );
	elseif( 9 == nIndex )		then
		btnBuy10:Show( bShow );
	end
	
end

-- SetSearchEnableBtn
function luaSearchMarket:SetSearchEnableBtn( nIndex )
	
	luaSearchMarket.SEARCHSTEP			= { STEP_RESULT = 1, STEP_ITEMCATAGORY = 2, STEP_LIST = 3 };
	
	-- STEP_ITEMCATAGORY는 <검색> - 비활성화
	-- STEP_LIST는 <내아이템> - 비활성화
	local strText	= STR( "UI_TRADEMAKET_BTN_SEARCH" );
	if( luaSearchMarket.SEARCHSTEP.STEP_LIST == luaSearchMarket.Step )			then
		strText		= STR( "UI_TRADEMAKET_SEARCH_MYITEM" );
	end
		
	if( ( nil == nIndex ) or ( 0 > nIndex ) )		then
		return ;
	end
	
	if( 0 == nIndex )			then
		btnBuy1:SetText( strText );
		btnBuy1:Enable( false );
	elseif( 1 == nIndex )		then
		btnBuy2:SetText( strText );
		btnBuy2:Enable( false );
	elseif( 2 == nIndex )		then
		btnBuy3:SetText( strText );
		btnBuy3:Enable( false );
	elseif( 3 == nIndex )		then
		btnBuy4:SetText( strText );
		btnBuy4:Enable( false );
	elseif( 4 == nIndex )		then
		btnBuy5:SetText( strText );
		btnBuy5:Enable( false );
	elseif( 5 == nIndex )		then
		btnBuy6:SetText( strText );
		btnBuy6:Enable( false );
	elseif( 6 == nIndex )		then
		btnBuy7:SetText( strText );
		btnBuy7:Enable( false );
	elseif( 7 == nIndex )		then
		btnBuy8:SetText( strText );
		btnBuy8:Enable( false );
	elseif( 8 == nIndex )		then
		btnBuy9:SetText( strText );
		btnBuy9:Enable( false );
	elseif( 9 == nIndex )		then
		btnBuy10:SetText( strText );
		btnBuy10:Enable( false );
	end
	
end

-- SearchListBtnClick
function luaSearchMarket:SearchListBtnClick( nIndex )

	if( luaSearchMarket.SEARCHSTEP.STEP_ITEMCATAGORY == luaSearchMarket.Step )		then
		luaSearchMarket:SearchItemList( nIndex );
	elseif( luaSearchMarket.SEARCHSTEP.STEP_LIST == luaSearchMarket.Step )				then
		luaSearchMarket:BuyItem( nIndex )
	end

	
	
end

-- SearchItemList
function luaSearchMarket:SearchItemList( nIndex )
	
	if( 0 > nIndex )	then
		return ;
	end
	
	local nvecIndex = lcSearchItemsList:GetItemData( nIndex );
	if( 0 > nvecIndex )  then
		return;
	end
	
	if( luaSearchMarket.SEARCHSTEP.STEP_ITEMCATAGORY == luaSearchMarket.Step )		then
		luaSearchMarket:OnTradeMarketSearch( nvecIndex );
	end
	
end

-- BuyItem
function luaSearchMarket:BuyItem( nIndex )
	
	luaSearchMarket.BuyItemID			= -1;
	luaSearchMarket.BuyItemIndex		= -1;
	luaSearchMarket.BuyItemAmount		= 0;
	luaSearchMarket.BuyItemUnitPrice	= 0;
	
	-- Controll Init
	frmConfirmBuyItem:SetText( STR( "UI_SHOP_BUY") );
	tvwConfirmBuyitemNum:Show( false );
	btnBoughtOk:Show( false );
	edtBuyItemNum:Show( true );
	btnBuyOk:Show( true );
	btnBuyCancel:Show( true );
	
	luaSearchMarket.BuyItemIndex		= lcSearchItemsList:GetItemData( nIndex );
	
	if( 0 > luaSearchMarket.BuyItemIndex )		then
		return ;
	end
	
	lcSearchItemsList:SetCurSel( luaSearchMarket.BuyItemIndex );
	
	luaSearchMarket:ShowfrmConfirmBuyItem();
	
end

-- ShowfrmConfirmBuyItem
function luaSearchMarket:ShowfrmConfirmBuyItem()
	
	if( true == frmConfirmBuyItem:GetShow() )	then
		return ;
	end
	
	-- ItemID
	luaSearchMarket.BuyItemID	= gamefunc:GetSearchItemID( luaSearchMarket.Step, luaSearchMarket.BuyItemIndex );	-- Index
	
	if( 0 > luaSearchMarket.BuyItemID )		then
		return ;
	end
		
	local x, y = frmConfirmBuyItem:GetParent():GetPosition();
	local w, h = frmConfirmBuyItem:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmConfirmBuyItem:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);
	frmConfirmBuyItem:DoModal();
	
	-- Item Color
	local r, g, b		= GetItemColor( luaSearchMarket.BuyItemID );
	
	-- Message
	local nEnchantGrade	= gamefunc:GetSearchItemEnchantGrade( luaSearchMarket.Step, luaSearchMarket.BuyItemIndex );
	local strItemName	= "{FONT name=\"fntBold\"}" .. "{COLOR r=" .. r .. " g=" .. g .. " b=" .. b .. "}" .. gamefunc:GetItemName( luaSearchMarket.BuyItemID, nEnchantGrade ) .. "{/COLOR}{/FONT}";
	tvwConfirmBuyItem:SetText( FORMAT( "UI_TRADEMAKET_BUY_ITEM", strItemName ) );
	
	-- Item Image
	local strItemImage = "{BITMAP name=\"bmpItemSlot\" w=42 h=42}{CR h=1}{SPACE w=1}{BITMAP name=\"" .. gamefunc:GetItemImage( luaSearchMarket.BuyItemID ) .. "\" w=40 h=40}{CR h=0}"
	tvwConfirmBuyItemImage:SetText( strItemImage );
	
	-- Item Name 
	tvwConfirmBuyItemName:SetText( strItemName );
	
	-- Buy Num
	luaSearchMarket.BuyItemAmount	= gamefunc:GetSearchItemAmount( luaSearchMarket.Step, luaSearchMarket.BuyItemIndex );
	edtBuyItemNum:SetText( luaSearchMarket.BuyItemAmount );
	
	-- Unit Price
	luaSearchMarket.BuyItemUnitPrice	= gamefunc:GetSearchItemPrice( luaSearchMarket.Step, luaSearchMarket.BuyItemIndex );
	local strUnitPrice					= "{FONT name=\"fntBold\"}{ALIGN hor=\"right\" ver=\"bottom\"}" .. luaGame:ConvertMoneyToStr( luaSearchMarket.BuyItemUnitPrice, "fntSmall");
	tvwConfirmBuyItemUnitPrice:SetText( strUnitPrice );

	-- Total Price
	luaSearchMarket:UpdateTotalPrice();
		
	frmConfirmBuyItem:Show( true );
	
end

-- UpdateTotalPrice
function luaSearchMarket:UpdateTotalPrice()
	
	if ( nil == edtBuyItemNum:GetText() ) or ( "" == edtBuyItemNum:GetText() )		then
		luaSearchMarket.BuyItemAmount	= 0;
	else
		luaSearchMarket.BuyItemAmount	= tonumber( edtBuyItemNum:GetText() );
	end
	
	local TotalPrice				= luaSearchMarket.BuyItemUnitPrice * luaSearchMarket.BuyItemAmount;
	local strTotalPrice				= "{FONT name=\"fntBold\"}{ALIGN hor=\"right\" ver=\"bottom\"}" .. luaGame:ConvertMoneyToStr( TotalPrice, "fntSmall");
	tvwConfirmBuyItemTotalPrice:SetText( strTotalPrice );
	
end


-- OnValueChangedConfirmNum
function luaSearchMarket:OnValueChangedConfirmNum()

	local nMaxValue		= gamefunc:GetSearchItemAmount( luaSearchMarket.Step, luaSearchMarket.BuyItemIndex );
	local nValue		= tonumber( edtBuyItemNum:GetText() );
	
	if( nValue < 1 )				then
		nValue			= "";
	elseif( nValue > nMaxValue )	then
		nValue			= nMaxValue;
	end
	
	edtBuyItemNum:SetText( nValue );	
	
	luaSearchMarket:UpdateTotalPrice();
	
end

-- btnClickBuyItem
function luaSearchMarket:btnClickBuyItem()
	
	if( 1 > luaSearchMarket.BuyItemAmount )	then
		luaTradeMarket:ShowConfirmTradeMarket( STR( "UI_TRADE_MARKET_BUYITEM_AMOUNTERROR" ) );
		return ;
	end

	frmConfirmBuyItem:Show( false );
	
	if( 0 > luaSearchMarket.BuyItemIndex )	then
		return ;
	end

	local TotalPrice		= luaSearchMarket.BuyItemAmount * luaSearchMarket.BuyItemAmount;
	
	-- 소지금 부족 체크
	if( TotalPrice > gamefunc:GetMoney() )		then
		luaTradeMarket:ShowConfirmTradeMarket( STR( "UI_MAILBOX_NOTENOUGHMONEY" ) );
		return ;
	end
	
	gamefunc:BuySearchItem( luaSearchMarket.BuyItemIndex, luaSearchMarket.BuyItemAmount );
		
end

-- OnTradeMarketBought
function luaSearchMarket:OnTradeMarketBought( bResult )

	if( 0 == bResult )		then
		-- 현재 아이템 목록에 대한 리스트 갱신
		gamefunc:TradeMarketSearch( luaSearchMarket.BuyItemID, luaSearchMarket.ListSort );
		return ;
	end
	
	frmConfirmBuyItem:Show( false );
	-- 구입 정보를 들고 있으므로 수정만 해주면 된다??
	frmConfirmBuyItem:SetText( STR( "UI_CONFIRM") );
	tvwConfirmBuyitemNum:Show( true );
	btnBoughtOk:Show( true );
	edtBuyItemNum:Show( false );
	btnBuyOk:Show( false );
	btnBuyCancel:Show( false );
	
	-- Item Color
	local r, g, b		= GetItemColor( luaSearchMarket.BuyItemID );
	
	local nEnchantGrade	= gamefunc:GetSearchItemEnchantGrade( luaSearchMarket.Step, luaSearchMarket.BuyItemIndex );
	-- Message
	local strItemName	= "{FONT name=\"fntBold\"}" .. "{COLOR r=" .. r .. " g=" .. g .. " b=" .. b .. "}" .. gamefunc:GetItemName( luaSearchMarket.BuyItemID, nEnchantGrade ) .. "{/COLOR}{/FONT}";
	tvwConfirmBuyItem:SetText( FORMAT( "UI_TRADEMAKET_BOUGHT_ITEM", strItemName ) );
	
	-- Item Image
	local strItemImage = "{BITMAP name=\"bmpItemSlot\" w=42 h=42}{CR h=1}{SPACE w=1}{BITMAP name=\"" .. gamefunc:GetItemImage( luaSearchMarket.BuyItemID ) .. "\" w=40 h=40}{CR h=0}"
	tvwConfirmBuyItemImage:SetText( strItemImage );
	
	-- Item Name 
	--local strItemName	= "{FONT name=\"fntBold\"}" .. "{COLOR r=" .. r .. " g=" .. g .. " b=" .. b .. "}" .. gamefunc:GetItemName( luaSearchMarket.BuyItemID, nEnchantGrade ) .. "{/COLOR}{/FONT}";
	tvwConfirmBuyItemName:SetText( strItemName );
	
	-- Buy Num
	tvwConfirmBuyitemNum:SetText( luaSearchMarket.BuyItemAmount );
	
	-- Unit Price
	local strUnitPrice					= "{FONT name=\"fntBold\"}{ALIGN hor=\"right\" ver=\"bottom\"}" .. luaGame:ConvertMoneyToStr( luaSearchMarket.BuyItemUnitPrice, "fntSmall");
	tvwConfirmBuyItemUnitPrice:SetText( strUnitPrice );

	-- Total Price
	local TotalPrice				= luaSearchMarket.BuyItemUnitPrice * luaSearchMarket.BuyItemAmount;
	local strTotalPrice				= "{FONT name=\"fntBold\"}{ALIGN hor=\"right\" ver=\"bottom\"}" .. luaGame:ConvertMoneyToStr( TotalPrice, "fntSmall");
	tvwConfirmBuyItemTotalPrice:SetText( strTotalPrice );
		
	frmConfirmBuyItem:DoModal();
	frmConfirmBuyItem:Show( true );
	
	-- 현재 아이템 목록에 대한 리스트 갱신
	gamefunc:TradeMarketSearch( luaSearchMarket.BuyItemID, luaSearchMarket.ListSort );
	
end

-- ToolTipSearchItem
function luaSearchMarket:ToolTipSearchItem()

	local strToolTip = "";
							
	local nCurSel = lcSearchItemsList:GetMouseOver();
	if( nCurSel < 0 )		then
		return ;
	end
	
	local nvecIndex		= lcSearchItemsList:GetItemData( nCurSel );
	local nItemID		= gamefunc:GetSearchItemID( luaSearchMarket.Step, nvecIndex );
	local nEnchantGrade	= gamefunc:GetSearchItemEnchantGrade( luaSearchMarket.Step, nvecIndex );
	local nElementType, nElementGrade = gamefunc:GetSearchItemElementEnchantData( luaSearchMarket.Step, nvecIndex );
	
	local nTooltipIndex	= nil;
	if( luaSearchMarket.SEARCHSTEP.STEP_LIST == luaSearchMarket.Step )		then
		nTooltipIndex	= gamefunc:GetTradeMarketTooltipIndex( luaTradeMarket.LISTTYPE.LIST_SEARCH, luaSearchMarket.Step, nvecIndex );
		if( 0 > nTooltipIndex )	then
			return ;
		end
	end
	
	local nSlotType = gamefunc:GetItemSlot( nItemID );
	if ( nSlotType ~= ITEM_SLOT.NONE)  and  ( gamefunc:GetEquippedItemID( nSlotType) > 0)  then
		
		strToolTip = strToolTip .. "{divide}" ..
					ToolTipDivideColor() .. "< " .. STR( "UI_EQUIPPEDITEM") .. " >{/COLOR}\n" .. luaToolTip:OnToolTipEquipItem( nItemID );
	end
	
	strToolTip = luaToolTip:GetItemToolTip( nItemID, nil, nil, nTooltipIndex, nEnchantGrade, nElementType, nElementGrade );
	
	local nSlotType = gamefunc:GetItemSlot( nItemID );
	if ( nSlotType ~= ITEM_SLOT.NONE)  and  ( gamefunc:GetEquippedItemID( nSlotType) > 0)  then
		strToolTip = strToolTip .. "{divide}" ..
					 ToolTipDivideColor() .. "< " .. STR( "UI_EQUIPPEDITEM") .. " >{/COLOR}\n" .. luaToolTip:OnToolTipEquipItem( nItemID );
	end
	
	lcSearchItemsList:SetToolTip( strToolTip );
	
end

-- SearchSort
function luaSearchMarket:SearchSort()
	
	gamefunc:SearchListSort( luaSearchMarket.Step, luaSearchMarket.ListSort );	
	
	if( luaSearchMarket.SEARCHSTEP.STEP_ITEMCATAGORY == luaSearchMarket.Step )	then
		-- 리스트 갱신
		luaSearchMarket:RefreshSearchMarket( luaSearchMarket.Step, luaSearchMarket.REFRESHSTEP.REFRESHTAB );
	end
	
end

-- SearchSortName
function luaSearchMarket:SearchSortName()
	
	if( luaSearchMarket.SEARCHSTEP.STEP_ITEMCATAGORY ~= luaSearchMarket.Step )				then
		return ;
	end
	
	if( luaTradeMarket.SORT.SORT_NAME == luaSearchMarket.ListSort )	then
		luaSearchMarket.ListSort	= luaTradeMarket.SORT.SORT_NAME_DESCENDANT;
	else
		luaSearchMarket.ListSort	= luaTradeMarket.SORT.SORT_NAME;
	end
	
	luaSearchMarket:SearchSort();
	
end

-- SearchSortLevel
function luaSearchMarket:SearchSortLevel()

	if( luaSearchMarket.SEARCHSTEP.STEP_ITEMCATAGORY ~= luaSearchMarket.Step )				then
		return ;
	end
	
	if( luaTradeMarket.SORT.SORT_LEVEL == luaSearchMarket.ListSort )	then
		luaSearchMarket.ListSort	= luaTradeMarket.SORT.SORT_LEVEL_DESCENDANT;
	else
		luaSearchMarket.ListSort	= luaTradeMarket.SORT.SORT_LEVEL;
	end
	
	luaSearchMarket:SearchSort();
	
end

-- SearchSortAmount
function luaSearchMarket:SearchSortAmount()

	if( luaSearchMarket.SEARCHSTEP.STEP_LIST ~= luaSearchMarket.Step )				then
		return ;
	end
	
	-- 수량은 많은것부터 해주자
	if( luaTradeMarket.SORT.SORT_AMOUNT_DESCENDANT == luaSearchMarket.ListSort )	then
		luaSearchMarket.ListSort	= luaTradeMarket.SORT.SORT_AMOUNT;
	else
		luaSearchMarket.ListSort	= luaTradeMarket.SORT.SORT_AMOUNT_DESCENDANT;
	end
	
	luaSearchMarket:SearchSort();
	
end

-- SearchSortPrice
function luaSearchMarket:SearchSortPrice()

	if( luaSearchMarket.SEARCHSTEP.STEP_LIST ~= luaSearchMarket.Step )				then
		return ;
	end
	
	if( luaTradeMarket.SORT.SORT_PRICE == luaSearchMarket.ListSort )	then
		luaSearchMarket.ListSort	= luaTradeMarket.SORT.SORT_PRICE_DESCENDANT;
	else
		luaSearchMarket.ListSort	= luaTradeMarket.SORT.SORT_PRICE;
	end
	
	luaSearchMarket:SearchSort();
	
end

-- InitpnlTradeMarketSearch
function luaSearchMarket:InitpnlTradeMarketSearch()

	-- Search
	pnlTradeMarketSearch:SetPosition( 0, 5 );
	
	local pnlWidth, pnlHeight	= pnlTradeMarketSearch:GetSize();
	
	-- Search Btn
	local btnWidth, btnHeight	= btnItemSearch:GetSize();
	local btnX, btnY			= btnItemSearch:GetPosition();
	btnX						= ( pnlWidth - btnWidth ) - 5;
	btnItemSearch:SetPosition( btnX, btnY );
	btnY						= btnY+1;
	
	-- SearchName Edt
	local editWidth, editHeight	= edtSearchName:GetSize();
	local editX, editY			= edtSearchName:GetPosition();
	editX						= ( btnX - editWidth ) - 10;
	edtSearchName:SetPosition( editX, btnY );
	
	-- SearchName Label
	local lbWidth, lbHeight	= lbSearchName:GetSize();
	lbWidth					= gamedraw:GetTextWidth( "fntScript", lbSearchName:GetText() ) + 10;
	local lbX, lbY		= lbSearchName:GetPosition();
	lbX					= ( editX - lbWidth ) - 5;
	lbSearchName:SetSize( lbWidth, lbHeight );
	lbSearchName:SetPosition( lbX, btnY );
	
	-- MaxLevel Edt
	local editWidth, editHeight	= edtSearchMaxLevel:GetSize();
	local editX, editY			= edtSearchMaxLevel:GetPosition();
	editX						= ( lbX - editWidth ) - 15;
	edtSearchMaxLevel:SetPosition( editX, btnY );
	
	-- ~
	local lbWidth, lbHeight		= lbLevelRange:GetSize();
	local lbX, lbY				= lbLevelRange:GetPosition();
	lbX							= editX - lbWidth;
	lbLevelRange:SetPosition( lbX, btnY );
	
	-- MinLevel Edt
	editX						= lbX - editWidth;
	edtSearchMinLevel:SetPosition( editX, btnY );
	
	-- SearchLevel Label
	local lbWidth, lbHeight	= lbSearchLevel:GetSize();
	lbWidth					= gamedraw:GetTextWidth( "fntScript", lbSearchLevel:GetText() ) + 10;
	local lbX, lbY		= lbSearchLevel:GetPosition();
	lbX					= ( editX - lbWidth ) - 5;
	lbSearchLevel:SetSize( lbWidth, lbHeight );
	lbSearchLevel:SetPosition( lbX, btnY );
	
	-- Search SeperateBar
	local pnlX, pnlY			= pnlTradeMarketSearch:GetPosition();
	local SearchSeperateBarY	= pnlY + pnlHeight;
	picTradeMarketSearchSeperateBar:SetPosition( 0, pnlHeight - 2 );
		
end

-- SearchItem
function luaSearchMarket:SearchItem()

	local nIndex = tbcTradeMarketTabCtrl:GetSelIndex();	
	if( luaTradeMarket.TABCTRL.SEARCH_ITEM ~= nIndex )				then
		return ;	
	end
	
	luaSearchMarket.ListSort			= luaTradeMarket.SORT.SORT_NAME;

	luaSearchMarket.strSearchName	= edtSearchName:GetText();
	luaSearchMarket.nSearchLvMax	= tonumber( edtSearchMaxLevel:GetText() );
	luaSearchMarket.nSearchLvMin	= tonumber( edtSearchMinLevel:GetText() );
	
	if( nil == luaSearchMarket.strSearchName ) 	then
		luaSearchMarket.strSearchName		= "";
	end
	
	if( nil == luaSearchMarket.nSearchLvMax )	then
		luaSearchMarket.nSearchLvMax		= 0;
	end
	
	if( ( nil == luaSearchMarket.nSearchLvMin )	or ( 1 == luaSearchMarket.nSearchLvMin ) ) then
		luaSearchMarket.nSearchLvMin		= 0;
	end
	
	if( ( "" == luaSearchMarket.strSearchName ) and ( 0 == luaSearchMarket.nSearchLvMax ) and ( 0 == luaSearchMarket.nSearchLvMin ) )		then
		luaSearchMarket:RefreshSearchMarket( luaSearchMarket.SEARCHSTEP.STEP_RESULT, 0 );
		return ;
	end
	
	if( ( "" ~= luaSearchMarket.strSearchName )	and ( luaSearchMarket.nSearchTextLimit > edtSearchName:GetLength() ) ) then
		return ;
	end
	
	if( luaSearchMarket.nSearchLvMin > luaSearchMarket.nSearchLvMax ) 		then
		luaSearchMarket:RefreshSearchMarket( luaSearchMarket.SEARCHSTEP.STEP_RESULT, 0 );
		return ;
	end
	
	if( 0 ~= luaSearchMarket.nSearchLvMax ) then
		luaSearchMarket.ListSort			= luaTradeMarket.SORT.SORT_LEVEL;
	end
	
	luaSearchMarket.nListStartIndex		= 0;
	
	gamefunc:SearchItemName( luaSearchMarket.strSearchName, luaSearchMarket.ListSort, luaSearchMarket.nSearchLvMin, luaSearchMarket.nSearchLvMax );
	
	-- 화면 잠시 홀드
	luaTradeMarket:TradeMarketBlackScreen( true );

end

-- InitSearch
function luaSearchMarket:InitSearch()
	
	edtSearchName:SetText( luaSearchMarket.strSearchName );
	
	if( 0 == tonumber( luaSearchMarket.nSearchLvMax ) )					then
		edtSearchMaxLevel:SetText( "" );
	else
		edtSearchMaxLevel:SetText( luaSearchMarket.nSearchLvMax );
	end
	
	if( 0 == tonumber( luaSearchMarket.nSearchLvMin ) )					then
		edtSearchMinLevel:SetText( "" );
	else
		edtSearchMinLevel:SetText( luaSearchMarket.nSearchLvMin );
	end	
	
end

-- PageBtnClick
function luaSearchMarket:PageBtnClick( strBtn )
	
	if( "btnPrevPage" == strBtn )			then
		luaSearchMarket.nListStartIndex		= luaSearchMarket.nListStartIndex - luaSearchMarket.ItemListMax;
	elseif( "btnNextPage" == strBtn )		then
		luaSearchMarket.nListStartIndex		= luaSearchMarket.nListStartIndex + luaSearchMarket.ItemListMax;	
	elseif( "btnFirstPage" == strBtn )		then
		luaSearchMarket.nListStartIndex		= 0;
	end
	
	if( luaSearchMarket.nListStartIndex < 0 )	then
		luaSearchMarket.nListStartIndex		= 0;
	end
	
	local nListCount		= gamefunc:GetSearchItemsCnt( luaSearchMarket.Step );
	if( luaSearchMarket.nListStartIndex	> nListCount - 1 )	then
		luaSearchMarket.nListStartIndex	= luaSearchMarket.nListStartIndex - luaSearchMarket.ItemListMax;
	end
	
	if( luaSearchMarket.SEARCHSTEP.STEP_ITEMCATAGORY == luaSearchMarket.Step )	then
		gamefunc:TradeMarketSearchPageStatistics( luaSearchMarket.nListStartIndex );
	else
		luaSearchMarket:RefreshListSearchItem();
	end
	
	-- 화면 잠시 홀드
	luaTradeMarket:TradeMarketBlackScreen( true );

end

-- InitPage
function luaSearchMarket:SetPage( nMaxCnt )

	btnSearchFirstPage:Enable( false );
	btnSearchPrevPage:Enable( false );
	btnSearchNextPage:Enable( false );
	
	-- 이전과 처음으로 버튼 검사
	if( 0 < luaSearchMarket.nListStartIndex )		then
		btnSearchFirstPage:Enable( true );
		btnSearchPrevPage:Enable( true );
	end
	
	local nPage, nMaxPage;
	if( 0 == nMaxCnt )		then
		nPage			= -1;
		nMaxPage		= 0;
	else
		nPage			= math.floor( luaSearchMarket.nListStartIndex / luaSearchMarket.ItemListMax );
		nMaxPage		= math.floor( nMaxCnt / luaSearchMarket.ItemListMax );
		if( 0 < nMaxCnt % luaSearchMarket.ItemListMax )	then
			nMaxPage	= nMaxPage + 1;
		end
		
	end
	
	local strPage = "{FONT name=\"fntBold\"}{COLUMN h=22}{ALIGN hor=\"center\" ver=\"center\"}" .. nPage+1 .. "\/" .. nMaxPage;
	tvwSearchPage:SetText( strPage );
	
	-- 다음 버튼 검사
	if( nMaxCnt > ( luaSearchMarket.nListStartIndex + luaSearchMarket.ItemListMax ) )	then
		btnSearchNextPage:Enable( true );
	end

end

-- OnOnUpdatepnlTradeMarketSearch
function luaSearchMarket:OnOnUpdatepnlTradeMarketSearch()
	
	local bSearchBtn	= true;
	
	local nIndex = tbcTradeMarketTabCtrl:GetSelIndex();	
	if( luaTradeMarket.TABCTRL.SEARCH_ITEM ~= nIndex )				then
		bSearchBtn	= false;
	end
	
	luaSearchMarket.ListSort			= luaTradeMarket.SORT.SORT_NAME;

	luaSearchMarket.strSearchName	= edtSearchName:GetText();
	luaSearchMarket.nSearchLvMax	= tonumber( edtSearchMaxLevel:GetText() );
	luaSearchMarket.nSearchLvMin	= tonumber( edtSearchMinLevel:GetText() );
	
	if( nil == luaSearchMarket.strSearchName ) 	then
		luaSearchMarket.strSearchName		= "";
	end
	
	if( nil == luaSearchMarket.nSearchLvMax )	then
		luaSearchMarket.nSearchLvMax		= 0;
	end
	
	if( ( nil == luaSearchMarket.nSearchLvMin )	or ( 1 == luaSearchMarket.nSearchLvMin ) ) then
		luaSearchMarket.nSearchLvMin		= 0;
	end
	
	if( ( "" == luaSearchMarket.strSearchName ) and ( 0 == luaSearchMarket.nSearchLvMax ) and ( 0 == luaSearchMarket.nSearchLvMin ) )		then
		bSearchBtn	= false;
	end
	
	if( ( "" ~= luaSearchMarket.strSearchName )	and ( luaSearchMarket.nSearchTextLimit > edtSearchName:GetLength() ) ) then
		return ;
	end
	
	if( luaSearchMarket.nSearchLvMin > luaSearchMarket.nSearchLvMax ) 		then
		bSearchBtn	= false;
		return ;
	end
	
	if( 0 ~= luaSearchMarket.nSearchLvMax ) then
		luaSearchMarket.ListSort			= luaTradeMarket.SORT.SORT_LEVEL;
	end
	
	btnItemSearch:Enable( bSearchBtn );

end