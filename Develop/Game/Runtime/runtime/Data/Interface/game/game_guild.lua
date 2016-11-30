--[[
	Game guild LUA script
--]]


-- Global instance
luaGuild = {};

luaGuild.m_bValueChange = false;



-- RefreshGuild
function luaGuild:RefreshGuild()

	luaGuild:RefreshGuildMemberList();
	luaGuild:RefreshControls();
end





-- RefreshGuildMemberList
function luaGuild:RefreshGuildMemberList()

	if ( frmSocial:GetShow() == false)  or  ( tbcSocialTabCtrl:GetSelIndex() ~= 1)  then  return;
	end
	
	
	local nCurSel = math.max( 0, lcGuildList:GetCurSel());
	
	lcGuildList:DeleteAllItems();
	

	local nCount = gamefunc:GetGuildMemberCount();
	if ( nCount == 0)  then
	
		labGuildName:SetText( "-");
		labGuildLeader:SetText( "-");
		labGuildMemberCount:SetText( "-");
		return;
	end
	
	
	-- Member list
	local nOfflineCount = 0;
	for i = 0, (nCount - 1)  do
	
		local strMemberName = gamefunc:GetGuildMemberName( i);
		local strMemberGrade = gamefunc:GetGuildMemberGrade( i);
		local bMemberOffline = gamefunc:IsGuildMemberOffline( i);
		
		local strTalentImage = "";
		
		local strGrade = STR( "GUILDMEMBER");
		if ( strMemberGrade == "master")  then  strGrade = STR( "GUILDLEADER");
		end
		
		local strState = STR( "UI_ONLINE");
		if ( bMemberOffline == true)  then
		
			strState = STR( "UI_OFFLINE");
			nOfflineCount = nOfflineCount + 1;
		end
		
		-- 오프라인 길드원 표시하기 여부
		if (bMemberOffline == true) and btnShowOffLine:GetCheck() == false then

		else
			local nIndex = lcGuildList:AddItem( strMemberName, strTalentImage);
			lcGuildList:SetItemText( nIndex, 1, strGrade);
			lcGuildList:SetItemText( nIndex, 2, strState);
			lcGuildList:SetItemData( nIndex, i);
				
			if ( bMemberOffline == true)  then  lcGuildList:SetItemEnable( nIndex, false);
			end
		end
		
		-- Guild leader
		if ( strMemberGrade == "master")  then  labGuildLeader:SetText( strMemberName);
		end
	end

	lcGuildList:SetCurSel( nCurSel);
	
	
	-- Guild name
	labGuildName:SetText( gamefunc:GetGuildName());


	-- Member count
	labGuildMemberCount:SetText( (nCount - nOfflineCount) .. " / " .. nCount);
end





-- RefreshControls
function luaGuild:RefreshControls()

	if ( frmSocial:GetShow() == false)  or  ( tbcSocialTabCtrl:GetSelIndex() ~= 1)  then  return;
	end


	btnDelegateGuildLeader:Enable( false);
	btnDisbandGuildMember:Enable( false);
	btnLeaveGuild:Enable( false);
	
	local nMemberCount = gamefunc:GetGuildMemberCount();
	if ( nMemberCount > 0)  then
		btnLeaveGuild:Enable( true);
	end
	
	if ( gamefunc:AmIGuildLeader() == true)  then
	
		local nEnable = false;
		local nCurSel = lcGuildList:GetCaretPos();
		if ( nCurSel >= 0)  then
		
			local nIndex = lcGuildList:GetItemData( nCurSel);
			if ( nIndex >= 0)  then

				local strName = lcGuildList:GetItemText( nCurSel, 0);
				local strMasterName = labGuildLeader:GetText();
				
				if (strName ~= strMasterName) then
					btnDelegateGuildLeader:Enable( true);
					btnDisbandGuildMember:Enable( true);
				end
			end
		end
	end
end






--
function luaGuild:OnShowfrmMakeGuild()

	local nMinKor, nMaxKor = gamefunc:GetGuildNameLengthKor();
	local nMinEng, nMaxEng = gamefunc:GetGuildNameLengthEng();
	tvGuildCreate:SetText( FORMAT( "UI_SOCIAL_ENTERGUILDNAME", nMinKor .. "~" .. nMaxKor));

	local x, y = frmMakeGuild:GetParent():GetPosition();
	local w, h = frmMakeGuild:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmMakeGuild:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);
	frmMakeGuild:DoModal();
	
	edtGuildName:SetText( "");
	edtGuildName:SetFocus();
	edtGuildName:SetSel( 0, edtGuildName:GetLength());
	luaGuild.m_bValueChange = false;
end





--
function luaGuild:OnValueChangeGuildName()

	local strGuildName = edtGuildName:GetText();

	local bValidate = gamefunc:IsValidateGuildName( strGuildName);
	if ( bValidate == false)  then
		luaGuild.m_bValueChange = false;
		return;
	end

	luaGuild.m_bValueChange = true;
end




--
function luaGuild:OnMakeGuildOK()

	if (luaGuild.m_bValueChange == false) then
	
		pbPresentationLower:Clear();
		pbPresentationLower:Add(STR( "GUILD_NOTCORRECTGUILDNAME"), 1);	
		return;
	end

	frmMakeGuild:Show( false);
	
	luaGuild:OnShowfrmConfirmGuild("Create")
end





--
function luaGuild:CloseMakeGuild()

	frmMakeGuild:Show( false);
	gamefunc:RequestNpcInteractionEnd();
end




-- OnClickDelegateGuildLeader
function luaGuild:OnClickDelegateGuildLeader()

	local nCurSel = lcGuildList:GetCaretPos();
	if ( nCurSel >= 0)  then
	
		local nIndex = lcGuildList:GetItemData( nCurSel);
		if ( nIndex >= 0)  then
			gamefunc:DelegateGuildLeader(nIndex);
		end
	end
end





-- OnClickDisbandGuildMember
function luaGuild:OnClickDisbandGuildMember()

	local nCurSel = lcGuildList:GetCaretPos();
	if ( nCurSel >= 0)  then
	
		local nIndex = lcGuildList:GetItemData( nCurSel);
		if ( nIndex >= 0)  then
			gamefunc:DisbandGuildMember(nIndex);
		end
	end
end





function luaGuild:OnShowfrmConfirmGuild(strType)

	local strtvw = "{REF text=\"" .. strType .. "://";
		
	if (strType == "Delegate") then
		
--		frmConfirmGuild:SetText("길드장 위임");
		
		local nCurSel = lcGuildList:GetCaretPos();
		if ( nCurSel >= 0)  then
	
			local strName = lcGuildList:GetItemText( nCurSel, 0);
			strtvw = strtvw .. "\"}{/REF}" .. FORMAT( "UI_SOCIAL_CONFIRMDELEGATEGUILDLEADER", strName);
			
		else
			return;
		end
		
	elseif (strType == "Disband") then
	
--		frmConfirmGuild:SetText("길드원 추방");

		local nCurSel = lcGuildList:GetCaretPos();
		if ( nCurSel >= 0)  then
	
			local strName = lcGuildList:GetItemText( nCurSel, 0);
			strtvw = strtvw .. "\"}{/REF}" .. FORMAT( "UI_SOCIAL_CONFIRMDISBANDGUILDMEMBER", strName);
			
		else
			return;
		end
		
	elseif (strType == "Leave") then
	
--		frmConfirmGuild:SetText("길드 탈퇴");
		
		local strGuild = gamefunc:GetGuildName();	
		strtvw = strtvw .. "\"}{/REF}" .. STR( "UI_SOCIAL_CONFIRMLEAVEGUILD");
		
	elseif (strType == "Destroy") then
		
--		frmConfirmGuild:SetText("길드 해체");

		local strGuild = gamefunc:GetGuildName();	
		strtvw = strtvw .. "\"}{/REF}" .. STR( "UI_SOCIAL_CONFIRMDESTROYGUILD");

	elseif (strType == "Create") then

--		frmConfirmGuild:SetText("길드 생성");

		local strGuild = edtGuildName:GetText();
		local strCost = "{COLOR r=230 g=180 b=20}1{FONT name=\"fntSmall\"}GP{/FONT}{/COLOR}";
		strtvw = strtvw .. strGuild .. "\"}{/REF}" .. FORMAT( "UI_SOCIAL_CONFIRMCREATEGUILD", strGuild, strCost);

	end

	local x, y = frmConfirmGuild:GetParent():GetPosition();
	local w, h = frmConfirmGuild:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmConfirmGuild:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);
	frmConfirmGuild:DoModal();

	tvwConfirmGuild:SetText(strtvw);
end




function luaGuild:OnOKConfirmGuild()

	local strRefText = tvwConfirmGuild:GetRefText( 1);
	local strType, strData = luaGame:GetReferenceTypeData( strRefText);
	
	if ( strType == "Delegate")  then
	
		luaGuild:OnClickDelegateGuildLeader();
		
	elseif (strType == "Disband") then
	
		 luaGuild:OnClickDisbandGuildMember();
		 
	elseif (strType == "Leave") then
	
		gamefunc:LeaveGuild();		
		
	elseif (strType == "Destroy") then
		
		gamefunc:DestroyGuild();
		
	elseif (strType == "Create") then
		
		if ( strData ~= nil ) then 
			gamefunc:CreateGuild(strData);
		end
	end
	
	luaGuild:OnCloseConfirmGuild();
end




function luaGuild:OnCloseConfirmGuild()

	frmConfirmGuild:Show( false);
	gamefunc:RequestNpcInteractionEnd();
end






function luaGuild:OnToolTipGuildName()

	local nMinKor, nMaxKor = gamefunc:GetGuildNameLengthKor();
	local nMinEng, nMaxEng = gamefunc:GetGuildNameLengthEng();
	edtGuildName:SetToolTip( FORMAT( "UI_SOCIAL_ENTERGUILDNAME", nMinKor .. "~" ..  nMaxKor));
end
