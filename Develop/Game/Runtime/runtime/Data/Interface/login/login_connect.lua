--[[
	Login connect LUA script
--]]


-- Global instance
luaLoginConnect = {};

-- EnterLoginFrame
function luaLoginConnect:EnterLoginFrame()

	-- accounthistory load
	--gamefunc:AccountHistoryLoad();
	
		frmLogin:Show( true);
		frmLoginBtm:Show( true);
		
		luaLoginConnect:RefreshServerList();
		
		--local strServer = gamefunc:GetHistory( "LoginServer");
		local strLastWorld	= nil;
		if ( strLastWorld ~= nil)  then
		
			local nCurSel = 0;
			for  i = 0, ( gamefunc:GetServerCount() - 1)  do
			
				if ( lcWorldList:GetItemText( i ) == strServer)  then  nCurSel = i;
				end
			end
			
			lcWorldList:SetCurSel( nCurSel);
		end

		luaLoginConnect:RefreshControls();
end





-- RefreshServerList
function luaLoginConnect:RefreshServerList()

	if ( frmLogin:GetShow() == false)  then  return;
	end
	
	
	local nCurSel = lcWorldList:GetCurSel();
	lcWorldList:DeleteAllItems();
	
	--gamefunc:AccountHistoryLoad();
	
	for  i = 0, ( gamefunc:GetServerCount() - 1)  do
	
		local strServerName = gamefunc:GetServerName( i);
		local nCurr, nMax = gamefunc:GetServerState( i);
		local nCapacity = nMax - nCurr;
		local nActive = gamefunc:GetServerActive( i);
		local nType = gamefunc:GetServerType( i);
		
		local strState, r, g, b;
		if ( nActive == false)  then		strState = STR( "UI_LOGIN_STATE_CHECKING");		r, g, b = 128, 128, 128;
		else
			
			local nRate		= ( nCurr / nMax ) * 100;	-- %
			
			if( 30 > nRate )			then
				strState = STR( "UI_LOGIN_STATE_GOOD");
				r, g, b = 111, 220, 89;
			elseif( 61 > nRate )		then
				strState = STR( "UI_LOGIN_STATE_BUSY");
				r, g, b = 230, 190, 0;
			else
				strState = STR( "UI_LOGIN_STATE_FULL");
				r, g, b = 254, 165, 0;
			end
			
		end
		
		--[[
		elseif ( nCapacity < 10)  then		strState = STR( "UI_LOGIN_STATE_FULL");			r, g, b = 170, 60, 50;
		elseif ( nCapacity < 100)  then		strState = STR( "UI_LOGIN_STATE_BUSY");			r, g, b = 160, 120, 55;
		else								strState = STR( "UI_LOGIN_STATE_GOOD");
		end
		]]--
		
		-- 월드 이름
		local nIndex = lcWorldList:AddItem( strServerName);
		if ( nActive == false)  then  lcWorldList:SetItemColor( nIndex, 0, r, g, b);
		end
		
		-- 캐릭터 수
		--[[
		local nCharNum	= gamefunc:GetWorldCharCount( strServerName );
		if( 0 > nCharNum )	then
			nCharNum	= "-";
		end
		lcWorldList:SetItemText( nIndex, 1, nCharNum );
		]]--
		
		-- 상태
		lcWorldList:SetItemText( nIndex, 1, strState);
		if ( r ~= nil  and  g ~= nil  and  b ~= nil)  then  lcWorldList:SetItemColor( nIndex, 1, r, g, b);
		end

		-- 이벤트 여부
		local strType = "", r, g, b;
		if ( nType == 1)  then				strType = STR( "UI_LOGIN_EVENTSERVER");			r, g, b = 170, 60, 50;
		end
		lcWorldList:SetItemText( nIndex, 2, strType);
		if ( r ~= nil  and  g ~= nil  and  b ~= nil)  then  lcWorldList:SetItemColor( nIndex, 2, r, g, b);
		end
		
		lcWorldList:SetItemData( nIndex, i);
	end
	
	lcWorldList:SetCurSel( nCurSel);
end





-- RefreshControls
function luaLoginConnect:RefreshControls()

	if ( frmLogin:GetShow() == false)  then  return;
	end
	
	local nCurSel = lcWorldList:GetCurSel();
	if ( nCurSel < 0)  then		btnLoginConnect:Enable( false);
	else						btnLoginConnect:Enable( true);
	end
end



function luaLoginConnect:OnKeyDown_EditID()
	--gamedebug:Log( "luaLoginConnect:OnKeyDown_EditID(" .. EventArgs.key .. ")" );
	if (EventArgs.key == 9) then --VK_TAB
		--gamedebug:Log( "EventArgs.key == VK_TAB" );
		edtPassward:SetFocus();
	end
end



function luaLoginConnect:OnKeyDown_EditPassword()
	--gamedebug:Log( "luaLoginConnect:OnKeyDown_EditPassword(" .. EventArgs.key .. ")" );
	if (EventArgs.key == 9) then --VK_TAB
		--gamedebug:Log( "EventArgs.key == VK_TAB" );
		edtID:SetFocus();
	end
end



-- Login
function luaLoginConnect:Login()

	local nCurSel = lcWorldList:GetCurSel();
	if ( nCurSel < 0)  then  return;
	end
	
	local nIndex = lcWorldList:GetItemData( nCurSel);
	if ( nIndex < 0)  then  return;
	end
	
	frmLogin:Show( false);
	frmLoginBtm:Show( false );
	
	-- Connect
	local strServerAddr = gamefunc:GetServerAddress( nIndex);
	gamefunc:LoginConnect(strServerAddr,edtID:GetText(),edtPassward:GetText());
	
	--gamefunc:SetHistory( "WorldName", lcWorldList:GetItemText( nCurSel ) );
	-- 마지막 접속 월드 저장

end




-- OnClickHomePage
function luaLoginConnect:OnClickHomePage()
	
	-- Show frame
	local x, y = frmHomePageMsgBox:GetParent():GetPosition();
	local w, h = frmHomePageMsgBox:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmHomePageMsgBox:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);
	frmHomePageMsgBox:DoModal();	
	
end

-- OpenHomePage
function luaLoginConnect:OpenHomePage()
	
	frmHomePageMsgBox:Show( false );
	--	URL = luaLoginConnect.HomePageUSA;
	
	
--	gamefunc:OnExplorer( URL );
	
end














-- OpenLoginErrorMsgFrame
function luaLoginConnect:OpenLoginErrorMsgFrame( strErrorMsg, nResult )

	tvwLoginErrorMsg:SetText( strErrorMsg);
	btnLoginErrorMsgBoxOK:SetUserData( nResult );

	-- Show frame
	local x, y = frmLoginErrorMsgBox:GetParent():GetPosition();
	local w, h = frmLoginErrorMsgBox:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmLoginErrorMsgBox:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);
	frmLoginErrorMsgBox:DoModal();	
	
	gamefunc:WaitDirectLogin( true);
	
end





-- OnClickLoginErrorClose
function luaLoginConnect:OnClickLoginErrorClose()
	
	frmLoginErrorMsgBox:Show( false );
	gamefunc:LoginDisconnect();
	luaLoginConnect:ReEnterIDLogin();
end





function luaLoginConnect:ReEnterIDLogin()

	-- Show UI
	layerLogin:Show( true);
	layerLoginFrame:Show( true);
	layerLoginLoading:Show( false);

	-- Update UI
	luaLoginConnect:EnterIDLogin();
end





function luaLoginConnect:EnterIDLogin()

	edtID:SetFocus();
	btnRememberID:SetCheck( true );
	local szID = gamefunc:GetHistory( "LoginID");
	edtID:SetText(szID);
	edtPassward:SetText("");
	edtPassward:SetFocus();
	
    local width, height = frmLoginID:GetParent():GetSize();
	local x, y, w, h = frmLoginID:GetRect();
    frmLoginID:SetPosition( ( width - w) * 0.5, height * 0.75);

	frmLoginID:Show(true);
end





function luaLoginConnect:IDLogin()

	local szID = edtID:GetText();
	local szPassward = edtPassward:GetText();
	if (szID == "") or (szPassward == "") then	return;
	end
	
	frmLoginID:Show(false);
	
	gamefunc:SetHistory( "LoginID", szID);

	gamefunc:LoginConnect("", szID, szPassward);
	
	--luaLoginConnect:EnterLoginFrame()
	
end

function luaLoginConnect:OnLoadedBackground()
	
	-- 이미지 비율( 16 : 10 )
	local width, height = gamefunc:GetWindowSize();
    local w, h = 1600 * height / 1000,  height;
    local x, y = 0, 0;
    
    -- 이미지 w가 해상도w보다 작다면 가로에 맞춰 다시 계산
	if( width > w )	then
		w, h			= width, 10 * width / 16;
		x, y			= 0, height - h;
	end
    
    picloginBackground:SetRect( x, y, w, h );
       	
end