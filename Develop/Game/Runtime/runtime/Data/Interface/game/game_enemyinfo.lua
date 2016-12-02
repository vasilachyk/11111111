--[[
	Game enemy info LUA script
--]]


-- Global instance
luaEnemyInfo = {};


-- Target info
luaEnemyInfo.target = {};
	luaEnemyInfo.target.id = 0;
	luaEnemyInfo.target.name = "";
	luaEnemyInfo.target.grade = nil;
	luaEnemyInfo.target.level = nil;
	luaEnemyInfo.target.hp = nil;
	luaEnemyInfo.target.timer = 0;





-- OnShowEnemyInfo
function luaEnemyInfo:OnShowEnemyInfo()

	if ( frmEnemyInfo:GetShow() == true)  then
	
--		if ( frmEnemyInfo:GetShow() == true)  then  gamefunc:PlaySound( "interact_round");
--		end
		
		frmEnemyInfo:SetTimer( 500, 0);
		
	else
	
		frmEnemyInfo:KillTimer();
	end


	luaEnemyInfo.target.timer = gamefunc:GetUpdateTime();
end





-- RefreshEnemyInfo
function luaEnemyInfo:RefreshEnemyInfo()

	if ( gamefunc:GetEnemyCount() == 0)  and  ( gamefunc:IsLockOnTarget() == false)  then
		
		frmEnemyInfo:Show( false);
		return;
	end


	local nID = gamefunc:GetEnemyID();
	if ( nID > 0)  then
	
		luaEnemyInfo.target.id = nID;
		luaEnemyInfo.target.name = gamefunc:GetEnemyName();
		if ( gamefunc:IsShowEnemyInfo() == true)  then
		
			luaEnemyInfo.target.grade = math.max( 0, gamefunc:GetEnemyGrade() - 3);
			luaEnemyInfo.target.level = gamefunc:GetEnemyLevel();
			luaEnemyInfo.target.hp = gamefunc:GetEnemyHP();
			
		else
		
			luaEnemyInfo.target.grade = nil;
			luaEnemyInfo.target.level = nil;
			luaEnemyInfo.target.hp = nil;
		end
				
		
		frmEnemyInfo:Show( true);
		
	else

		frmEnemyInfo:Show( false);
	end
end





-- OnDrawEnemyInfo
function luaEnemyInfo:OnTimerEnemyInfo()

	if ( gamefunc:IsLockOnTarget() == true)  then
	
		luaEnemyInfo.target.name = gamefunc:GetEnemyName();
			
		if ( gamefunc:IsShowEnemyInfo() == true)  then  luaEnemyInfo.target.hp = gamefunc:GetEnemyHP();
		end
	end
end





-- OnDrawEnemyInfo
function luaEnemyInfo:OnDrawEnemyInfo()

	local w, h = frmEnemyInfo:GetSize();
	local ratio = math.min( 1.0, (gamefunc:GetUpdateTime() - luaEnemyInfo.target.timer) / 150);
	if ( frmEnemyInfo:GetShow() == false)  then  ratio = 1.0 - ratio;  end
	local sh = (h - 33) * ( ratio * ratio);
	local _h = (h - sh) * 0.5;

	-- Background
	local opacity = gamedraw:SetOpacity( 0.5);
	gamedraw:SetBitmap( "bmpGradationRight");
	gamedraw:Draw( 0, _h, 50, sh);
	gamedraw:SetBitmap( "bmpGradationLeft");
	gamedraw:Draw( w - 50, _h, 50, sh);
	gamedraw:SetBitmap( "bmpGradationNone");
	gamedraw:Draw( 50, _h, w - 100, sh);
	gamedraw:SetOpacity( opacity);
	
	gamedraw:SetBitmap( "bmpGlowBar");
	gamedraw:Draw( -50, _h - 1, w + 100, 1);
	gamedraw:Draw( -50, _h + sh - 1, w + 100, 1);
	
	
	-- Grade
	if ( luaEnemyInfo.target.grade ~= nil)  and  ( luaEnemyInfo.target.grade > 0)  then

		local _x = ( w  - ( 20 * luaEnemyInfo.target.grade)) * 0.5;
		gamedraw:SetBitmap( "bmpGrade");
		for  i = 0, ( luaEnemyInfo.target.grade - 1)  do
		
			gamedraw:Draw( _x + ( 20 * i), 6, 20, 20);
		end
	end
	
	
	-- Name and Level
	gamedraw:SetFont( "fntScript");
	gamedraw:SetColor( 210, 210, 210);
	gamedraw:SetTextAlign( "left", "bottom");
	gamedraw:TextEx( 50, 15, w - 100, 20, luaEnemyInfo.target.name);

	if ( luaEnemyInfo.target.level ~= nil)  then
	
		gamedraw:SetFont( "fntSmall");
		gamedraw:SetColor( 210, 210, 130);
		gamedraw:SetTextAlign( "right", "bottom");
		gamedraw:TextEx( 50, 15, w - 100, 20, "Lv." .. luaEnemyInfo.target.level);
	end
	
	
	-- HP gauge
	if ( luaEnemyInfo.target.hp ~= nil)  then
	
		local len = ( w - 100) * ( luaEnemyInfo.target.hp * 0.01);
		gamedraw:SetBitmap( "bmpGauges");
		gamedraw:DrawEx( 50, 40, ( w - 100) * luaEnemyInfo.target.hp * 0.01, 7, 0, 0, 32, 20);
		
		local r, g, b = gamedraw:SetBitmapColor( 64, 64, 64);
		gamedraw:DrawEx( 50 + len, 40, w - 100 - len, 7, 0, 0, 32, 20);
		gamedraw:SetBitmapColor( r, g, b);
	end
end





-- OnNcHitTestEnemyInfo
function luaEnemyInfo:OnNcHitTestEnemyInfo()

	EventArgs.hittest = HITTEST.NOWHERE;
	
	local x, y, w, h = frmEnemyInfo:GetWindowRect();
	local px, py = gamefunc:GetCursorPos();
	
	if ( px >= x)  and  ( px < (x + w))  and  ( py >= y)  and  ( py < (y + h))  then

		EventArgs.hittest = HITTEST.CAPTION;
	end

	return true;
end
