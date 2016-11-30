-- 하피 아엘로

function NPC_7102194:OnDie(DespawnInfo)
-- 현재 GetKillerPlayer() 요 함수가 막타를 기준으로 되어있다.
-- 2012.06.14
	local Field = this:GetField();
	local QuestPVP = Field:GetQuestPVP()
	local killer = this:GetKillerPlayer()
	local QPVPTeam = killer:GetQPVPTeam()
	
	local trollBoss = Field:GetNPC(7102150)
	local ogreBoss = Field:GetNPC(7102151)
	
	this:NarrationNow("$$Field_102001_7")
	
	if (QPVPTeam == 1) then
		QuestPVP:GiveTeamBuff(1, 120068)
		
		-- 표시용 버프 건다.
		trollBoss:GainBuff(120081)
		
	elseif (QPVPTeam == 2) then
		QuestPVP:GiveTeamBuff(2, 120068)
		
		-- 표시용 버프 건다.
		ogreBoss:GainBuff(120081)
		
	end
end





