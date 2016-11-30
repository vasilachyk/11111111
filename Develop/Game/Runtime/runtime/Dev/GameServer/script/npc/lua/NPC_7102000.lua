-- 사나운 디아고

function NPC_7102000:OnDie(DespawnInfo)
-- 현재 GetKillerPlayer() 요 함수가 막타를 기준으로 되어있다.
-- 2012.06.14
	local Field = this:GetField();
	local QuestPVP = Field:GetQuestPVP()
	local killer = this:GetKillerPlayer()
	local QPVPTeam = killer:GetQPVPTeam()
	
	local trollTower = Field:GetNPC(7102195)
	local ogreTower = Field:GetNPC(7102197)
	local trollBoss = Field:GetNPC(7102150)
	local ogreBoss = Field:GetNPC(7102151)
	
	this:NarrationNow("$$Field_102001_9")
	
	if (QPVPTeam == 1) then
		QuestPVP:GiveTeamBuff(1, 120069)
		
		-- 거점 강화 버프를 건당
		trollTower:GainBuff(120079)
		trollBoss:GainBuff(120079)
		
		-- 거점 약화 버프를 건다
		ogreTower:GainBuff(120078)
		ogreBoss:GainBuff(120078)
		
	elseif (QPVPTeam == 2) then
		QuestPVP:GiveTeamBuff(2, 120069)
		
		-- 거점 강화 버프를 건당
		ogreTower:GainBuff(120079)
		ogreBoss:GainBuff(120079)
		
		-- 거점 약화 버프를 건다
		trollTower:GainBuff(120078)
		trollBoss:GainBuff(120078)
		
	end
end





