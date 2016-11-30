--[[
	Game GMTool LUA script
--]]


-- Global instance
luaGMTool = {};
luaGMTool.CATEGORY		= { GMT_NONE = 0, GMT_SEARCH = 1, GMT_SPAWN = 2, GMT_MOVEBATTLE = 3, GMT_CHAR = 4, GMT_BAN = 5, GMT_ETC = 6 };
luaGMTool.CurrCategory	= luaGMTool.CATEGORY.GMT_NONE;

-- OnShowGMToolFrame
function luaGMTool:OnShowGMToolFrame()

	-- Show
	if ( true == frmGMTool:GetShow() )		then
		
		luaGMTool:InitGMTool();
		
	-- Hide
	else
	
	end
	
	
	luaGame:ShowWindow( frmGMTool );
end

-- InitGMTool( 초기화 )
function luaGMTool:InitGMTool()
	
	luaGMTool:InitGMToolPos();
	
	luaGMTool:ChangeCategory( luaGMTool.CATEGORY.GMT_CHAR );
	
	-- 필요에 따라 열때마다 갱신이 필요한것들 처리
	luaGMChar:InitGMChar();
	
end

-- InitGMToolPos( GM Tool 위치 조정 )
function luaGMTool:InitGMToolPos()

	-- 해상도에 따른 창 가운데 위치 시키기
	local winWidth, winHeight		= gamefunc:GetWindowSize();
	local frameWidth, frameHeight	= frmGMTool:GetSize();
	local px, py					= frmGMTool:GetPosition();
	frmGMTool:SetPosition( ( ( winWidth - frameWidth ) * 0.5 ), ( winHeight - frameHeight ) * 0.1 );
	
	--gamedebug:Log( "luaGMTool:InitGMToolSize() WinSize" );
	
end

-- InitGMToolPos
function luaGMTool:ChangeCategory( nCategory )
	
	if( nCategory == luaGMTool.CurrCategory	)	then
		return ;
	end
		
	--gamedebug:Log( "luaGMTool:ChangeCategory() : " .. nCategory );

	luaGMTool:HideAllCategory();
	
	if( luaGMTool.CATEGORY.GMT_SEARCH == nCategory )				then
		luaGMSearch:ShowGMSearchTab();
	elseif( luaGMTool.CATEGORY.GMT_SPAWN == nCategory )				then
		luaGMSpawn:ShowGMSpawnTab();
	elseif( luaGMTool.CATEGORY.GMT_MOVEBATTLE == nCategory )		then
		luaGMMoveBattle:ShowGMMoveBattleTab();
	elseif( luaGMTool.CATEGORY.GMT_CHAR == nCategory )				then
		luaGMChar:ShowGMCharTab();
	elseif( luaGMTool.CATEGORY.GMT_BAN == nCategory )				then
		luaGMBan:ShowGMBanTab();
	elseif( luaGMTool.CATEGORY.GMT_ETC == nCategory )				then
		luaGMEtc:ShowGMEtcTab();
	else
		--gamedebug:Log( "luaGMTool:ChangeCategory() Category Error : " .. nCategory );
	end
		
	luaGMTool.CurrCategory	= nCategory;
	
end

-- HideAllCategory
function luaGMTool:HideAllCategory()
	
	luaGMSearch:HideGMSearchTab();
	luaGMSpawn:HideGMSpawnTab();
	luaGMMoveBattle:HideGMMoveBattleTab();
	luaGMChar:HideGMCharTab();
	luaGMBan:HideGMBanTab();
	luaGMEtc:HideGMEtcTab();
	
end