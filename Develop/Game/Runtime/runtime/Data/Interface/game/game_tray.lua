--[[
	Tray base LUA script
--]]


-- Global instance
luaTray= {};


-- new
function luaTray:OnUserArgumentTray( _DefaultFunction)

	local _owner = EventArgs:GetOwner();
	local _name = _owner:GetName();
	local _wnd = _G[ _name];
	local _arg = EventArgs:GetUserArgument();
	
	if ( _arg == "RESTORE_UI")  then

		local _function = gamefunc:GetAccountParam( _name, "function")  or  _DefaultFunction;
		if ( _function ~= nil)  and  ( _G[ _function] == nil)  then  _function = _DefaultFunction;
		end
		
		if ( _function ~= nil)  then  _wnd:BindScriptInstance( _function);
		end

	elseif ( _arg == "RECORD_UI")  then

		local _function = _wnd:GetScriptInstance( _function);
		gamefunc:SetAccountParam( _name, "function", _function);
	end
end


























-- Tray base script instance
luaTrayBase = {};





-- new
function luaTrayBase:new()

	inst = {};
    setmetatable( inst, self);
    self.__index = self;
    return inst;
end





-- OnInitialize
function luaTrayBase:OnInitialize( _wnd)
end





-- OnUpdate
function luaTrayBase:OnUpdate( _wnd)
end





-- OnDraw
function luaTrayBase:OnDraw( _wnd)
end





-- OnClick
function luaTrayBase:OnClick( _wnd)
end





-- OnRClick
function luaTrayBase:OnRClick( _wnd)

	OnTrayPopupMenu( _wnd);
end





-- OnHotKey
function luaTrayBase:OnHotKey( _wnd)
end





-- OnToolTip
function luaTrayBase:OnToolTip( _wnd)
end




-- OnEnter
function luaTrayBase:OnEnter( _wnd)
end




-- OnLeave
function luaTrayBase:OnLeave( _wnd)
end
