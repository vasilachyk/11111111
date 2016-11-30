--[[
	Game mail box LUA script
--]]


-- Global instance
luaMailBox = {};


-- Scroll timer
luaMailBox.m_nScrollTimer = 0;


-- Progress bar timer
luaMailBox.m_fProgressBarTimer = nil;


-- Attached
luaMailBox.m_Attached = {};
luaMailBox.m_Attached.money = 0;
luaMailBox.m_Attached.items = {};
luaMailBox.m_Attached.itemorder = {};





-- OnShowMailBoxFrame
function luaMailBox:OnShowMailBoxFrame()
	
	frmReadMail:Show( false);

	frmConfirmDeleteMail:Show( false);

	frmSendMailProgress:Show( false);
	frmSendMailErrorMsgBox:Show( false);
	

	luaMailBox:ResetSendMail();

	
	-- Show
	if ( frmMailBox:GetShow() == true)  then
	
		tbcMailBoxTabCtrl:SetSelIndex( 0);

		lcMailBox:SetCurSel( -1);

		luaMailBox:RefreshMailBox();
		
	-- Hide
   	else
   	
		gamefunc:RequestNpcInteractionEnd();

		frmInventory:Show( false);
	end
	
	
	luaGame:ShowWindow( frmMailBox);
end





-- RefreshMailBox
function luaMailBox:RefreshMailBox()

	if ( frmMailBox:GetShow() == false)  then  return;
	end
	
	
	luaMailBox:RefreshMailBoxList();
	luaMailBox:RefreshMailBoxControls();
	luaMailBox:RefreshSendMailControls();
	
	
	if ( tbcMailBoxTabCtrl:GetSelIndex() == 1)  then  frmInventory:Show( true);
	end
end





-- RefreshMailBoxList
function luaMailBox:RefreshMailBoxList()

	if ( frmMailBox:GetShow() == false)  or  ( tbcMailBoxTabCtrl:GetSelIndex() ~= 0)  then  return;
	end
	
	
	frmConfirmDeleteMail:Show( false);


	local nCurSel = lcMailBox:GetCurSel();
	lcMailBox:DeleteAllItems();

	for  i = (gamefunc:GetMailCount() - 1), 0, -1  do
	
		local strSender = STR( "UI_MAILBOX_SENDER") .. " : " .. gamefunc:GetMailSender( i);
		local strTitle = gamefunc:GetMailTitle( i);
		
		local nRemained = gamefunc:GetMailRemaindDay( i);
		local strRemained;
		if ( strRemained == 0)  then	strRemained = STR( "UI_MAILBOX_LESSONEDAY");
		else							strRemained = FORMAT( "UI_MAILBOX_DAYLEFT", nRemained + 1);
		end
		
		local bRead = gamefunc:IsMailRead( i);

		local strImage = "iconMailClose";
		local nThumbID = gamefunc:GetMailAttachedThumbItemID( i);
		if ( nThumbID > 0)  then

			strImage = gamefunc:GetItemImage( nThumbID);
		
		else
		
			if ( bRead == true)  then  strImage = "iconMailOpen";
			end
		end
		
				
		local nIndex = lcMailBox:AddItem( strTitle, strImage);
		lcMailBox:SetItemText( nIndex, 1, strSender);
		lcMailBox:SetItemText( nIndex, 2, "");
		lcMailBox:SetItemText( nIndex, 3, strRemained);
		lcMailBox:SetItemData( nIndex, i);

		if ( bRead == false)  then
		
			lcMailBox:SetItemColor( nIndex, 1, 80, 130, 130);
			
			if ( nRemained == 0)  then		lcMailBox:SetItemColor( nIndex, 3, 128, 32, 8);
			else							lcMailBox:SetItemColor( nIndex, 3, 80, 130, 130);
			end
			
		else

			lcMailBox:SetItemColor( nIndex, 0, 80, 80, 80);
			lcMailBox:SetItemColor( nIndex, 1, 40, 65, 65);

			if ( nRemained == 0)  then		lcMailBox:SetItemColor( nIndex, 3, 64, 16, 4);
			else							lcMailBox:SetItemColor( nIndex, 3, 40, 65, 65);
			end
		end
	end
	
	lcMailBox:SetCurSel( math.max( 0, nCurSel));
	
	
	
	-- Mail box is full
	local bFull = gamefunc:IsMailBoxFull();

	local strText = "";
	if ( bFull == true)  then
	
		strText = strText .. "{BITMAP name=\"iconDefExclamation\" w=32 h=32}{CR h=0}{INDENT dent=35}{FONT name=\"fntScript\"}{COLOR r=170 g=60 b=50}" .. STR( "UI_MAILBOX_FULLED");
	end
	
	tvwMailBoxState:SetText( strText);
end





-- RefreshMailBoxControls
function luaMailBox:RefreshMailBoxControls()

	if ( frmMailBox:GetShow() == false)  or  ( tbcMailBoxTabCtrl:GetSelIndex() ~= 0)  then  return;
	end
	
	
	local nCurSel = lcMailBox:GetCurSel();
	if ( nCurSel < 0)  then
	
		btnReadMail:Enable( false);
		btnDeleteMail:Enable( false);
		
	else
	
		btnReadMail:Enable( true);
		btnDeleteMail:Enable( true);	
	end
end





-- ReadMail
function luaMailBox:ReadMail()

	local nCurSel = lcMailBox:GetCurSel();
	if ( nCurSel < 0)  then  return;
	end
	
	local nIndex = lcMailBox:GetItemData( nCurSel);
	if ( nIndex < 0)  then  return;
	end
	
	
	btnReadMail:Enable( false);
	
	gamefunc:ReadMail( nIndex);
end





-- ReplyMail
function luaMailBox:ReplyMail()

	local nCurSel = lcMailBox:GetCurSel();
	if ( nCurSel < 0)  then  return;
	end
	
	local nIndex = lcMailBox:GetItemData( nCurSel);
	if ( nIndex < 0)  then  return;
	end
	

	frmInventory:Show( true);
	
	tbcMailBoxTabCtrl:SetSelIndex( 1);

	luaMailBox:ResetSendMail();


	local strSender = gamefunc:GetMailSender( nIndex);
	local strTitle = "[" .. STR( "UI_MAILBOX_REPLY") .. "] " .. gamefunc:GetMailTitle( nIndex);
	
	edtSendMailReceiver:SetText( strSender);
	edtSendMailTitle:SetText( strTitle);
	

	luaMailBox:RefreshSendMailControls();

	edtSendMailContent:SetFocus();
end





-- SendMail
function luaMailBox:SendMail()

	luaInventory:ClosConfirmMoneyAmountFrame();
	luaInventory:CloseConfirmItemQuantityFrame();
	
	
	local strTitle = edtSendMailTitle:GetText();
	if ( string.len( strTitle) == 0)  then  edtSendMailTitle:SetText( STR( "UI_MAILBOX_UNTITILED"));
	end

	
	luaMailBox:OpenSendMailProgressFrame();
end





-- DeleteMail
function luaMailBox:DeleteMail()

	local nCurSel = lcMailBox:GetCurSel();
	if ( nCurSel < 0)  then  return;
	end
	
	local nIndex = lcMailBox:GetItemData( nCurSel);
	if ( nIndex < 0)  then  return;
	end


	gamefunc:DeleteMail( nIndex);
end





-- OnDrawItemBkgrndReadMail
function luaMailBox:OnDrawItemBkgrndReadMail()

	local nSubItem = EventArgs:GetItemSubItem();

	if ( nSubItem == 2)  then
	
		local x, y, w, h = EventArgs:GetItemRect();
		local nItem = EventArgs:GetItemIndex();
		local nIndex = lcMailBox:GetItemData( nItem);
		
		if ( nIndex > -1)  then
		
			local bRead = gamefunc:IsMailRead( nIndex);
			if ( bRead == true)  then  gamedraw:SetBitmapColor( 128, 128, 128);
			end
			
		
			if ( gamefunc:GetMailAttachedMoney( nIndex) > 0)  then
			
				gamedraw:SetBitmap( "iconCoin");
				gamedraw:Draw( x, y + (h - 18) * 0.5, 18, 18);
			end

			if ( gamefunc:GetMailAttachedThumbItemID( nIndex) > 0)  then

				gamedraw:SetBitmap( "iconClip");
				gamedraw:Draw( x + 15, y + (h - 18) * 0.5, 18, 18);
			end


			if ( bRead == true)  then  gamedraw:SetBitmapColor( 255, 255, 255);
			end
		end
	end
end





-- ResetMail
function luaMailBox:ResetSendMail()

	gamefunc:ClearSendMailAttachedItems();


	luaMailBox.m_Attached.money = 0;
	luaMailBox.m_Attached.items = nil;
	luaMailBox.m_Attached.items = {};
	luaMailBox.m_Attached.itemorder = nil;
	luaMailBox.m_Attached.itemorder = {};
	
	
	edtSendMailReceiver:SetText( "");
	edtSendMailTitle:SetText( "");
	edtSendMailContent:SetText( "");
	
	
	luaMailBox:RefreshSendMailAttachedObj();
	luaMailBox:RefreshSendMailControls();
end





-- RefreshSendMailAttachedObj
function luaMailBox:RefreshSendMailAttachedObj()

	local strText = "{INDENT dent=2}{ALIGN ver=\"center\"}{COLUMN h=26}{CR h=2}{FONT name=\"fntScript\"}";
	
	local nCount = 0;
	local bExist = false;
	
	if ( luaMailBox.m_Attached.money > 0)  then
	
		local strMoney = luaGame:ConvertMoneyToStr( luaMailBox.m_Attached.money, "fntSmall");
		
		strText = strText .. "{ALIGN hor=\"right\"}{REF text=\"deletemoney://\"}{SPACE w=4}{BITMAP name=\"iconDefStop\" w=12 h=12}{SPACE w=4}{/REF}{SPACE w=185}{CR h=0}" ..
			"{ALIGN hor=\"left\"}{REF text=\"money://\"}{SPACE w=180 h=26}{/REF}{CR h=0}" ..
			"{SPACE w=2}{BITMAP name=\"iconCoin\" w=24 h=24}" .. strMoney .. "{CR h=0}";
		 
			
		nCount = 1;
		bExist = true;
	end
	
	
	for  i, _index  in pairs( luaMailBox.m_Attached.itemorder)  do
	
		local nID = gamefunc:GetInvenItemID( _index);
		if ( nID > 0)  then
			
			local strName = gamefunc:GetItemName( nID);
			local strImage = gamefunc:GetItemImage( nID);
			local strReference = "item://" .. nID;
			local r, g, b = GetItemColor( nID);

			strName = "{COLOR r=" .. r .. " g=" .. g .. " b=" .. b .. "}" .. gamedraw:SubTextWidth( "fntScript", strName, 110) .. "{/COLOR}";

			if ( luaMailBox.m_Attached.items[ _index].nQuantity > 1)  then  strName = strName .. " x" .. luaMailBox.m_Attached.items[ _index].nQuantity;
			end
			

			if ( ( nCount % 2) == 0)  then
			
				if ( bExist == true)  then  strText = strText .. "{CR}";
				end
				

				strText = strText .. "{ALIGN hor=\"right\"}{REF text=\"deleteitem://" .. _index .. "\"}{SPACE w=4}{BITMAP name=\"iconDefStop\" w=12 h=12}{SPACE w=4}{/REF}{SPACE w=185}{CR h=0}" ..
					"{ALIGN hor=\"left\"}{REF text=\"" .. strReference .. "\"}{SPACE w=180 h=26}{/REF}{CR h=0}" ..
					"{SPACE w=2}{BITMAP name=\"" .. strImage .. "\" w=24 h=24}" .. strName .. "{CR h=0}";

			else
			
				strText = strText .. "{ALIGN hor=\"right\"}{REF text=\"deleteitem://" .. _index .. "\"}{SPACE w=4}{BITMAP name=\"iconDefStop\" w=12 h=12}{SPACE w=4}{/REF}{CR h=0}" ..
					"{ALIGN hor=\"left\"}{SPACE w=185}{REF text=\"" .. strReference .. "\"}{SPACE w=180 h=26}{/REF}{CR h=0}" ..
					"{SPACE w=185}{SPACE w=2}{BITMAP name=\"" .. strImage .. "\" w=24 h=24}" .. strName;
			end
			
			bExist = true;
		end
		
		
		nCount = nCount + 1;
	end
	
	
	if ( bExist == false)  then  strText = "{FONT name=\"fntScript\"}" .. STR( "UI_MAILBOX_ATTACHMENTMSG");
	end
	
	
	tvwMailAttach:SetText( strText);
end





-- RefreshSendMailControls
function luaMailBox:RefreshSendMailControls()

	if ( frmMailBox:GetShow() == false)  or  ( tbcMailBoxTabCtrl:GetSelIndex() ~= 1)  then  return;
	end
	
	
	-- Update UI
	if ( frmSendMailProgress:GetShow() == true)  or  ( frmSendMailErrorMsgBox:GetShow() == true)  then
	
		edtSendMailReceiver:Enable( false);
		edtSendMailTitle:Enable( false);
		edtSendMailContent:Enable( false);
		btnResetMail:Enable( false);
		btnSendMail:Enable( false);
		
		return;
	
	else
	
		edtSendMailReceiver:Enable( true);
		edtSendMailTitle:Enable( true);
		edtSendMailContent:Enable( true);
		btnResetMail:Enable( true);
		btnSendMail:Enable( true);
	end
	
	
	-- Check enable send butotn
	local bEnable = true;
	
	if	( edtSendMailReceiver:GetLength() == 0)  then
--		( string.lower( gamefunc:GetName()) == string.lower( edtSendMailReceiver:GetText()))  then
	
		bEnable = false;
	end
	

	-- Update content length
	local nLen = edtSendMailContent:GetLength();
	labRemainedMailContentChar:SetText( nLen .. " / " .. "500" .. STR( "UI_MAILBOX_CHARACTER"));
	
	if ( nLen > 500)  then
	
		labRemainedMailContentChar:SetColor( 180, 30, 30);
		bEnable = false;
	
	else
	
		labRemainedMailContentChar:SetColor( 160, 160, 160);
	end
	
	
	-- Update cost
	local nCost = 50;
	for  _index, _count in pairs( luaMailBox.m_Attached.items)  do  nCost = nCost + 100;
	end

	local nMoney = gamefunc:GetMoney() - luaMailBox.m_Attached.money;

	local strText = "{ALIGN ver=\"bottom\"}" .. STR( "COST") .. "{CR h=0}{ALIGN hor=\"right\"}";
	if ( nCost > nMoney)  then
	
		strText = strText .. "{BITMAP name=\"iconDefExclamation\" w=16 h=16}{SPACE w=5}";

		tvwMailSendCost:SetToolTip( STR( "UI_MAILBOX_NOTENOUGHMONEY"));
		
		bEnable = false;
		
	else	

		tvwMailSendCost:SetToolTip( "");
	end
	
	strText = strText .. luaGame:ConvertMoneyToStr( nCost, "fntSmall") .. "{SPACE w=10}";
	tvwMailSendCost:SetText( strText);
	

	-- Update send mail button
	btnSendMail:Enable( bEnable);
end





-- OnItemClickSendMailAttach
function luaMailBox:OnItemClickSendMailAttach()

	-- Get reference text
	local nItemIndex = EventArgs:GetItemIndex();
	if ( nItemIndex < 0)  then  return;
	end

	
	local strRefText = tvwMailAttach:GetRefText( nItemIndex);
	local strType, strData, nIndex = luaGame:GetReferenceTypeData( strRefText);
	
	
	-- Clicked selectable item
	if ( strType == "deletemoney")  then
	
		luaMailBox.m_Attached.money = 0;
		
		luaMailBox:RefreshSendMailAttachedObj();
		luaMailBox:RefreshSendMailControls();
		
		local strSound = gamefunc:GetMoneyPutDownSound();
		gamefunc:PlaySound( strSound);

		
	elseif ( strType == "deleteitem")  then
	
		local nIndex = tonumber( strData);
		if ( nIndex >= 0)  then
		
			gamefunc:DetachItemToSendMail( nIndex, luaMailBox.m_Attached.items[ nIndex].nQuantity);		
		end
		

		-- Play sound
		local nID = gamefunc:GetInvenItemID( nIndex);
		local strSound = gamefunc:GetItemPutDownSound( nID);
		gamefunc:PlaySound( strSound);
	end
end





-- OnToolTipSendMailAttach
function luaMailBox:OnToolTipSendMailAttach()

	local strToolTip = "";

	-- Get reference text
	local nItemIndex = EventArgs:GetItemIndex();
	if ( nItemIndex >= 0)  then

		local strRefText = tvwMailAttach:GetRefText( nItemIndex);
		local strType, strData = luaGame:GetReferenceTypeData( strRefText);


		-- Set tooltip
		if ( strType == "item")  then

			local nID = tonumber( strData);
			if ( nID > 0)  then

				strToolTip = luaToolTip:GetItemToolTip( nID, nil, nil);
				
				local nSlotType = gamefunc:GetItemSlot( nID);
				if ( nSlotType ~= ITEM_SLOT.NONE)  then  strToolTip = strToolTip;
				end
			end
		
		
		elseif ( strType == "delete")  then
		
			strToolTip = STR( "UI_MAILBOX_DELETEITEM");
		end
	end
	
	tvwMailAttach:SetToolTip( strToolTip);
end





-- OnDropSendMailAttachedObj
function luaMailBox:OnDropSendMailAttachedObj()

	local _sender = _G[ DragEventArgs:GetSender():GetName()];
	if ( _sender == nil)  then  return false;
	end
	
	
	local bRetVal = false;

	-- Inventory item
	if ( _sender == lcInventory)  then
	
		local nIndex = DragEventArgs:GetItemData( 0);
		if ( nIndex >= 0)  then
		
			local nID = gamefunc:GetInvenItemID( nIndex);
			if ( nID > 0)  then
			
				local nCount = table.getn( luaMailBox.m_Attached.itemorder);
				if ( nCount < 5)  then
				
					luaInventory:OpenConfirmItemQuantityFrame( luaMailBox.CallbackDropSendMailAttachedItem, STR( "UI_CONFIRM"), STR( "UI_MAILBOX_CONFIRMATTACHITEM"));
					
					bRetVal = true;
				end
			end
		end
		

	-- Money
	elseif ( _sender == tvwMoney)  then
	
		luaInventory:OpenConfirmMoneyAmountFrame( luaMailBox.CallbackDropSendMailAttachedMoney, luaMailBox.m_Attached.money);
		
		bRetVal = true;
	end
	

	return bRetVal;
end





-- CallbackDropSendMailAttachedItem
function luaMailBox:CallbackDropSendMailAttachedItem( nIndex, nQuantity)

	if ( luaMailBox.m_Attached.items[ nIndex] == nil)  then
	
		gamefunc:AttachItemToSendMail( nIndex, nQuantity);

	else
	
		local nDiff = nQuantity - luaMailBox.m_Attached.items[ nIndex].nQuantity;
		
		if ( nDiff > 0)  then			gamefunc:AttachItemToSendMail( nIndex, nDiff);
		elseif ( nDiff < 0)  then		gamefunc:DetachItemToSendMail( nIndex, -nDiff);
		end
	end
end





-- CallbackDropSendMailAttachedMoney
function luaMailBox:CallbackDropSendMailAttachedMoney( nMoney)

	nMoney = math.min( nMoney, gamefunc:GetMoney());

	luaMailBox.m_Attached.money = nMoney;
	
	luaMailBox:RefreshSendMailAttachedObj();
	luaMailBox:RefreshSendMailControls();
end





-- OnReadMail
function luaMailBox:OnReadMail()

	luaMailBox:RefreshMailBox();

	luaMailBox:OpenReadMailFrame();
end





-- OnSendMail
function luaMailBox:OnSendMail( nErrorCode)

	frmSendMailProgress:Show( false);


	if ( nErrorCode == 1)  then
	
		luaMailBox:ResetSendMail();
		
		tbcMailBoxTabCtrl:SetSelIndex( 0);

	else
	
		luaMailBox:OpenSendMailErrorMsgBox( nErrorCode);
	end
end





-- OnDeleteMail
function luaMailBox:OnDeleteMail()

	frmReadMail:Show( false);

	luaMailBox:RefreshMailBox();
end





-- OnRecievedNewMail
function luaMailBox:OnRecievedNewMail()

	luaMessageBox:MessageBox( STR( "UI_MAILBOX_ARRIVEDNEW"), 10000, "mail");
	
	frmReadMail:Show( false);
	
	luaMailBox:RefreshMailBox();
end





-- OnTakeMailItem
function luaMailBox:OnTakeMailItem( nItemIndex)

	luaMailBox:RefreshMailBox();
	luaMailBox:RefreshReadMailFrame();
end





-- OnTakeMailMoney
function luaMailBox:OnTakeMailMoney()

	luaMailBox:RefreshMailBox();
	luaMailBox:RefreshReadMailFrame();
end





-- OnAttachedItem
function luaMailBox:OnAttachedItem( nIndex, nQuantity)

	if ( luaMailBox.m_Attached.items[ nIndex] == nil)  then
	
		luaMailBox.m_Attached.items[ nIndex] = {};
		luaMailBox.m_Attached.items[ nIndex].nQuantity = nQuantity;
		
		table.insert( luaMailBox.m_Attached.itemorder, nIndex);

	else
	
		luaMailBox.m_Attached.items[ nIndex].nQuantity = luaMailBox.m_Attached.items[ nIndex].nQuantity + nQuantity;
	end
	
	
	luaMailBox:RefreshSendMailAttachedObj();
	luaMailBox:RefreshSendMailControls();
end





-- OnDetachedItem
function luaMailBox:OnDetachedItem( nIndex, nQuantity)

	if ( luaMailBox.m_Attached.items[ nIndex] == nil)  then  return;
	end
	

	luaMailBox.m_Attached.items[ nIndex].nQuantity = luaMailBox.m_Attached.items[ nIndex].nQuantity - nQuantity;

	if ( luaMailBox.m_Attached.items[ nIndex].nQuantity <= 0)  then

		luaMailBox.m_Attached.items[ nIndex] = nil;
		
		
		for i, _index  in pairs( luaMailBox.m_Attached.itemorder)  do
		
			if ( _index == nIndex)  then
			
				table.remove( luaMailBox.m_Attached.itemorder, i);
				break;
			end
		end
	end
	
	
	luaMailBox:RefreshSendMailAttachedObj();
	luaMailBox:RefreshSendMailControls();
end















-- OpenReadMailFrame
function luaMailBox:OpenReadMailFrame()

	if ( frmMailBox:GetShow() == false)  then  return;
	end
	
	local nCurSel = lcMailBox:GetCurSel();
	if ( nCurSel < 0)  then  return;
	end
	
	local nIndex = lcMailBox:GetItemData( nCurSel);
	if ( nIndex < 0)  then  return;
	end


	luaMailBox:RefreshReadMailFrame();
	

    btnReadMail:Enable( false);
    btnDeleteMail:Enable( false);

	
	-- Reposition frame
	local x, y = frmReadMail:GetParent():GetPosition();
	local w, h = frmReadMail:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmReadMail:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);
	frmReadMail:DoModal();
end





-- OnNcHitTestReadMail
function luaMailBox:OnNcHitTestReadMail()

	EventArgs.hittest = HITTEST.NOWHERE;
	
	local x, y, w, h = frmReadMail:GetWindowRect();
	local px, py = gamefunc:GetCursorPos();
	
	if ( px >= x)  and  ( px < (x + w))  and  ( py >= y)  and  ( py < (y + h))  then

		EventArgs.hittest = HITTEST.CAPTION;
	end

	return true;
end





-- RefreshReadMailFrame
function luaMailBox:RefreshReadMailFrame()

	if ( frmMailBox:GetShow() == false)  then  return;
	end
	
	local nCurSel = lcMailBox:GetCurSel();
	if ( nCurSel < 0)  then  return;
	end
	
	local nIndex = lcMailBox:GetItemData( nCurSel);
	if ( nIndex < 0)  then  return;
	end
	

	-- Set contents
	local strTitle = gamefunc:GetMailTitle( nIndex);
	local strSender = gamefunc:GetMailSender( nIndex);
	local strContent = gamefunc:GetMailContent( nIndex);
	local strText = "{CR}{FONT name=\"fntHeadline\"}{COLOR r=250 g=230 b=210}" .. strTitle .. "{/COLOR}{/FONT}\n" ..
		"{INDENT}{COLOR r=100 g=0 b=0}{REF text=\"sender://" .. strSender .. "\"}" .. STR( "UI_MAILBOX_SENDER") .. " : " .. strSender .. "{/REF}{/COLOR}{CR h=30}" ..
		"{BITMAP name=\"bmpHorizonBar\" w=300 h=3}{CR}{PRGSPC spacing=0}" .. strContent;


	local nMoney = gamefunc:GetMailAttachedMoney( nIndex);
	local nCount = gamefunc:GetMailAttachedItemCount( nIndex);
	if ( nMoney > 0)  or  ( nCount > 0)  then
	
		strText = strText .. "{CR h=30}{/INDENT}{INDENT}{BITMAP name=\"bmpHorizonBar\" w=300 h=3}{CR}{FONT name=\"fntScriptWeak\"}" .. STR( "UI_MAILBOX_WARNATTACHMENT") .. "{/FONT}\n{ALIGN ver=\"bottom\"}";
	end


	-- Add attached money
	if ( nMoney > 0)  then
	
		local strMoney = luaGame:ConvertMoneyToStr( nMoney, "fntSmallStrong");

		strText = strText .. "{/INDENT}{INDENT}{REF text=\"money://" .. luaMailBox.m_Attached.money .. "\"}{BITMAP name=\"bmpScrollItemSlot\" w=300 h=44}{/REF}{CR h=2}" ..
			"{INDENT dent=2}{BITMAP name=\"iconMoney\" w=40 h=40}{CR h=3}" ..
			"{INDENT dent=50}" .. STR( "MONEY") .. "{CR h=18}" ..
			"{FONT name=\"fntScriptStrong\"}" .. strMoney .. "{FONT name=\"fntRegularWeak\"}{CR h=23}";
	end
	

	-- Add attached items
	for  i = 0, ( nCount - 1)  do
	
		local nID = gamefunc:GetMailAttachedItemID( nIndex, i);
		local strName = gamefunc:GetItemName( nID);
		local strImage = gamefunc:GetItemImage( nID);
		local nItemIndex = gamefunc:GetMailAttachedItemIndex( nIndex, i);
		local nQuantity = gamefunc:GetMailAttachedItemQuantity( nIndex, i);
		local nTier = gamefunc:GetItemTier();
		local strTier = GetItemTierStr( nTier);
		local r, g, b = GetItemColor( nID);
		
		strText = strText .. "{/INDENT}{INDENT}{REF text=\"item://" .. nID .. "&" .. nItemIndex .. "\"}{BITMAP name=\"bmpScrollItemSlot\" w=300 h=44}{/REF}{CR h=2}" ..
			"{INDENT dent=2}{BITMAP name=\"" .. strImage .. "\" w=40 h=40}{CR h=3}" ..
			"{INDENT dent=50}" .. strName .. "{CR h=18}" ..
			"{FONT name=\"fntScriptWeak\"}" .. STR( "QUANTITY") .. " : " .. nQuantity .. "{CR h=0}" ..
			"{SPACE w=100}{COLOR r=" .. r .. " g=" .. g .. " b=" .. b .. "}" .. strTier .. "{/COLOR}{/FONT}{CR h=23}";
	end

	tvwReadMail:SetText( strText);
end





-- CloseReadMailFrame
function luaMailBox:CloseReadMailFrame()

	frmReadMail:Show( false);
	
	luaMailBox:RefreshMailBoxControls();
end





-- OnShowReadMailFrame
function luaMailBox:OnShowReadMailFrame()

	if ( frmReadMail:GetShow() == true)  then
	
		luaMailBox:OpenScrolledPaper();

	else
	
		luaMailBox:CloseReadMailFrame();
	end
end





-- OpenScrolledPaper
function luaMailBox:OpenScrolledPaper()

	luaMailBox.m_nScrollTimer = gamefunc:GetUpdateTime();
end





-- OnUpdateReadMailFrame
function luaMailBox:OnUpdateReadMailFrame()

	local fElapsed = gamefunc:GetUpdateTime() - luaMailBox.m_nScrollTimer - 250.0;
	if ( fElapsed < 0.0)  then
	
		fElapsed = 0.0;
		tvwReadMail:Show( false);
	else
	
		tvwReadMail:Show( true);
	end
	
	local h = 560  +  math.min( 0.0, 0.8 * fElapsed - 460.0) * math.cos( fElapsed * 0.003);
	pnlReadMailScroll:SetSize( pnlReadMailScroll:GetWidth(), h);
end





-- OnItemClickReadMail
function luaMailBox:OnItemClickReadMail()

	-- Get reference text
	local nItemIndex = EventArgs:GetItemIndex();
	if ( nItemIndex < 0)  then  return;
	end

	
	local nCurSel = lcMailBox:GetCurSel();
	if ( nCurSel < 0)  then  return;
	end
	
	local nIndex = lcMailBox:GetItemData( nCurSel);
	if ( nIndex < 0)  then  return;
	end
	
	
	local strRefText = tvwReadMail:GetRefText( nItemIndex);
	local strType, strData, nItemIndex = luaGame:GetReferenceTypeData( strRefText);
	
	
	-- Clicked selectable item
	if ( strType == "sender")  then

		frmReadMail:Show( false);
		
		luaMailBox:ReplyMail();

	elseif ( strType == "money")  then
	
		gamefunc:TakeMailMoney( nIndex);
		
	elseif ( strType == "item")  then
	
		gamefunc:TakeMailItem( nIndex, nItemIndex);
	end
end





-- OnToolTipReadMail
function luaMailBox:OnToolTipReadMail()

	local strToolTip = "";

	-- Get reference text
	local nItemIndex = EventArgs:GetItemIndex();
	if ( nItemIndex >= 0)  then

		local strRefText = tvwReadMail:GetRefText( nItemIndex);
		local strType, strData = luaGame:GetReferenceTypeData( strRefText);


		-- Set tooltip
		if ( strType == "sender")  then
		
			strToolTip = STR( "UI_MAILBOX_REPLYSENDER");
			
		elseif ( strType == "item")  then

			local nID = tonumber( strData);
			if ( nID > 0)  then

				strToolTip = luaToolTip:GetItemToolTip( nID, nil, nil);
				
				local nSlotType = gamefunc:GetItemSlot( nID);
				if ( nSlotType ~= ITEM_SLOT.NONE)  then  strToolTip = strToolTip;
				end
			end
		end
	end
	
	tvwReadMail:SetToolTip( strToolTip);
end

















-- OpenConfirmDeleteMailFrame
function luaMailBox:OpenConfirmDeleteMailFrame()

	local nCurSel = lcMailBox:GetCurSel();
	if ( nCurSel < 0)  then  return;
	end
	
	local nIndex = lcMailBox:GetItemData( nCurSel);
	if ( nIndex < 0)  then  return;
	end
	

    btnReadMail:Enable( false);
    btnDeleteMail:Enable( false);


	-- Set description
	local strTitle = gamefunc:GetMailTitle( nIndex);
	local strSender = STR( "UI_MAILBOX_SENDER") .. " : " .. gamefunc:GetMailSender( nIndex);

	local strText = "{BITMAP name=\"bmpItemSlot\" w=42 h=42}{CR h=1}" ..
		"{SPACE w=1}{BITMAP name=\"iconScroll\" w=40 h=40}{CR h=0}{INDENT dent=45}{FONT name=\"fntRegular\"}{COLOR r=160 g=160 b=160}" .. strTitle ..
		"{/COLOR}{/FONT}{CR}{FONT name=\"fntScript\"}{COLOR r=80 g=130 b=130}" .. strSender;
	tvwDeleteMailDesc:SetText( strText);

	
	-- Reposition frame
	local x, y = frmConfirmDeleteMail:GetParent():GetPosition();
	local w, h = frmConfirmDeleteMail:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmConfirmDeleteMail:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);
	frmConfirmDeleteMail:DoModal();
end





-- CloseConfirmDeleteMailFrame
function luaMailBox:CloseConfirmDeleteMailFrame()

	frmConfirmDeleteMail:Show( false);
	
	luaMailBox:RefreshMailBoxControls();
end


















-- OpenSendMailProgressFrame
function luaMailBox:OpenSendMailProgressFrame()

	-- Reset progress bar
	luaMailBox.m_fProgressBarTimer = gamefunc:GetUpdateTime();
	pcSendMailProgress:SetPos( 0);
	
	
	-- Reposition frame
	local x, y = frmSendMailProgress:GetParent():GetPosition();
	local w, h = frmSendMailProgress:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmSendMailProgress:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);
	frmSendMailProgress:DoModal();
	

	luaMailBox:RefreshSendMailControls();
end





-- OnUpdateSendMailProgressBar
function luaMailBox:OnUpdateSendMailProgressBar()

	if ( luaMailBox.m_fProgressBarTimer == nil)  then  return;
	end
	
	
	local fElapsed = gamefunc:GetUpdateTime() - luaMailBox.m_fProgressBarTimer;
	local nPos = ( fElapsed * 0.2) - 50;

	pcSendMailProgress:SetPos( nPos);
	
	
	-- Send mail when progress is full
	if ( nPos >= 100)  then
	
		local strReceiver = edtSendMailReceiver:GetText();
		local strTitle = edtSendMailTitle:GetText();
		local strContent = edtSendMailContent:GetText();
		
		gamefunc:SendMail( strReceiver, strTitle, strContent, luaMailBox.m_Attached.money);
		
		
		luaMailBox.m_fProgressBarTimer = nil;
	end
end














-- OpenSendMailErrorMsgBox
function luaMailBox:OpenSendMailErrorMsgBox( nResult)

	if ( frmMailBox:GetShow() == false)  then  return;
	end
	

	frmSendMailProgress:Show( false);


	-- Set error message
	local strMsg = gamefunc:GetMailErrorMsg( nResult);
	tvwSendMailErrorMsg:SetText( strMsg);


	-- Reposition frame
	local x, y = frmSendMailErrorMsgBox:GetParent():GetPosition();
	local w, h = frmSendMailErrorMsgBox:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmSendMailErrorMsgBox:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);
	frmSendMailErrorMsgBox:DoModal();
	
	
	luaMailBox:RefreshSendMailControls();
end
