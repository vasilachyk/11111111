--[[
	Game BattleArea LUA script
--]]


-- Global instance
luaBattleArea = {};

function luaBattleArea:OnShow()
	--gamedebug:Log("luaBattleArea:OnShow()")

	pnBattleArenaScore:Show(true)
	luaBattleArea:OnSize()
end

function luaBattleArea:OnRefresh()
	--gamedebug:Log("luaBattleArea:OnRefresh()")
	
	local redscore, bluescore = gamefunc:GetCurrentBattleArenaScore()
	local str = string.format("%d : %d", redscore, bluescore)
	labBattleArenaScore:SetText(str)	
end

function luaBattleArea:OnHide()
	--gamedebug:Log("luaBattleArea:OnHide()")

	pnBattleArenaScore:Show(false)
end

function luaBattleArea:OnSize()
	--gamedebug:Log("luaBattleArea:OnSize()")

	local x,y = pnBattleArenaScore:GetPosition()
	x = (gamefunc:GetWindowWidth() - pnBattleArenaScore:GetWidth()) * 0.5;
    pnBattleArenaScore:SetPosition( x, y);
end