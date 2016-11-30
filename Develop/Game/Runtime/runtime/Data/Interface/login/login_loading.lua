--[[
	Login frame LUA script
--]]


-- Global instance
luaLoginLoding = {};
luaLoginLoding.MonsterMax	= 16;


-- OnLoadedpicLoginLoadingBase
function luaLoginLoding:OnLoadedpicLoginLoadingBase()
	
	-- 885, 821
	local logoX, logoY, logoW, logoH		= picLoginLoadingLogo:GetRect();
	
	local imgW, imgH;
	imgH	= gamefunc:GetWindowHeight() - 280;
	imgW	= ( imgH * 885 ) / 821;
	picLoginLoadingBase:SetSize( imgW, imgH );
	
	local x, y, w, h = picLoginLoadingBase:GetRect();
	local x = ( gamefunc:GetWindowWidth() - w ) * 0.5;
    picLoginLoadingBase:SetPosition( x, logoY+logoH);
	
end

-- OnLoadedpicLoginLoadingMonster
function luaLoginLoding:OnLoadedpicLoginLoadingMonster()
	
	local logoX, logoY, logoW, logoH		= picLoginLoadingLogo:GetRect();
	local imgW, imgH	= picLoginLoadingBase:GetSize();
    -- Moster size 320
    local monSizeH	= ( imgH * 320 )/ 821;
    local monSizeW	= ( imgH * 320 )/ 821;
    picLoginLoadingMonster:SetSize( monSizeW, monSizeH );
    
    local x2, y2, w2, h2 = picLoginLoadingMonster:GetRect();
	local x2 = ( gamefunc:GetWindowWidth() - w2 ) * 0.5;
	local y2 = ( imgH - h2 ) * 0.5;
    picLoginLoadingMonster:SetPosition( x2, logoY+logoH+y2 );
    
    local strImage	= gamefunc:GetLodingMonsterRandomImage( 1, luaLoginLoding.MonsterMax );
	picLoginLoadingMonster:SetImage( strImage );
	
end
