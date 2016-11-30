--[[
	Game TradeMarket LUA script
--]]


-- Global instance
luaTradeMarket = {};
luaTradeMarket.TabCtrlBtnHeight		= 25;
luaTradeMarket.TABCTRL	= { SEARCH_ITEM = 0, MY_MARKET = 1 };
luaTradeMarket.CurrTab	= -1;
luaTradeMarket.LISTTYPE	= { LIST_SEARCH = 0, LIST_SAILES = 1, LIST_CALULATE = 2 };
luaTradeMarket.SORT		= { SORT_NONE = 0, SORT_PRICE = 1, SORT_PRICE_DESCENDANT = 2, SORT_AMOUNT = 3, SORT_AMOUNT_DESCENDANT = 4,
							SORT_NAME = 5, SORT_NAME_DESCENDANT = 6, SORT_LEVEL = 7, SORT_LEVEL_DESCENDANT = 8 };
	
luaTradeMarket.ItemListMax			= 0;
luaTradeMarket.nListStartIndex		= 0;


-- OnShowTradeMarketFrame
function luaTradeMarket:OnShowTradeMarketFrame()

	if( true == frmTradeMarket:GetShow() )	then
		luaTradeMarket:RefreshTradeMarket();
	else
		luaTradeMarket:CloseTradeMarket();
	end
	
	luaGame:ShowWindow( frmTradeMarket );
	
end

-- OpenTradeMarket
function luaTradeMarket:OpenTradeMarket()
	
	if( true == frmTradeMarket:GetShow() )	then
		return ;
	end	
	
	luaTradeMarket:InitTradeMarket();
	frmTradeMarket:Show( true );
	
end

-- InitTradeMarket
function luaTradeMarket:InitTradeMarket()
	
	tbcTradeMarketTabCtrl:SetSelIndex( luaTradeMarket.TABCTRL.SEARCH_ITEM );
	
	luaSearchMarket:InitSearchMarket();
	luaMyMarket:InitMyMarket();
	luaTradeMarket:TradeMarketBlackScreen( false );
	frmConfirmTradeMarket:Show( false );
	
end

-- InitPage
function luaTradeMarket:SetPage( nMaxCnt )

	btnFirstPage:Enable( false );
	btnPrevPage:Enable( false );
	btnNextPage:Enable( false );
	
	-- 이전과 처음으로 버튼 검사
	if( 0 < luaTradeMarket.nListStartIndex )		then
		btnFirstPage:Enable( true );
		btnPrevPage:Enable( true );
	end
	
	local nPage, nMaxPage;
	if( 0 == nMaxCnt )		then
		nPage			= -1;
		nMaxPage		= 0;
	else
		nPage			= math.floor( luaTradeMarket.nListStartIndex / luaTradeMarket.ItemListMax );
		nMaxPage		= math.floor( nMaxCnt / luaTradeMarket.ItemListMax );
		if( 0 < nMaxCnt % luaTradeMarket.ItemListMax )	then
			nMaxPage	= nMaxPage + 1;
		end
		
	end
	
	local strPage = "{FONT name=\"fntBold\"}{COLUMN h=22}{ALIGN hor=\"center\" ver=\"center\"}" .. nPage+1 .. "\/" .. nMaxPage;
	tvwTradeMarketPage:SetText( strPage );
	
	-- 다음 버튼 검사
	if( nMaxCnt > ( luaTradeMarket.nListStartIndex + luaTradeMarket.ItemListMax ) )	then
		btnNextPage:Enable( true );
	end

end

-- RefreshTradeMarket
function luaTradeMarket:RefreshTradeMarket()

	luaTradeMarket:RefreshMoney();
	luaTradeMarket:RefreshfrmTradeMarket();
	
	luaTradeMarket:RefreshTradeMarketTabCtrl();
	
end

-- RefreshfrmTradeMarket
function luaTradeMarket:RefreshfrmTradeMarket()
	
	local winWidth, winHeight		= gamefunc:GetWindowSize();

	local frameWidth, frameHeight	= frmTradeMarket:GetSize();
	local px, py					= frmTradeMarket:GetPosition();
	frmTradeMarket:SetPosition( ( ( winWidth - frameWidth ) * 0.5 ), ( winHeight - frameHeight ) * 0.3 );
	
	
	-- CloseBtn
	local px, py		= btnCloseTradeMarket:GetPosition();
	btnCloseTradeMarket:SetPosition( frameWidth - 40, py );
	
	-- Money 
	local px, py;
	local width, height	=  pnlTradeMarketMoney:GetSize();
	px					= ( frameWidth - width ) - 10;
	py					= ( frameHeight - height ) - 10;
	pnlTradeMarketMoney:SetPosition( px, py );
	
	-- Bottom SeperateBar( Money 위로 offset -5 )
	local BtmBarY		= py - 5;
	picTradeMarketBtmSeperateBar:SetPosition( 0, BtmBarY );
	
end

-- OnLoadedTradeMarketFilterTabCtrl
function luaTradeMarket:OnLoadedTradeMarketFilterTabCtrl()

	tbcTradeMarketTabCtrl:SetTabName( luaTradeMarket.TABCTRL.SEARCH_ITEM,	STR( "UI_TRADEMAKET_TAB_SEARCH_ITEM"   ) );
    tbcTradeMarketTabCtrl:SetTabName( luaTradeMarket.TABCTRL.MY_MARKET,		STR( "UI_TRADEMAKET_TAB_MY_MARKET"     ) );
    
    local px		= 0;
    for i=luaTradeMarket.TABCTRL.SEARCH_ITEM, luaTradeMarket.TABCTRL.MY_MARKET	do
    
		local x, y, w, h	= tbcTradeMarketTabCtrl:GetTabRect( i );
		w	= gamedraw:GetTextWidth( "fntScript", tbcTradeMarketTabCtrl:GetTabName( i ) ) + 50;
		tbcTradeMarketTabCtrl:SetTabRect( i, px, y, w, luaTradeMarket.TabCtrlBtnHeight );
		
		px	= px + w;
    end
    
    local TabCtrlX, TabCtrlY		= tbcTradeMarketTabCtrl:GetPosition();
    local TabCtrlSeperateBarY		= TabCtrlY + luaTradeMarket.TabCtrlBtnHeight;
    picTradeMarketTabCtrlSeperateBar:SetPosition( 0, TabCtrlSeperateBarY );
   
end

-- RefreshMoney
function luaTradeMarket:RefreshMoney()
	
	if ( false == frmTradeMarket:GetShow() )  then
	  return;
	end
	
	local strMoney = "{FONT name=\"fntBold\"}{COLUMN h=22}{ALIGN hor=\"right\" ver=\"bottom\"}" .. luaGame:ConvertMoneyToStr( gamefunc:GetMoney(), "fntSmall") .. "{SPACE w=10}";
	tvwTradeMarketMoney:SetText( strMoney );
	
end

-- RefreshTradeMarketTabCtrl
function luaTradeMarket:RefreshTradeMarketTabCtrl()

	if ( false == frmTradeMarket:GetShow() )  then
	  return;
	end
	
	local nIndex = tbcTradeMarketTabCtrl:GetSelIndex();	
	
	if( luaTradeMarket.CurrTab == nIndex )	then
		return;
	end
	
	luaTradeMarket.CurrTab		= nIndex;
	
	if( luaTradeMarket.TABCTRL.SEARCH_ITEM == nIndex )				then
			
		luaSearchMarket:InitSearchMarketControl();
		
	elseif( luaTradeMarket.TABCTRL.MY_MARKET == nIndex )			then
		
		luaMyMarket:InitMyMarketControl();
	
	end

	luaTradeMarket:TradeMarketBlackScreen( true );
	
end

-- CalcItemExpiry
function luaTradeMarket:CalcItemExpiry( nExpiry )

	if( 1 > nExpiry )		then
		-- 1분 미만
		strExpiry			= STR( "UI_TRADEMAKET_EXPIRY_LESSONEMIN" );
		
		return strExpiry, 255, 45, 45;
	end
	
	local nH		= nExpiry / 60;		-- min -> hour
	
	local nDay		= math.floor( nH / 24 );
	local nHour		= math.floor( nH % 24 );
	
	local strExpiry;
	if( nDay > 0 )			then
		
		strExpiry			= nDay .. STR( "UNIT_DAY" );
		if( nHour > 0 )	then
			strExpiry			= strExpiry .. " " .. nHour .. STR( "HOUR" );
		end
		
		return strExpiry, 230, 230, 230;
	
	elseif( nHour > 0 )		then
	
		strExpiry			= nHour .. " " .. STR( "HOUR" );
		
		return strExpiry, 230, 127, 0;
		
	else

		strExpiry			= nExpiry .. " " .. STR( "MINUTE" );
		
		return strExpiry, 255, 45, 45;
		
	end
	
	return "";
	
end

-- PageBtnClick
function luaTradeMarket:PageBtnClick( strBtn )
	
	if( "btnPrevPage" == strBtn )			then
		luaTradeMarket.nListStartIndex		= luaTradeMarket.nListStartIndex - luaTradeMarket.ItemListMax;
	elseif( "btnNextPage" == strBtn )		then
		luaTradeMarket.nListStartIndex		= luaTradeMarket.nListStartIndex + luaTradeMarket.ItemListMax;	
	elseif( "btnFirstPage" == strBtn )		then
		luaTradeMarket.nListStartIndex		= 0;
	end
	
	if( luaTradeMarket.nListStartIndex < 0 )	then
		luaTradeMarket.nListStartIndex		= 0;
	end
	
	local nIndex = tbcTradeMarketTabCtrl:GetSelIndex();	
	if( luaTradeMarket.TABCTRL.SEARCH_ITEM == nIndex )				then
		luaSearchMarket:PageBtnClick();
	elseif( luaTradeMarket.TABCTRL.MY_MARKET == nIndex )			then
		luaMyMarket:PageBtnClick();
	end
	
end

-- ShowConfirmTradeMarket
function luaTradeMarket:ShowConfirmTradeMarket( Msg )
	
	local x, y = frmConfirmTradeMarket:GetParent():GetPosition();
	local w, h = frmConfirmTradeMarket:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmConfirmTradeMarket:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);
	frmConfirmTradeMarket:DoModal();
	
	local strMsg		= "{ALIGN hor=\"left\" ver=\"bottom\"}" .. Msg;
	tvwConfirmTradeMarket:SetText( strMsg );
	
	frmConfirmTradeMarket:Show( true );
	
end

-- OnPreDrawItemPrice
function luaTradeMarket:OnPreDrawItemPrice( nItem )

	local nSubItem = EventArgs:GetItemSubItem();
	
	if( nSubItem == nItem )  then
		return true;
	end
	
	return false;
end

-- OnDrawItemBkgrndPrice
function luaTradeMarket:OnDrawItemBkgrndPrice( nItem, listctrl )

	local nIndex = EventArgs:GetItemIndex();
	local nSubItem = EventArgs:GetItemSubItem();

	if( nSubItem == nItem )  then
	
		local x, y, w, h = EventArgs:GetItemRect();
				
		local nPrice = tonumber( listctrl:GetItemText( nIndex, nSubItem ) );
		if ( ( nil == nPrice ) or ( 0 > nPrice ) )		then
			gamedraw:SetTextAlign( "center", "center");
			gamedraw:SetFont( "fntRegular" );
			gamedraw:TextEx( x, y, w, h, "-" );
			return ;
		end
		
		x = x + 4;
		y = y + 4;
		w = w - 8;
		h = h - 8;
		
		local r, g, b;
		local StartX		= x + w;
		local nSpace		= 3;
		
		local nGold		= math.floor( nPrice / 10000 );
		local nSilver	= math.floor( nPrice / 100) - ( nGold * 100 );
		local nCopper	= nPrice % 100;
		
		gamedraw:SetTextAlign( "left", "center");
		
		
		
		-- copper
		if( 0 < nCopper )			then
			
			-- Copper Color	
			r		= 200;
			g		= 120;
			b		= 60;
			gamedraw:SetColor( r, g, b );
			
			StartX			= StartX - gamedraw:GetTextWidth( "fntSmall", STR( "COPPERPOINT" ) ) - nSpace;
			gamedraw:SetFont( "fntSmall" );
			gamedraw:TextEx( StartX, y, w, h, STR( "COPPERPOINT") );
			
			StartX			= StartX - gamedraw:GetTextWidth( "fntRegular", nCopper ) - nSpace;
			gamedraw:SetFont( "fntRegular" );
			gamedraw:TextEx( StartX, y, w, h, nCopper );
			
		end
		
		-- Silver
		if( 0 < nSilver )			then
			
			-- Silver Color
			r		= 200;
			g		= 200;
			b		= 200;
			gamedraw:SetColor( r, g, b );
			
			StartX			= StartX - gamedraw:GetTextWidth( "fntSmall", STR( "SILVERPOINT" ) ) - nSpace;
			gamedraw:SetFont( "fntSmall" );
			gamedraw:TextEx( StartX, y, w, h, STR( "SILVERPOINT") );
			
			StartX			= StartX - gamedraw:GetTextWidth( "fntRegular", nSilver ) - nSpace;
			gamedraw:SetFont( "fntRegular" );
			gamedraw:TextEx( StartX, y, w, h, nSilver );
			
		end
		
		-- Gold
		if( 0< nGold )				then
			
			-- Silver Color
			r		= 230;
			g		= 180;
			b		= 20;
			gamedraw:SetColor( r, g, b );
			
			StartX			= StartX - gamedraw:GetTextWidth( "fntSmall", STR( "GOLDPOINT" ) ) - nSpace;
			gamedraw:SetFont( "fntSmall" );
			gamedraw:TextEx( StartX, y, w, h, STR( "GOLDPOINT") );
			
			StartX			= StartX - gamedraw:GetTextWidth( "fntRegular", nGold ) - nSpace;
			gamedraw:SetFont( "fntRegular" );
			gamedraw:TextEx( StartX, y, w, h, nGold );
			
		end
		
	end
		
end

-- OnValueChangedConfirmNumberEdit
function luaTradeMarket:OnValueChangedConfirmNumberEdit( Edit, Limit )

	if( nil == Edit )		then
		return;
	end
	
	local strMax	= "";
	for i=1, Limit-1	do
		strMax		= strMax .. "9";
	end
	
	local strText		= Edit:GetText();
	if ( nil == strText ) or ( "" == strText )					then
		Edit:SetText( "" );
	elseif( 0 == tonumber( Edit:GetText() ) )					then
		Edit:SetText( "" );
	elseif( tonumber( strMax ) < tonumber( Edit:GetText() ) )	then
		Edit:SetText( strMax );
	end
	
	luaMyMarket:UpdateRegisterInfo();

end

-- OnValueChangedConfirmPriceEdit
function luaTradeMarket:OnValueChangedConfirmPriceEdit( Edit, Limit )

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

-- InitPage
function luaTradeMarket:InitPage()
	
	luaTradeMarket:SetPage( 0 );
	
end

-- TradeMarketException
function luaTradeMarket:TradeMarketException( ErrorCode )
	
	luaTradeMarket:ShowConfirmTradeMarket( gamefunc:GetResultString( ErrorCode ) );
	
end

-- CloseTradeMarket
function luaTradeMarket:CloseTradeMarket()

	gamefunc:CloseTradeMarket();
	luaTradeMarket:InitTradeMarket();

end

-- OnTradeMarketUnRegistered
function luaTradeMarket:OnTradeMarketUnRegistered( bResult )
	
	if( luaTradeMarket.TABCTRL.MY_MARKET == luaTradeMarket.CurrTab )		then
		
		luaMyMarket:OnTradeMarketUnRegistered( bResult );
	
	end
	
end

-- GetExpiryColor
function luaTradeMarket:GetExpiryColor()
	
	local a, b, c =0;
	
	return a, b, c;
	
end

-- OnTimerSearchMarket
function luaTradeMarket:TradeMarketBlackScreen( bShow )
	
	if( true == bShow )		then
		pntTradeMarketBlackScreen:SetOpacity( 0.0 );
		pntTradeMarketBlackScreen:DoModal();
pntTradeMarketBlackScreen:SetTimer( gamefunc:GetTMDefaultInterval(), 0);
	else
		pntTradeMarketBlackScreen:KillTimer();	
	end

	pntTradeMarketBlackScreen:Show( bShow );

end

-- OnTimerSearchMarket
function luaTradeMarket:OnTimerSearchMarket()

	luaTradeMarket:TradeMarketBlackScreen( false );
	
end