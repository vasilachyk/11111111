--[[
	Game party indicator LUA script
--]]


-- Global instance
luaPartyIndicator = {};

-- Item height
luaPartyIndicator.m_nItemHeight = 76;





-- OnTimerPartyIndicator
function luaPartyIndicator:OnTimerPartyIndicator()

	local nCount = gamefunc:GetPartyMemberCount();
	if ( nCount > 1)  then
	
		frmPartyIndicator:Show( true);
		
		local w1, h1 = frmPartyIndicator:GetSize();
		local w2, h2 = btnIndLeaveParty:GetSize();

		frmPartyIndicator:SetSize( w1, luaPartyIndicator.m_nItemHeight * ( nCount - 1) + h2 + 4);
		
	else

		frmPartyIndicator:Show( false);
	end
end





-- OnDrawPartyIndicator
function luaPartyIndicator:OnDrawPartyIndicator()

	local x, y, w, h = frmPartyIndicator:GetRect();
	
	local bRightAlign = false;
	if ( ( x + w * 0.5) > ( gamefunc:GetWindowWidth() * 0.5))  then  bRightAlign = true;  end
	
	
	local _w, _h = btnIndLeaveParty:GetSize();
	local x, y = 0, _h + 4;
	local fHilgtOpacity = 0.2 + 0.2 * math.sin( gamefunc:GetUpdateTime() * 0.02);

	local nMemberCount = gamefunc:GetPartyMemberCount();
	for  i = 0, ( nMemberCount - 1)  do
	
		if ( gamefunc:IsPartyMemberMe( i) == false)  then
		
			local strEmblem = "iconEmblem";
			local strName = gamefunc:GetPartyMemberName( i);
			local strName = gamedraw:SubTextWidth( "fntScriptStrong", strName, 100);
			local nLevel = gamefunc:GetPartyMemberLevel( i);
			local bIsDead = gamefunc:IsPartyMemberDead( i);
			local bIsOffline = gamefunc:IsPartyMemberOffline( i);
			local bIsHightLight = gamefunc:IsPartyMemberHightlight( i);

			local nPercentHP = 0;
			local nPercentEN = 0;
			if ( bIsDead == false)  and  ( bIsOffline == false)  then
			
				nPercentHP = math.min( 100, gamefunc:GetPartyMemberHP( i));
				nPercentEN = math.min( 100, gamefunc:GetPartyMemberEN( i));
			end
			
			local strState = nil;
			if ( bIsOffline == true)  then		strState = STR( "UI_OFFLINE");
			elseif ( bIsDead == true)  then		strState = STR( "UI_DIE");
			end
			
			
			-- Draw background
			gamedraw:SetBitmap( "bmpPlayerInfo");
			gamedraw:Draw( x, y, 192, 24);
			if ( bIsHightLight == true)  then

				local _effect = gamedraw:SetEffect( "add");
				local _opacity = gamedraw:SetOpacity( 0.5 + 0.5 * math.sin( gamefunc:GetUpdateTime() * 0.015));
				gamedraw:Draw( x, y, 192, 24);
				gamedraw:SetEffect( _effect);
				gamedraw:SetOpacity( _opacity);
			end
		
		
			-- Draw emblem
			local _x, _y = 0, y;
			if ( bRightAlign == true)  then  _x = w - 30;  end
			gamedraw:SetBitmap( "bmpEmblemSlot");
			gamedraw:Draw( _x, _y, 33, 33);
			gamedraw:SetBitmap( strEmblem);
			gamedraw:Draw( _x + 4, _y + 4, 25, 25);
			

			-- Draw Level
			local _x, _y = 38, y + 6;
			if ( bRightAlign == true)  then  _x = 15;  end
			gamedraw:SetBitmap( "bmpPlayerLevel");
			gamedraw:Draw( _x, _y, 23, 12);
			gamedraw:SetFont( "fntSmall");
			gamedraw:SetColor( 230, 230, 230);
			gamedraw:SetTextAlign( "center", "center");
			gamedraw:TextEx( _x, _y, 23, 12, nLevel);


			-- Draw name
			local _x, _y = 65, y;
			if ( bRightAlign == true)  then  _x = 42;  end
			gamedraw:SetFont( "fntSubScript");
			gamedraw:SetColor( 230, 230, 230);
			gamedraw:SetTextAlign( "left", "center");
			gamedraw:TextEx( _x, _y, 110, 24, strName);
			

			-- Draw HP gauge
			local _x, _y = 33, y + 24;
			if ( bRightAlign == true)  then  _x = 9;  end
			gamedraw:SetBitmap( "bmpGauges");
			gamedraw:DrawEx( _x, _y, 152, 9, 0, 100, 32, 10);
			gamedraw:DrawEx( _x + 1, _y + 1, 1.5 * nPercentHP, 7, 0, 0, 32, 20);
			

			-- Draw EN gauge
			gamedraw:DrawEx( _x, _y + 10, 152, 6, 0, 100, 32, 10);
			gamedraw:DrawEx( _x + 1, _y + 11, 1.5 * nPercentEN, 4, 0, 80, 32, 20);

		
			-- Draw state
			if ( strState ~= nil)  then
			
				gamedraw:SetColor( 160, 160, 160);
				gamedraw:SetTextAlign( "center", "center");
				gamedraw:TextEx( _x, _y, 152, 16, strState);
			end


			-- Draw buff
			local x1 = _x;
			local x2 = _x;
			_y = y + 42;
			for  j = 0, (gamefunc:GetPartyMemberBuffCount( i) - 1)  do
			
				local nBuffID = gamefunc:GetPartyMemberBuffID( i, j);
				local bDeBuff = gamefunc:IsDebuff( nBuffID);
				local strBuffImage = gamefunc:GetBuffImage( nBuffID);

				gamedraw:SetBitmap( strBuffImage);
				
				if ( bDeBuff == false)  then
				
					gamedraw:Draw( x1, _y, 16, 16);
					x1 = x1 + 17;
				
				else
				
					gamedraw:Draw( x2, _y + 17, 16, 16);
					x2 = x2 + 17;		
				end
			end

			y = y + luaPartyIndicator.m_nItemHeight;
		end
	end
end





-- OnDblClickPartyIndicator
function luaPartyIndicator:OnDblClickPartyIndicator()

	tbcSocialTabCtrl:SetSelIndex( 0);

	frmSocial:Show( true);
end





-- OnNcHitTestPartyIndicator
function luaPartyIndicator:OnNcHitTestPartyIndicator()

	EventArgs.hittest = HITTEST.NOWHERE;
	
	local x, y, w, h = frmPartyIndicator:GetWindowRect();
	local px, py = gamefunc:GetCursorPos();
	
	if ( px >= x)  and  ( px < (x + w))  and  ( py >= y)  and  ( py < (y + h))  then

		EventArgs.hittest = HITTEST.CAPTION;
	end

	return true;
end





-- OnPositionPartyIndicator
function luaPartyIndicator:OnPositionPartyIndicator()

	local x, y, w, h = frmPartyIndicator:GetRect();
	local _x, _y, _w, _h = btnIndLeaveParty:GetRect();
	if ( ( x + w * 0.5) > ( gamefunc:GetWindowWidth() * 0.5))  then		btnIndLeaveParty:SetPosition( w - _w, _y);
	else																btnIndLeaveParty:SetPosition( 0, _y);
	end
end
