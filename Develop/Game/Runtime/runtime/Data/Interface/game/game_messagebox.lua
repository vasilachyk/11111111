--[[
	Game message box manager LUA script
--]]


-- Global instance
luaMessageBox = {};


-- Message box info
luaMessageBox.m_MessageBoxes = {};


-- Variables
luaMessageBox.Confirm = {};
	luaMessageBox.Confirm.strType = nil;
	luaMessageBox.Confirm.bConfirmed = false;
	luaMessageBox.Confirm._Callback = nil;





-- Initialize
function luaMessageBox:Initialize()

	local _owner = EventArgs:GetOwner();
	local _window = _G[ _owner:GetName()];

	luaMessageBox.m_MessageBoxes[ _window] = {};
	
	-- Layout
	luaMessageBox.m_MessageBoxes[ _window].strType = "";
	luaMessageBox.m_MessageBoxes[ _window].x = 0;
	luaMessageBox.m_MessageBoxes[ _window].y = 0;
	luaMessageBox.m_MessageBoxes[ _window].w = _window:GetWidth();
	luaMessageBox.m_MessageBoxes[ _window].h = _window:GetHeight();
	
	-- Lifetime
	luaMessageBox.m_MessageBoxes[ _window].fLifeTime = 0;
	luaMessageBox.m_MessageBoxes[ _window].fStartTime = 0;

	-- Confirm
	luaMessageBox.m_MessageBoxes[ _window].bConfirm = false;
	luaMessageBox.m_MessageBoxes[ _window].strConfirmMsg = "";
	luaMessageBox.m_MessageBoxes[ _window].callbackFunc = nil;
end





-- MessageBox
function luaMessageBox:MessageBox( strString, fLifeTime, strType, strConfirmMsg, callbackFunc)

	local strKey = gamefunc:GetDisplayKeyString( "NPCINTERACTION");
	luaMessageBox:MessageBoxEx( strString, fLifeTime, strType, strConfirmMsg, strKey, callbackFunc)
end


function luaMessageBox:MessageBoxEx( strString, fLifeTime, strType, strConfirmMsg, strKey, callbackFunc)

	-- Initialize variables
	if ( fLifeTime == nil)  or  ( fLifeTime < 0)  then		fLifeTime = 0;
	else													fLifeTime = math.max( 5000, fLifeTime);
	end
	
	strType = strType  or  "";
	strConfirmMsg = strConfirmMsg  or  "";
	
	
	-- Close duplicated message box
	luaMessageBox:DeleteMessageBoxType( strType);
	
	
	-- Get start position
	local x, y = gamefunc:GetWindowSize();
	for _window, msgbox  in pairs( luaMessageBox.m_MessageBoxes)  do

		if ( _window:GetShow() == true)  then  y = y - msgbox.h;
		end
	end
	

	-- Show message box
	for _window, msgbox  in pairs( luaMessageBox.m_MessageBoxes)  do
	
		if ( _window:GetShow() == false)  then
		
			x = x - msgbox.w - 10;
			y = y - msgbox.h - 20;


			local bConfirm = true;			
			if ( strConfirmMsg == nil)  or  ( strConfirmMsg == "")  then  bConfirm = false;
			end

			local bShowKey = true;
			if ( strKey == nil)  or  ( strKey == "")  then  bShowKey = false;
			end

			-- Add mouse click and key button
			if ( bShowKey == true)  then
				local _x, _y, _w, _h = _window:GetClientRect();
				strString = "{ALIGN hor=\"right\" ver=\"bottom\"}{SPACE h=" .. _h - 2 .. "}{FONT name=\"fntBoldStrong\"}{COLOR r=180 g=64 b=20}(" .. strKey .. "){/COLOR}{/FONT} , {BITMAP name=\"bmpMouseBtnLeft\" w=15 h=20}{CR h=0}" ..
					"{ALIGN hor=\"center\"}" .. strString;
			end

			
			_window:SetText( strString);
			_window:SetRect( x, y, msgbox.w, 0);
			_window:Show( true);
			
			msgbox.hOwner = _window;
			msgbox.x = x;
			msgbox.y = y;
			msgbox.strType = strType;
			msgbox.fLifeTime = fLifeTime;
			msgbox.fStartTime = gamefunc:GetUpdateTime();

			if ( bConfirm == true)  then
			
				msgbox.bConfirm = true;
				msgbox.strConfirmMsg = strConfirmMsg;
				
			else
				
				msgbox.bConfirm = false;
				msgbox.strConfirmMsg = "";
			end

			msgbox.callbackFunc = callbackFunc;
			
			
			-- Play sound
			gamefunc:PlaySound( "popup_msg_alarm");
			
	
			break;
		end
	end
end



-- DeleteMessageBoxType
function luaMessageBox:DeleteMessageBoxType( strType)

	if ( strType == nil)  or  ( strType == "")  then  return;
	end
	

	if ( frmMessageBoxConfirm:GetShow() == true)  and
		( luaMessageBox.Confirm.strType ~= nil)  and  ( luaMessageBox.Confirm.strType == strType)  then
		
		luaMessageBox.Confirm._Callback = nil;
		
		frmMessageBoxConfirm:Show( false);
	end


	for _window, msgbox  in pairs( luaMessageBox.m_MessageBoxes)  do
	
		if ( _window:GetShow() == true)  and  ( msgbox.strType == strType)  then
		
			luaMessageBox:DeleteMessageBox( _window);
			break;
		end
	end
end





-- DeleteMessageBox
function luaMessageBox:DeleteMessageBox( _delwnd)

	if ( _delwnd:GetShow() == false)  then  return;
	end
	
	_delwnd:Show( false);


	for _window, msgbox  in pairs( luaMessageBox.m_MessageBoxes)  do
	
		if ( _window:GetShow() == true)  and  ( msgbox.y < luaMessageBox.m_MessageBoxes[ _delwnd].y)  then
		
			msgbox.y = msgbox.y + luaMessageBox.m_MessageBoxes[ _delwnd].h;
		end
	end
end





-- Clear
function luaMessageBox:Clear()

	for _window, msgbox  in pairs( luaMessageBox.m_MessageBoxes)  do
	
		_window:Show( false);
	end
end






-- OnUpdateMessageBox
function luaMessageBox:OnUpdateMessageBox()

	local _owner = EventArgs:GetOwner();
	local _window = _G[ _owner:GetName()];
	local msgbox = luaMessageBox.m_MessageBoxes[ _window];
	local fElapsed = gamefunc:GetUpdateTime() - msgbox.fStartTime;
	

	-- Infinite life time
	local fRatio = 1.0;
	if ( msgbox.fLifeTime == 0)  then
	
		-- Expand
		if ( fElapsed < 500)  then  fRatio = fElapsed / 500;
		end


	-- Finite life time
	else
	
		-- Delete
		if ( fElapsed > msgbox.fLifeTime)  then
		
			if ( msgbox.callbackFunc ~= nil)  then  msgbox:callbackFunc( 0);
			end

			luaMessageBox:DeleteMessageBox( _window);

			return;
		end
	
		
		-- Expand or collapse
		if ( fElapsed < 500)  then								fRatio = fElapsed / 500;
		elseif ( fElapsed > (msgbox.fLifeTime - 500))  then		fRatio = (msgbox.fLifeTime - fElapsed) / 500;
		end
	end

	
	local height = math.floor( msgbox.h * fRatio);
	_window:SetRect( msgbox.x, msgbox.y + msgbox.h - height, msgbox.w, height);
	
	local fOpacity = math.min( 1.0,  fRatio * 2.0);
	_window:SetOpacity( fOpacity);
end





-- OnDrawMessageBox
function luaMessageBox:OnDrawMessageBox()
	
	local _owner = EventArgs:GetOwner();
	local _window = _G[ _owner:GetName()];
	local msgbox = luaMessageBox.m_MessageBoxes[ _window];
	
	if ( msgbox.strType == "levelup")  then
	
		local nElapsed = math.floor( gamefunc:GetUpdateTime() - msgbox.fStartTime);
		if ( nElapsed > 1000  and  nElapsed < 1100 )  or
			( nElapsed > 1200  and  nElapsed < 1300)  or
			( nElapsed > 1400  and  nElapsed < 1500)  then

			local _owner = EventArgs:GetOwner();
			local x, y, w, h = _owner:GetRect();
			
			local _effect = gamedraw:SetEffect( "add");
			local _opacity = gamedraw:SetOpacity( 0.9);
			gamedraw:SetBitmap( "bmpGauges");
			gamedraw:DrawEx( -2, -2, w + 4, h + 4, 0, 0, 32, 20);
			gamedraw:SetEffect( _effect);
			gamedraw:SetOpacity( _opacity);
		end
	end
end





-- OnClickMessageBox
function luaMessageBox:OnClickMessageBox()

	if ( frmMessageBoxConfirm:GetShow() == true)  then  return;
	end
	

	local _owner = EventArgs:GetOwner();
	local _window = _G[ _owner:GetName()];
	local msgbox = luaMessageBox.m_MessageBoxes[ _window];

	if ( msgbox.callbackFunc ~= nil)  then
	
		if ( msgbox.bConfirm == true)  then
		
			luaMessageBox.Confirm.strType = msgbox.strType;
			luaMessageBox.Confirm._Callback = msgbox.callbackFunc;
		
			tvwMessageBoxMsg:SetText( msgbox.strConfirmMsg);
			frmMessageBoxConfirm:Show( true);
			
		else

			msgbox:callbackFunc( 1);
		end
	end
	

	luaMessageBox:DeleteMessageBox( _window);
end




-- QueryExistRunHotKey
function luaMessageBox:QueryExistRunHotKey()

	if ( frmMessageBoxConfirm:GetShow() == true)  then  return true;
	end


	local bRetVal = false;
	
	for _window, msgbox  in pairs( luaMessageBox.m_MessageBoxes)  do
	
		if ( _window:GetShow() == true)  and  ( msgbox.callbackFunc ~= nil)  then
			
			if ( msgbox.bConfirm == true)  then
			
				luaMessageBox.Confirm.strType = msgbox.strType;
				luaMessageBox.Confirm._Callback = msgbox.callbackFunc;
			
				tvwMessageBoxMsg:SetText( msgbox.strConfirmMsg);
				frmMessageBoxConfirm:Show( true);

				luaMessageBox:DeleteMessageBox( _window);
				
				bRetVal = true;
				break;
			end
		end
	end

	return bRetVal;
end
















-- OnShowMessageBoxComfirmFrame
function luaMessageBox:OnShowMessageBoxComfirmFrame()

	-- Show
    if ( frmMessageBoxConfirm:GetShow() == true)  then
    
		luaMessageBox.Confirm.bConfirmed = false;
		
		-- Disabled message boxes
		for _window, msgbox  in pairs( luaMessageBox.m_MessageBoxes)  do  _window:Enable( false);
		end

		local x = ( gamefunc:GetWindowWidth() - frmMessageBoxConfirm:GetWidth()) * 0.5;
		local y = ( gamefunc:GetWindowHeight() - frmMessageBoxConfirm:GetHeight()) * 0.5;
		frmMessageBoxConfirm:SetPosition( x, y);

		-- Show cursor
		gamefunc:ShowCursor( true);


	-- Hide
	else
	
		if ( luaMessageBox.Confirm.bConfirmed == false)  then  luaMessageBox:OnClickConfirmNo();
		end

		luaMessageBox.Confirm._Callback = nil;


		-- Enabled message boxes
		for _window, msgbox  in pairs( luaMessageBox.m_MessageBoxes)  do  _window:Enable( true);
		end
    end
end





-- OnClickConfirmYes
function luaMessageBox:OnClickConfirmYes()

	luaMessageBox.Confirm.bConfirmed = true;

	if ( luaMessageBox.Confirm._Callback ~= nil)  then  luaMessageBox.Confirm:_Callback( 1);
	end

	frmMessageBoxConfirm:Show( false);
end





-- OnClickConfirmNo
function luaMessageBox:OnClickConfirmNo()

	luaMessageBox.Confirm.bConfirmed = true;
	
	if ( luaMessageBox.Confirm._Callback ~= nil)  then  luaMessageBox.Confirm:_Callback( 0);
	end

	frmMessageBoxConfirm:Show( false);
end
