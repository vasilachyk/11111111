--[[
	Game cashshop LUA script
--]]


-- Global instance
luaCashShop = {};

luaCashShop.CATEGORY = { MAIN = 0, ENCHANT = 1, CONVENIENCE = 2, COSTUME = 3, PACKAGE = 4, EVENT = 5, RIDE = 6, CRYSTAL = 7 };
	luaCashShop.CATEGORY.MAIN = { HOT = 0, NEW = 1, TOTAL = 2 };
	luaCashShop.CATEGORY.ENCHANT = { TOTAL = 0 };
	luaCashShop.CATEGORY.CONVENIENCE = { TOTAL = 0, CONSUMABLE = 1, SCROLL = 2, FUNCTION = 3, GROWTH = 4, POTION = 5 };
	luaCashShop.CATEGORY.COSTUME = { TOTAL = 0, FUNCTION = 1, PACKAGE = 2, ARMOR = 3, WEAPON = 4, ACCESSORY = 5};
	luaCashShop.CATEGORY.PACKAGE = { TOTAL = 0 };
	luaCashShop.CATEGORY.EVENT = { LIMITED = 0 };
	luaCashShop.CATEGORY.RIDE = { TOTAL = 0 };
	luaCashShop.CATEGORY.CRYSTAL = { TOTAL = 0 };

luaCashShop.TAB_DEPTH1 =
{
	NA = 0,
	MAIN = 1,				-- 메인
	ENHANCE = 2,			-- 강화
	CONVENIENCE = 3,		-- 편의
	COSTUME = 4,			-- 코스튬
	PACKAGE = 5,			-- 패키지
	EVENT = 6,				-- 이벤트
	MOUNT = 7,				-- 탈것
	CRYSTAL = 8				-- 크리스탈
};

luaCashShop.TAB_DEPTH2 =
{
	NA = 0,
	MAIN_HOT = 11,						-- 메인/추천
	MAIN_NEW = 12,						-- 메인/신상품
	ENHANCE_ENHANCE = 21,				-- 강화/강화
	CONVENIENCE_CONSUMABLE = 31,		-- 편의/소모품
	CONVENIENCE_SCROLL = 32,			-- 편의/주문서
	CONVENIENCE_FUNCTION = 33,			-- 편의/기능성
	CONVENIENCE_GROWTH = 34,			-- 편의/성장
	CONVENIENCE_POTION = 35,			-- 편의/물약
	COSTUME_FUNCTION = 41,				-- 코스튬/기능성
	COSTUME_PACKAGE = 42,				-- 코스튬/패키지
	COSTUME_ARMOR = 43,					-- 코스튬/방어구
	COSTUME_WEAPON = 44,				-- 코스튬/무기
	COSTUME_ACCESSORY = 45,				-- 코스튬/액세서리
	PACKAGE_PACKAGE = 51,				-- 패키지/패키지
	EVENT_LIMITED = 61,					-- 이벤트/기간제한
	MOUNT_MOUNT = 71,					-- 탈것/탈것
	CRYSTAL_CRYSTAL = 81				-- 크리스탈/크리스탈
};

luaCashShop.Category = {};
	luaCashShop.Category.Tab = -1;
	luaCashShop.Category.SubTab = -1;
	
luaCashShop.CurrPage = 0;
luaCashShop.MaxPage = 0;

luaCashShop.nPageItemCount = 15;

luaCashShop.SaleItem = {};

luaCashShop.nCrystalItemID = 710;

luaCashShop.nClickItemIndex = 0;
luaCashShop.nClickedItemIndex = 0;


function luaCashShop:GetPriceXWidth(nPrice)
	
	local nCipherSize = 10;
	local nWidth = 30;

	local nCipherCount = 1;
	for  i = 1, 10  do
		
		nCipherCount = nCipherCount * 10;
		if( nPrice >= nCipherCount ) then
			nWidth = nWidth + nCipherSize;
		end
	end

	if(true == gamefunc:IsLocale_ja_JP() )		then
		nWidth = nWidth + 20;
	end

	return nWidth;
end


function luaCashShop:OpenCashShopReq()
	
	gamefunc:XPostCashShopReq();
end


-- OnShowCashshopFrame
function luaCashShop:OnShowCashshopFrame()

	-- Show
	if ( frmCashShop:GetShow() == true)  then
	
		local width, height	= gamefunc:GetWindowSize();
		local w, h			= frmCashShop:GetSize();
		frmCashShop:SetPosition( ( ( width - w ) * 0.5 ), ( height - h ) * 0.3 );

		luaCashShop:ChangeCategory(luaCashShop.CATEGORY.MAIN);
		
		luaCashShop:Refresh();
		
		luaCashShop:OnClickPageButton(luaCashShop.CurrPage);
		
	-- Hide
	else

		frmInventory:Show(false);
		frmConfirmBuyProductItem:Show(false);
		frmConfirmMoveProductItem:Show(false);
		frmConfirmBuySuccess:Show(false);
		frmConfirmGiftCashItem:Show(false);
		frmGiftSuccess:Show(false);

		if ( frmItemPreviewFrame:GetShow() == true)  then
           frmItemPreviewFrame:Show(false);
        end
		
		if( ( true == gamefunc:IsLocale_en_US() ) or ( true == gamefunc:IsLocale_en_GB() ) or ( true == gamefunc:IsLocale_de_DE() ) ) 		then
			-- 캐쉬창이 닫혔다고 알려준다.
			gamefunc:CashShopClose();
		end
		
	end
	
	luaGame:ShowWindow( frmCashShop);
	
end




function luaCashShop:Refresh()
	
	luaCashShop:RefreshBalance();

	luaCashShop:RefreshItemList();
	
	luaCashShop:RefreshCashInven();

end


function luaCashShop:RefreshBalance()

	if ( frmCashShop:GetShow() == false)  then
		return;
	end

	local nMoney = gamefunc:GetCashMoney();
	local strMoney = "{FONT name=\"fntScriptStrong\"}{COLUMN h=22}{ALIGN hor=\"left\" ver=\"bottom\"}" .. 
		STR("UI_CASHSHOP_PMANGCASH") .. " : " .. luaGame:ConvertPmangMoneyToStr( nMoney) .. "{SPACE w=10}";
		
	tvwPmangMoney:SetText( strMoney);


	local nCrystal = gamefunc:GetInvenItemQuantityByID(luaCashShop.nCrystalItemID);
	local strCrystal = "{FONT name=\"fntScriptStrong\"}{COLUMN h=22}{ALIGN hor=\"left\" ver=\"bottom\"}" .. 
		STR("UI_CASHSHOP_CRYSTAL") .. " : " .. luaGame:ConvertPmangMoneyToStr( nCrystal) .. "{SPACE w=10}";
		
	tvwHaveCrystal:SetText( strCrystal);
end


function luaCashShop:RefreshItemCategory()



	luaCashShop.SaleItem = {};


	-- 메인탭의 추천, 신상품
	local nCount = gamefunc:GetCashItemCount();
	for  i = 0, (nCount - 1)  do
	
		local nProductItemID = gamefunc:GetCashItemID(i);
		local nTabDepth1 = gamefunc:GetProductItemTabDepth1(nProductItemID);
		local nTabDepth2 = gamefunc:GetProductItemTabDepth2(nProductItemID);
		
		luaCashShop:RefreshItemCategoryInsertMainTab(nTabDepth1, nTabDepth2, nProductItemID);
	end

	-- 각 탭의 전체 탭
	for  i = 0, (nCount - 1)  do
	
		local nProductItemID = gamefunc:GetCashItemID(i);
		local nTabDepth1 = gamefunc:GetProductItemTabDepth1(nProductItemID);
		local nTabDepth2 = gamefunc:GetProductItemTabDepth2(nProductItemID);
		
		luaCashShop:RefreshItemCategoryInsertTotalTab(nTabDepth1, nTabDepth2, nProductItemID);
	end
	
	-- 나머지 탭들
	for  i = 0, (nCount - 1)  do
	
		local nProductItemID = gamefunc:GetCashItemID(i);
		local nTabDepth1 = gamefunc:GetProductItemTabDepth1(nProductItemID);
		local nTabDepth2 = gamefunc:GetProductItemTabDepth2(nProductItemID);
		local nExtraTabDepth1 = gamefunc:GetProductItemExtraTabDepth1(nProductItemID);
		local nExtraTabDepth2 = gamefunc:GetProductItemExtraTabDepth2(nProductItemID);
		
		luaCashShop:RefreshItemCategoryInsert(nTabDepth1, nTabDepth2, nProductItemID);
		luaCashShop:RefreshItemCategoryInsert(nExtraTabDepth1, nExtraTabDepth2, nProductItemID);
	end

	-- 크리스탈 탭
	for  i = 0, (nCount - 1)  do
	
		local nProductItemID = gamefunc:GetCashItemID(i);
		local nTabDepth1 = gamefunc:GetProductItemTabDepth1(nProductItemID);
		local nTabDepth2 = gamefunc:GetProductItemTabDepth2(nProductItemID);
		
		luaCashShop:RefreshItemCategoryInsertCrystalTab(nTabDepth1, nTabDepth2, nProductItemID);
	end

end


function luaCashShop:RefreshItemCategoryInsertMainTab(nTabDepth1, nTabDepth2, nProductItemID)


	if (gamefunc:IsProductItemCrystal(nProductItemID) == true) then
		return;
	end

	local nCategory = luaCashShop.Category.Tab;
	local nSubCategory = luaCashShop.Category.SubTab;

		if ( nCategory == luaCashShop.CATEGORY.MAIN) then

			if ( luaCashShop.Category.SubTab == luaCashShop.CATEGORY.MAIN.NEW) and
				(gamefunc:IsProductItemNew(nProductItemID) == true) then
				
				table.insert(luaCashShop.SaleItem, nProductItemID);

			elseif ( luaCashShop.Category.SubTab == luaCashShop.CATEGORY.MAIN.HOT) and
				(gamefunc:IsProductItemHot(nProductItemID) == true) then
				
				table.insert(luaCashShop.SaleItem, nProductItemID);
			end
		end
end


function luaCashShop:RefreshItemCategoryInsertTotalTab(nTabDepth1, nTabDepth2, nProductItemID)

	if (gamefunc:IsProductItemCrystal(nProductItemID) == true) then
		return;
	end

	local nCategory = luaCashShop.Category.Tab;
	local nSubCategory = luaCashShop.Category.SubTab;

		if ( nCategory == luaCashShop.CATEGORY.MAIN) then

			if ( luaCashShop.Category.SubTab == luaCashShop.CATEGORY.MAIN.TOTAL) then
				
				table.insert(luaCashShop.SaleItem, nProductItemID);
			end

		elseif ( nCategory == luaCashShop.CATEGORY.ENCHANT)
			and (nTabDepth1 == luaCashShop.TAB_DEPTH1.ENHANCE) then

			if ( luaCashShop.Category.SubTab == luaCashShop.CATEGORY.ENCHANT.TOTAL) then
				
				table.insert(luaCashShop.SaleItem, nProductItemID);
			end

		elseif ( nCategory == luaCashShop.CATEGORY.CONVENIENCE)
			and (nTabDepth1 == luaCashShop.TAB_DEPTH1.CONVENIENCE) then

			if ( luaCashShop.Category.SubTab == luaCashShop.CATEGORY.CONVENIENCE.TOTAL) then
				
				table.insert(luaCashShop.SaleItem, nProductItemID);
			end

		elseif ( nCategory == luaCashShop.CATEGORY.COSTUME)
			and (nTabDepth1 == luaCashShop.TAB_DEPTH1.COSTUME) then

			if ( luaCashShop.Category.SubTab == luaCashShop.CATEGORY.COSTUME.TOTAL) then
				
				table.insert(luaCashShop.SaleItem, nProductItemID);
			end

		elseif ( nCategory == luaCashShop.CATEGORY.PACKAGE)
			and (nTabDepth1 == luaCashShop.TAB_DEPTH1.PACKAGE) then

			if ( luaCashShop.Category.SubTab == luaCashShop.CATEGORY.PACKAGE.TOTAL) then
				
				table.insert(luaCashShop.SaleItem, nProductItemID);
			end

		elseif ( nCategory == luaCashShop.CATEGORY.EVENT)
			and (nTabDepth1 == luaCashShop.TAB_DEPTH1.EVENT) then

			if ( luaCashShop.Category.SubTab == luaCashShop.CATEGORY.EVENT.TOTAL) then
				
				table.insert(luaCashShop.SaleItem, nProductItemID);
			end

		elseif ( nCategory == luaCashShop.CATEGORY.RIDE)
			and (nTabDepth1 == luaCashShop.TAB_DEPTH1.MOUNT) then

			if ( luaCashShop.Category.SubTab == luaCashShop.CATEGORY.RIDE.TOTAL) then
				
				table.insert(luaCashShop.SaleItem, nProductItemID);
			end
		end
end


function luaCashShop:RefreshItemCategoryInsert(nTabDepth1, nTabDepth2, nProductItemID)
  
	if (gamefunc:IsProductItemCrystal(nProductItemID) == true) then
		return;
	end

	local nCategory = luaCashShop.Category.Tab;
	local nSubCategory = luaCashShop.Category.SubTab;

		if ( nCategory == luaCashShop.CATEGORY.MAIN) 
			and (nTabDepth1 == luaCashShop.TAB_DEPTH1.MAIN) then
		
			if ( luaCashShop.Category.SubTab == luaCashShop.CATEGORY.MAIN.HOT)
				and (nTabDepth2 == luaCashShop.TAB_DEPTH2.MAIN_HOT) then
				
				table.insert(luaCashShop.SaleItem, nProductItemID);

			elseif ( luaCashShop.Category.SubTab == luaCashShop.CATEGORY.MAIN.NEW)
				and (nTabDepth2 == luaCashShop.TAB_DEPTH2.MAIN_NEW) then
				
				table.insert(luaCashShop.SaleItem, nProductItemID);
			end
			
		elseif ( nCategory == luaCashShop.CATEGORY.ENCHANT) 
			and (nTabDepth1 == luaCashShop.TAB_DEPTH1.ENHANCE) then

			
		elseif ( nCategory == luaCashShop.CATEGORY.CONVENIENCE) 
			and (nTabDepth1 == luaCashShop.TAB_DEPTH1.CONVENIENCE) then

			if ( luaCashShop.Category.SubTab == luaCashShop.CATEGORY.CONVENIENCE.CONSUMABLE)
				and(nTabDepth2 == luaCashShop.TAB_DEPTH2.CONVENIENCE_CONSUMABLE) then
				
				table.insert(luaCashShop.SaleItem, nProductItemID);
			
			elseif ( luaCashShop.Category.SubTab == luaCashShop.CATEGORY.CONVENIENCE.SCROLL)
				and (nTabDepth2 == luaCashShop.TAB_DEPTH2.CONVENIENCE_SCROLL) then
				
				table.insert(luaCashShop.SaleItem, nProductItemID);

			elseif ( luaCashShop.Category.SubTab == luaCashShop.CATEGORY.CONVENIENCE.FUNCTION)
				and (nTabDepth2 == luaCashShop.TAB_DEPTH2.CONVENIENCE_FUNCTION) then
				
				table.insert(luaCashShop.SaleItem, nProductItemID);

			elseif ( luaCashShop.Category.SubTab == luaCashShop.CATEGORY.CONVENIENCE.GROWTH)
				and (nTabDepth2 == luaCashShop.TAB_DEPTH2.CONVENIENCE_GROWTH) then
				
				table.insert(luaCashShop.SaleItem, nProductItemID);

			elseif ( luaCashShop.Category.SubTab == luaCashShop.CATEGORY.CONVENIENCE.POTION)
				and (nTabDepth2 == luaCashShop.TAB_DEPTH2.CONVENIENCE_POTION) then
				
				table.insert(luaCashShop.SaleItem, nProductItemID);
			end

		elseif ( nCategory == luaCashShop.CATEGORY.COSTUME) 
			and (nTabDepth1 == luaCashShop.TAB_DEPTH1.COSTUME) then

			if ( luaCashShop.Category.SubTab == luaCashShop.CATEGORY.COSTUME.FUNCTION)
				and(nTabDepth2 == luaCashShop.TAB_DEPTH2.COSTUME_FUNCTION) then
				
				table.insert(luaCashShop.SaleItem, nProductItemID);
				
			elseif ( luaCashShop.Category.SubTab == luaCashShop.CATEGORY.COSTUME.PACKAGE)
				and (nTabDepth2 == luaCashShop.TAB_DEPTH2.COSTUME_PACKAGE) then
				
				table.insert(luaCashShop.SaleItem, nProductItemID);

			elseif ( luaCashShop.Category.SubTab == luaCashShop.CATEGORY.COSTUME.ARMOR)
				and (nTabDepth2 == luaCashShop.TAB_DEPTH2.COSTUME_ARMOR) then
				
				table.insert(luaCashShop.SaleItem, nProductItemID);
				
			elseif ( luaCashShop.Category.SubTab == luaCashShop.CATEGORY.COSTUME.WEAPON)
				and (nTabDepth2 == luaCashShop.TAB_DEPTH2.COSTUME_WEAPON) then
				
				table.insert(luaCashShop.SaleItem, nProductItemID);
				
			elseif ( luaCashShop.Category.SubTab == luaCashShop.CATEGORY.COSTUME.ACCESSORY)
				and (nTabDepth2 == luaCashShop.TAB_DEPTH2.COSTUME_ACCESSORY) then
				
				table.insert(luaCashShop.SaleItem, nProductItemID);
			end
			
		elseif ( nCategory == luaCashShop.CATEGORY.PACKAGE) 
			and (nTabDepth1 == luaCashShop.TAB_DEPTH1.PACKAGE) then

			
		elseif ( nCategory == luaCashShop.CATEGORY.EVENT) 
			and (nTabDepth1 == luaCashShop.TAB_DEPTH1.EVENT) then

			if ( luaCashShop.Category.SubTab == luaCashShop.CATEGORY.EVENT.LIMITED)
				and (nTabDepth2 == luaCashShop.TAB_DEPTH2.EVENT_LIMITED) then
				
				table.insert(luaCashShop.SaleItem, nProductItemID);
				
			end
			
		elseif ( nCategory == luaCashShop.CATEGORY.RIDE) 
			and (nTabDepth1 == luaCashShop.TAB_DEPTH1.MOUNT) then


		end
end


function luaCashShop:RefreshItemCategoryInsertCrystalTab(nTabDepth1, nTabDepth2, nProductItemID)

	if (gamefunc:IsProductItemCrystal(nProductItemID) == false) then
		return;
	end

	local nCategory = luaCashShop.Category.Tab;
	local nSubCategory = luaCashShop.Category.SubTab;

		if ( nCategory == luaCashShop.CATEGORY.CRYSTAL) then

			if ( luaCashShop.Category.SubTab == luaCashShop.CATEGORY.CRYSTAL.TOTAL) and
				(gamefunc:IsProductItemCrystal(nProductItemID) == true) then
				
				table.insert(luaCashShop.SaleItem, nProductItemID);
			end
		end
end




function luaCashShop:RefreshItemList()

	for  i = 1, luaCashShop.nPageItemCount  do

		local _pnlProductItem			= _G[ "pnlProductItem" .. i ];
		local _btnProductItemPreview	= _G[ "btnProductItemPreview" .. i ];
		local _btnProductItemGift		= _G[ "btnProductItemGift" .. i ];

		_pnlProductItem:Show(false);
		_btnProductItemPreview:Show(false);
		_btnProductItemGift:Enable(true);
	end

	

	local nItemCount = table.getn(luaCashShop.SaleItem);
	luaCashShop.MaxPage = math.max(1, math.ceil(nItemCount / luaCashShop.nPageItemCount));
	
	local nBeginCount = luaCashShop.CurrPage * luaCashShop.nPageItemCount;
	local nEndCount = math.min(((luaCashShop.CurrPage + 1) * luaCashShop.nPageItemCount), nItemCount);

	if(nItemCount > 0) then
		tvwCashShopNoItem:Show(false);
	else
		tvwCashShopNoItem:Show(true);
	end
	
	for  i = nBeginCount+1, nEndCount  do

		local _pnlProductItem			= _G[ "pnlProductItem" .. i - nBeginCount ];
		local _picProductItemImage		= _G[ "picProductItemImage" .. i - nBeginCount ];
		local _picProductItemImageTag	= _G[ "picProductItemImageTag" .. i - nBeginCount ];
		local _labProductItemCount		= _G[ "labProductItemCount" .. i - nBeginCount ];
		local _tvwProductItemName		= _G[ "tvwProductItemName" .. i - nBeginCount ];
		local _tvwProductItemPrice		= _G[ "tvwProductItemPrice" .. i - nBeginCount ];
		local _btnProductItemPreview	= _G[ "btnProductItemPreview" .. i - nBeginCount ];
		local _btnProductItemGift		= _G[ "btnProductItemGift" .. i - nBeginCount ];

		_pnlProductItem:Show(true);

		local nProductItemID = luaCashShop.SaleItem[i];
		local strName = gamefunc:GetProductItemName(nProductItemID);
		local nItemPrice = gamefunc:GetProductItemPrice(nProductItemID);
		local nItemCrystalPrice = gamefunc:GetProductItemCrystalPrice(nProductItemID);
		local nItemSalePrice = gamefunc:GetProductItemSalePrice(nProductItemID);
		local nItemCount = gamefunc:GetProductItemCount(nProductItemID);
		local nItemID = gamefunc:GetItemIDByProductItem(nProductItemID);
		local strImage = gamefunc:GetItemImage( nItemID );
		local strReference = "item://" .. nProductItemID;
		local r, g, b = GetItemColor( nItemID);

		local bNew	= gamefunc:IsProductItemNew(nProductItemID);
		local bSale = gamefunc:IsProductItemSale(nProductItemID);
		local bBest = gamefunc:IsProductItemBest(nProductItemID);
		local bEvent = gamefunc:IsProductItemEvent(nProductItemID);
		local bCrystal = gamefunc:IsProductItemCrystal(nProductItemID);

		-- 아이템 이미지
		_picProductItemImage:SetImage( strImage );

		-- 아이템 태그(베스트, 신규, 이벤트 순)

		_picProductItemImageTag:SetImage("");
		if (bBest == true) then
			_picProductItemImageTag:SetImage( "iconCashShopBest" );
		elseif (bNew == true) then
			_picProductItemImageTag:SetImage( "iconCashShopNew" );
		elseif (bEvent == true) then
			_picProductItemImageTag:SetImage( "iconCashShopEvent" );
		end

		-- 아이템 수량
		_labProductItemCount:SetText("");
		if(nItemCount > 1) then
			_labProductItemCount:SetText(nItemCount);
		end

		-- 아이템 이름
		local nLimitLength = 300;
		strName = "{COLOR r=" .. r .. " g=" .. g .. " b=" .. b .. "}" ..
			gamedraw:SubTextWidth( "fntScript", strName, nLimitLength) .. "{/COLOR}";

		_tvwProductItemName:SetText("{FONT name=\"fntScript\"}{SPACE w=1}" .. strName);

		-- 아이템 가격
		local costText = "";
		costText = costText .. luaGame:AddPmangMoneyColor(FORMAT( "UI_CASHSHOP_CURRENCY", nItemPrice));

		if (bSale == true)	then
			local nWidth = luaCashShop:GetPriceXWidth(nItemPrice);
			costText = luaGame:AddPmangMoneyColor(FORMAT( "UI_CASHSHOP_CURRENCY", nItemSalePrice)) ..
				"{SPACE w=10}" .. costText .. "{SPACE w=15}" ..
				"{CR h=0}{BITMAP name=\"bmpPriceX\" w=" .. nWidth .. " h=15}{SPACE w=5}";
		else
			costText = costText .. "{SPACE w=15}";
		end

		if (bCrystal == true) then
			-- 크리스탈 아이템이면 크리스탈 개수가 보이도록
			costText = "{BITMAP name=\"bmpCrystal\" w=15 h=15}{SPACE w=5}" .. luaGame:AddPmangMoneyColor(nItemCrystalPrice) .. "{SPACE w=20}";
		end

		costText = "{FONT name=\"fntSubScript\"}{ALIGN hor=\"right\" ver=\"top\"}" .. costText;

		_tvwProductItemPrice:SetText(costText);


		-- 미리보기 활성화 아이템
		if(frmItemPreview:IsPossiblePreviewItem( nItemID) == true)	then
			_btnProductItemPreview:Show(true);
		end

		-- 크리스탈 아이템은 선물 버튼 비활성화
		if (bCrystal == true) then
			_btnProductItemGift:Enable(false);
		end

	end
	
end




function luaCashShop:RefreshCashInven()

	lcCashInventory:DeleteAllItems();
		
	local nCount = gamefunc:GetCashInvenItemCount();
	if ( nCount == 0) then	
		btnMoveItem:Enable(false);
		return;
	else
		btnMoveItem:Enable(true);
	end
	
	for  i = 0, (gamefunc:GetCashInvenItemMaxCount() - 1)  do

		local nItemID = gamefunc:GetCashInvenItemID( i);
		if (nItemID <= 0) then
		
			local nIndex = lcCashInventory:AddItem( "", "");
			lcCashInventory:SetItemData( nIndex, i);
			
		else
			local strName = gamefunc:GetCashInvenProductName( i);
			local strImage = gamefunc:GetItemImage( nItemID );
			if ( strImage == nil)  or  ( strImage == "")  then  strImage = "iconUnknown"
			end
			
			-- Add list item
			local nIndex = lcCashInventory:AddItem( strName, strImage);
			lcCashInventory:SetItemData( nIndex, i);

			local nItemCount = gamefunc:GetCashInvenItemQuantity( i);
			lcCashInventory:SetItemText( nIndex, 1, nItemCount);
		end
	end	
end



function luaCashShop:OnDrawItemCashInvenListCtrl()

	local nIndex = EventArgs:GetItemIndex();
	local nSlotID = EventArgs:GetItemIndex();
	local x, y, w, h = EventArgs:GetItemRect();

	local strSenderName = gamefunc:GetCashInvenItemGiftSenderName(nSlotID);
	if ( strSenderName ~= "") then
		gamedraw:SetBitmap( "iconGiftMarker");
		gamedraw:DrawEx( x, y, 14, 14, 0, 0, 14, 14);
	end
	
	local bDraw = false;
	local strImage = lcCashInventory:GetItemImage( nIndex);
	if ( strImage ~= nil)  and  ( strImage ~= "")  then  bDraw = true;
	end

	if ( bDraw == false)  then  return;
	end

	-- Draw quantity
	local nQuantity = tonumber( lcCashInventory:GetItemText( nIndex, 1));
	if ( nQuantity ~= nil)  and  ( nQuantity > 1)  then

		gamedraw:SetColor( 210, 210, 210);
		gamedraw:SetFont( "fntSubScriptStrong");
		gamedraw:SetTextAlign( "right", "bottom");
		gamedraw:TextEx( x, y, w - 2, h - 2, nQuantity);
	end

end




function luaCashShop:HideAllCategory()
	
	btnMain:SetCheck(false);
	btnEnchant:SetCheck(false);
	btnConvenience:SetCheck(false);
	btnCostume:SetCheck(false);
	btnPackage:SetCheck(false);
	btnEvent:SetCheck(false);
	btnRide:SetCheck(false);
	btnCrystal:SetCheck(false);
	
	pnlMain:Show(false);
	pnlEnchant:Show(false);
	pnlConvenience:Show(false);
	pnlCostume:Show(false);
	pnlPackage:Show(false);
	pnlEvent:Show(false);
	pnlRide:Show(false);
	pnlCrystal:Show(false);
	
end

function luaCashShop:ChangeCategory( nCategory)

--	if( nCategory == luaCashShop.Category.Tab)	then	return;
--	end

	luaCashShop.Category.Tab = nCategory;
	luaCashShop.Category.SubTab = 0;
	tbcMain:SetSelIndex(0);
	tbcEnchant:SetSelIndex(0);
	tbcConvenience:SetSelIndex(0);
	tbcCostume:SetSelIndex(0);
	tbcPackage:SetSelIndex(0);
	tbcEvent:SetSelIndex(0);
	tbcRide:SetSelIndex(0);
	

	luaCashShop:HideAllCategory();

	if ( nCategory == luaCashShop.CATEGORY.MAIN)	then
		
		luaCashShop:OnSelChangeMainTabCtrl();

		btnMain:SetCheck(true);
		pnlMain:Show(true);
			
	elseif ( nCategory == luaCashShop.CATEGORY.ENCHANT) then
	
		luaCashShop:OnSelChangeEnchantTabCtrl();
	
		btnEnchant:SetCheck(true);
		pnlEnchant:Show(true);
	
	elseif ( nCategory == luaCashShop.CATEGORY.CONVENIENCE)		then
	
		luaCashShop:OnSelChangeConvenienceTabCtrl();
	
		btnConvenience:SetCheck(true);
		pnlConvenience:Show(true);

	elseif ( nCategory == luaCashShop.CATEGORY.COSTUME)	then
	
		luaCashShop:OnSelChangeCostumeTabCtrl();
		
		btnCostume:SetCheck(true);
		pnlCostume:Show(true);

	elseif ( nCategory == luaCashShop.CATEGORY.PACKAGE)	then

		luaCashShop:OnSelChangePackageTabCtrl();
		
		btnPackage:SetCheck(true);
		pnlPackage:Show(true);

	elseif ( nCategory == luaCashShop.CATEGORY.EVENT)	then

		luaCashShop:OnSelChangeEventTabCtrl();
		
		btnEvent:SetCheck(true);
		pnlEvent:Show(true);

	elseif ( nCategory == luaCashShop.CATEGORY.RIDE)	then

		luaCashShop:OnSelChangeRideTabCtrl();

		btnRide:SetCheck(true);
		pnlRide:Show(true);

	elseif ( nCategory == luaCashShop.CATEGORY.CRYSTAL)	then

		luaCashShop:OnSelChangeCrystalTabCtrl();

		btnCrystal:SetCheck(true);
		pnlCrystal:Show(true);

	end
	
	--luaCashShop:RefreshItemCategory();
	--luaCashShop:RefreshItemList();
end



function luaCashShop:OnSelChangeMainTabCtrl()

	luaCashShop.Category.SubTab = tbcMain:GetSelIndex();
	
	luaCashShop:RefreshItemCategory();
	luaCashShop:RefreshItemList();
	
	luaCashShop.CurrPage = 0;
	luaCashShop:RefreshPageButton();
end



function luaCashShop:OnSelChangeEnchantTabCtrl()

	luaCashShop.Category.SubTab = tbcEnchant:GetSelIndex();

	luaCashShop:RefreshItemCategory();
	luaCashShop:RefreshItemList();
	
	luaCashShop:RefreshPageButton();
end




function luaCashShop:OnSelChangeConvenienceTabCtrl()

	luaCashShop.Category.SubTab = tbcConvenience:GetSelIndex();

	luaCashShop:RefreshItemCategory();
	luaCashShop:RefreshItemList();
	
	luaCashShop:RefreshPageButton();
end



function luaCashShop:OnSelChangeCostumeTabCtrl()

	luaCashShop.Category.SubTab = tbcCostume:GetSelIndex();

	luaCashShop:RefreshItemCategory();
	luaCashShop:RefreshItemList();

	luaCashShop:RefreshPageButton();
end




function luaCashShop:OnSelChangePackageTabCtrl()

	luaCashShop.Category.SubTab = tbcPackage:GetSelIndex();

	luaCashShop:RefreshItemCategory();
	luaCashShop:RefreshItemList();
	
	luaCashShop:RefreshPageButton();
end




function luaCashShop:OnSelChangeEventTabCtrl()

	luaCashShop.Category.SubTab = tbcEvent:GetSelIndex();

	luaCashShop:RefreshItemCategory();
	luaCashShop:RefreshItemList();

	luaCashShop:RefreshPageButton();
end




function luaCashShop:OnSelChangeRideTabCtrl()

	luaCashShop.Category.SubTab = tbcRide:GetSelIndex();

	luaCashShop:RefreshItemCategory();
	luaCashShop:RefreshItemList();

	luaCashShop:RefreshPageButton();
end


function luaCashShop:OnSelChangeCrystalTabCtrl()

	luaCashShop.Category.SubTab = tbcCrystal:GetSelIndex();

	luaCashShop:RefreshItemCategory();
	luaCashShop:RefreshItemList();

	luaCashShop:RefreshPageButton();
end


function luaCashShop:RefreshPageButton()

	luaCashShop.CurrPage = 0;
	luaCashShop:OnClickPageButton(0);
end


function luaCashShop:OnClickPageButton(nPage)

	if (luaCashShop.CurrPage > 4) and (nPage < 5) then
	
		local nTempMok = math.floor(luaCashShop.CurrPage / 5);
		local nTemp = luaCashShop.CurrPage % 5;
	
		nPage = nPage + nTempMok*5;
		
	end

	if (nPage >= luaCashShop.MaxPage) then
		nPage = luaCashShop.CurrPage;
	end

	luaCashShop.CurrPage = nPage;
	luaCashShop:RefreshItemList();
	
	luaCashShop:SetPageNumber(nPage);
end



function luaCashShop:SetPageNumber(nPage)

	--gamedebug:Log( "luaCashShop:SetPageNumber(" .. nPage .. ")");

	picNumber1:SetImage("bmpTextlabel1");
	picNumber2:SetImage("bmpTextlabel1");
	picNumber3:SetImage("bmpTextlabel1");
	picNumber4:SetImage("bmpTextlabel1");
	picNumber5:SetImage("bmpTextlabel1");

	if nPage > 4 then
	
		local nTempMok = math.floor(nPage / 5);
		local nTemp = nPage % 5;
		
		--gamedebug:Log( "nTempMok : " .. nTempMok .. "     nTemp: " .. nTemp);
		
		for i = 1, 5 do
		
			local _window = rawget( _G, "btnNumber" .. i);
			if luaCashShop.MaxPage >= nTempMok*5 + i then
				_window:SetText(nTempMok*5 + i);
		
				--gamedebug:Log( "SetText : " .. nTempMok*5 + i);
			else
				_window:SetText("");
			end
		
		end
		
		local _window = rawget( _G, "picNumber" .. nTemp+1);
		_window:SetImage("bmpTextlabel2");
	
	else

		local tempPage = nPage;
		if tempPage > 4 then tempPage = 4;
		end

		for i = 1, 5 do
		
			local _window = rawget( _G, "btnNumber" .. i);
			
			if luaCashShop.MaxPage >= i then
				_window:SetText(i);
			else
				_window:SetText("");
			end
			
		
		end

		local _window = rawget( _G, "picNumber" .. tempPage+1);
		_window:SetImage("bmpTextlabel2");

	end

end



function luaCashShop:OnClickPreButton(bMax)

	if (luaCashShop.CurrPage == 0) then return;
	end

	if ( bMax == true) then
		luaCashShop.CurrPage = 0;
	else
		luaCashShop.CurrPage = math.max(0, luaCashShop.CurrPage-1);
	end
	
	luaCashShop:OnClickPageButton(luaCashShop.CurrPage);
end





function luaCashShop:OnClickNextButton(bMin)

	local nItemCount = table.getn(luaCashShop.SaleItem);
	luaCashShop.MaxPage = math.max(1, math.ceil(nItemCount / luaCashShop.nPageItemCount));
	

	if (luaCashShop.CurrPage == luaCashShop.MaxPage-1) then return;
	end

	if ( bMin == true) then
		luaCashShop.CurrPage = luaCashShop.MaxPage-1;
	else
		luaCashShop.CurrPage = math.min(luaCashShop.MaxPage-1, luaCashShop.CurrPage+1);
	end

	luaCashShop:OnClickPageButton(luaCashShop.CurrPage);
end




-- 구매
function luaCashShop:OpenCorfirmBuyProductItemCrystal(nProductItemID)

	local strName = gamefunc:GetProductItemName(nProductItemID);
	local bSale = gamefunc:IsProductItemSale(nProductItemID);
	local nItemPrice = gamefunc:GetProductItemPrice(nProductItemID);
	local nItemSalePrice = gamefunc:GetProductItemSalePrice(nProductItemID);
	local nItemID = gamefunc:GetItemIDByProductItem(nProductItemID);
	local strImage = gamefunc:GetItemImage( nItemID );
	local r, g, b = GetItemColor( nItemID);
	local nCrystalPrice = gamefunc:GetProductItemCrystalPrice(nProductItemID);
	local nCrystalInven = gamefunc:GetInvenItemQuantityByID(luaCashShop.nCrystalItemID);

	strName = "{COLOR r=" .. r .. " g=" .. g .. " b=" .. b .. "}" ..
		gamedraw:SubTextWidth( "fntScript", strName, 250) .. "{/COLOR}";

	local strText = 
		"{INDENT dent=0}{ALIGN hor=\"left\"}{CR h=0}{BITMAP name=\"bmpItemSlot\" w=66 h=66}{CR h=1}{SPACE w=1}{BITMAP name=\"" .. strImage .. "\" w=64 h=64}{CR h=0}" ..
		"{INDENT dent=70}".. "{FONT name=\"fntScript\"}" .. strName;

	strText = strText ..
		"{CR}{BITMAP name=\"bmpCrystal\" w=15 h=15}{SPACE w=5}" .. luaGame:AddPmangMoneyColor(nCrystalPrice);
	
			
	tvwConfirmBuyProductItem:SetText( strText);

	local strMoney = "{FONT name=\"fntBold\"}{COLUMN h=22}{ALIGN hor=\"left\" ver=\"bottom\"}" .. 
		STR("UI_CASHSHOP_CRYSTAL_INFO") .. "{CR h =10}{BITMAP name=\"bmpDefSeperateBarHor2\" w=250 h=2}{CR}" ..
		"{ALIGN hor=\"left\"}" .. STR("UI_CASHSHOP_CRYSTAL_HAVE") .. "   :{CR h=0}{ALIGN hor=\"right\"}" .. luaGame:ConvertPmangMoneyToStr( nCrystalInven) .. "{SPACE w=150}{CR}";
		
	strMoney = strMoney .. "{ALIGN hor=\"left\"}" .. STR("UI_CASHSHOP_CRYSTAL_ACCOUNT") .. "   :{CR h=0}{ALIGN hor=\"right\"}" .. luaGame:ConvertPmangMoneyToStr( nCrystalPrice) .. "{SPACE w=150}{CR}" ..
		"{ALIGN hor=\"left\"}" .. STR("UI_CASHSHOP_CRYSTAL_BALANCES") .. "   :{CR h=0}{ALIGN hor=\"right\"}" .. luaGame:ConvertPmangMoneyToStr( nCrystalInven - nCrystalPrice) .. "{SPACE w=150}{CR}";

	strMoney = strMoney ..
		"{CR h =10}{ALIGN hor=\"center\"}" .. PinkColor() .. STR("UI_CASHSHOP_PROVISION_CRYSTAL") .. STR("UI_CASHSHOP_BUY") .. EndColor();
		
	tvwConfirmBuyProductItemMoney:SetText( strMoney);


	btnConfirmBuyProductItemOK:SetUserData(nProductItemID);

	local width, height	= gamefunc:GetWindowSize();
	local w, h			= frmConfirmBuyProductItem:GetSize();
	frmConfirmBuyProductItem:SetPosition( ( ( width - w ) * 0.5 ), ( height - h ) * 0.5 );

	frmConfirmBuyProductItem:DoModal();
end


function luaCashShop:OpenCorfirmBuyProductItem(nProductItemID)

	local strName = gamefunc:GetProductItemName(nProductItemID);
	local bSale = gamefunc:IsProductItemSale(nProductItemID);
	local nItemPrice = gamefunc:GetProductItemPrice(nProductItemID);
	local nItemSalePrice = gamefunc:GetProductItemSalePrice(nProductItemID);
	local nItemID = gamefunc:GetItemIDByProductItem(nProductItemID);
	local strImage = gamefunc:GetItemImage( nItemID );
	local r, g, b = GetItemColor( nItemID);

	strName = "{COLOR r=" .. r .. " g=" .. g .. " b=" .. b .. "}" ..
		gamedraw:SubTextWidth( "fntScript", strName, 250) .. "{/COLOR}";

	local strText = 
		"{INDENT dent=0}{ALIGN hor=\"left\"}{CR h=0}{BITMAP name=\"bmpItemSlot\" w=66 h=66}{CR h=1}{SPACE w=1}{BITMAP name=\"" .. strImage .. "\" w=64 h=64}{CR h=0}" ..
		"{INDENT dent=70}".. "{FONT name=\"fntScript\"}" .. strName;

	if (bSale == true)	then
		local nWidth = luaCashShop:GetPriceXWidth(nItemPrice);
		strText = strText .. 
			"{CR}" .. luaGame:AddPmangMoneyColor(FORMAT( "UI_CASHSHOP_CURRENCY", nItemSalePrice)) ..
			"{CR h=0}{SPACE w=80}" .. luaGame:AddPmangMoneyColor(FORMAT( "UI_CASHSHOP_CURRENCY", nItemPrice)) ..
			"{CR h=0}{SPACE w=70}{BITMAP name=\"bmpPriceX\" w=" .. nWidth .. " h=15}";
	else

		strText = strText .. "{CR}" .. luaGame:AddPmangMoneyColor(FORMAT( "UI_CASHSHOP_CURRENCY", nItemPrice));
	
	end
			
	tvwConfirmBuyProductItem:SetText( strText);

	local nMoney = gamefunc:GetCashMoney();
	local strMoney = "{FONT name=\"fntBold\"}{COLUMN h=22}{ALIGN hor=\"left\" ver=\"bottom\"}" .. 
		STR("UI_CASHSHOP_PAYMENTINFO") .. "{CR h =10}{BITMAP name=\"bmpDefSeperateBarHor2\" w=250 h=2}{CR}" ..
		"{ALIGN hor=\"left\"}" .. STR("UI_CASHSHOP_PMANGCASH") .. "   :{CR h=0}{ALIGN hor=\"right\"}" .. luaGame:ConvertPmangMoneyToStr( nMoney) .. "{SPACE w=150}{CR}";
		
	if (bSale == true)	then
		local nWidth = luaCashShop:GetPriceXWidth(nItemPrice);
		strMoney = strMoney .. 
			"{ALIGN hor=\"left\"}" .. STR("UI_CASHSHOP_PAYMENTACCOUNT") .. "   :{CR h=0}{ALIGN hor=\"right\"}" .. luaGame:ConvertPmangMoneyToStr( nItemSalePrice) .. "{SPACE w=150}" ..
			"{CR h=0}" .. luaGame:AddPmangMoneyColor(FORMAT( "UI_CASHSHOP_CURRENCY", nItemPrice)) .. "{SPACE w=20}" ..
			"{CR h=0}{BITMAP name=\"bmpPriceX\" w=" .. nWidth .. " h=15}{SPACE w=20}{CR}" ..
			"{ALIGN hor=\"left\"}" .. STR("UI_CASHSHOP_PAYMENT_BALANCES") .. ":{CR h=0}{ALIGN hor=\"right\"}" .. luaGame:ConvertPmangMoneyToStr( nMoney - nItemSalePrice) .. "{SPACE w=150}{CR}";
			
	else
		strMoney = strMoney .. "{ALIGN hor=\"left\"}" .. STR("UI_CASHSHOP_PAYMENTACCOUNT") .. "   :{CR h=0}{ALIGN hor=\"right\"}" .. luaGame:ConvertPmangMoneyToStr( nItemPrice) .. "{SPACE w=150}{CR}" ..
			"{ALIGN hor=\"left\"}" .. STR("UI_CASHSHOP_PAYMENT_BALANCES") .. ":{CR h=0}{ALIGN hor=\"right\"}" .. luaGame:ConvertPmangMoneyToStr( nMoney - nItemPrice) .. "{SPACE w=150}{CR}";
	end

	strMoney = strMoney ..
		"{CR h =10}{ALIGN hor=\"center\"}" .. PinkColor() .. STR("UI_CASHSHOP_PROVISION") .. STR("UI_CASHSHOP_BUY") .. EndColor();
		
	tvwConfirmBuyProductItemMoney:SetText( strMoney);


	btnConfirmBuyProductItemOK:SetUserData(nProductItemID);

	local width, height	= gamefunc:GetWindowSize();
	local w, h			= frmConfirmBuyProductItem:GetSize();
	frmConfirmBuyProductItem:SetPosition( ( ( width - w ) * 0.5 ), ( height - h ) * 0.5 );

	frmConfirmBuyProductItem:DoModal();
end




function luaCashShop:OnItemClickTerms(_wnd)

	-- Get reference text
	local nItemIndex = EventArgs:GetItemIndex();
	if ( nItemIndex < 0)  then  return;
	end

	
	local strRefText = _wnd:GetRefText( nItemIndex);
	local strType, strData = luaGame:GetReferenceTypeData( strRefText);
	
	
	-- Clicked selectable item
	if ( strType == "terms")  then	gamefunc:ShowTerms();
	end
end



function luaCashShop:CheckBuyProductItem(nProductItemID)

	local nMaxCount = gamefunc:GetCashInvenItemMaxCount();
	local nCount = gamefunc:GetCashInvenItemCount();
	if (nMaxCount == nCount) then
		luaGame:OnEventErrorMessageBox( STR("UI_CASHSHOP_CASHINVEN_SPACE_SHORT"));		
		return false;
	end

	if (luaCashShop:CheckGiftProductItem(nProductItemID) == true) then return true;
	end
	
	return false;	
end

function luaCashShop:CheckBuyProductItemCrystal(nProductItemID)

	local nCrystalPrice = gamefunc:GetProductItemCrystalPrice(nProductItemID);
	local nCrystalInven = gamefunc:GetInvenItemQuantityByID(luaCashShop.nCrystalItemID);
	if (nCrystalPrice > nCrystalInven) then
		luaGame:OnEventErrorMessageBox( STR("UI_CASHSHOP_CRYSTAL_SHORT"));		
		return false;
	end

	return true;	
end



function luaCashShop:CheckGiftProductItem(nProductItemID)

	if ( nProductItemID <= 0)  then	return false;
	end

	local nItemPrice = gamefunc:GetProductItemPrice(nProductItemID);
	local nItemSalePrice = gamefunc:GetProductItemSalePrice(nProductItemID);
	local bSale = gamefunc:IsProductItemSale(nProductItemID);	
	local nMoney = gamefunc:GetCashMoney();

		if (bSale == true) and ( nMoney >= nItemSalePrice)	then	return true;
	elseif (bSale == false) and ( nMoney >= nItemPrice)		then	return true;
	else
		local width, height	= gamefunc:GetWindowSize();
        local x, y			= frmCashBalanceShort:GetParent():GetPosition();
		local w, h			= frmCashBalanceShort:GetSize();
		frmCashBalanceShort:SetPosition( ( ( width - w ) * 0.5 - x), ( height - h ) * 0.5 - y );
		frmCashBalanceShort:DoModal();
	end
	
	return false;
end




function luaCashShop:CloseConfirmBuyProductItem()

	btnConfirmBuyProductItemOK:SetUserData(0);
	frmConfirmBuyProductItem:Show(false);

end




function luaCashShop:DoConfirmBuyProductItem()

	local nProductItemID = btnConfirmBuyProductItemOK:GetUserData();

	gamefunc:BuyProductItem(nProductItemID);
	
	luaCashShop:CloseConfirmBuyProductItem();
end




function luaCashShop:OnItemClickProductItemListCtrl(_wnd)

	-- Get reference text
	local nItemIndex = EventArgs:GetItemIndex();
	if ( nItemIndex < 0)  then  return;
	end

	
	local strRefText = _wnd:GetRefText( nItemIndex);
	local strType, strData = luaGame:GetReferenceTypeData( strRefText);
	
	
	-- Clicked selectable item
	if ( strType == "item")  then
	
		local nProductItemID = tonumber( strData);
		if ( nProductItemID >= 0)  then
			
			-- 상세 보기
			luaCashShop:OpenProductItemInfo(nProductItemID);
			
		end
		
	elseif ( strType == "buyitem")  then
	
		local nProductItemID = tonumber( strData);
		luaCashShop:BuyItem(nProductItemID);
		
		-- Play sound
		local nItemID = gamefunc:GetItemIDByProductItem(nProductItemID);
		local strSound = gamefunc:GetItemPutDownSound( nItemID);
		gamefunc:PlaySound( strSound);
		
	elseif ( strType == "giftitem")  then

		local nProductItemID = tonumber( strData);
		if luaCashShop:CheckGiftProductItem(nProductItemID) == true then
		
			luaCashShop:OpenCorfirmGiftCashItem(nProductItemID);
		end
		
		-- Play sound
		local nItemID = gamefunc:GetItemIDByProductItem(nProductItemID);
		local strSound = gamefunc:GetItemPutDownSound( nItemID);
		gamefunc:PlaySound( strSound);
		
	end
end




function luaCashShop:OnToolTipProductItemListCtrl(_wnd)



	local strToolTip = "";

	-- Get reference text
	local nItemIndex = EventArgs:GetItemIndex();
	if ( nItemIndex >= 0)  then

		local strRefText = _wnd:GetRefText( nItemIndex);
		local strType, strData = luaGame:GetReferenceTypeData( strRefText );

		-- Set tooltip
		if ( strType == "item")  then

			local nProductID = tonumber( strData);
			local nID = gamefunc:GetItemIDByProductItem( nProductID);
			
			if ( nID > 0)  then
				
				strToolTip = luaToolTip:GetItemToolTip( nID, nil, nil);
				
				local nSlotType = gamefunc:GetItemSlot( nID);
				if ( nSlotType ~= ITEM_SLOT.NONE)  then  strToolTip = strToolTip;
				end
			end
		
		
		elseif ( strType == "buyitem")  then
		
			strToolTip = STR("UI_CASHSHOP_CASH_TOOLTIP");
			
		elseif ( strType == "giftitem")  then
		
			strToolTip = STR("UI_CASHSHOP_GIFT_TOOLTIP");
			
		end
	end
	
	_wnd:SetToolTip( strToolTip);
end




function luaCashShop:OnDragBeginCashInvenListCtrl()

	DragEventArgs:SetEffect( "add");
	
	return true;
end




function luaCashShop:OnToolTipCashInvenListCtrl()

	local strToolTip = "";

	local nSel = lcCashInventory:GetMouseOver();
	if ( nSel >= 0)  then
	
		local nIndex = lcCashInventory:GetItemData( nSel);
		if ( nIndex >= 0)  then

			local nItemID = gamefunc:GetCashInvenItemID( nIndex);
			if ( nItemID > 0)  then

				strToolTip = luaToolTip:GetItemToolTip( nItemID, nil, nil);
				
				local nSlotType = gamefunc:GetItemSlot( nItemID);
				if ( nSlotType ~= ITEM_SLOT.NONE)  and  ( gamefunc:GetEquippedItemID( nSlotType) > 0)  then

					strToolTip = strToolTip .. "{divide}" ..
								ToolTipDivideColor() .. "< " .. STR( "UI_EQUIPPEDITEM") .. " >{/COLOR}\n" .. luaToolTip:OnToolTipEquipItem( nItemID);
				end
			end
		end
	end

	lcCashInventory:SetToolTip( strToolTip);
end


function luaCashShop:OnClickCashInvenItem()

	local nSel = lcCashInventory:GetMouseOver();
	if ( nSel >= 0)  then

		local nIndex = lcCashInventory:GetItemData( nSel);
		if ( nIndex >= 0)  then

			local nItemID = gamefunc:GetCashInvenItemID( nIndex);
			if ( nItemID > 0)  then
				luaCashShop.nClickedItemIndex = luaCashShop.nClickItemIndex;
				luaCashShop.nClickItemIndex = nIndex;

				lcCashInventory:SetItemImageTag(luaCashShop.nClickedItemIndex,"");
				lcCashInventory:SetItemImageTag(luaCashShop.nClickItemIndex,"bmpItemSlotClicked");
				
			end
		end
	end
end


function luaCashShop:OpenfrmInventory()

	local x, y = frmInventory:GetPosition();
	local w, h = frmInventory:GetSize();
	local sx, sy, sw, sh = lcCashInventory:GetWindowRect();
	frmInventory:SetPosition( sx - w, sy - (w - sw) );	
	frmInventory:Show( not frmInventoryMgr:GetShow());
end



function luaCashShop:OpenCorfirmMovetoInven(nIndex)

	local nInvenMaxCount = gamefunc:GetInvenItemMaxCount();
	local nInvenCount = gamefunc:GetInvenItemCount();
	if (nInvenMaxCount == nInvenCount) then
		luaGame:OnEventErrorMessageBox( STR("UI_CASHSHOP_INVEN_SPACE_SHORT"));
		return;
	end

	local strSenderName = gamefunc:GetCashInvenItemGiftSenderName(nIndex);
	if ( strSenderName ~= "") then
	
		frmConfirmMoveProductItem:SetText(STR("UI_CASHSHOP_GIFT_DLG_MOVE"));
		tvwDlgStrMoveItem:SetText(STR("UI_CASHSHOP_GIFT_DLG_MOVE_STR") .. strSenderName);
	
	else
	
		frmConfirmMoveProductItem:SetText(STR("UI_CASHSHOP_DLG_MOVE"));
		tvwDlgStrMoveItem:SetText(STR("UI_CASHSHOP_DLG_STR_MOVE"));
	
	end

	local strName = gamefunc:GetCashInvenProductName(nIndex);
	local nItemID = gamefunc:GetCashInvenItemID(nIndex);
	local strImage = gamefunc:GetItemImage( nItemID );
	local r, g, b = GetItemColor( nItemID);

	if( true == gamefunc:IsLocale_en_US() )	then
		strName = "{COLOR r=" .. r .. " g=" .. g .. " b=" .. b .. "}" .. gamedraw:SubTextWidth( "fntScript", strName, 350) .. "{/COLOR}";
	else
		strName = "{COLOR r=" .. r .. " g=" .. g .. " b=" .. b .. "}" .. gamedraw:SubTextWidth( "fntScript", strName, 250) .. "{/COLOR}";
	end
	

	local strText = 
		"{INDENT dent=0}{ALIGN hor=\"left\"}{CR h=0}{BITMAP name=\"bmpItemSlot\" w=66 h=66}{CR h=1}{SPACE w=1}{BITMAP name=\"" .. strImage .. "\" w=64 h=64}{CR h=0}" ..
		"{INDENT dent=70}".. "{FONT name=\"fntScript\"}" .. strName ..
		"{FONT name=\"fntBold\"}{COLUMN h=22}{ALIGN hor=\"left\" ver=\"bottom\"}{/INDENT}" .. 
		"{CR}{CR}{CR}{ALIGN hor=\"center\"}" .. PinkColor() .. STR("UI_CASHSHOP_PROVISION") .. STR("UI_CASHSHOP_USE") .. EndColor();
		
	tvwMoveProductItem:SetText( strText);	

	btnConfirmMoveProductItemOK:SetUserData(nIndex);
	
	local width, height	= gamefunc:GetWindowSize();
	local w, h			= frmConfirmBuyProductItem:GetSize();
	frmConfirmMoveProductItem:SetPosition( ( ( width - w ) * 0.5 ), ( height - h ) * 0.5 );
	frmConfirmMoveProductItem:DoModal();
end




function luaCashShop:CloseConfirmMovetoInven()

	btnConfirmMoveProductItemOK:SetUserData(0);

	frmConfirmMoveProductItem:Show(false);
end




function luaCashShop:DoConfirmMovetoInven()

	local nIndex = btnConfirmMoveProductItemOK:GetUserData();
	gamefunc:SetMoveCashInvenItem(nIndex);

	luaCashShop:CloseConfirmMovetoInven();
end





function luaCashShop:OpenProductItemInfo(nProductItemID)

	local strName = gamefunc:GetProductItemName(nProductItemID);
	local bSale = gamefunc:IsProductItemSale(nProductItemID);
	local nItemPrice = gamefunc:GetProductItemPrice(nProductItemID);
	local nItemSalePrice = gamefunc:GetProductItemSalePrice(nProductItemID);
	local strItemDesc = gamefunc:GetProductItemDesc(nProductItemID);
	local nItemID = gamefunc:GetItemIDByProductItem(nProductItemID);
	local strImage = gamefunc:GetItemImage( nItemID );
	local r, g, b = GetItemColor( nItemID);
	local bCrystal = gamefunc:IsProductItemCrystal(nProductItemID);
	local nItemCrystalPrice = gamefunc:GetProductItemCrystalPrice(nProductItemID);

	strName = "{COLOR r=" .. r .. " g=" .. g .. " b=" .. b .. "}" ..
		gamedraw:SubTextWidth( "fntScript", strName, 350) .. "{/COLOR}";

	local strText = 
		"{INDENT dent=0}{ALIGN hor=\"left\"}{CR h=0}{BITMAP name=\"bmpItemSlot\" w=66 h=66}{CR h=1}{SPACE w=1}{BITMAP name=\"" .. strImage .. "\" w=64 h=64}{CR h=0}" ..
		"{INDENT dent=70}".. "{FONT name=\"fntScript\"}" .. strName;
	
	if (bCrystal == true) then
		strText = strText ..
			"{CR}{BITMAP name=\"bmpCrystal\" w=15 h=15}{SPACE w=5}" .. luaGame:AddPmangMoneyColor(nItemCrystalPrice) .. "{SPACE w=20}";
	else
		if (bSale == true)	then
			local nWidth = luaCashShop:GetPriceXWidth(nItemPrice);
			strText = strText .. 
				"{CR}" .. luaGame:AddPmangMoneyColor(FORMAT( "UI_CASHSHOP_CURRENCY", nItemSalePrice)) ..
				"{CR h=0}{SPACE w=80}" .. luaGame:AddPmangMoneyColor(FORMAT( "UI_CASHSHOP_CURRENCY", nItemPrice)) ..
				"{CR h=0}{SPACE w=70}{BITMAP name=\"bmpPriceX\" w=" .. nWidth .. " h=15}";
		else
			strText = strText .. "{CR}" .. luaGame:AddPmangMoneyColor(FORMAT( "UI_CASHSHOP_CURRENCY", nItemPrice));
		end
	end

	tvwProductItemInfo:SetText( strText);

	
	strText = "{FONT name=\"fntScript\"}" .. strItemDesc .. "{CR}{CR h=10}";
	tvwProductItemInfoDesc:SetText( strText);


	btnBuyProductItem:SetUserData(nProductItemID);

	local width, height	= gamefunc:GetWindowSize();
	local w, h			= frmConfirmBuyProductItem:GetSize();
	frmProductItemInfo:SetPosition( ( ( width - w ) * 0.5 ), ( height - h ) * 0.5 );
	frmProductItemInfo:DoModal();
end




function luaCashShop:DoBuyProductItem()

	local nProductItemID = btnBuyProductItem:GetUserData();

	luaCashShop:CloseProductItemInfo();

	luaCashShop:BuyItem(nProductItemID);
end

function luaCashShop:BuyItem(nProductItemID)

	if (gamefunc:IsProductItemCrystal(nProductItemID) == true) then
		if (luaCashShop:CheckBuyProductItemCrystal(nProductItemID) == true) then
			luaCashShop:OpenCorfirmBuyProductItemCrystal(nProductItemID);		
		end	
	else
		if (luaCashShop:CheckBuyProductItem(nProductItemID) == true) then
			luaCashShop:OpenCorfirmBuyProductItem(nProductItemID);		
		end
	end
end




function luaCashShop:CloseProductItemInfo()

	btnBuyProductItem:SetUserData(0);
	frmProductItemInfo:Show(false);
end




function luaCashShop:OpenBuyProductItemSuccess(nProductItemID)

	local strName = gamefunc:GetProductItemName(nProductItemID);
	local nID = gamefunc:GetItemIDByProductItem(nProductItemID);
	local strImage = gamefunc:GetItemImage( nID );
	local bCrystal = gamefunc:IsProductItemCrystal(nProductItemID);

	if(bCrystal == true) then
		tvwBuyItemComfirm:SetText( STR("UI_CASHSHOP_BUYSUCCESS_CRYSTAL"));
	else
		tvwBuyItemComfirm:SetText( STR("UI_CASHSHOP_BUYSUCCESS"));
	end

	local strText = "{BITMAP name=\"bmpItemSlot\" w=42 h=42}{CR h=1}" ..
		"{SPACE w=1}{BITMAP name=\"" .. strImage .. "\" w=40 h=40}{CR h=0}" ..
		"{INDENT dent=45}{FONT name=\"fntRegular\"}{COLOR r=160 g=160 b=160}" .. strName ..
		"{/COLOR}{/FONT}{CR}{FONT name=\"fntScript\"}{COLOR r=80 g=130 b=130}" .. STR( "QUANTITY") .. " : " .. 1;
	tvwBuyItemDesc:SetText( strText);
	
	local strToolTip = luaToolTip:GetItemToolTip( nID, nil, nil);
	tvwBuyItemDesc:SetToolTip( strToolTip);

	local width, height	= frmCashShop:GetSize();
	local w, h			= frmConfirmBuySuccess:GetSize();
	frmConfirmBuySuccess:SetPosition( (( width - w ) * 0.5 ), ( height - h ) * 0.5 );
	frmConfirmBuySuccess:DoModal();
end




function luaCashShop:CloseConfirmBuySuccess()

	frmConfirmBuySuccess:Show(false);
	
end



-- 구매
function luaCashShop:OpenCorfirmGiftCashItem(nProductItemID)

	edtUserName:SetText(STR("UI_CASHSHOP_GIFT_USER"));
	tvwNotMatchUser:SetText("");	
	btnConfirmGiftCashItemOK:Enable(false);

	local strName = gamefunc:GetProductItemName(nProductItemID);
	local bSale = gamefunc:IsProductItemSale(nProductItemID);
	local nItemPrice = gamefunc:GetProductItemPrice(nProductItemID);
	local nItemSalePrice = gamefunc:GetProductItemSalePrice(nProductItemID);
	local nItemID = gamefunc:GetItemIDByProductItem(nProductItemID);
	local strImage = gamefunc:GetItemImage( nItemID );
	local r, g, b = GetItemColor( nItemID);

	strName = "{COLOR r=" .. r .. " g=" .. g .. " b=" .. b .. "}" ..
		gamedraw:SubTextWidth( "fntScript", strName, 250) .. "{/COLOR}";

	local strText = 
		"{INDENT dent=0}{ALIGN hor=\"left\"}{CR h=0}{BITMAP name=\"bmpItemSlot\" w=66 h=66}{CR h=1}{SPACE w=1}{BITMAP name=\"" .. strImage .. "\" w=64 h=64}{CR h=0}" ..
		"{INDENT dent=70}".. "{FONT name=\"fntScript\"}" .. strName;
	
	if (bSale == true)	then
		local nWidth = luaCashShop:GetPriceXWidth(nItemPrice);
		strText = strText .. 
			"{CR}" .. luaGame:AddPmangMoneyColor(FORMAT( "UI_CASHSHOP_CURRENCY", nItemSalePrice)) ..
			"{CR h=0}{SPACE w=80}" .. luaGame:AddPmangMoneyColor(FORMAT( "UI_CASHSHOP_CURRENCY", nItemPrice)) ..
			"{CR h=0}{SPACE w=70}{BITMAP name=\"bmpPriceX\" w=" .. nWidth .. " h=15}";
	else

		strText = strText .. "{CR}" .. luaGame:AddPmangMoneyColor(FORMAT( "UI_CASHSHOP_CURRENCY", nItemPrice));
	
	end
			
	tvwConfirmGiftCashItem:SetText( strText);

	local nMoney = gamefunc:GetCashMoney();
	local strMoney = "{FONT name=\"fntBold\"}{COLUMN h=22}{ALIGN hor=\"left\" ver=\"bottom\"}" .. 
		STR("UI_CASHSHOP_PAYMENTINFO") .. "{CR h =10}{BITMAP name=\"bmpDefSeperateBarHor2\" w=250 h=2}{CR}" ..
		"{ALIGN hor=\"left\"}" .. STR("UI_CASHSHOP_PMANGCASH") .. "   :{CR h=0}{ALIGN hor=\"right\"}" .. luaGame:ConvertPmangMoneyToStr( nMoney) .. "{SPACE w=150}{CR}";
		
	if (bSale == true)	then
		local nWidth = luaCashShop:GetPriceXWidth(nItemPrice);
		strMoney = strMoney .. 
			"{ALIGN hor=\"left\"}" .. STR("UI_CASHSHOP_PAYMENTACCOUNT") .. "   :{CR h=0}{ALIGN hor=\"right\"}" .. luaGame:ConvertPmangMoneyToStr( nItemSalePrice) .. "{SPACE w=150}" ..
			"{CR h=0}" .. luaGame:AddPmangMoneyColor(FORMAT( "UI_CASHSHOP_CURRENCY", nItemPrice)) .. "{SPACE w=20}" ..
			"{CR h=0}{BITMAP name=\"bmpPriceX\" w=" .. nWidth .. " h=15}{SPACE w=20}{CR}" ..
			"{ALIGN hor=\"left\"}" .. STR("UI_CASHSHOP_PAYMENT_BALANCES") .. ":{CR h=0}{ALIGN hor=\"right\"}" .. luaGame:ConvertPmangMoneyToStr( nMoney - nItemSalePrice) .. "{SPACE w=150}{CR}";
			
	else
		strMoney = strMoney .. "{ALIGN hor=\"left\"}" .. STR("UI_CASHSHOP_PAYMENTACCOUNT") .. "   :{CR h=0}{ALIGN hor=\"right\"}" .. luaGame:ConvertPmangMoneyToStr( nItemPrice) .. "{SPACE w=150}{CR}" ..
			"{ALIGN hor=\"left\"}" .. STR("UI_CASHSHOP_PAYMENT_BALANCES") .. ":{CR h=0}{ALIGN hor=\"right\"}" .. luaGame:ConvertPmangMoneyToStr( nMoney - nItemPrice) .. "{SPACE w=150}{CR}";
	end

	strMoney = strMoney ..
		"{CR h =10}{ALIGN hor=\"center\"}   " .. PinkColor() .. STR("UI_CASHSHOP_PROVISION") .. STR("UI_CASHSHOP_BUY") .. EndColor();
		

	tvwConfirmGiftCashItemMoney:SetText( strMoney);


	btnConfirmGiftCashItemOK:SetUserData(nProductItemID);

	local width, height	= gamefunc:GetWindowSize();
	local w, h			= frmConfirmGiftCashItem:GetSize();
	frmConfirmGiftCashItem:SetPosition( ( ( width - w ) * 0.5 ), ( height - h ) * 0.5 );

	frmConfirmGiftCashItem:DoModal();
end




function luaCashShop:CloseConfirmGiftCashItem()

	frmConfirmGiftCashItem:Show(false);
end




function luaCashShop:DoConfirmGiftCashItem()

	local strName = edtUserName:GetText();
	local nItemID = btnConfirmGiftCashItemOK:GetUserData();
	gamefunc:Gift( nItemID, strName);

	luaCashShop:CloseConfirmGiftCashItem();
end




function luaCashShop:FindMatchUser(strName)

	if ( gamefunc:GetName() == strName) then
		tvwNotMatchUser:SetText(STR("UI_CASHSHOP_SAME_USER"));
		return;
	end

	gamefunc:FindMatchUser(strName);
end




function luaCashShop:RefreshMatchUser(sParam1, nParam2)

	if ( nParam2 == 1)  then
		tvwNotMatchUser:SetText(STR("UI_CASHSHOP_MATCH_USER"));
		btnConfirmGiftCashItemOK:Enable(true);
		
	elseif ( nParam2 == 0)  then
	
		tvwNotMatchUser:SetText("{COLOR r=250 g=0 b=0}" .. sParam1 .. ".{/COLOR}");
		btnConfirmGiftCashItemOK:Enable(false);
	end
end




function luaCashShop:OnClickCashHelp()

	local width, height	= gamefunc:GetWindowSize();
	local w, h			= frmCashHelp:GetSize();
	frmCashHelp:SetPosition( ( ( width - w ) * 0.5 ), ( height - h ) * 0.5 );
	frmCashHelp:DoModal();
end




function luaCashShop:OnLoadedCashHelp()

	tvwCashHelp:SetText( "{FONT name=\"fntScript\"}" .. STR("UI_CASHSHOP_PMANG_CASH_DESC"));

end




function luaCashShop:OpenGiftSuccess(nProductItemID)

	local strName = gamefunc:GetProductItemName(nProductItemID);
	local nID = gamefunc:GetItemIDByProductItem(nProductItemID);
	local strImage = gamefunc:GetItemImage( nID );

	local strText = "{BITMAP name=\"bmpItemSlot\" w=42 h=42}{CR h=1}" ..
		"{SPACE w=1}{BITMAP name=\"" .. strImage .. "\" w=40 h=40}{CR h=0}" ..
		"{INDENT dent=45}{FONT name=\"fntRegular\"}{COLOR r=160 g=160 b=160}" .. strName ..
		"{/COLOR}{/FONT}{CR}{FONT name=\"fntScript\"}{COLOR r=80 g=130 b=130}" .. STR( "QUANTITY") .. " : " .. 1;
	tvwGiftItemDesc:SetText( strText);
	
	local strToolTip = luaToolTip:GetItemToolTip( nID, nil, nil);
	tvwGiftItemDesc:SetToolTip( strToolTip);

	local width, height	= frmCashShop:GetSize();
	local w, h			= frmGiftSuccess:GetSize();
	frmGiftSuccess:SetPosition( (( width - w ) * 0.5 ), ( height - h ) * 0.5 );
	frmGiftSuccess:DoModal();
end



function luaCashShop:CloseGiftSuccess()

	frmGiftSuccess:Show(false);
	
end



function luaCashShop:OnValueChangedUserName()

	tvwNotMatchUser:SetText("");	
	btnConfirmGiftCashItemOK:Enable(false);
end

function luaCashShop:OnBegin()

	if( ( true == gamefunc:IsLocale_en_US() ) or ( true == gamefunc:IsLocale_en_GB() ) or ( true == gamefunc:IsLocale_de_DE() ) ) 		then
		
		-- Show
		if ( frmCashShop:GetShow() == true)  then
			luaCashShop:ChangeCategory(luaCashShop.CATEGORY.MAIN);
			luaCashShop:Refresh();
			luaCashShop:OnClickPageButton(luaCashShop.CurrPage);

		-- Hide
		else
			frmCashShop:DoModal();
		end
	
	else
		frmCashShop:DoModal();
	end
	
end


function luaCashShop:OnToolTipProductItemIcon(nIndex)

	local _picProductItemImage			= _G[ "picProductItemImage" .. nIndex];

	local nBeginCount = luaCashShop.CurrPage * luaCashShop.nPageItemCount;
	local nCurIndex = nBeginCount + nIndex;
	local nProductItemID = luaCashShop.SaleItem[nCurIndex];
	local nID = gamefunc:GetItemIDByProductItem( nProductItemID);
	local strToolTip = "";
			
	if ( nID > 0)  then
				
		strToolTip = luaToolTip:GetItemToolTip( nID, nil, nil);
	end

	_picProductItemImage:SetToolTip( strToolTip);
end


function luaCashShop:OnClickProductItemIcon(nIndex)

	local nBeginCount = luaCashShop.CurrPage * luaCashShop.nPageItemCount;
	local nCurIndex = nBeginCount + nIndex;
	local nProductItemID = luaCashShop.SaleItem[nCurIndex];

	if ( nProductItemID >= 0)  then

		luaCashShop:OpenProductItemInfo(nProductItemID);
	end
end


function luaCashShop:OnClickProductItemPreview(nIndex)

	local nBeginCount = luaCashShop.CurrPage * luaCashShop.nPageItemCount;
	local nCurIndex = nBeginCount + nIndex;
	local nProductItemID = luaCashShop.SaleItem[nCurIndex];
	local nItemID = gamefunc:GetItemIDByProductItem(nProductItemID);

	luaItemPreview:OnClickItemPreview(nItemID);
end


function luaCashShop:OnClickProductItemBuy(nIndex)

	local nBeginCount = luaCashShop.CurrPage * luaCashShop.nPageItemCount;
	local nCurIndex = nBeginCount + nIndex;
	local nProductItemID = luaCashShop.SaleItem[nCurIndex];

	luaCashShop:BuyItem(nProductItemID);
		
	-- Play sound
	local nItemID = gamefunc:GetItemIDByProductItem(nProductItemID);
	local strSound = gamefunc:GetItemPutDownSound( nItemID);
	gamefunc:PlaySound( strSound);
end


function luaCashShop:OnClickProductItemGift(nIndex)

	local nBeginCount = luaCashShop.CurrPage * luaCashShop.nPageItemCount;
	local nCurIndex = nBeginCount + nIndex;
	local nProductItemID = luaCashShop.SaleItem[nCurIndex];

	if luaCashShop:CheckGiftProductItem(nProductItemID) == true then
		
		luaCashShop:OpenCorfirmGiftCashItem(nProductItemID);
	end
		
	-- Play sound
	local nItemID = gamefunc:GetItemIDByProductItem(nProductItemID);
	local strSound = gamefunc:GetItemPutDownSound( nItemID);
	gamefunc:PlaySound( strSound);
end