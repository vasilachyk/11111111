--[[
	Game friends LUA script
--]]


-- Global instance
luaFriends = {};


-- RefreshFriends
function luaFriends:RefreshFriends()

	--gamedebug:Log( "luaFriends:RefreshFriends()\n");
	luaFriends:RefreshControls();
	luaFriends:RefreshFriendsMemberList();
	
end




function luaFriends:OnLoadedMemberCount()

	local nMaxCount = gamefunc:GetFriendsMaxMemberCount();

	labFriendMemberCount:SetText( "0 / " .. nMaxCount);
end




-- RefreshFriendsMemberList
function luaFriends:RefreshFriendsMemberList()

	if ( frmSocial:GetShow() == false)  or  ( tbcSocialTabCtrl:GetSelIndex() ~= 1)  then  return;
	end
	
	
	local nCurSel = math.max( 0, lcFriendsList:GetCurSel());
	
	lcFriendsList:DeleteAllItems();
	
	local nMaxCount = gamefunc:GetFriendsMaxMemberCount();
	local nCount = gamefunc:GetFriendsMemberCount();
	if ( nCount == 0)  then	return;
	end
	
	-- Member list
	local nOfflineCount = 0;
	for i = 0, (nCount - 1)  do
	
		local strMemberName		= gamefunc:GetFriendsMemberName( i);
		local strMemberLevel	= gamefunc:GetFriendsMemberLevel( i);
		local strMemberLocation = gamefunc:GetFieldName(gamefunc:GetFriendsMemberLocation( i));
		local strMemberChannel	= gamefunc:GetFriendsMemberChannel( i);
		local bMemberOffline	= gamefunc:IsFriendsMemberOffline( i);
		local nTitleStyle		= gamefunc:GetFriendsMemberTitleStyle( i);
		local strTalentImage	= TITLE_STYLE_ICON[nTitleStyle];
	
		local strState = STR( "UI_ONLINE");
		if ( bMemberOffline == true)  then
		
			strState = STR( "UI_OFFLINE");
			nOfflineCount = nOfflineCount + 1;
		end
		
		-- 오프라인 친구 표시하기 여부
		if (bMemberOffline == true) and (btnShowOfflineFriends:GetCheck() == false) then

		else
			local strMemberNameForm = strMemberName .. "(" .. strMemberLevel .. ")";
			if (bMemberOffline == false) then
				strMemberNameForm = strMemberNameForm .. " / " .. strMemberLocation .. " (ch " .. strMemberChannel .. ")"
			end

			local nIndex = lcFriendsList:AddItem( strMemberNameForm, strTalentImage);
			lcFriendsList:SetItemText( nIndex, 1, "");
			lcFriendsList:SetItemText( nIndex, 2, strState);
			lcFriendsList:SetItemData( nIndex, i);
			
			if ( bMemberOffline == true)  then  lcFriendsList:Enable( nIndex, false);
			end

		end
	
	end
	
	lcFriendsList:SetCurSel( nCurSel);

	if (btnShowOfflineFriends:GetCheck() == false) then
	
		labFriendMemberCount:SetText( (nCount - nOfflineCount) .. " / " .. nMaxCount);	
	else
	
		labFriendMemberCount:SetText( nCount .. " / " .. nMaxCount);	
	end

end




-- RefreshControls
function luaFriends:RefreshControls()

	if ( frmSocial:GetShow() == false)  or  ( tbcSocialTabCtrl:GetSelIndex() ~= 1)  then  return;
	end

	
	
end



-- OnClickConfirmFriend
function luaFriends:OnClickConfirmFriend()
	
	frmConfirmFriends:Show( false );

	local strRefText = tvwConfirmFriends:GetRefText( 1);
	local strType, strData = luaGame:GetReferenceTypeData( strRefText);

	if (strType == "Add") then

		local strName = edtAddFriend:GetText();
		if(strName ~= "") then
			gamefunc:AddFriend( strName);
		end

	elseif (strType == "Delete") then

		local nCurSel = lcFriendsList:GetCurSel();
		if ( nCurSel < 0)  then	return;
		end

		local nIndex = lcFriendsList:GetItemData( nCurSel);
		if ( nIndex < 0)  then return;
		end

		gamefunc:KickFriend( nIndex);
	end

end


function luaFriends:WhisperToFriend()

	local strFriendName = "";
	
	local nCurSel = lcFriendsList:GetCurSel();
	if ( nCurSel >= 0)  then
	
		local i = lcFriendsList:GetItemData( nCurSel );
		if ( i >= 0)  then
		
			strFriendName = gamefunc:GetFriendsMemberName( i);
		end
	end

	if (strFriendName == "") then return;
	end
	
	local strChatMsg = "";
	strChatMsg = "/w " .. strFriendName .. " ";
	
	--luaChattingBox:SetEditText( strChatMsg);

	gamefunc:SetLastSendWhisper( strFriendName );
	cmwChattingBox:SetPrefix( 8, STR( "UI_CHATTING_WHISPER" ), "  [" .. gamefunc:GetLastSendWhisper() .. "]" );
	
	luaChattingBox:ActivateChatInput( true);
	
end



function luaFriends:OnShowfrmConfirmFriends(strType)

	edtAddFriend:Show(false);
	edtAddFriend:SetText( "");

	local strtvw = "{REF text=\"" .. strType .. "://";

	if (strType == "Add") then

		strtvw = strtvw .. "\"}{/REF}" ..STR( "UI_SOCIAL_CONFIRM_ADD_FRIEND");

		edtAddFriend:Show(true);
		edtAddFriend:SetText( "");
		edtAddFriend:SetSel( 0, edtAddFriend:GetLength());

	elseif (strType == "Delete") then

		local nCurSel = lcFriendsList:GetCaretPos();
		if ( nCurSel < 0)  then	return;
		end

		local nIndex = lcFriendsList:GetItemData( nCurSel);
		if ( nIndex < 0)  then return;
		end

		local strFriendName	= gamefunc:GetFriendsMemberName( nIndex);
		strtvw = strtvw .. "\"}{/REF}" .. FORMAT( "UI_SOCIAL_CONFIRM_KICK_FRIEND", strFriendName);
	end

	local x, y = frmConfirmFriends:GetParent():GetPosition();
	local w, h = frmConfirmFriends:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmConfirmFriends:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);
	frmConfirmFriends:DoModal();

	tvwConfirmFriends:SetText(strtvw);

	if (strType == "Add") then
		edtAddFriend:SetFocus();
	end
end

