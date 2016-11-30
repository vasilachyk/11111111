--[[
	Game Enchant LUA script
--]]


-- Global instance
luaElementEnchant									= {};
luaElementEnchant.SLOTIMAGE							= { NONE_ITEM = "bmpEnchantItemSlotOff", SET_ITEM  = "bmpEnchantItemSlotOn", NONE_AGENTITEM = "bmpEnchantAgentSlotOff", SET_AGENTITEM = "bmpEnchantAgentSlotOn" };
luaElementEnchant.ENCHANT_STATE						= { ENCHANT_NONE = 0, ENCHANT_OPEN = 1, ENCHANT_NOAGENT = 2, ENCHANT_NOTENOUGHMONEY = 3, ENCHANT_READY = 4, ENCHANT_READYPLUS = 5, ENCHANT_DOING = 6, ENCHANT_RESULT = 7, ENCHANT_NO_ELEMENT_GEM = 8 };
luaElementEnchant.ENCHANT_RESULT					= { RESULT_NONE = 0, RESULT_SUCC = 1, RESULT_SKIP = 2, RESULT_DOWN = 3, RESULT_BROKEN = 4 };

luaElementEnchant.EnchantState						= luaElementEnchant.ENCHANT_STATE.ENCHANT_NONE;
luaElementEnchant.EnchantState_Msg					= luaElementEnchant.ENCHANT_STATE.ENCHANT_NONE;
luaElementEnchant.EnchantResult						= luaElementEnchant.ENCHANT_RESULT.RESULT_NONE;
luaElementEnchant.TargetItemID						= -1;
luaElementEnchant.TargetItemInvenSlotIndex			= -1;
luaElementEnchant.TargetGrade						= 0;
luaElementEnchant.ElementGemItemID					= -1;
luaElementEnchant.ElementGemItemInvenSlotIndex		= -1;
luaElementEnchant.ElementGemElementType				= 0;
luaElementEnchant.ResultItemID						= -1;
luaElementEnchant.ResultItemInvenSlotIndex			= -1;
luaElementEnchant.ResultGrade						= 0;
luaElementEnchant.ResultElement						= 0;
luaElementEnchant.EnchantCost						= -1;

luaElementEnchant.DropSender						= "";
luaElementEnchant.fProgressBarTimer					= nil;


-- OnShowEnchantFrame
function luaElementEnchant:OnShowEnchantFrame()

	if( true == frmElementEnchant:GetShow() )	then
		
		luaElementEnchant:InitEnchant();
		
	else
		
		luaElementEnchant:FinishEnchant();
		gamefunc:RequestNpcInteractionEnd();
		
	end

end

-- OnOpenEnchantFrame
function luaElementEnchant:OnOpenEnchantFrame()

	-- gamedebug:Log( "luaElementEnchant:OnOpenEnchantFrame() call" );
	
	if( true == frmElementEnchant:GetShow() )	then
		return ;
	end
	
	-- Inven Open
	if( false == frmInventory:GetShow() )	then

		frmInventory:Show( true );
	
	end
	
	-- Show frame
	local x, y = frmInventory:GetPosition();
	local w, h = frmElementEnchant:GetSize();
	frmElementEnchant:SetPosition( ( x - w ) -10, y );	
	frmElementEnchant:Show( true );
	
end

-- OnCloseEnchantFrame
function luaElementEnchant:OnCloseEnchantFrame()

	if( false == frmElementEnchant:GetShow() )	then
		return ;
	end
	
	frmCautionMsgBox:Show( false );
	frmInventory:Show( false );
	frmElementEnchant:Show( false );

end

-- EnchantError
function luaElementEnchant:EnchantError( nError )
	
	-- gamedebug:Log( "luaElementEnchant:EnchantError() " .. nError );
	
	luaElementEnchant:EnchantErrorMsg( nError );
	luaElementEnchant:OnCloseEnchantFrame();
	
end	

-- OnUpdateFrame
function luaElementEnchant:OnUpdateFrame()

	if( false == frmInventory:GetShow() )	then

		luaElementEnchant:OnCloseEnchantFrame();

	end
	
	-- 메세지 업데이트
	luaElementEnchant:UpdateMessage();

end

-- FinishEnchant
function luaElementEnchant:FinishEnchant()
	
	luaElementEnchant:CloseEnchantProgressBar();
	luaElementEnchant:InitEnchantData();
	
end

-- InitEnchant
function luaElementEnchant:InitEnchant()
	
	luaElementEnchant:InitEnchantData();
	luaElementEnchant:InitEnchantUI();
		
end

-- InitEnchantData
function luaElementEnchant:InitEnchantData()

	luaElementEnchant.EnchantState	= luaElementEnchant.ENCHANT_STATE.ENCHANT_OPEN;
	luaElementEnchant.EnchantResult	= luaElementEnchant.ENCHANT_RESULT.RESULT_NONE;
	
	luaElementEnchant.TargetItemID					= -1;
	luaElementEnchant.TargetItemInvenSlotIndex		= -1;
--	luaElementEnchant.TargetGrade					= 0;
	luaElementEnchant.ElementGemItemID				= -1;
	luaElementEnchant.ElementGemItemInvenSlotIndex	= -1;
	luaElementEnchant.ResultItemID					= -1;
	luaElementEnchant.ResultItemInvenSlotIndex		= -1;
	luaElementEnchant.ResultGrade					= 0;
	luaElementEnchant.ResultElement					= 0;
	luaElementEnchant.EnchantCost					= -1;
	luaElementEnchant.DropSender					= "";
	
end

-- InitEnchantUI
function luaElementEnchant:InitEnchantUI()
	
	-- 아이템( 타겟, 결과 ) 초기화
	luaElementEnchant:SetTargetItem( -1 );
	luaElementEnchant:SetResultItem( -1 );
		
	-- 원소석 초기화
	luaElementEnchant:SetElementGemItem( -1 );
	
	-- 금액
	luaElementEnchant:SetEnchantMoney( 0 );
	
	-- Confirm Btn Hidden
	btnConfirmElementEnchant:Show( false );
	btnRedoElementEnchant:Show( false );
	btnRedoElementEnchant:SetUserData( -1 );
	
	-- DoEnchant, Cancel Btn Show
	btnDoElementEnchant:Show( true );
	btnCancelElementEnchant:Show( true );
	
	-- Enchant Btn Enable
	btnDoElementEnchant:Enable( false );
	
	-- Enchant Progress
	luaElementEnchant:CloseEnchantProgressBar();
	
end

-- SetEnchantMoney
function luaElementEnchant:SetEnchantMoney( nMoney, color )

	local strMoney = "{FONT name=\"fntBold\"}{COLUMN h=22}{ALIGN hor=\"right\" ver=\"bottom\"}" .. luaGame:ConvertMoneyToStr( nMoney, "fntSmall", color ) .. "{SPACE w=10}";
	tvwElementEnchantPrice:SetText( strMoney );
	
end

-- ClearEnchantMessage
function luaElementEnchant:ClearEnchantMessage()
	luaElementEnchant:SetEnchantMessage1( "" );
	luaElementEnchant:SetEnchantMessage2( "" );
end

-- SetEnchantMessage1
function luaElementEnchant:SetEnchantMessage1( strMsg )
	
	if( ( "" == strMsg ) or ( nil == strMsg ) )	then
		tvwElementEnchantMessage1:SetText( "" );
		return ;
	end
	
	local strText	= "{FONT name=\"fntScript\"}{BITMAP name=\"iconDefInformation\" w=16 h=16}" .. "  ";	
	
	strText	= strText .. strMsg;
	tvwElementEnchantMessage1:SetText( strText );
	
end

-- SetEnchantMessage2
function luaElementEnchant:SetEnchantMessage2( strMsg )
	
	if( ( "" == strMsg ) or ( nil == strMsg ) )	then
		tvwElementEnchantMessage2:SetText( "" );
		return ;
	end
	
	local strText	= "{FONT name=\"fntScript\"}{BITMAP name=\"iconDefInformation\" w=16 h=16}" .. "  ";	
	
	strText	= strText .. strMsg;
	tvwElementEnchantMessage2:SetText( strText );
	
end

-- SetTargetItem
function luaElementEnchant:SetTargetItem( nItemID, nInvenSlotIndex )
	
	local strBaseImage		= luaElementEnchant.SLOTIMAGE.NONE_ITEM;
	local strItemImage		= "";
	local strItemName		= "{FONT name=\"fntScript\"}{ALIGN hor=\"center\" ver=\"center\"}"
								.. STR( "UI_ENCHANT_TARGETITEM" );
		
	luaElementEnchant.TargetItemID				= -1;
	luaElementEnchant.TargetItemInvenSlotIndex	= -1;
--	luaElementEnchant.TargetGrade				= 0;
	
	if( nItemID > 0 )		then

		luaElementEnchant.TargetItemID				= nItemID;
		luaElementEnchant.TargetItemInvenSlotIndex	= nInvenSlotIndex;
		luaElementEnchant.TargetGrade				= gamefunc:GetInvenItemEnchantGrade( luaElementEnchant.TargetItemInvenSlotIndex );
		
		local nCurrElementType, nCurrElementGrade = gamefunc:GetInvenItemElementEnchantData( luaElementEnchant.TargetItemInvenSlotIndex );
	
		-- 배경 변경	
		strBaseImage		= luaElementEnchant.SLOTIMAGE.SET_ITEM;
		
		-- Item 이미지
		strItemImage = gamefunc:GetItemImage( luaElementEnchant.TargetItemID );
		if ( nil == strItemImage )  or  ( "" == strItemImage )	then
			strItemImage = "iconUnknown"
		end
		
		local r, g, b	= GetItemColor( luaElementEnchant.TargetItemID );
		strItemName		= "{FONT name=\"fntScript\"}{ALIGN hor=\"center\" ver=\"center\"}{COLOR r=" .. r .. " g=" .. g .. " b=" .. b .. "}"
						.. gamefunc:GetInvenItemName( luaElementEnchant.TargetItemInvenSlotIndex );
						
		-- gamedebug:Log("luaElementEnchant:SetTargetItem - " .. nCurrElementType .. "/" .. nCurrElementGrade);
		
		if( nCurrElementType ~= 0 and nCurrElementGrade > 0 ) then
			local strElementEnchant		= FORMAT( "UI_ENCHANT_ELEMENT_ENCHANT_NOTICE", luaElementEnchant:GetStrElementType( nCurrElementType ) );
	 		strItemName = strItemName .. "{CR}" .. strElementEnchant .. " +" ..nCurrElementGrade ;
		end
	
	end
	
	-- gamedebug:Log("luaElementEnchant:SetTargetItem - " .. luaElementEnchant.TargetGrade);
	picElementEnchantTargetSlot:SetImage( strBaseImage );
	picElementEnchantTargetItem:SetImage( strItemImage );
	tvwElementEnchantTargetItemNameText:SetText( strItemName );
	tvwElementEnchantTargetDropArea:SetToolTip( "" );
	
end

-- SetElementGemItem
function luaElementEnchant:SetElementGemItem( nItemID, nInvenSlotIndex )

	local strBaseImage		= luaElementEnchant.SLOTIMAGE.NONE_AGENTITEM;
	local strItemImage		= "";
	local strItemName		= "{FONT name=\"fntScript\"}{ALIGN hor=\"center\" ver=\"center\"}"
								.. STR( "UI_ELEMENT_ENCHANT_GEM" );
	
	luaElementEnchant.ElementGemItemID				= -1;
	luaElementEnchant.ElementGemItemInvenSlotIndex	= -1;
	
	if( nItemID > 0 )		then
		
		luaElementEnchant.ElementGemItemID				= nItemID;
		luaElementEnchant.ElementGemItemInvenSlotIndex	= nInvenSlotIndex;
		luaElementEnchant.ElementGemElementType			= gamefunc:GetElementGemToElementType( nItemID );

		-- 배경 변경	
		strBaseImage		= luaElementEnchant.SLOTIMAGE.SET_AGENTITEM;
		
		-- Item 이미지
		strItemImage = gamefunc:GetItemImage( luaElementEnchant.ElementGemItemID );
		if ( nil == strItemImage )  or  ( "" == strItemImage )	then
			strItemImage = "iconUnknown"
		end
		
		local r, g, b	= GetItemColor( luaElementEnchant.ElementGemItemID );
		strItemName		= "{FONT name=\"fntScript\"}{ALIGN hor=\"center\" ver=\"center\"}{COLOR r=" .. r .. " g=" .. g .. " b=" .. b .. "}"
						.. gamefunc:GetInvenItemName( luaElementEnchant.ElementGemItemInvenSlotIndex );
	
	end
	
	picElementEnchantGemSlot:SetImage( strBaseImage );
	picElementEnchantGemItemImage:SetImage( strItemImage );
	tvwElementEnchantGemItemNameText:SetText( strItemName );
	tvwElementEnchantGemItemDropArea:SetToolTip( "" );
	
	-- 예상금액 요청
	gamefunc:GetElementEnchantCost( luaElementEnchant.TargetItemInvenSlotIndex, luaElementEnchant.ElementGemItemInvenSlotIndex );
	
end

-- SetResultItem
function luaElementEnchant:SetResultItem( nItemID, nElementType, nEnchantGrade, nInvenIndex )
	
	local strBaseImage		= luaElementEnchant.SLOTIMAGE.NONE_ITEM;
	local strItemImage		= "";
	local strItemName		= "{FONT name=\"fntScript\"}{ALIGN hor=\"center\" ver=\"center\"}"
								.. STR( "UI_ENCHANT_RESULTITEM" );
	picElementEnchantResultItem:SetColorize( 255, 255, 255 );
	
	if( nItemID > 0 )		then

		-- gamedebug:Log("luaElementEnchant:SetResultItem() - ItemID : " .. nItemID .. " / Element : " .. nElementType .. " / Grade : " .. nEnchantGrade .. " / nInvenIndex : " .. nInvenIndex );
		
		luaElementEnchant.ResultItemID						= nItemID;
		luaElementEnchant.ResultItemInvenSlotIndex			= nInvenIndex;
		luaElementEnchant.ResultGrade						= nEnchantGrade;
		luaElementEnchant.ResultElement						= nElementType;
	
		-- 배경 변경	
		strBaseImage		= luaElementEnchant.SLOTIMAGE.SET_ITEM;
		
		-- Item 이미지
		strItemImage = gamefunc:GetItemImage( nItemID );
		if ( nil == strItemImage )  or  ( "" == strItemImage )	then
			strItemImage = "iconUnknown"
		end
		
		local r, g, b	= GetItemColor( nItemID );
		strItemName		= "{FONT name=\"fntScript\"}{ALIGN hor=\"center\" ver=\"center\"}{COLOR r=" .. r .. " g=" .. g .. " b=" .. b .. "}"
						.. gamefunc:GetItemName( nItemID, luaElementEnchant.TargetGrade );
	
		if( nElementType ~= 0 and nEnchantGrade > 0 ) then
			local strElementEnchant		= FORMAT( "UI_ENCHANT_ELEMENT_ENCHANT_NOTICE", luaElementEnchant:GetStrElementType( nElementType ) );
	 		strItemName = strItemName .. "{CR}" .. strElementEnchant .. " +" ..nEnchantGrade ;
		end
		
	else
		
		luaElementEnchant.ResultItemID						= -1;
		luaElementEnchant.ResultItemInvenSlotIndex			= -1;
		luaElementEnchant.ResultGrade						= 0;
		luaElementEnchant.ResultElement						= 0;
	
	end
	
	picElementEnchantResultSlot:SetImage( strBaseImage );
	picElementEnchantResultItem:SetImage( strItemImage );
	tvwElementEnchantResultItemNameText:SetText( strItemName );
	
	-- 부서진 아이템일 경우 세팅
	if( ( nItemID > 0 )	and ( luaElementEnchant.EnchantResult == luaElementEnchant.ENCHANT_RESULT.RESULT_BROKEN ) )		then
		
		picElementEnchantResultItem:SetColorize( 255, 128, 128 );
		
	end
	
end

-- GetCurrItemIDandSlotIndex
function luaElementEnchant:GetCurrItemIDandSlotIndex( _wnd )
	
	if( _wnd == tvwElementEnchantTargetDropArea )						then
		return  luaElementEnchant.TargetItemID, luaElementEnchant.TargetItemInvenSlotIndex;
		
	elseif( _wnd == tvwElementEnchantGemItemDropArea )		then
		return luaElementEnchant.ElementGemItemID, luaElementEnchant.ElementGemItemInvenSlotIndex;
		
	elseif( _wnd == tvwElementEnchantResultDropArea )		then
		return luaElementEnchant.ResultItemID, luaElementEnchant.ResultGrade, luaElementEnchant.ResultElement;
		
	end	
	
	return -1, -1;
	
end
	
-- IsValidItemIDandSlotIndex
function luaElementEnchant:IsValidItemIDandSlotIndex( nItemID, nSlotIndex )
	
	if( 0 > nItemID )			then
		return false;
	elseif( nil == nSlotIndex )	then
		return true;
	elseif( 0 > nSlotIndex )	then
		return false;
	end

	return true;
	
end

-- OnDragBeginEnchantItem
function luaElementEnchant:OnDragBeginEnchantItem()
	
	local _wnd				= _G[ EventArgs:GetOwner():GetName() ];
	local nItemID			= -1;
	local nSlotIndex		= -1;
	
	if( _wnd == tvwElementEnchantResultDropArea )		then
		-- 결과아이템 드레그 안됨
		return false;
	end	
	
	nItemID, nSlotIndex		= luaElementEnchant:GetCurrItemIDandSlotIndex( _wnd );
	if( false == luaElementEnchant:IsValidItemIDandSlotIndex( nItemID, nSlotIndex ) )	then
		return false;
	end
	
	DragEventArgs:AddDragData( gamefunc:GetInvenItemName( nSlotIndex ), gamefunc:GetItemImage( nItemID ), nSlotIndex );
	DragEventArgs:SetFont( "fntRegular");
	DragEventArgs:SetImageSize( 40, 40);
	
	return true;
	
end

-- OnDragEndEnchantItem
function luaElementEnchant:OnDragEndEnchantItem()

	if( ( luaElementEnchant.DropSender == lcInventory ) or ( luaElementEnchant.DropSender == "" ) )	then
		local _wnd				= _G[ EventArgs:GetOwner():GetName() ];
		luaElementEnchant:ClearEnchantItem( _wnd );
	end
		
	luaElementEnchant.DropSender	= "";
	
	return true;
	
end

-- ClearEnchantItem
function luaElementEnchant:ClearEnchantItem( _wnd )

	local nSoundID = -1;

	-- 이벤트 메세지에 따라 초기화 변경
	if( _wnd == tvwElementEnchantTargetDropArea )					then
		nSoundID = luaElementEnchant.TargetItemID;

		-- 타겟 아이템을 뺄 경우 그냥 모두 초기화
		luaElementEnchant:InitEnchant();	

	elseif( _wnd == tvwElementEnchantGemItemDropArea )	then
		nSoundID = luaElementEnchant.ElementGemItemID;

		-- 원소석과 결과 아이템 초기화
		luaElementEnchant:SetElementGemItem( -1 );
		luaElementEnchant:SetResultItem( -1 )

	end	

	local strSound = gamefunc:GetItemPutDownSound( nSoundID );
	gamefunc:PlaySound( strSound);
	
	luaElementEnchant:UpdateEnchant();
	
end

-- OnDblClickEnchantItem
function luaElementEnchant:OnDblClickEnchantItem()
	
	local _wnd				= _G[ EventArgs:GetOwner():GetName() ];
	
	luaElementEnchant:ClearEnchantItem( _wnd );
	
end

function luaElementEnchant:OnRClickEnchantItem()
	
	luaElementEnchant:OnDblClickEnchantItem();
	
end


-- ToolTipEnchantItem
function luaElementEnchant:ToolTipEnchantItem()

	local _wnd				= _G[ EventArgs:GetOwner():GetName() ];
	
	_wnd:SetToolTip( "" );
	
	-- gamedebug:Log(" luaElementEnchant:ToolTipEnchantItem() - 1 ");
	
	-- 툴팁 아이템에 따라 ID, Index 변경
	local nItemID			= -1;
	local nSlotIndex		= -1;
	nItemID, nSlotIndex		= luaElementEnchant:GetCurrItemIDandSlotIndex( _wnd );
	
	-- gamedebug:Log(" luaElementEnchant:ToolTipEnchantItem() - nItemID : ".. nItemID .. " / nSlotIndex : " .. nSlotIndex);
	
	if( false == luaElementEnchant:IsValidItemIDandSlotIndex( nItemID, nSlotIndex ) )	then
		return false;
	end
	
	-- gamedebug:Log(" luaElementEnchant:ToolTipEnchantItem() - 2 ");
	
	local strToolTip = "";
	
	strToolTip = luaToolTip:GetItemToolTip( nItemID, nSlotIndex, nil );
	if( _wnd == tvwElementEnchantResultDropArea )		then
		-- nSlotIndex에 EnchantGrade를 반환해줌
		-- 원래 아이템 가지고 출력해줘야함
		--luaElementEnchant.TargetItemID, luaElementEnchant.TargetItemInvenSlotIndex;
		
		if( luaElementEnchant.EnchantResult == luaElementEnchant.ENCHANT_RESULT.RESULT_BROKEN )	then
			-- 부서진 아이템일 경우에는 아이템이 없어지므로 툴팁을 출력하지 않는다
			return true;
		end
		
		-- gamedebug:Log(" luaElementEnchant:ToolTipEnchantItem() - 3 ");
		
		if( luaElementEnchant.ENCHANT_STATE.ENCHANT_RESULT == luaElementEnchant.EnchantState )	then
			-- 결과는 인벤 아이템 그대로 출력
			strToolTip = luaToolTip:GetItemToolTip( luaElementEnchant.ResultItemID, luaElementEnchant.ResultItemInvenSlotIndex, nil );
		else
			-- 결과 상태가 아니면 예상(+1)로 변환 해서 출력
			local nCurrElementType, nCurrElementGrade = gamefunc:GetInvenItemElementEnchantData( luaElementEnchant.ResultItemInvenSlotIndex );
			-- gamedebug:Log("luaElementEnchant:ToolTipEnchantItem() - CurrElement : " .. nCurrElementType .. " / CurrGrade : " .. nCurrElementGrade);
			-- gamedebug:Log("luaElementEnchant:ToolTipEnchantItem() - ResultElement : " .. luaElementEnchant.ResultElement .. " / ResultGrade : " .. luaElementEnchant.ResultGrade);
			
			gamefunc:ChangeElementGradeToInvenItem( luaElementEnchant.ResultItemInvenSlotIndex, luaElementEnchant.ResultElement, luaElementEnchant.ResultGrade );
			strToolTip = luaToolTip:GetItemToolTip( luaElementEnchant.ResultItemID, luaElementEnchant.ResultItemInvenSlotIndex, nil );
			gamefunc:ChangeElementGradeToInvenItem( luaElementEnchant.ResultItemInvenSlotIndex, nCurrElementType, nCurrElementGrade );
		
		end
		
	end	
	
	-- gamedebug:Log(" luaElementEnchant:ToolTipEnchantItem() - 4 ");
		
	local nSlotType = gamefunc:GetItemSlot( nItemID );
	if ( nSlotType ~= ITEM_SLOT.NONE)  and  ( gamefunc:GetEquippedItemID( nSlotType) > 0)  then
		strToolTip = strToolTip .. "{divide}" ..
					 ToolTipDivideColor() .. "< " .. STR( "UI_EQUIPPEDITEM") .. " >{/COLOR}\n" .. luaToolTip:OnToolTipEquipItem( nItemID );
	end
	
	-- gamedebug:Log(" luaElementEnchant:ToolTipEnchantItem() - 5 ");
	
	_wnd:SetToolTip( strToolTip );
	
end


-- OnDropEnchantItem
function luaElementEnchant:OnDropEnchantItem()

	-- gamedebug:Log(" luaElementEnchant:OnDropEnchantItem() - 1 ");
	local _wnd						= _G[ EventArgs:GetOwner():GetName() ];
	luaElementEnchant.DropSender	= _G[ DragEventArgs:GetSender():GetName() ];
	
	if( luaElementEnchant.DropSender ~= lcInventory and luaElementEnchant.DropSender ~= lcExInventory) then
		-- 인벤이 아니면 등록 불가
		return ;
	end

	-- gamedebug:Log(" luaElementEnchant:OnDropEnchantItem() - 2 ");
	if	(luaElementEnchant.DropSender == lcExInventory and gamefunc:IsExInventory() == false)	then
		return;
	end

	local nIndex	= DragEventArgs:GetItemData( 0 );
	local nID		= gamefunc:GetInvenItemID( nIndex );
	
	-- gamedebug:Log(" luaElementEnchant:OnDropEnchantItem() - 3 ");
	if( false == luaElementEnchant:IsValidItemIDandSlotIndex( nID, nIndex ) )	then
		return ;
	end

	-- 결과창중이라면 초기화 한번 해줌
	if( luaElementEnchant.ENCHANT_STATE.ENCHANT_RESULT == luaElementEnchant.EnchantState )	then
		luaElementEnchant:InitEnchant();
	end
	
	-- 아이템 그랍 처리
	if( _wnd == tvwElementEnchantTargetDropArea )						then
	
		luaElementEnchant:RegisteredEnchantItem( nID, nIndex );

	elseif( _wnd == tvwElementEnchantGemItemDropArea )		then
		
		luaElementEnchant:RegisteredElementGemItem( nID, nIndex );

	end	
	
	luaElementEnchant:UpdateEnchant();
	
end

-- RegisteredEnchantItem( 강화아이템 등록 )
function luaElementEnchant:RegisteredEnchantItem( nItemID, nInvenSlotIndex )

	-- 출력된 메세지 클리어
	luaElementEnchant:ClearEnchantRegisterMsg();
	
	--UI및 Data 클리어
	luaElementEnchant:InitEnchant();

	-- 강화 가능 여부 확인
	if ( false == gamefunc:CheckItemElementEnchantableflag( nInvenSlotIndex ) )	 then
		luaElementEnchant:EnchantRegisterFailedGuideMsg();
		return ;
	end
	
	-- 아이템 등록
	luaElementEnchant:SetTargetItem( nItemID, nInvenSlotIndex );
			
	-- 등록 가능한 원소석 찾아서 자동 등록
	luaElementEnchant:AutoRegisteredElementGemItem( nInvenSlotIndex );
	
	luaElementEnchant:UpdateEnchant();
	
end

-- AutoRegisteredElementGemItem( 자동 원소석 등록 )
function luaElementEnchant:AutoRegisteredElementGemItem( nInvenSlotIndex )
	
	local nMaxElementEnchantGrade = gamefunc:GetMaxElementEnchantGrade();
	local nTargetItemElementType, nTargetItemElementGrade = gamefunc:GetInvenItemElementEnchantData( luaElementEnchant.TargetItemInvenSlotIndex );
	
	local nGemItemSoltID, nGemItemID = gamefunc:GetAutoRegisteredElementGemItem( nInvenSlotIndex );
	
	if( 0 > nGemItemID or nMaxElementEnchantGrade <= nTargetItemElementGrade  )	then
		return ;
		
	end
	
	luaElementEnchant:RegisteredElementGemItem( nGemItemID, nGemItemSoltID );
	
		
end
-- CheckAgentPos( 강화+보조제 위치 확인 )
function luaElementEnchant:CheckAgentPos( Type, ItemType )
	
	if( Type == ItemType )	then
		return true;
	end
		
	-- gamedebug:Log( "luaElementEnchant:CheckAgentPos() " .. Type .. " / " .. ItemType  );
		
	luaElementEnchant:EnchantAgentPositionErrorGuideMsg();
	
	return false;
	
end

-- RegisteredElementGemItem( 원소석 등록 )
function luaElementEnchant:RegisteredElementGemItem( nItemID, nInvenSlotIndex )

	if	(nInvenSlotIndex >= 80 and gamefunc:IsExInventory() == false)	then
		return;
	end

	-- 출력된 메세지 클리어
	luaElementEnchant:ClearEnchantRegisterMsg();
	
	-- 강화아이템 등록 여부 확인
	if( 0 > luaElementEnchant.TargetItemID )	then
		luaElementEnchant:EnchantFirstTargetItemGuideMsg();
		return ;
	end
	
	local nMaxElementEnchantGrade = gamefunc:GetMaxElementEnchantGrade();
	local nTargetItemElementType, nTargetItemElementGrade = gamefunc:GetInvenItemElementEnchantData( luaElementEnchant.TargetItemInvenSlotIndex );
	if ( nMaxElementEnchantGrade <= nTargetItemElementGrade )	 then
	
		local nElementGemElementType = gamefunc:GetElementGemToElementType( nItemID );
		if( nElementGemElementType == nTargetItemElementType )	then
			luaElementEnchant:ElementgemRegisterFailedGuideMsg();
			return;
		end
		
	end

	-- 원소석 맞는지 확인
	if( false == luaElementEnchant:CheckAgentPos( ENCHANT_CATEGORY.EC_ELEMENT_GEM, gamefunc:GetInvenItemEnchantCategory( nInvenSlotIndex ) ) )		then
		return;
	end
	
	

	-- 아이템 등록
	luaElementEnchant:SetElementGemItem( nItemID, nInvenSlotIndex );
		
	luaElementEnchant:UpdateEnchant();
	
end


-- IsSelectedEnchantItem( 인첸창에 등록된 아이템인가 )
function luaElementEnchant:IsSelectedEnchantItem( nInvenSlotIndex )

	if( nInvenSlotIndex == luaElementEnchant.TargetItemInvenSlotIndex )			then
		return true;
	elseif( nInvenSlotIndex == luaElementEnchant.ElementGemItemInvenSlotIndex )	then
		return true;
	end

end

-- OnClickEnchant
function luaElementEnchant:OnClickEnchant()
	-- 강화 가능 검사
	-- Target 아이템에 속성 인첸트 값이 있는데, 인첸트 할려고 하는 속성이랑 똑같지 않으면 주의 메시지 표시
	local nTargetItemElementType, nTargetItemElementGrade = gamefunc:GetInvenItemElementEnchantData( luaElementEnchant.TargetItemInvenSlotIndex );
	if( nTargetItemElementType ~= 0 and nTargetItemElementType ~= luaElementEnchant.ElementGemElementType ) then
		luaElementEnchant:ShowCautionMsgBox();
		return ;
	end
	
	-- 강화 시작
	luaElementEnchant:DoEnchant();
	
end

-- DoEnchant
function luaElementEnchant:DoEnchant()

	luaElementEnchant.EnchantState		= luaElementEnchant.ENCHANT_STATE.ENCHANT_DOING;
	
	-- ProgressBar 열기
	luaElementEnchant:OpenEnchantProgressBar();
	
end

-- OpenEnchantProgressBar
function luaElementEnchant:OpenEnchantProgressBar()
	
	pcElementEnchantProgress:SetPos( 0 );
	luaElementEnchant.fProgressBarTimer	= gamefunc:GetUpdateTime();
	
	-- Reposition frame
	local x, y = frmElementEnchantProgress:GetParent():GetPosition();
	local w, h = frmElementEnchantProgress:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmElementEnchantProgress:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);
	frmElementEnchantProgress:DoModal();
	
end

-- CloseEnchantProgressBar
function luaElementEnchant:CloseEnchantProgressBar()
	
	luaElementEnchant.fProgressBarTimer = nil;
	frmElementEnchantProgress:Show( false );
	
end

-- OnUpdateEnchantProgressBar
function luaElementEnchant:OnUpdateEnchantProgressBar()

	if ( luaElementEnchant.fProgressBarTimer == nil)  then  return;
	end
	
	
	local fElapsed = gamefunc:GetUpdateTime() - luaElementEnchant.fProgressBarTimer + 100;
	local nPos = fElapsed / 30.0;
	pcElementEnchantProgress:SetPos( nPos );
	
	
	if ( nPos >= 100)  then
		luaElementEnchant:FinishEnchantProgress();
	end
	
end

-- FinishEnchantProgress
function luaElementEnchant:FinishEnchantProgress()

	-- 인첸트 요청
	gamefunc:ElementEnchantStart( luaElementEnchant.TargetItemInvenSlotIndex, luaElementEnchant.ElementGemItemInvenSlotIndex );
	
	luaElementEnchant.fProgressBarTimer		= nil;
	--luaElementEnchant:CloseEnchantProgressBar();

end

-- EnchantCostRES( 강화 예상 금액 )
function luaElementEnchant:EnchantCostRES( nCost )
	
	-- gamedebug:Log("luaElementEnchant:EnchantCostRES : Cost = " .. nCost);
	luaElementEnchant.EnchantCost		= nCost;
	luaElementEnchant:UpdateEnchant();
	
end

-- SetEnchantResultState( 강화 결과 표시 )
function luaElementEnchant:SetEnchantResultState( state )

	local nResultItemID			= luaElementEnchant.TargetItemID;
	local nResultInvenIndex		= luaElementEnchant.TargetItemInvenSlotIndex;
	local nResultItemGrade		= luaElementEnchant.TargetGrade;
	local nResultElementType	= luaElementEnchant.ResultElement;
	local nRedoSlotIndex		= -1;
	
	-- 결과에 따른 inven 아이템 등급 변화처리
	
	if( state == luaElementEnchant.ENCHANT_RESULT.RESULT_SUCC )		then
		gamefunc:ElementEnchantSucc( luaElementEnchant.TargetItemInvenSlotIndex, luaElementEnchant.ResultElement, luaElementEnchant.ResultGrade	);
--	elseif( state == luaElementEnchant.ENCHANT_RESULT.RESULT_DOWN )	then
--		gamefunc:ElementEnchantDown( luaElementEnchant.TargetItemInvenSlotIndex );
	end
	
	if( state ~= luaElementEnchant.ENCHANT_RESULT.RESULT_BROKEN )	then
		nResultElementType, nResultItemGrade = gamefunc:GetInvenItemElementEnchantData( luaElementEnchant.TargetItemInvenSlotIndex );
		
		-- gamedebug:Log("luaElementEnchant:SetEnchantResultState() - Type : " .. nResultElementType .. ", Grade : " .. nResultItemGrade);
		
		-- 한번 더 하기가 가능한 아이템인지 검사
		-- 강화 가능 여부 확인
		if ( true == gamefunc:IsInvenItemElementEnchantAble( luaElementEnchant.TargetItemInvenSlotIndex ) )	 then
			nRedoSlotIndex		= luaElementEnchant.TargetItemInvenSlotIndex;
		end
	end
	
	luaElementEnchant:CloseEnchantProgressBar();
	
	-- 인첸트 창 초기화
	luaElementEnchant:InitEnchant();
	luaElementEnchant:UpdateArrow();
	
	-- 버튼 변경
	-- Confirm Btn Hidden
	btnConfirmElementEnchant:Show( true );
	btnRedoElementEnchant:Show( true );
	if( 0 <= nRedoSlotIndex )		then
		btnRedoElementEnchant:SetUserData( nRedoSlotIndex );
		btnRedoElementEnchant:Enable( true );
	else
		btnRedoElementEnchant:SetUserData( -1 );
		btnRedoElementEnchant:Enable( false );
	end
	
	
	-- DoEnchant, Cancel Btn Show
	btnDoElementEnchant:Show( false );
	btnCancelElementEnchant:Show( false );
	
	luaElementEnchant.EnchantState		= luaElementEnchant.ENCHANT_STATE.ENCHANT_RESULT;
	luaElementEnchant.EnchantResult	= state;
	
	luaElementEnchant:RegisteredResultItem( nResultItemID, nResultElementType, nResultItemGrade, nResultInvenIndex );
	
end

-- OnShowEnchantProgress
function luaElementEnchant:OnShowEnchantProgress()

	if ( frmElementEnchantProgress:GetShow() == true)  then
		
		--gamefunc:PlaySound( "progress_up", "progress_up" );
	
	else
		
		gamefunc:StopSound( "progress_up" );
		
		-- 중간에 취소
		if ( luaElementEnchant.fProgressBarTimer ~= nil)  then
			
		end
	end
end

-- UpdateEnchant( 인첸트 상황 변경 )
function luaElementEnchant:UpdateEnchant()
	
	-- 인첸트 상태 검사
	luaElementEnchant:UpdateEnchantState();
	-- 화살표 
	luaElementEnchant:UpdateArrow();
	
end

-- UpdateEnchantState( 강화 상태 검사 )
function luaElementEnchant:UpdateEnchantState()
	
	-- gamedebug:Log("luaElementEnchant:UpdateEnchantState() -- 1");
	btnRedoElementEnchant:Show( false );
	btnDoElementEnchant:Show( true );
	btnDoElementEnchant:Enable( false );
	
	if( 0 > luaElementEnchant.TargetItemID )		then
		luaElementEnchant.EnchantState						= luaElementEnchant.ENCHANT_STATE.ENCHANT_OPEN;
		return ;
	end
		
	if( 0 > luaElementEnchant.ElementGemItemID )		then
		luaElementEnchant.EnchantState						= luaElementEnchant.ENCHANT_STATE.ENCHANT_NO_ELEMENT_GEM;
		return ;
	end
		
	-- gamedebug:Log("luaElementEnchant:UpdateEnchantState() -- 2");
	
	-- gamedebug:Log("luaElementEnchant.EnchantCost : " .. luaElementEnchant.EnchantCost);
	
	-- 인첸트가 가능은 한 상황
	if( 0 > luaElementEnchant.EnchantCost )	then
		return ;
	end
	
	local nMyMoney			= gamefunc:GetMoney();
	-- gamedebug:Log("nMyMoney : " .. luaElementEnchant.EnchantCost .. " / " .. nMyMoney);
	
	if( luaElementEnchant.EnchantCost > nMyMoney )		then
		-- 소지금 부족 인첸 불가
		luaElementEnchant.EnchantState						= luaElementEnchant.ENCHANT_STATE.ENCHANT_NOTENOUGHMONEY;
		luaElementEnchant:SetEnchantMoney( luaElementEnchant.EnchantCost, "{COLOR r=255 g=20 b=20}" );
		return ;
	end
	

	-- 결과 예상 아이템 출력
	-- 등록된 타겟 아이템의 EnchantGrade + 1
	local nItemID = luaElementEnchant.TargetItemID
	local TargetSlotIndex = luaElementEnchant.TargetItemInvenSlotIndex;
	local nElementType, nNextGrade	= gamefunc:GetInvenItemElementEnchantData( TargetSlotIndex );
	if( luaElementEnchant.ElementGemElementType == nElementType ) then
		nNextGrade = nNextGrade + 1;
	else
		nNextGrade = 1; 
		nElementType = luaElementEnchant.ElementGemElementType;
	end
	
	-- gamedebug:Log("luaElementEnchant:UpdateEnchantState() - ElementType : " .. nElementType .. " / NextGrade : " .. nNextGrade);
	
	luaElementEnchant:SetResultItem( nItemID, nElementType, nNextGrade, TargetSlotIndex );	
	
	
	-- gamedebug:Log("luaElementEnchant:UpdateEnchantState() -- 3");
	
	luaElementEnchant:SetEnchantMoney( luaElementEnchant.EnchantCost );
	
	btnDoElementEnchant:Enable( true );
	
	if( 0 < luaElementEnchant.ElementGemItemID )	then
		luaElementEnchant.EnchantState						= luaElementEnchant.ENCHANT_STATE.ENCHANT_READYPLUS;
	else
		luaElementEnchant.EnchantState						= luaElementEnchant.ENCHANT_STATE.ENCHANT_READY;
	end
	
	-- gamedebug:Log("luaElementEnchant:UpdateEnchantState() -- 4");
		
end

-- UpdateArrow( 상황에 맞는 화살표 변경 )
function luaElementEnchant:UpdateArrow()
	
	local strTargetArrowImage				= "bmpEnchantTargetArrowOff";
	local strWidthArrowImage				= "bmpEnchantWidthArrowOff";
	local strResultArrowImage				= "bmpEnchantResultArrowOff";
	
	-- 타겟아이템이 등록되있다면
	if( 0 < luaElementEnchant.TargetItemID )		then
		
		strTargetArrowImage				= "bmpEnchantTargetArrowOn";
		
		if( 0 < luaElementEnchant.ElementGemItemID )	then
			strResultArrowImage			= "bmpEnchantResultArrowOn";
		end
			
	end
	
	picElementEnchantTargetArrow:SetImage( strTargetArrowImage );
	picElementEnchantResultArrow:SetImage( strResultArrowImage );
end

-- RegisteredResultItem( 결과아이템 )
function luaElementEnchant:RegisteredResultItem( nResultItemID, nResultElementType, nResultItemGrade, nInvenSlotIndex )
	
	if( ( 0 > nResultItemID ) or ( luaElementEnchant.ENCHANT_STATE.ENCHANT_RESULT ~= luaElementEnchant.EnchantState ) )	then
		return ;
	end
	
	luaElementEnchant:SetResultItem( nResultItemID, nResultElementType, nResultItemGrade, nInvenSlotIndex );
	
end

-- UpdateMessage( 상황에 맞는 메세지 출력 )
function luaElementEnchant:UpdateMessage()

	--if( luaElementEnchant.EnchantState == luaElementEnchant.EnchantState_Msg ) then
	--	return ;
	--end
	
	luaElementEnchant.EnchantState_Msg = luaElementEnchant.EnchantState;
	
	luaElementEnchant:ClearEnchantMessage();
	
	if( luaElementEnchant.ENCHANT_STATE.ENCHANT_OPEN == luaElementEnchant.EnchantState )				then
		luaElementEnchant:EnchantOpenMsg();
	elseif( luaElementEnchant.ENCHANT_STATE.ENCHANT_NOAGENT == luaElementEnchant.EnchantState )			then
		luaElementEnchant:EnchantNoAgentMsg();
	elseif( luaElementEnchant.ENCHANT_STATE.ENCHANT_NOTENOUGHMONEY == luaElementEnchant.EnchantState )	then
		luaElementEnchant:EnchantNotEnoughMoneyMsg();
	elseif( luaElementEnchant.ENCHANT_STATE.ENCHANT_READY == luaElementEnchant.EnchantState )			then
		luaElementEnchant:EnchantReadyMsg();
	elseif( luaElementEnchant.ENCHANT_STATE.ENCHANT_READYPLUS == luaElementEnchant.EnchantState )		then
		luaElementEnchant:EnchantReadyPlusMsg();
	elseif( luaElementEnchant.ENCHANT_STATE.ENCHANT_DOING == luaElementEnchant.EnchantState )			then
		luaElementEnchant:EnchantDoingMsg();
	elseif( luaElementEnchant.ENCHANT_STATE.ENCHANT_RESULT == luaElementEnchant.EnchantState )			then
		luaElementEnchant:EnchantResultMsg();
	elseif( luaElementEnchant.ENCHANT_STATE.ENCHANT_NO_ELEMENT_GEM == luaElementEnchant.EnchantState )	then
		luaElementEnchant:EnchantNotElementGemMsg();
	end
	
end

-- SetGuideMsg( 가이드메세지 )
function luaElementEnchant:SetGuideMsg( strMsg )
	
	luaGame:OnEventPresentation( strMsg, PRESENTATION_TYPE.LOWER, nil );
	
end

-- EnchantResultMsg( 결과 메세지 종합 처리 )
function luaElementEnchant:EnchantResultMsg()

	if( luaElementEnchant.EnchantResult == luaElementEnchant.ENCHANT_RESULT.RESULT_SUCC )			then
		luaElementEnchant:EnchantResultSuccMsg();
	elseif( luaElementEnchant.EnchantResult == luaElementEnchant.ENCHANT_RESULT.RESULT_SKIP )		then
		luaElementEnchant:EnchantResultFailedSkipMsg();
	elseif( luaElementEnchant.EnchantResult == luaElementEnchant.ENCHANT_RESULT.RESULT_DOWN )		then
		luaElementEnchant:EnchantResultFailedDownMsg();
	elseif( luaElementEnchant.EnchantResult == luaElementEnchant.ENCHANT_RESULT.RESULT_BROKEN )	then
		luaElementEnchant:EnchantResultFailedBrokenMsg();
	else
		-- gamedebug:Log( "luaElementEnchant:EnchantResultMsg() ???" .. luaElementEnchant.EnchantResult );
	end
	
end

-- RedoEnchant
function luaElementEnchant:RedoEnchant()
	
	local nRedoIndex		= btnRedoElementEnchant:GetUserData();
	if( 0 > nRedoIndex )		then
		luaElementEnchant:InitEnchant();
		return ;
	end
	
	local nID		= gamefunc:GetInvenItemID( nRedoIndex );
	-- 결과창중이라면 초기화 한번 해줌
	if( luaElementEnchant.ENCHANT_STATE.ENCHANT_RESULT == luaElementEnchant.EnchantState )	then
		luaElementEnchant:InitEnchant();
	end

	luaElementEnchant:RegisteredEnchantItem( nID, nRedoIndex );
		
end

--=============================================================
-- 상황메세지
--=============================================================
-- EnchantOpenMsg( 강화 시작시 나오는 메세지 )
function luaElementEnchant:EnchantOpenMsg()
	
	luaElementEnchant:SetEnchantMessage1( STR( "UI_ELEMENT_ENCHANT_REGISTERITEM" ) );
	luaElementEnchant:SetEnchantMessage2( "" );
	
end

-- EnchantResultSuccMsg( 결과 - 성공 )
function luaElementEnchant:EnchantResultSuccMsg()
	
	luaElementEnchant:SetEnchantMessage1( STR( "UI_ELEMENT_ENCHANT_RESULT_SUCC" ) );
	luaElementEnchant:SetEnchantMessage2( "" );
	
end

-- EnchantResultFailedSkipMsg( 결과 - 실패 - 보존 )
function luaElementEnchant:EnchantResultFailedSkipMsg()
	
	luaElementEnchant:SetEnchantMessage1( STR( "UI_ELEMENT_ENCHANT_RESULT_FAILED_SKIP" ) );
	luaElementEnchant:SetEnchantMessage2( "" );
	
end

-- EnchantResultFailedDownMsg( 결과 - 실패 - 하락 )
function luaElementEnchant:EnchantResultFailedDownMsg()

	luaElementEnchant:SetEnchantMessage1( FORMAT( "UI_ENCHANT_RESULT_FAILED_DOWN", 1) );
	luaElementEnchant:SetEnchantMessage2( "" );
	
end

-- EnchantResultFailedBrokenMsg( 결과 - 실패 - 부서짐 )
function luaElementEnchant:EnchantResultFailedBrokenMsg()

	luaElementEnchant:SetEnchantMessage1( STR( "UI_ENCHANT_RESULT_FAILED_BROKEN" ) );
	luaElementEnchant:SetEnchantMessage2( "" );
	
end

-- EnchantReadyOnlyAgentMsg( 강화가능 - 강화제만 존재 )
function luaElementEnchant:EnchantReadyMsg()
	
	local strMsg1		= "";
	local strMsg2		= "";
	local nEnchantGrade	= luaElementEnchant.TargetGrade;
	
	
	
	luaElementEnchant:SetEnchantMessage1( strMsg1 );
	luaElementEnchant:SetEnchantMessage2( strMsg2 );
	
end

-- EnchantReadyAgentsMsg( 강화가능 - 보조제 하나이상 존재 )
function luaElementEnchant:EnchantReadyPlusMsg()
	
	local strMsg1		= "";
	local strMsg2		= "";
	local nEnchantGrade	= luaElementEnchant.TargetGrade;
	
	if( 0 < luaElementEnchant.ElementGemItemID ) then
		-- 원소석의 속성을 가져와서 메시지로 출력 해주자.
		local elementType = gamefunc:GetElementGemToElementType(luaElementEnchant.ElementGemItemID);
		local strElementType = luaElementEnchant:GetStrElementType(elementType);
		
		strMsg1		= FORMAT( "UI_ENCHANT_ELEMENT_ENCHANT_NOTICE", strElementType );
	end
	
	luaElementEnchant:SetEnchantMessage1( strMsg1 );
	luaElementEnchant:SetEnchantMessage2( strMsg2 );
	
end		

-- EnchantNoAgentMsg( 보조제 없음 )
function luaElementEnchant:EnchantNoAgentMsg()

	luaElementEnchant:SetEnchantMessage1( STR( "UI_ENCHANT_NOAGENT" ) );
	luaElementEnchant:SetEnchantMessage2( "" );
	
end
-- EnchantNotEnoughMoneyMsg( 소지금 부족함 )
function luaElementEnchant:EnchantNotEnoughMoneyMsg()
	
	luaElementEnchant:SetEnchantMessage1( STR( "UI_ENCHANT_NOTENOUGHMONEY" ) );
	luaElementEnchant:SetEnchantMessage2( "" );
	
end

-- EnchantNotEnoughMoneyMsg( 원소석 없음 )
function luaElementEnchant:EnchantNotElementGemMsg()
	
	luaElementEnchant:SetEnchantMessage1( STR( "UI_ENCHANT_NO_ELEMENT_GEM" ) );
	luaElementEnchant:SetEnchantMessage2( STR("UI_ENCHANT_OTHER_ELEMENT_GEM") );
	
end
-- EnchantDoingMsg( 인첸트중 )
function luaElementEnchant:EnchantDoingMsg()

	luaElementEnchant:SetEnchantMessage1( "" );
	luaElementEnchant:SetEnchantMessage2( "" );
	
end

-- ClearEnchantRegisterMsg
function luaElementEnchant:ClearEnchantRegisterMsg()
	luaElementEnchant:SetGuideMsg( "" );
end
--=============================================================
--=============================================================

--=============================================================
-- 상황메세지
--=============================================================

-- EnchantRegisterFailedGuideMsg( 강화불가능 아이템 등록시 )
function luaElementEnchant:EnchantRegisterFailedGuideMsg()
	
	luaElementEnchant.EnchantState		= luaElementEnchant.ENCHANT_STATE.ENCHANT_OPEN;
	
	luaElementEnchant:SetGuideMsg( STR( "UI_ENCHANT_REGISTERFAILEDITEM" ) );
	
end

-- EnchantRegisterFailedGuideMsg( 강화불가능 아이템 등록시 )
function luaElementEnchant:ElementgemRegisterFailedGuideMsg()
	
	luaElementEnchant.EnchantState		= luaElementEnchant.ENCHANT_STATE.ENCHANT_NO_ELEMENT_GEM;
	
	luaElementEnchant:SetGuideMsg( STR( "UI_ENCHANT_REGISTERFAILEDELEMENTGEM" ) );
	
end


-- EnchantFirstTargetItemGuideMsg( 강화아이템 등록전 강화+보조제 등록시 )
function luaElementEnchant:EnchantFirstTargetItemGuideMsg()

	luaElementEnchant.EnchantState		= luaElementEnchant.ENCHANT_STATE.ENCHANT_OPEN;
	
	luaElementEnchant:SetGuideMsg( STR( "UI_ENCHANT_FIRSTTARGETITEM_REGISTER" ) );
	
end

-- EnchantAgentGradeErrorGuideMsg( 강화제 등록시 강화아이템이 맞지 않을 경우 )
function luaElementEnchant:EnchantAgentGradeErrorGuideMsg()

	luaElementEnchant:SetGuideMsg( STR( "UI_ENCHANT_AGENTGRADE_ERROR" ) );
	
end

-- EnchantAgentPositionErrorGuideMsg( 강화 보조제의 위치가 맞지 않을때 )
function luaElementEnchant:EnchantAgentPositionErrorGuideMsg()

	luaElementEnchant:SetGuideMsg( STR( "UI_ENCHANT_AGENTERRORPOS" ) );
	
end

-- EnchantErrorMsg( 서버에서 Error가 왔을 때 처리 )
function luaElementEnchant:EnchantErrorMsg( nError )

	local str	= STR( "UI_ENCHANT_RESULTERROR" );
	if( 0 < nError )	then
		str		= str .. "[ " .. nError .. " ]";
	end
	
	luaElementEnchant:SetGuideMsg( str );
	
end

function luaElementEnchant:GetStrElementType(elementType)
	
	local strKey = gamefunc:GetElementTypeToElementStringKey(elementType)
	return STR( strKey );
	
end

function luaElementEnchant:ShowCautionMsgBox()

	tvwCautionMsg:SetText( STR( "UI_ELEMENT_ENCHANT_OTHER_ATTRIBUTE" ) );
	
	frmCautionMsgBox:DoModal();
end
--=============================================================
--=============================================================
