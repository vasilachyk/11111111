--[[
	Game player state viewer LUA script
--]]


-- Global instance
luaPlayerState = {};


-- Type of state
luaPlayerState.TYPE_STR = { "무기스왑 불가", "점프 불가", "이동 불가", "회피 불가" };
luaPlayerState.TYPE = { NONE = 0, SWAP = 1, JUMP = 2, MOVING = 3, DODGE = 4, END = 5 };





-- OnLoadedPlayerStateViewer
function luaPlayerState:OnLoadedPlayerStateViewer()

	luaPlayerState.State = {};
	luaPlayerState.State.timer = gamefunc:GetUpdateTime();
	for i = ( luaPlayerState.TYPE.NONE + 1), ( luaPlayerState.TYPE.END - 1)  do
	
		luaPlayerState.State[ i] = {};
		luaPlayerState.State[ i].name = luaPlayerState.TYPE_STR[ i];
		luaPlayerState.State[ i].enable = 1;
		luaPlayerState.State[ i].ratio = 0.0;
	end
end





-- OnUpdatePlayerStateViewer
function luaPlayerState:OnUpdatePlayerStateViewer()

	local nSwap, nJump, nMoving, nDodge = gamefunc:GetMyPlayerState();
	luaPlayerState.State[ luaPlayerState.TYPE.SWAP].enable = nSwap;
	luaPlayerState.State[ luaPlayerState.TYPE.JUMP].enable = nJump;
	luaPlayerState.State[ luaPlayerState.TYPE.MOVING].enable = nMoving;
	luaPlayerState.State[ luaPlayerState.TYPE.DODGE].enable = nDodge;
	
	
	local nElapsed = gamefunc:GetUpdateTime() - luaPlayerState.State.timer;
	if  ( nElapsed < 5)  then  return;
	end
	
	luaPlayerState.State.timer = gamefunc:GetUpdateTime();
	local fDelta = nElapsed * 0.005;
	
	for i = ( luaPlayerState.TYPE.NONE + 1), ( luaPlayerState.TYPE.END - 1)  do
	
		if ( luaPlayerState.State[ i].enable > 0)  then		luaPlayerState.State[ i].ratio = math.max( 0.0, luaPlayerState.State[ i].ratio - fDelta);
		else												luaPlayerState.State[ i].ratio = math.min( 1.0, luaPlayerState.State[ i].ratio + fDelta);
		end
	end
end





-- OnDrawPlayerStateViewer
function luaPlayerState:OnDrawPlayerStateViewer()

	local _opacity = gamedraw:GetOpacity();
	gamedraw:SetFont( "fntRegularStrong");
	gamedraw:SetColor( 255, 255, 255);
	gamedraw:SetTextAlign( "center", "top");

	local width, height = pnlPlayerState:GetSize();
	local w = 0.0;
	for i = ( luaPlayerState.TYPE.NONE + 1), ( luaPlayerState.TYPE.END - 1)  do  w = w + 80 * luaPlayerState.State[ i].ratio;
	end

	gamedraw:SetBitmap( "bmpGlowBar");
	gamedraw:SetOpacity( 0.7);
	gamedraw:Draw( ( width * 0.5) - w, 0, w * 2.0, height);

	local bBlankOpacity = _opacity * ( 0.7 + 0.3 * math.sin( gamefunc:GetUpdateTime() * 0.01));
	gamedraw:SetBitmap( "bmpPlayerState");

	local x = ( width - w) * 0.5;
	for i = ( luaPlayerState.TYPE.NONE + 1), ( luaPlayerState.TYPE.END - 1)  do
	
		if ( luaPlayerState.State[ i].ratio > 0.0)  then
		
			local _w = 80 * luaPlayerState.State[ i].ratio;
			local _x = x + ( _w - 80) * 0.5;
	
			gamedraw:SetOpacity( _opacity * luaPlayerState.State[ i].ratio);
			gamedraw:DrawEx( _x + 20, 15, 40, 40, 64 * i, 0, 64, 64);

			gamedraw:SetOpacity( _opacity * luaPlayerState.State[ i].ratio * bBlankOpacity);
			gamedraw:DrawEx( _x + 15, 10, 50, 50, 0, 0, 64, 64);

			gamedraw:SetOpacity( _opacity);
			gamedraw:TextEx( _x - 50, 60, 180, 20, luaPlayerState.State[ i].name);

			x = x + 80 * luaPlayerState.State[ i].ratio;
		end
	end
end
