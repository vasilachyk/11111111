--[[
	Game enemy info LUA script
--]]


-- Global instance
luaTargetInfo = {};


-- Target info
luaTargetInfo.target = {};
	luaTargetInfo.target.id = 0;
	luaTargetInfo.target.name = "";
	luaTargetInfo.target.grade = nil;
	luaTargetInfo.target.level = nil;
	luaTargetInfo.target.hp = nil;
	luaTargetInfo.target.interaction = nil;
	luaTargetInfo.target.enemy = 0;
	luaTargetInfo.target.faction = 0;
	luaTargetInfo.target.battle = 0;
	luaTargetInfo.target.timer = 0;


INTERACT_TYPE =
{
	NONE				= 0,
	TALK				= 1,
	TAKE				= 2,
	QUEST				= 3,
	TRADE				= 4,
	TRRIGGER			= 5
};





-- OnShowTargetInfo
function luaTargetInfo:OnShowTargetInfo()

--	if ( frmTargetInfo:GetShow() == true)  then  gamefunc:PlaySound( "interact_round");
--	end

	luaTargetInfo.target.timer = gamefunc:GetUpdateTime();
end





-- RefreshTargetInfo
function luaTargetInfo:RefreshTargetInfo()

	local nID = gamefunc:GetTargetID();
	if ( nID > 0)  then
	
		luaTargetInfo.target.id = nID;
		luaTargetInfo.target.name = gamefunc:GetTargetName();
		luaTargetInfo.target.grade = math.max( 0, gamefunc:GetTargetGrade() - 3);
		luaTargetInfo.target.level = gamefunc:GetTargetLevel();
		luaTargetInfo.target.interaction = gamefunc:GetTargetInteractType();

		if ( gamefunc:IsShowTargetInfo() == true)  then		luaTargetInfo.target.hp = gamefunc:GetTargetHP();
		else												luaTargetInfo.target.hp = nil;
		end

		luaTargetInfo.target.enemy, luaTargetInfo.target.faction, luaTargetInfo.target.battle = gamefunc:GetTargetAttackableType();
		
		
		local w, h = frmTargetInfo:GetSize();
		w = math.max( 150, gamedraw:GetTextWidth( "fntScript", luaTargetInfo.target.name) + 40) + 60;
		frmTargetInfo:SetSize( w, h);
		
		
		frmTargetInfo:Show( true);
	end
end





-- HideTargetInfo
function luaTargetInfo:HideTargetInfo()
	
	frmTargetInfo:Show( false);
end





-- OnDrawTargetInfo
function luaTargetInfo:OnDrawTargetInfo()

	local w, h = frmTargetInfo:GetSize();
	local ratio = math.min( 1.0, (gamefunc:GetUpdateTime() - luaTargetInfo.target.timer) / 100);
	if ( frmTargetInfo:GetShow() == false)  then  ratio = 1.0 - ratio;  end
	local sh = (h - 25) * ( ratio * ratio);
	local _h = (h - sh) * 0.5;

	-- Background
	local opacity = gamedraw:SetOpacity( 0.5);
	gamedraw:SetBitmap( "bmpGradationRight");
	gamedraw:Draw( 0, _h, 30, sh);
	gamedraw:SetBitmap( "bmpGradationLeft");
	gamedraw:Draw( w - 30, _h, 30, sh);
	gamedraw:SetBitmap( "bmpGradationNone");
	gamedraw:Draw( 30, _h, w - 60, sh);
	gamedraw:SetOpacity( opacity);
	
	gamedraw:SetBitmap( "bmpGlowBar");
	gamedraw:Draw( -30, _h - 1, w + 60, 1);
	gamedraw:Draw( -30, _h + sh - 1, w + 60, 1);
	
	
	-- Grade
	if ( luaTargetInfo.target.grade ~= nil)  and  ( luaTargetInfo.target.grade > 0)  then

		local _x = ( w  - ( 20 * luaTargetInfo.target.grade)) * 0.5;
		gamedraw:SetBitmap( "bmpGrade");
		for  i = 0, ( luaTargetInfo.target.grade - 1)  do
		
			gamedraw:Draw( _x + ( 20 * i), 1, 20, 20);
		end
	end
	
	
	-- Battle
	if ( luaTargetInfo.target.battle ~= nil)  and  ( luaTargetInfo.target.battle > 0)  and  ( luaTargetInfo.target.faction < 0)  then
	
		gamedraw:SetBitmap( "iconBattle");
		gamedraw:Draw( 10, 0, 25, 25);
	end
		
	
	-- Name and Level
	gamedraw:SetFont( "fntScript");
	gamedraw:SetTextAlign( "left", "bottom");
	if ( luaTargetInfo.target.enemy == nil)  then			gamedraw:SetColor( 210, 210, 210);
	elseif ( luaTargetInfo.target.enemy > 0)  then
	
		if ( luaTargetInfo.target.faction < 0)  then		gamedraw:SetColor( 255, 64, 32);
		elseif ( luaTargetInfo.target.faction == 0)  then	gamedraw:SetColor( 230, 160, 64);
		end

	else
	
		if ( luaTargetInfo.target.faction > 0)  then		gamedraw:SetColor( 160, 220, 255);
		else												gamedraw:SetColor( 210, 210, 210);
		end
	end	
	gamedraw:TextEx( 30, 15, w - 60, 20, luaTargetInfo.target.name);

	if ( luaTargetInfo.target.level ~= nil)  then
	
		gamedraw:SetFont( "fntSmall");
		gamedraw:SetColor( 210, 210, 130);
		gamedraw:SetTextAlign( "right", "bottom");
		gamedraw:TextEx( 30, 15, w - 60, 20, "Lv." .. luaTargetInfo.target.level);
	end
	
	
	-- HP gauge
	if ( luaTargetInfo.target.hp ~= nil)  then
	
		local len = ( w - 60) * ( luaTargetInfo.target.hp * 0.01);
		gamedraw:SetBitmap( "bmpGauges");
		gamedraw:DrawEx( 30, 40, ( w - 60) * luaTargetInfo.target.hp * 0.01, 7, 0, 0, 32, 20);
		
		local r, g, b = gamedraw:SetBitmapColor( 64, 64, 64);
		gamedraw:DrawEx( 30 + len, 40, w - 60 - len, 7, 0, 0, 32, 20);
		gamedraw:SetBitmapColor( r, g, b);
	end
	
		
	-- Keys
	gamedraw:SetFont( "fntSubScriptStrong");
	gamedraw:SetColor( 230, 230, 230);
	gamedraw:SetTextAlign( "left", "bottom");

	local _x = w - 10;
	if ( true)  then
	
		local strVKey = "";
		local nVKey = gamefunc:GetVirtualKey( "LOCKTARGET");
		if ( nVKey > 0)  then  strVKey = gamefunc:GetVirtualKeyStr( nVKey);  end
		_x = _x - 25 - gamedraw:GetTextWidth( "fntSubScriptStrong", strVKey);
	
		gamedraw:SetBitmap( "iconInsight");
		gamedraw:Draw( _x, h - 25, 25, 25);
		gamedraw:TextEx( _x + 20, h - 25, 50, 25, strVKey);
	end
	
	local nInteract = luaTargetInfo.target.interaction;
	if ( nInteract ~= nil)  and  ( nInteract ~= INTERACT_TYPE.NONE)  then
	
		local strBitmap = "";
		if ( nInteract == INTERACT_TYPE.TALK)  then				strBitmap = "iconTalk";
		elseif ( nInteract == INTERACT_TYPE.TAKE)  then			strBitmap = "iconTake";
		elseif ( nInteract == INTERACT_TYPE.QUEST)  then		strBitmap = "iconQuest";
		elseif ( nInteract == INTERACT_TYPE.TRADE)  then		strBitmap = "iconTrade";
		elseif ( nInteract == INTERACT_TYPE.TRRIGGER)  then		strBitmap = "iconTrigger";
		end

		local strVKey = "";
		local nVKey = gamefunc:GetVirtualKey( "NPCINTERACTION");
		if ( nVKey > 0)  then  strVKey = gamefunc:GetVirtualKeyStr( nVKey);  end
		_x = _x - 25 - gamedraw:GetTextWidth( "fntSubScriptStrong", strVKey);
		
		gamedraw:SetBitmap( strBitmap);
		gamedraw:Draw( _x, h - 25, 25, 25);
		gamedraw:TextEx( _x + 20, h - 25, 50, 25, strVKey);
	end
end

