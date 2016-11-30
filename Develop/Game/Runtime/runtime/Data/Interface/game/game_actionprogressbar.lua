--[[
	Game action progressbar LUA script
--]]


-- Global instance
luaActionProgressBar = {};


-- Update timer
luaActionProgressBar.m_fUpdateTimer = 0;

-- Auto End
luaActionProgressBar.m_bAutoEnd = true;





-- BeginActionProgressBar
function luaActionProgressBar:BeginActionProgressBar( strActionName, nArrivalTime)

	lbActionProgressMsg:SetText( strActionName);
	
	pcActionProgressBar:SetRange( 0, nArrivalTime);
	pcActionProgressBar:SetPos( 0);

	frmActionProgressBar:Show( true);


	luaActionProgressBar.m_fUpdateTimer = gamefunc:GetUpdateTime();
	luaActionProgressBar.m_bAutoEnd = true;
end





-- EndActionProgressBar
function luaActionProgressBar:EndActionProgressBar()

	frmActionProgressBar:Show( false);
end





-- OnUpdateActionProgressBar
function luaActionProgressBar:OnUpdateActionProgressBar()

	local fElapsed = gamefunc:GetUpdateTime() - luaActionProgressBar.m_fUpdateTimer;
	pcActionProgressBar:SetPos( fElapsed);
	
	local _min, _max = pcActionProgressBar:GetRange();	
	
	if(luaActionProgressBar.m_bAutoEnd) then
		if ( (fElapsed - _max) > 1000)  then  frmActionProgressBar:Show( false);
		end	
	end
end





-- OnPositionActionProgressBar
function luaActionProgressBar:OnPositionActionProgressBar()

	local x, y = frmActionProgressBar:GetPosition();
	x = ( gamefunc:GetWindowWidth() - frmActionProgressBar:GetWidth()) * 0.5;
	frmActionProgressBar:SetPosition( x, y);
end


-- OnAutoEndDiable
function luaActionProgressBar:OnAutoEndDiable()
	luaActionProgressBar.m_bAutoEnd = false;
end