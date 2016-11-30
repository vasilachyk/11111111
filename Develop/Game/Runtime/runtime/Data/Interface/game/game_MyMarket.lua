--[[
	Game MyMarket LUA script
--]]


-- Global instance
luaMyMarket							= {};
luaMyMarket.REGISTERED_COLUMN		= { NAME = 0,  LEVEL = 1, QUANTITY = 2,  UINTPRICE = 3,  EXPIRY = 4, STATE = 5 };
luaMyMarket.CALULATE_COLUMN			= { NAME = 0,  LEVEL = 1, QUANTITY = 2,  PRICE = 3,  EXPIRY = 4 };
luaMyMarket.CALCTYPE				= { SOLDITEM = 0, EXPIREDITEM = 1 };
luaMyMarket.RegisterItemID			= -1;
luaMyMarket.RegisterItemSlotID		= -1;
luaMyMarket.UnRegisterItemIndex		= -1;
luaMyMarket.RegisterAmount			= 0;
luaMyMarket.UnitPrice				= 0;
luaMyMarket.TotalPrice				= 0;
luaMyMarket.Commition				= 0;
luaMyMarket.nTotalPriceMin			= 20;
luaMyMarket.nTotalPriceMax			= 400000000;
luaMyMarket.nRegisteredStartIndex	= 0;
luaMyMarket.nCalulateStartIndex		= 0;
luaMyMarket.ItemListMax				= 6;
luaMyMarket.CalcItemIndex			= -1;

-- OnLoadedMyMarket
function luaMyMarket:OnLoadedMyMarket()

	local pgWidth, pgHeight	= pnlMyMarket:GetSize();

	--[[
	-- 상단 바
	nX			= 0;
	nY			= ( nY + nH ) + 5;
	nW, nH		= picMyMarketTopSeperateBar:GetSize();
	picMyMarketTopSeperateBar:SetPosition( nX, nY );
	]]--

	local nX, nY, nW, nH;
	-- 판매 관리
	
	if( true == gamefunc:IsLocale_de_DE() )		then
		nY	= 5;
	else
		nY	= 10;
	end
	
	nW, nH		= tvwSalesMng:GetSize();
	nX			= 10;
	tvwSalesMng:SetPosition( nX, nY );

	-- 판매 관리 리스트
	nX			= 10;
	nY			= ( nY + nH ) + 5;
	nW, nH		= lcSalesManagement:GetSize();
	lcSalesManagement:SetPosition( nX, nY );

	-- 판매 페이지
	nX			= 0;
	nY			= ( nY + nH ) + 10;
	nW, nH		= pnlRegisteredPage:GetSize();
	pnlRegisteredPage:SetPosition( nX, nY );

	-- 물품 등록 버튼
	nW, nH			= btnRegister:GetSize();
	if( true == gamefunc:IsLocale_de_DE() )		then
		nX				= ( pgWidth - nW ) - 5;
	else
		nX				= ( pgWidth - nW ) - 30;
	end
	btnRegister:SetPosition( nX, nY );

	-- 등록 갯수 표시
	nW, nH		= RegisteredCnt:GetSize();
	nX			= ( nX - nW );
	RegisteredCnt:SetPosition( nX, nY+5 );

	-- 구분바
	nX			= 0;
	nW, nH		= btnRegister:GetSize();
	nY			= ( nY + nH ) + 5;
	nW, nH		= picMyMarketSeperateBar:GetSize();
	picMyMarketSeperateBar:SetPosition( nX, nY );

	-- 정산
	if( true == gamefunc:IsLocale_de_DE() )		then
		nY			= ( nY + nH ) + 2;
	else
		nY			= ( nY + nH ) + 7;
	end
	
	nW, nH		= tvwCalculate:GetSize();
	--nX			= ( pgWidth - nW ) / 2;
	nX			= 10;
	tvwCalculate:SetPosition( nX, nY );

	-- 정산 리스트
	nX			= 10;
	nY			= ( nY + nH ) + 5;
	nW, nH		= lcCalculate:GetSize();
	lcCalculate:SetPosition( nX, nY );

	-- 정산 페이지
	nX			= 0;
	nY			= ( nY + nH ) + 10;
	nW, nH		= pnlCalculatePage:GetSize();
	pnlCalculatePage:SetPosition( nX, nY );

	-- 모두 정산 버튼
	nW, nH		= btnAllCalculateItem:GetSize();
	nX			=  ( pgWidth - nW ) / 2;
	nY			= ( nY + nH ) + 10;
	btnAllCalculateItem:SetPosition( nX, nY );
	
	luaMyMarket:InitSalesManagement();
	luaMyMarket:InitCalculateList();
	luaMyMarket:InitCancelBtn();
	luaMyMarket:InitCaculateBtn();
	
end

-- InitMyMarket
function luaMyMarket:InitMyMarket()
	
	luaMyMarket:InitMyMarketControl();
	luaMyMarket:InitRegisterItemInfo();

end

-- InitMyMarketControl
function luaMyMarket:InitMyMarketControl()
	
	luaMyMarket:ClosefrmRegisterItem();
	frmConfirmUnRegisterItem:Show( false );
	luaMyMarket.CalcItemIndex			= -1;
	
	if( luaTradeMarket.TABCTRL.MY_MARKET == luaTradeMarket.CurrTab )	then
		luaMyMarket:ShowMyMarketItems();
	end
	
end

-- ShowMyMarketItems
function luaMyMarket:ShowMyMarketItems()
	
	gamefunc:ShowMyMarketItems();
end

-- RefreshMyMarketItems
function luaMyMarket:RefreshMyMarketItems()

	luaMyMarket:RefreshMySaileList();
	luaMyMarket:RefreshMySoldList();

end

-- InitSalesManagement
function luaMyMarket:InitSalesManagement()
	
	lcSalesManagement:SetColumnText( luaMyMarket.REGISTERED_COLUMN.NAME, STR( "ITEM" ) );
    lcSalesManagement:SetColumnText( luaMyMarket.REGISTERED_COLUMN.LEVEL, STR( "LEVEL" ) );
    lcSalesManagement:SetColumnText( luaMyMarket.REGISTERED_COLUMN.QUANTITY, STR( "QUANTITY" ) );
    lcSalesManagement:SetColumnText( luaMyMarket.REGISTERED_COLUMN.UINTPRICE, STR( "UI_TRADEMAKET_UNITPRICE" ) );
    lcSalesManagement:SetColumnText( luaMyMarket.REGISTERED_COLUMN.EXPIRY, STR( "UI_TRADEMAKET_EXPIRY" ) );
	lcSalesManagement:SetColumnText( luaMyMarket.REGISTERED_COLUMN.STATE, STR( "UI_TRADEMAKET_CACULATE_SAILES_STATE" ) );
    
end



-- OnSelectedItemFromInventory
function luaMyMarket:OnSelectedItemFromInventory( nIndex, nID )
	
	if( luaMyMarket:CheckConfirmTradeMarket(nIndex, nID) == false ) then
		return;
	end

	luaMyMarket:RegisterItemInfo( nIndex, nID );

end



-- OnDropItem
function luaMyMarket:OnDropItem()
	
	local _wnd		= _G[ EventArgs:GetOwner():GetName() ];
	local _sender	= _G[ DragEventArgs:GetSender():GetName() ];
	
	if( _sender ~= lcInventory and _sender ~= lcExInventory )  then
		-- 인벤이 아니면 등록 불가
		return ;
	end
	
	local nIndex	= DragEventArgs:GetItemData( 0 );
	local nID		= gamefunc:GetInvenItemID( nIndex );
	
	luaMyMarket:OnSelectedItemFromInventory( nIndex, nID );
end



-- CheckConfirmTradeMarket
function luaMyMarket:CheckConfirmTradeMarket( nIndex, nID )

	if( ( nIndex < 0 ) or ( nID < 0 ) )	then
		return false;
	end
	
	if( nIndex == luaMyMarket.RegisterItemID ) then
		return false;
	end
	
	-- 거래불가, 팔기불가 체크
	if( false == gamefunc:CheckTradeItem( nIndex ) )	then
		luaTradeMarket:ShowConfirmTradeMarket( STR( "UI_TRADEMAKET_REGISTER_IMPOSSIBLEITEM_TEXT" ) );
		return false;
	end

	return true;

end




-- RegisterItemInfo
function luaMyMarket:RegisterItemInfo( nSlotID, nItemID )
	
	luaMyMarket.RegisterItemSlotID	= nSlotID;
	luaMyMarket.RegisterItemID		= nItemID;
	
	-- Item 이미지
	local strImage = gamefunc:GetItemImage( luaMyMarket.RegisterItemID );
	if ( nil == strImage )  or  ( "" == strImage )	then
			strImage = "iconUnknown"
	end
	RegisterItemImage:SetImage( strImage );

	-- Item 이름
	local r, g, b	= GetItemColor( luaMyMarket.RegisterItemID );
	local strName = "{FONT name=\"fntScript\"}{ALIGN hor=\"center\" ver=\"center\"}{COLOR r=" .. r .. " g=" .. g .. " b=" .. b .. "}"
					--.. gamefunc:GetItemName( luaMyMarket.RegisterItemID );
					.. gamefunc:GetInvenItemName( luaMyMarket.RegisterItemSlotID );
	tvwRegisterItemName:SetText( strName );

	--gamedebug:Log( "RegisterItemInfo " .. strName );

	-- Default
	edtPriceGP:SetText( 0 );
	edtPriceSP:SetText( 0 );
	edtPriceCP:SetText( 0 );
	
	-- Item 갯수
	luaMyMarket.RegisterAmount	= gamefunc:GetInvenItemQuantity( luaMyMarket.RegisterItemSlotID );
	edtRegisterAmount:SetText( luaMyMarket.RegisterAmount );
	
	-- Play sound
	local strSound = gamefunc:GetItemPutUpSound( nItemID);
	gamefunc:PlaySound( strSound);

	-- 정보 변경
	luaMyMarket:UpdateRegisterInfo();
	
end

-- ToolTipRegisterItem()
function luaMyMarket:ToolTipRegisterItem()
	
	local strToolTip = "";
							
	if( luaMyMarket.RegisterItemID < 0 )	then
		return ;
	end
	
	strToolTip = luaToolTip:GetItemToolTip( luaMyMarket.RegisterItemID, luaMyMarket.RegisterItemSlotID, nil );
	local nSlotType = gamefunc:GetItemSlot( luaMyMarket.RegisterItemID );
	if ( nSlotType ~= ITEM_SLOT.NONE)  and  ( gamefunc:GetEquippedItemID( nSlotType) > 0)  then
		strToolTip = strToolTip .. "{divide}" ..
					 ToolTipDivideColor() .. "< " .. STR( "UI_EQUIPPEDITEM") .. " >{/COLOR}\n" .. luaToolTip:OnToolTipEquipItem( luaMyMarket.RegisterItemID );
	end
	
	tvwDropArea:SetToolTip( strToolTip);
	
end

-- OnValueChangedConfirmNum
function luaMyMarket:OnValueChangedConfirmNum()
	
	local nMaxValue		= gamefunc:GetInvenItemQuantity( luaMyMarket.RegisterItemSlotID ); 
	local nValue		= tonumber( edtRegisterAmount:GetText() );
	
	if( nValue < 1 )				then
		nValue			= 1;
	elseif( nValue > nMaxValue )	then
		nValue			= nMaxValue;
	end
	
	edtRegisterAmount:SetText( nValue );	
	
end

-- OnValueChangedConfirmMoney
function luaMyMarket:OnValueChangedConfirmMoney( Edit, Limit )

	if( nil == Edit )		then
		return;
	end
	
	local strMax	= "";
	for i=1, Limit-1	do
		strMax		= strMax .. "9";
	end
	
	local strText		= Edit:GetText();
	if ( nil == strText ) or ( "" == strText )					then
		Edit:SetText( "0" );
	elseif( tonumber( strMax ) < tonumber( Edit:GetText() ) )	then
		Edit:SetText( strMax );
	end
	
	luaMyMarket:UpdateRegisterInfo();
	
end

-- UpdateRegisterInfo()
function luaMyMarket:UpdateRegisterInfo()
	
	tvwTotalPrice:SetText( "" );
	--tvwCommition:SetText( "" );
	
	-- 등록 물품 없음
	if( luaMyMarket.RegisterItemID < 0 )		then
		return ;
	end
	
	-- 등록 물품 갯수 없음
	luaMyMarket.RegisterAmount		= tonumber( edtRegisterAmount:GetText() );
	if( luaMyMarket.RegisterAmount < 1 )		then
		return ;
	end
	
	-- 총 가격
	luaMyMarket.UnitPrice	= 0;

	if( nil ~= edtPriceGP:GetText() )		then
		luaMyMarket.UnitPrice			= tonumber( edtPriceGP:GetText() ) * 10000;				-- Gold
	end
	
	if( nil ~= edtPriceSP:GetText() )		then
		luaMyMarket.UnitPrice			= luaMyMarket.UnitPrice + tonumber( edtPriceSP:GetText() ) * 100;	-- Silver
	end
	
	if( nil ~= edtPriceCP:GetText() )		then
		luaMyMarket.UnitPrice			= luaMyMarket.UnitPrice + tonumber( edtPriceCP:GetText() );		-- Copper
	end
	
	luaMyMarket.TotalPrice				= luaMyMarket.UnitPrice * luaMyMarket.RegisterAmount;
		
	local str = "{FONT name=\"fntBold\"}{COLUMN h=22}{ALIGN hor=\"right\" ver=\"bottom\"}" .. luaGame:ConvertMoneyToStr( luaMyMarket.TotalPrice, "fntSmall") .. "{SPACE w=10}";
	tvwTotalPrice:SetText( str );
	
	-- 수수료 계산
	luaMyMarket.Commition				= gamefunc:GetTradeMaketCommition( luaMyMarket.TotalPrice );
	
	str = "{FONT name=\"fntBold\"}{COLUMN h=22}{ALIGN hor=\"right\" ver=\"bottom\"}" .. luaGame:ConvertMoneyToStr( luaMyMarket.Commition, "fntSmall") .. "{SPACE w=10}";
	tvwCommition:SetText( str );
	
end

-- RefreshMySaileList
function luaMyMarket:RefreshMySaileList()

	local nIndex = tbcTradeMarketTabCtrl:GetSelIndex();	
	if( luaTradeMarket.TABCTRL.MY_MARKET ~= nIndex )				then
		return ;	
	end
	
	local nListCnt		= gamefunc:GetMySailesItemCnt();
	luaMyMarket:ShowCancelBtn( false );
	luaMyMarket.nRegisteredStartIndex		= 0;

	if( nListCnt < 1 )		then
		luaMyMarket:DeleteAllRegisterItems();
		luaMyMarket:SetRegisteredPage( 0 );
		return ;
	end
	
	luaMyMarket:RefreshMySaileItem();

end

-- RefreshMySoldList
function luaMyMarket:RefreshMySoldList()

	local nIndex = tbcTradeMarketTabCtrl:GetSelIndex();	
	if( luaTradeMarket.TABCTRL.MY_MARKET ~= nIndex )				then
		return ;	
	end
	
	luaMyMarket.nCalulateStartIndex		= 0;
	luaMyMarket:ShowCaculateBtn( false );
	btnAllCalculateItem:Enable( false );
	
	local nListCnt		= gamefunc:GetCalculateItemCnt();
		
	if( nListCnt < 1 )		then
		lcCalculate:DeleteAllItems();
		luaMyMarket:SetCalulatePage( 0 );
		luaMyMarket:ShowCaculateBtn( false );
		return ;
	end
	
	luaMyMarket:RefreshCalculateItem();
	
end

-- RefreshMySaileItem
function luaMyMarket:RefreshMySaileItem()
	
	luaMyMarket:DeleteAllRegisterItems();
	
	-- PageSetting
	local nListCount		= gamefunc:GetMySailesItemCnt();
	luaMyMarket:SetRegisteredPage( nListCount );
	
	local nID;
	local nEnchantGrade;
	local nEndIndex		= ( luaMyMarket.nRegisteredStartIndex + luaMyMarket.ItemListMax ) - 1;
	
	for i=luaMyMarket.nRegisteredStartIndex , nEndIndex			do
		
		nID				= gamefunc:GetMySailesItemID( i );	-- Index
		nEnchantGrade	= gamefunc:GetMySailesItemEnchantGrade( i );
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
		local nIndex = lcSalesManagement:AddItem( strName, strImage );
		
		lcSalesManagement:SetItemData( nIndex, i );
		lcSalesManagement:SetItemColor( nIndex, luaMyMarket.REGISTERED_COLUMN.NAME, r, g, b );
		
		-- Level
		local nItemLevel		= gamefunc:GetItemEquipReqLevel( nID );
		if( 1 > nItemLevel )	then
			nItemLevel			= 1;
		end
			
		lcSalesManagement:SetItemText( nIndex, luaMyMarket.REGISTERED_COLUMN.LEVEL, nItemLevel );
		lcSalesManagement:SetItemColor( nIndex, luaMyMarket.REGISTERED_COLUMN.LEVEL, r, g, b );
	
		-- QuanTity
		local nQuanTity	= gamefunc:GetMySailesItemAmount( i );
		lcSalesManagement:SetItemText( nIndex, luaMyMarket.REGISTERED_COLUMN.QUANTITY, nQuanTity );
		lcSalesManagement:SetItemColor( nIndex, luaMyMarket.REGISTERED_COLUMN.QUANTITY, 230, 230, 230 );
		
		-- UnitPrice
		local nUnitPrice	= gamefunc:GetMySailesItemPrice( i );
		lcSalesManagement:SetItemText( nIndex, luaMyMarket.REGISTERED_COLUMN.UINTPRICE, nUnitPrice );
		
		local nExpiry		= gamefunc:GetMySailesItemExpiry( i );
		local strExpiry, r, g, b	= luaTradeMarket:CalcItemExpiry( nExpiry );
		lcSalesManagement:SetItemText( nIndex, luaMyMarket.REGISTERED_COLUMN.EXPIRY, strExpiry );
		lcSalesManagement:SetItemColor( nIndex, luaMyMarket.REGISTERED_COLUMN.EXPIRY, r, g, b );

		-- 판매 기간 만료인지 체크
		local strState		= STR( "UI_TRADEMAKET_REGISTERED_ITEM" );
		r, g, b				= 230, 230, 230;
		if( true == gamefunc:IsUnRegisteredItem( i ) )		then
			strState		= STR( "UI_TRADEMAKET_UNREGISTERED_ITEM" );
			r, g, b			= 255, 45, 45;
		end

		-- text
		lcSalesManagement:SetItemText( nIndex, luaMyMarket.REGISTERED_COLUMN.STATE, strState );
		lcSalesManagement:SetItemColor( nIndex, luaMyMarket.REGISTERED_COLUMN.STATE, r, g, b );

		-- Calcel Btn
		luaMyMarket:ShowCancelBtn( true, nIndex );
		
	end

end

-- RefreshCalculateItem
function luaMyMarket:RefreshCalculateItem()
	
	lcCalculate:DeleteAllItems();
	luaMyMarket:ShowCaculateBtn( false );
	
	-- 모두 정산 아이템이 있나 확인
	if( true == gamefunc:IsSoldItems() )	then
		btnAllCalculateItem:Enable( true );
	end

	local nListCnt		= gamefunc:GetCalculateItemCnt();
	luaMyMarket:SetCalulatePage( nListCnt );

	local nID;
	local nEnchantGrade;
	local nEndIndex		= ( luaMyMarket.nCalulateStartIndex + luaMyMarket.ItemListMax ) - 1;

	for i=luaMyMarket.nCalulateStartIndex , nEndIndex			do

		nID				= gamefunc:GetCalculateItemID( i );
		if( nID < 0 )		then
			return;
		end
		
		nEnchantGrade	= gamefunc:GetCalculateItemEnchantGrade( i );
		local strName	= gamefunc:GetItemName( nID, nEnchantGrade );
		local strImage	= gamefunc:GetItemImage( nID );
		
		if ( nil == strImage )  or  ( "" == strImage )	then
			strImage = "iconUnknown"
		end

		local r, g, b	= GetItemColor( nID );
		
		-- ItemName
		local nIndex	= lcCalculate:AddItem( strName, strImage );
		lcCalculate:SetItemData( nIndex, i );
		lcCalculate:SetItemColor( nIndex, luaMyMarket.CALULATE_COLUMN.NAME, r, g, b );

		
		-- Level
		local nItemLevel		= gamefunc:GetItemEquipReqLevel( nID );
		if( 1 > nItemLevel )	then
			nItemLevel			= 1;
		end
		lcCalculate:SetItemText( nIndex, luaMyMarket.CALULATE_COLUMN.LEVEL, nItemLevel );
		lcCalculate:SetItemColor( nIndex, luaMyMarket.CALULATE_COLUMN.LEVEL, r, g, b );

		-- Amount
		local nAmount	= gamefunc:GetCalculateItemAmount( i );
		lcCalculate:SetItemText( nIndex, luaMyMarket.CALULATE_COLUMN.QUANTITY, nAmount );
		lcCalculate:SetItemColor( nIndex, luaMyMarket.CALULATE_COLUMN.QUANTITY, 230, 230, 230 );

		-- Price
		local Price		= gamefunc:GetCalculateItemSoldPrice( i );
		lcCalculate:SetItemText( nIndex, luaMyMarket.CALULATE_COLUMN.PRICE, Price );

		-- Expiry
		local nExpiry		= gamefunc:GetCalculateItemExpiry( i );
		local strExpiry, r, g, b	= luaTradeMarket:CalcItemExpiry( nExpiry );
		lcCalculate:SetItemText( nIndex, luaMyMarket.CALULATE_COLUMN.EXPIRY, strExpiry );
		lcCalculate:SetItemColor( nIndex, luaMyMarket.CALULATE_COLUMN.EXPIRY, r, g, b );

		-- Btn
		luaMyMarket:ShowCaculateBtn( true, nIndex );
--[[
		-- 기간만료인지 판매완료인지 검사
		local CalcType	= gamefunc:GetCalculateItemType( i );

		-- 판매상황 & 버튼
		local strState		= STR( "UI_TRADEMAKET_CALCULATE_SOLDITEM" );
		local strBtn		= STR( "UI_TRADEMAKET_TAB_CALCULATE" );
		r, g, b				= 230, 230, 230;
		if( luaMyMarket.CALCTYPE.EXPIREDITEM == CalcType )		then
			strState		= STR( "UI_TRADEMAKET_CALCULATE_EXPIREDITEM" );
			strBtn			= STR( "UI_TRADEMAKET_ITEM_UNREGISTER" );
			r, g, b			= 255, 45, 45;
		end
		
		-- text
		--lcCalculate:SetItemText( nIndex, luaMyMarket.CALULATE_COLUMN.STATE, strState );
		--lcCalculate:SetItemColor( nIndex, luaMyMarket.CALULATE_COLUMN.STATE, r, g, b );
		
		

		]]--

	end

end

-- ShowCancelBtn
function luaMyMarket:ShowCancelBtn( bShow, nIndex, strBtn )
	
	if( ( nil == nIndex ) or ( 0 > nIndex ) )		then
		
		btnCancel1:Show( bShow );
		btnCancel2:Show( bShow );
		btnCancel3:Show( bShow );
		btnCancel4:Show( bShow );
		btnCancel5:Show( bShow );
		btnCancel6:Show( bShow );
		btnCancel7:Show( bShow );
		btnCancel8:Show( bShow );
		btnCancel9:Show( bShow );
		btnCancel10:Show( bShow );	
		
	end
	
	if( 0 == nIndex )			then
		btnCancel1:Show( bShow );
	elseif( 1 == nIndex )		then
		btnCancel2:Show( bShow );
	elseif( 2 == nIndex )		then
		btnCancel3:Show( bShow );
	elseif( 3 == nIndex )		then
		btnCancel4:Show( bShow );
	elseif( 4 == nIndex )		then
		btnCancel5:Show( bShow );
	elseif( 5 == nIndex )		then
		btnCancel6:Show( bShow );
	elseif( 6 == nIndex )		then
		btnCancel7:Show( bShow );
	elseif( 7 == nIndex )		then
		btnCancel8:Show( bShow );
	elseif( 8 == nIndex )		then
		btnCancel9:Show( bShow );
	elseif( 9 == nIndex )		then
		btnCancel10:Show( bShow );
	end
	
end

-- InitCancelBtn
function luaMyMarket:InitCancelBtn()
	
	local gpX, gpY			= lcSalesManagement:GetPosition();
	local gpW, gpH			= lcSalesManagement:GetSize();
	
	local btnW, btnH;
	btnW					= 80;
	btnH					= 20;
	
	local btnX, btnY;
	btnX					= ( gpX + gpW ) - btnW -5;

	btnY					= gpY + 32;
	btnCancel1:SetSize( btnW, btnH );
	btnCancel1:SetPosition( btnX, btnY );
	
	btnY					= btnY + 26;
	btnCancel2:SetSize( btnW, btnH );
	btnCancel2:SetPosition( btnX, btnY );	
	
	btnY					= btnY + 26;
	btnCancel3:SetSize( btnW, btnH );
	btnCancel3:SetPosition( btnX, btnY );	
	
	btnY					= btnY + 26;
	btnCancel4:SetSize( btnW, btnH );
	btnCancel4:SetPosition( btnX, btnY );	
	
	btnY					= btnY + 26;
	btnCancel5:SetSize( btnW, btnH );
	btnCancel5:SetPosition( btnX, btnY );	
	
	btnY					= btnY + 26;
	btnCancel6:SetSize( btnW, btnH );
	btnCancel6:SetPosition( btnX, btnY );	
	
	btnY					= btnY + 26;
	btnCancel7:SetSize( btnW, btnH );
	btnCancel7:SetPosition( btnX, btnY );	
	
	btnY					= btnY + 26;
	btnCancel8:SetSize( btnW, btnH );
	btnCancel8:SetPosition( btnX, btnY );	
	
	btnY					= btnY + 26;
	btnCancel9:SetSize( btnW, btnH );
	btnCancel9:SetPosition( btnX, btnY );	
	
	btnY					= btnY + 26;
	btnCancel10:SetSize( btnW, btnH );
	btnCancel10:SetPosition( btnX, btnY );	
	
	luaMyMarket:ShowCancelBtn( false );
	
end

-- ClickRegister
function luaMyMarket:ClickRegister()
	
	luaMyMarket:ShowfrmRegisterItem();

end

-- InitRegisterItemInfo
function luaMyMarket:InitRegisterItemInfo()
	
	RegisterItemImage:SetImage( "" );
	tvwRegisterItemName:SetText( "" );
	edtPriceGP:SetText( "" );
	edtPriceSP:SetText( "" );
	edtPriceCP:SetText( "" );
	edtRegisterAmount:SetText( "" );
	tvwTotalPrice:SetText( "" );
	tvwCommition:SetText( "" );
	luaMyMarket.RegisterItemSlotID	= -1;
	luaMyMarket.RegisterItemID		= -1;
	luaMyMarket.RegisterAmount		= 0;
	luaMyMarket.UnitPrice			= 0;
	luaMyMarket.TotalPrice			= 0;
	luaMyMarket.Commition			= 0;

end

-- ShowfrmRegisterItem
function luaMyMarket:ShowfrmRegisterItem()

	if( true == frmRegisterItem:GetShow() )	then
		return;
	end

	-- 등록 최대 갯수를 확인 
	local nMaxCnt	= gamefunc:GetRegisteredMaxCnt();
	local nCurrCnt	= gamefunc:GetMySailesItemCnt();

	if( nMaxCnt > nCurrCnt )	then
		-- 인벤 띄우기
		if( false == frmInventory:GetShow() )	then
			frmInventory:Show( true );
		end

		luaMyMarket:InitfrmRegisterControl();
	
		luaMyMarket:InitRegisterItemInfo();

		frmRegisterItem:Show( true );	
		return ;
	end

	local strCnt	= "{COLOR r= 160 g= 120  b= 55 }" .. nCurrCnt .. "\/" .. nMaxCnt .. "{/COLOR}";

	luaTradeMarket:ShowConfirmTradeMarket( FORMAT( "UI_TRADE_MARKET_UNABLE_REGISTERITEM", strCnt ) );
	
end

-- InitfrmRegisterControl
function luaMyMarket:InitfrmRegisterControl()

	-- 프레임
	local mX, mY	= frmTradeMarket:GetPosition();
	local x, y = frmRegisterItem:GetPosition();
	local w, h = frmRegisterItem:GetSize();
    local width, height = gamefunc:GetWindowSize();

	-- 인벤
	local nInvenX, nInvenY = frmInventory:GetPosition();
	local nInvenW, nInvenH = frmInventory:GetSize();

	x		= ( ( width - ( w + nInvenW ) ) * 0.5 ) - mX;
	y		= ( height - h ) * 0.3;
    frmRegisterItem:SetPosition( x, y - mY );
	frmRegisterItem:DoModal();

	x		= ( ( x + w ) + mX ) + 10;
	
	frmInventory:SetPosition( x, y );

	-- 아이템 이미지 베이스
	local nX, nY	= RegisterItemImageBase:GetPosition();
	local nW, nH	= RegisterItemImageBase:GetSize();
	nX				= ( w - nW ) / 2;
	nY				= 35;
	RegisterItemImageBase:SetPosition( nX, nY );
	
	-- 아이템 이미지
	RegisterItemImage:SetPosition( nX+5, nY+5 );

	-- Drop 영역
	tvwDropArea:SetPosition( nX-10, nY-10 );

	-- 아이템 이름
	nY			= ( nY + nH ) + 10;
	nW, nH		= tvwRegisterItemName:GetSize();
	tvwRegisterItemName:SetPosition( 0, nY );

	-- 상단 바
	nY			= ( nY + nH );
	nW, nH		= picRegisterItemTopSeperateBar:GetSize();
	picRegisterItemTopSeperateBar:SetPosition( 0, nY );

	-- 개당 가격 텍스트
	nX			= 10;
	nY			= ( nY + nH ) + 10;
	nW, nH		= lbRegisterUnitPrice:GetSize();
	lbRegisterUnitPrice:SetPosition( nX, nY );
		
	-- 개당 가격 GP 입력
	nX			= ( nX + nW ) + 10;
	nW, nH		= edtPriceGP:GetSize();
	edtPriceGP:SetPosition( nX, nY );
	nX			= ( nX + nW ) + 5;
	nW, nH		= tvwRegisterGPText:GetSize();
	tvwRegisterGPText:SetPosition( nX, nY );

	-- 개당 가격 SP 입력
	nX			= ( nX + nW ) + 5;
	nW, nH		= edtPriceSP:GetSize();
	edtPriceSP:SetPosition( nX, nY );
	nX			= ( nX + nW ) + 5;
	nW, nH		= tvwRegisterSPText:GetSize();
	tvwRegisterSPText:SetPosition( nX, nY );

	-- 개당 가격 CP 입력
	nX			= ( nX + nW ) + 5;
	nW, nH		= edtPriceCP:GetSize();
	edtPriceCP:SetPosition( nX, nY );
	nX			= ( nX + nW ) + 5;
	nW, nH		= tvwRegisterCPText:GetSize();
	tvwRegisterCPText:SetPosition( nX, nY );

	-- 갯수 텍스트
	nX			= 10;
	nY			= ( nY + nH ) + 5;
	nW, nH		= lbRegisterAmount:GetSize();
	lbRegisterAmount:SetPosition( nX, nY );
	nX			= ( nX + nW ) + 10;
	nW, nH		= edtRegisterAmount:GetSize();
	edtRegisterAmount:SetPosition( nX, nY );

	-- 총가격 텍스트
	nX			= 10;
	nY			= ( nY + nH ) + 5;
	nW, nH		= lbTotalPrice:GetSize();
	lbTotalPrice:SetPosition( nX, nY );
	nX			= ( nX + nW ) + 10;
	nW, nH		= tvwTotalPrice:GetSize();
	tvwTotalPrice:SetPosition( nX, nY );

	-- 수수료 텍스트
	nX			= 10;
	nY			= ( nY + nH ) + 5;
	nW, nH		= lbRegisterCommition:GetSize();
	lbRegisterCommition:SetPosition( nX, nY );
	nX			= ( nX + nW ) + 10;
	nW, nH		= tvwCommition:GetSize();
	tvwCommition:SetPosition( nX, nY );

	-- 하단 바
	nY			= ( nY + nH ) + 5;
	nW, nH		= picRegisterItemBtmSeperateBar:GetSize();
	picRegisterItemBtmSeperateBar:SetPosition( 0, nY );

	-- 수수료 안내
	nY			= ( nY + nH ) + 5;
	nW, nH		= tvwRegisterCommition:GetSize();
	tvwRegisterCommition:SetPosition( 5, nY );

	
	if( true == gamefunc:IsLocale_de_DE() )		then
		
	else
		-- 등록 확인 버튼
	nY			= ( nY + nH ) + 5;
	nW, nH		= btnRegisterOk:GetSize();
	nX			= ( w - ( ( nW * 2 ) + 40 ) ) /2;
	btnRegisterOk:SetPosition( nX, nY );

	-- 등록 취소 버튼
	nX			= ( nX + nW ) + 20;
	nW, nH		= btnRegisterCancel:GetSize();
	btnRegisterCancel:SetPosition( nX, nY );
	end
	
	

end

-- ClosefrmRegisterItem
function luaMyMarket:ClosefrmRegisterItem()

	frmInventory:Show( false );
	frmRegisterItem:Show( false );

end

-- ConfirmRegisterItem
function luaMyMarket:ConfirmRegisterItem()
	
	if( false == frmRegisterItem:GetShow() )	then
		return;
	end

	if( false == luaMyMarket:CheckRegister() )		then
		return;
	end

	luaMyMarket:ClosefrmRegisterItem();

	-- 만료일은 임시 3 나중에 고정될수도?
	gamefunc:RegisterItem( luaMyMarket.RegisterItemSlotID, luaMyMarket.UnitPrice, luaMyMarket.RegisterAmount, 3 );

	-- 화면 잠시 홀드
	luaTradeMarket:TradeMarketBlackScreen( true );

end

-- CheckRegister
function luaMyMarket:CheckRegister()
	
	-- 등록된 아이템이 슬롯에 있는지 검사
	local nID		= gamefunc:GetInvenItemID( luaMyMarket.RegisterItemSlotID );
	if( ( 0 > nID ) or ( nID ~= luaMyMarket.RegisterItemID ) )	then
		luaTradeMarket:ShowConfirmTradeMarket( STR( "UI_TRADEMAKET_REGISTER_IMPOSSIBLEITEM_TEXT" ) );
		return false;
	end
	
	-- 금액 검사( 총금액의 최대/최소 판매금액 )
	if( luaMyMarket.nTotalPriceMin > luaMyMarket.TotalPrice )			then
		luaTradeMarket:ShowConfirmTradeMarket( FORMAT( "UI_TRADEMAKET_REGISTER_PRICEMIN_TEXT", luaGame:ConvertMoneyToStr( luaMyMarket.nTotalPriceMin, "fntSmall") ) );
		return false;
	elseif( luaMyMarket.nTotalPriceMax < luaMyMarket.TotalPrice )		then
		luaTradeMarket:ShowConfirmTradeMarket( FORMAT( "UI_TRADEMAKET_REGISTER_PRICEMAX_TEXT", luaGame:ConvertMoneyToStr( luaMyMarket.nTotalPriceMax, "fntSmall") ) );
		return false;
	end
	
	-- 수수료 검사( 수수료 최소 1원 보장 )
	if( luaMyMarket.Commition < 1 )		then
		luaTradeMarket:ShowConfirmTradeMarket( FORMAT( "UI_TRADEMAKET_REGISTER_COMMITIONNOT_TEXT", luaGame:ConvertMoneyToStr( 1, "fntSmall") ) );
		return false;
	end
	
	local nMyMoney		= gamefunc:GetMoney();
	if( luaMyMarket.Commition > nMyMoney )		then
		luaTradeMarket:ShowConfirmTradeMarket( STR( "UI_TRADEMAKET_REGISTER_COMMITIONFAIL_TEXT" ) );
		return false;
	end
	
	return true;
end

-- DeleteAllRegisterItems
function luaMyMarket:DeleteAllRegisterItems()
	
	lcSalesManagement:DeleteAllItems();
	luaMyMarket:ShowCancelBtn( false );
	
end

-- UnregisterItem
function luaMyMarket:UnregisterItem( nIndex )
	
	if( true == frmConfirmUnRegisterItem:GetShow() )	then
		return;
	end
	
	lcSalesManagement:SetCurSel( nIndex );
	
	local x, y = frmConfirmUnRegisterItem:GetParent():GetPosition();
	local w, h = frmConfirmUnRegisterItem:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmConfirmUnRegisterItem:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);
	frmConfirmUnRegisterItem:DoModal();
	
	local nvecIndex		= lcSalesManagement:GetItemData( nIndex );
	local nID			= gamefunc:GetMySailesItemID( nvecIndex );
	local nEnchantGrade	= gamefunc:GetMySailesItemEnchantGrade( nvecIndex );
	
	-- Message
	local r, g, b		= GetItemColor( nID );
	
	local strItemName	= "{FONT name=\"fntBold\"}" .. "{COLOR r=" .. r .. " g=" .. g .. " b=" .. b .. "}" .. gamefunc:GetItemName( nID, nEnchantGrade ) .. "{/COLOR}{/FONT}";
	tvwConfirmUnRegisterItem:SetText( FORMAT( "UI_TRADEMAKET_CONFIRM_UNREGISTER_ITEM", strItemName ) );

	
	-- Item Image
	local strItemImage = "{BITMAP name=\"bmpItemSlot\" w=42 h=42}{CR h=1}{SPACE w=1}{BITMAP name=\"" .. gamefunc:GetItemImage( nID ) .. "\" w=40 h=40}{CR h=0}"
	tvwConfirmUnRegisteredItemImage:SetText( strItemImage );
	
	-- Item Name 
	tvwConfirmUnRegisteredItemName:SetText( strItemName );
	
	-- Sales Num
	local SaleNum			= gamefunc:GetMySailesItemAmount( nvecIndex );
	local strSaleNum		= "{ALIGN hor=\"right\" ver=\"bottom\"}" .. SaleNum;
	tvwConfirmUnRegisteredSalesNum:SetText( strSaleNum );
	
	-- Unit Price
	local UnitPrice			= gamefunc:GetMySailesItemPrice( nvecIndex );
	local strUnitPrice		= "{FONT name=\"fntBold\"}{ALIGN hor=\"right\" ver=\"bottom\"}" .. luaGame:ConvertMoneyToStr( UnitPrice, "fntSmall");
	tvwConfirmUnRegisteredUnitPrice:SetText( strUnitPrice );

	-- Total Price
	local TotalPrice		= UnitPrice * SaleNum;
	local strTotalPrice		= "{FONT name=\"fntBold\"}{ALIGN hor=\"right\" ver=\"bottom\"}" .. luaGame:ConvertMoneyToStr( TotalPrice, "fntSmall");
	tvwConfirmUnRegisteredTotalPrice:SetText( strTotalPrice );

	
	frmConfirmUnRegisterItem:Show( true );
	
	luaMyMarket.UnRegisterItemIndex	= nvecIndex;
	
end

-- ShowfrmConfirmUnRegisterItem
function luaMyMarket:ShowfrmConfirmUnRegisterItem()

	frmConfirmUnRegisterItem:Show( false );

	gamefunc:UnregisterItem( luaMyMarket.UnRegisterItemIndex );

	-- 화면 잠시 홀드
	luaTradeMarket:TradeMarketBlackScreen( true );
	
end

-- ShowfrmConfirmUnRegisterItem
function luaMyMarket:ToolTipRegisteredItem()

	local strToolTip = "";
							
	local nCurSel = lcSalesManagement:GetMouseOver();
	if( nCurSel < 0 )		then
		return ;
	end
	
	local nvecIndex		= lcSalesManagement:GetItemData( nCurSel );
	local nItemID		= gamefunc:GetMySailesItemID( nvecIndex );
	local nEnchantGrade	= gamefunc:GetMySailesItemEnchantGrade( nvecIndex );
	local nElementType, nElementGrade = gamefunc:GetMySailesItemElementEnchantData( nvecIndex );
	
	local nTooltipIndex	= gamefunc:GetTradeMarketTooltipIndex( luaTradeMarket.LISTTYPE.LIST_SAILES, luaSearchMarket.Step, nvecIndex );
	if( 0 > nTooltipIndex )	then
		return ;
	end
	
	strToolTip = luaToolTip:GetItemToolTip( nItemID, nil, nil, nTooltipIndex, nEnchantGrade, nElementType, nElementGrade );
	local nSlotType = gamefunc:GetItemSlot( nItemID );
	if ( nSlotType ~= ITEM_SLOT.NONE)  and  ( gamefunc:GetEquippedItemID( nSlotType) > 0)  then
		strToolTip = strToolTip .. "{divide}" ..
					 ToolTipDivideColor() .. "< " .. STR( "UI_EQUIPPEDITEM") .. " >{/COLOR}\n" .. luaToolTip:OnToolTipEquipItem( nItemID );
	end
	
	lcSalesManagement:SetToolTip( strToolTip );
	
end

-- OnTradeMarketUnRegistered
function luaMyMarket:OnTradeMarketUnRegistered( bResult )

	if( -1 < luaMyMarket.UnRegisterItemIndex )	then
		-- 관리 취소( 리스트 재요청 )
		luaMyMarket:ShowMyMarketItems();
		luaMyMarket.UnRegisterItemIndex	= -1;

		return ;
	end
	
	-- 정산 취소
	luaMyMarket:CalculateUnRegistered( bResult );
		
end

-- RegisteredPageBtnClick
function luaMyMarket:RegisteredPageBtnClick( strBtn )

	if( "btnPrevPage" == strBtn )			then
		luaMyMarket.nRegisteredStartIndex		= luaMyMarket.nRegisteredStartIndex - luaMyMarket.ItemListMax;
	elseif( "btnNextPage" == strBtn )		then
		luaMyMarket.nRegisteredStartIndex		= luaMyMarket.nRegisteredStartIndex + luaMyMarket.ItemListMax;	
	elseif( "btnFirstPage" == strBtn )		then
		luaMyMarket.nRegisteredStartIndex		= 0;
	end
	
	if( luaMyMarket.nRegisteredStartIndex < 0 )	then
		luaMyMarket.nRegisteredStartIndex		= 0;
	end
	
	local nListCount		= gamefunc:GetMySailesItemCnt();
	if( luaMyMarket.nRegisteredStartIndex	> nListCount - 1 )	then
		luaMyMarket.nRegisteredStartIndex	= luaMyMarket.nRegisteredStartIndex - luaMyMarket.ItemListMax;
	end

	luaMyMarket:RefreshMySaileItem();	

	-- 화면 잠시 홀드
	luaTradeMarket:TradeMarketBlackScreen( true );

end

-- CalulatePageBtnClick
function luaMyMarket:CalulatePageBtnClick( strBtn )

	if( "btnPrevPage" == strBtn )			then
		luaMyMarket.nCalulateStartIndex		= luaMyMarket.nCalulateStartIndex - luaMyMarket.ItemListMax;
	elseif( "btnNextPage" == strBtn )		then
		luaMyMarket.nCalulateStartIndex		= luaMyMarket.nCalulateStartIndex + luaMyMarket.ItemListMax;	
	elseif( "btnFirstPage" == strBtn )		then
		luaMyMarket.nCalulateStartIndex		= 0;
	end
	
	if( luaMyMarket.nCalulateStartIndex < 0 )	then
		luaMyMarket.nCalulateStartIndex		= 0;
	end
	
	local nListCount		= gamefunc:GetCalculateItemCnt();
	if( luaMyMarket.nCalulateStartIndex	> nListCount - 1 )	then
		luaMyMarket.nCalulateStartIndex	= luaMyMarket.nCalulateStartIndex - luaMyMarket.ItemListMax;
	end

	luaMyMarket:RefreshCalculateItem();

	-- 화면 잠시 홀드
	luaTradeMarket:TradeMarketBlackScreen( true );

end

-- SetRegisteredPage
function luaMyMarket:SetRegisteredPage( nMaxCnt )

	btnRegisteredFirstPage:Enable( false );
	btnRegisteredPrevPage:Enable( false );
	btnRegisteredNextPage:Enable( false );
	
	-- 이전과 처음으로 버튼 검사
	if( 0 < luaMyMarket.nRegisteredStartIndex )		then
		btnRegisteredFirstPage:Enable( true );
		btnRegisteredPrevPage:Enable( true );
	end
	
	local nPage, nMaxPage;
	if( 0 == nMaxCnt )		then
		nPage			= -1;
		nMaxPage		= 0;
	else
		nPage			= math.floor( luaMyMarket.nRegisteredStartIndex / luaMyMarket.ItemListMax );
		nMaxPage		= math.floor( nMaxCnt / luaMyMarket.ItemListMax );
		if( 0 < nMaxCnt % luaMyMarket.ItemListMax )	then
			nMaxPage	= nMaxPage + 1;
		end
		
	end
	
	local strPage = "{FONT name=\"fntBold\"}{COLUMN h=22}{ALIGN hor=\"center\" ver=\"center\"}" .. nPage+1 .. "\/" .. nMaxPage;
	tvwRegisteredPage:SetText( strPage );
	
	-- 다음 버튼 검사
	if( nMaxCnt > ( luaMyMarket.nRegisteredStartIndex + luaMyMarket.ItemListMax ) )	then
		btnRegisteredNextPage:Enable( true );
	end

	luaMyMarket:RegisteredCnt();

end

-- SetCalulatePage
function luaMyMarket:SetCalulatePage( nMaxCnt )

	btnCalculateFirstPage:Enable( false );
	btnCalculatePrevPage:Enable( false );
	btnCalculateNextPage:Enable( false );
	
	-- 이전과 처음으로 버튼 검사
	if( 0 < luaMyMarket.nCalulateStartIndex )		then
		btnCalculateFirstPage:Enable( true );
		btnCalculatePrevPage:Enable( true );
	end
	
	local nPage, nMaxPage;
	if( 0 == nMaxCnt )		then
		nPage			= -1;
		nMaxPage		= 0;
	else
		nPage			= math.floor( luaMyMarket.nCalulateStartIndex / luaMyMarket.ItemListMax );
		nMaxPage		= math.floor( nMaxCnt / luaMyMarket.ItemListMax );
		if( 0 < nMaxCnt % luaMyMarket.ItemListMax )	then
			nMaxPage	= nMaxPage + 1;
		end
		
	end
	
	local strPage = "{FONT name=\"fntBold\"}{COLUMN h=22}{ALIGN hor=\"center\" ver=\"center\"}" .. nPage+1 .. "\/" .. nMaxPage;
	tvwCalculatePage:SetText( strPage );
	
	-- 다음 버튼 검사
	if( nMaxCnt > ( luaMyMarket.nCalulateStartIndex + luaMyMarket.ItemListMax ) )	then
		btnCalculateNextPage:Enable( true );
	end

	luaMyMarket:RegisteredCnt();

end

-- InitCalculateList
function luaMyMarket:InitCalculateList()
	
	lcCalculate:SetColumnText( luaMyMarket.CALULATE_COLUMN.NAME, STR( "ITEM" ) );
    lcCalculate:SetColumnText( luaMyMarket.CALULATE_COLUMN.LEVEL, STR( "LEVEL" ) );
    lcCalculate:SetColumnText( luaMyMarket.CALULATE_COLUMN.QUANTITY, STR( "QUANTITY" ) );
    lcCalculate:SetColumnText( luaMyMarket.CALULATE_COLUMN.PRICE, STR( "MONEY" ) );
    lcCalculate:SetColumnText( luaMyMarket.CALULATE_COLUMN.EXPIRY, STR( "UI_TRADEMAKET_EXPIRY" ) );
    --lcCalculate:SetColumnText( luaMyMarket.CALULATE_COLUMN.STATE, STR( "UI_TRADEMAKET_CACULATE_SAILES_STATE" ) );
    
end

-- InitCaculateBtn
function luaMyMarket:InitCaculateBtn()
	
	local lcX, lcY		= lcCalculate:GetPosition();
	local btnX, btnY	= btnCalculateItem1:GetPosition();

	btnY				= lcY + 32;
	btnCalculateItem1:SetPosition( btnX, btnY );

	local OffsetY		= 26;
	local btnX, btnY	= btnCalculateItem1:GetPosition();
	
	btnY				= btnY + OffsetY;
	btnCalculateItem2:SetPosition( btnX, btnY );
	
	btnY				= btnY + OffsetY;
	btnCalculateItem3:SetPosition( btnX, btnY );
	
	btnY				= btnY + OffsetY;
	btnCalculateItem4:SetPosition( btnX, btnY );
	
	btnY				= btnY + OffsetY;
	btnCalculateItem5:SetPosition( btnX, btnY );
	
	btnY				= btnY + OffsetY;
	btnCalculateItem6:SetPosition( btnX, btnY );
	
	btnY				= btnY + OffsetY;
	btnCalculateItem7:SetPosition( btnX, btnY );

	luaMyMarket:ShowCaculateBtn( false );

end

-- ShowBuyBtn
function luaMyMarket:ShowCaculateBtn( bShow, nIndex, strBtn )
	
	if( ( nil == nIndex ) or ( 0 > nIndex ) )		then
		
		btnCalculateItem1:Show( bShow );
		btnCalculateItem2:Show( bShow );
		btnCalculateItem3:Show( bShow );
		btnCalculateItem4:Show( bShow );
		btnCalculateItem5:Show( bShow );
		btnCalculateItem6:Show( bShow );
		btnCalculateItem7:Show( bShow );
	end
	
	if( 0 == nIndex )			then
		btnCalculateItem1:Show( bShow );
	elseif( 1 == nIndex )		then
		btnCalculateItem2:Show( bShow );
	elseif( 2 == nIndex )		then
		btnCalculateItem3:Show( bShow );
	elseif( 3 == nIndex )		then
		btnCalculateItem4:Show( bShow );
	elseif( 4 == nIndex )		then
		btnCalculateItem5:Show( bShow );
	elseif( 5 == nIndex )		then
		btnCalculateItem6:Show( bShow );
	elseif( 6 == nIndex )		then
		btnCalculateItem7:Show( bShow );
	elseif( 7 == nIndex )		then
		btnCalculateItem8:Show( bShow );
	end
	
end

-- AllCalculateItem
function luaMyMarket:AllCalculateItem()
	
	gamefunc:AllCalculateItem();

	-- 화면 잠시 홀드
	luaTradeMarket:TradeMarketBlackScreen( true );
	
end

-- CalculateItem
function luaMyMarket:CalculateItem( nIndex )

	local nvecIndex = lcCalculate:GetItemData( nIndex );
	if( 0 > nvecIndex )  then
		return;
	end
	
	lcCalculate:SetCurSel( nIndex );
	
	luaMyMarket.CalcItemIndex	= nvecIndex;
	
	-- 정산
	gamefunc:CalculateItem( luaMyMarket.CalcItemIndex );

	-- 화면 잠시 홀드
	luaTradeMarket:TradeMarketBlackScreen( true );
	
end

-- TradeMarketSoldedItem
function luaMyMarket:TradeMarketSoldedItem( bResult )
	
	if( 1 == bResult )		then
	
		local nID			= gamefunc:GetCalculateItemID( luaMyMarket.CalcItemIndex );
		local nEnchantGrade	= gamefunc:GetCalculateItemEnchantGrade( luaMyMarket.CalcItemIndex );
		if( nID < 0 )		then
			luaMyMarket:ShowMyMarketItems();
			return;
		end

		-- Item Color
		local r, g, b		= GetItemColor( nID );		
	
		local strItemName		= "{FONT name=\"fntBold\"}" .. "{COLOR r=" .. r .. " g=" .. g .. " b=" .. b .. "}" .. gamefunc:GetItemName( nID, nEnchantGrade ) .. "{/COLOR}{/FONT}";
		local strItemAmount		= gamefunc:GetCalculateItemAmount( luaMyMarket.CalcItemIndex );
		local strMoney			= luaGame:ConvertMoneyToStr( gamefunc:GetCalculateItemSoldPrice( luaMyMarket.CalcItemIndex ), "fntSmall");
		local strSolded			= FORMAT( "UI_TRADEMAKET_CALCULATE_SOLDEDITEM_TEXT", strItemName, strItemAmount, strMoney );
		luaTradeMarket:ShowConfirmTradeMarket( strSolded );
	
	end

	luaMyMarket.CalcItemIndex	= -1;

	-- 리스트 갱신
	luaMyMarket:ShowMyMarketItems();
	
end

-- CalculateUnRegistered
function luaMyMarket:CalculateUnRegistered( bResult )

	if( 1 == bResult )		then
		local nID			= gamefunc:GetCalculateItemID( luaMyMarket.CalcItemIndex );
		local nEnchantGrade	= gamefunc:GetCalculateItemEnchantGrade( luaMyMarket.CalcItemIndex );	
		if( nID < 0 )		then
			luaMyMarket:ShowMyMarketItems();
			return;
		end

		-- Item Color
		local r, g, b		= GetItemColor( nID );		
	
		local strItemName		= "{FONT name=\"fntBold\"}" .. "{COLOR r=" .. r .. " g=" .. g .. " b=" .. b .. "}" .. gamefunc:GetItemName( nID, nEnchantGrade ) .. "{/COLOR}{/FONT}";
		local strItemAmount		= gamefunc:GetCalculateItemAmount( i );
		local strUnreg			= FORMAT( "UI_TRADEMAKET_CALCULATE_UNREGITEM_TEXT", strItemName, strItemAmount );
		luaTradeMarket:ShowConfirmTradeMarket( strUnreg );
	
	end
		
	luaMyMarket.CalcItemIndex	= -1;

	-- 리스트 갱신
	luaMyMarket:ShowMyMarketItems();
	
end

-- OnTradeMarketCalcAllSoldItem
function luaMyMarket:OnTradeMarketCalcAllSoldItem( nParam1, nParam2 )
	
	local nHistroyCount		= nParam2;
	local nTotalMoney		= nParam1;
	
	if( ( 0 ~= nHistroyCount ) and ( 0 ~= nTotalMoney ) )	then
		
		local strHistroyCount	= "{FONT name=\"fntBold\"}" .. nHistroyCount .. "{/COLOR}{/FONT}";
		local strTotalMoney		= luaGame:ConvertMoneyToStr( nTotalMoney, "fntSmall" );
		local strAllSoldItem	= FORMAT( "UI_TRADEMAKET_CALCULATE_SOLDEDITEMALL_TEXT", strHistroyCount, strTotalMoney );
		luaTradeMarket:ShowConfirmTradeMarket( strAllSoldItem );
	
	end
	
	-- 리스트 갱신
	luaMyMarket:ShowMyMarketItems();
	
end

-- ToolTipCalculateItem
function luaMyMarket:ToolTipCalculateItem()
	
	local strToolTip = "";
							
	local nCurSel = lcCalculate:GetMouseOver();
	if( nCurSel < 0 )		then
		return ;
	end
	
	local nvecIndex		= lcCalculate:GetItemData( nCurSel );
	local nItemID		= gamefunc:GetCalculateItemID( nvecIndex );
	local nEnchantGrade	= gamefunc:GetCalculateItemEnchantGrade( nvecIndex );
	local nElementType, nElementGrade = gamefunc:GetCalculateItemElementEnchantData( nvecIndex );
	local nTooltipIndex	= gamefunc:GetTradeMarketTooltipIndex( luaTradeMarket.LISTTYPE.LIST_CALULATE, luaSearchMarket.Step, nvecIndex );

	if( 0 > nTooltipIndex )	then
		return ;
	end
	
	strToolTip = luaToolTip:GetItemToolTip( nItemID, nil, nil, nTooltipIndex, nEnchantGrade, nElementType, nElementGrade );
	
	local nSlotType = gamefunc:GetItemSlot( nItemID );
	if ( nSlotType ~= ITEM_SLOT.NONE)  and  ( gamefunc:GetEquippedItemID( nSlotType) > 0)  then
		strToolTip = strToolTip .. "{divide}" ..
					 ToolTipDivideColor() .. "< " .. STR( "UI_EQUIPPEDITEM") .. " >{/COLOR}\n" .. luaToolTip:OnToolTipEquipItem( nItemID );
	end
	
	lcCalculate:SetToolTip( strToolTip );
	
end

-- RegisteredCnt
function luaMyMarket:RegisteredCnt()
	-- 등록 최대 갯수
	local nMaxCnt	= gamefunc:GetRegisteredMaxCnt();
	-- 현재 등록된 갯수
	local nCurrCnt	= gamefunc:GetMySailesItemCnt();

	local strCnt	= "{FONT name=\"fntBold\"}{COLOR r= 160 g= 120  b= 55 }{ALIGN hor=\"left\" ver=\"center\"}" .. 
		STR( "UI_TRADEMAKET_REGISTERED_COUNT" ) .. " : " .. nCurrCnt .. " \/ " .. nMaxCnt;

	RegisteredCnt:SetText( strCnt );
end

-- RegisteredCnt
function luaMyMarket:ReleaseRegisterItem()
	
	local strSound = gamefunc:GetItemPutDownSound( luaMyMarket.RegisterItemID );
	gamefunc:PlaySound( strSound);

	luaMyMarket:InitRegisterItemInfo();

end

-- TradeMarketRegistered
function luaMyMarket:TradeMarketRegistered()
	
	luaMyMarket:InitRegisterItemInfo();

	-- 리스트 재요청
	luaMyMarket:ShowMyMarketItems();
end

-- OnValueChangedConfirmPriceGP
function luaMyMarket:OnValueChangedConfirmPriceGP()
	
	local strText		= edtPriceGP:GetText();
	if ( nil == strText ) or ( "" == strText )					then
		
		edtPriceGP:SetText( "0" );
		edtPriceGP:SetSel( 0, edtPriceGP:GetLength() );
		
	elseif( luaInventory.nConfirmMoneyAmountGold < tonumber( strText ) )	then
		edtPriceGP:SetText( luaInventory.nConfirmMoneyAmountGold );
		edtPriceGP:SetSel( 0, edtPriceGP:GetLength() );
		edtPriceSP:SetText( "0" );
		edtPriceCP:SetText( "0" );
	end
	
	luaMyMarket:UpdateRegisterInfo();
	
end

-- OnValueChangedConfirmPriceSP
function luaMyMarket:OnValueChangedConfirmPriceSP()
	
	local strText		= edtPriceGP:GetText();
	if ( nil ~= strText ) and ( luaInventory.nConfirmMoneyAmountGold <= tonumber( strText ) )	then
	
		edtPriceSP:SetText( "0" );
		edtPriceSP:SetSel( 0, edtPriceSP:GetLength() );
		return ;
	end
		
	strText		= edtPriceSP:GetText();
	if ( nil == strText ) or ( "" == strText )					then
		edtPriceSP:SetText( "0" );
		edtPriceSP:SetSel( 0, edtPriceSP:GetLength() );
		
	elseif( 99 < tonumber( strText ) )	then
		edtPriceSP:SetText( 99 );
		edtPriceSP:SetSel( 0, edtPriceSP:GetLength() );
	end
	
	luaMyMarket:UpdateRegisterInfo();
	
end

-- OnValueChangedConfirmPriceCP
function luaMyMarket:OnValueChangedConfirmPriceCP()
	
	local strText		= edtPriceGP:GetText();
	if ( nil ~= strText ) and ( luaInventory.nConfirmMoneyAmountGold <= tonumber( strText ) )	then
		edtPriceCP:SetText( "0" );
		edtPriceCP:SetSel( 0, edtPriceCP:GetLength() );
		return ;
	end
		
	strText		= edtPriceCP:GetText();
	if ( nil == strText ) or ( "" == strText )					then
		edtPriceCP:SetText( "0" );
		edtPriceCP:SetSel( 0, edtPriceCP:GetLength() );
		
	elseif( 99 < tonumber( strText ) )	then
		edtPriceCP:SetText( 99 );
		edtPriceCP:SetSel( 0, edtPriceCP:GetLength() );
	end

	luaMyMarket:UpdateRegisterInfo();	
	
end