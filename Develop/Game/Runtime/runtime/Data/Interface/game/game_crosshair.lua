--[[
	Game crosshair LUA script
--]]


-- Global instance
luaCrossHair = {};


-- Variables

-- Cross Hair Start
function luaCrossHair:OnStart( nParam1, nParam2 )
	
	local _wnd = _G[ "picCrossHair" ];

	local strCrossHair = gamefunc:GetCurrentCrossHairName();
	if (strCrossHair == "") then
		_wnd:Show(false);
		return;
	end
	
	_wnd:SetImage( strCrossHair);
	_wnd:Show(true);
	
    luaCrossHair:Update( nParam1, nParam2 );
end

-- Cross Hair Pick
function luaCrossHair:OnPick( nParam1, nParam2 )

	local _wnd = _G[ "picCrossHair" ];
	
	local strCrossHairPick = gamefunc:GetCurrentCrossHairPickName();
	if (strCrossHairPick == "") then
		_wnd:Show(false);
		return;
	end
		
	_wnd:SetImage( strCrossHairPick);
	_wnd:Show(true);

	luaCrossHair:Update( nParam1, nParam2 );
end

-- Cross Hair Aways
function luaCrossHair:OnAways( nParam1, nParam2 )

	local _wnd = _G[ "picCrossHair" ];

	local strCrossHairAways = gamefunc:GetCurrentCrossHairAwaysName();
	if (strCrossHairAways == "") then
		_wnd:Show(false);
		return;
	end
		
	_wnd:SetImage( strCrossHairAways);
	_wnd:Show(true)
	
	luaCrossHair:Update( nParam1, nParam2 );
end

-- Cross Hair End
function luaCrossHair:OnEnd()

	picCrossHair:Show(false);

end


-- Cross Hair Update
function luaCrossHair:Update( nParam1, nParam2 )

	local _wnd = _G[ "picCrossHair" ];

	-- 사이즈 수정
	local nWidth = _wnd:GetImageWidth();
	local nHeight = _wnd:GetImageHeight();
	
	local nWidthHalf = nWidth / 2;
	local nHeightHalf = nHeight / 2;
	
	pnlCrossHair:SetSize(nWidth, nHeight);
	_wnd:SetSize(nWidth, nHeight);
	
	-- 위치 수정
    local x = ( nParam1 - nWidthHalf);
    local y = ( nParam2 - nHeightHalf);
    pnlCrossHair:SetPosition( x, y);
    
end