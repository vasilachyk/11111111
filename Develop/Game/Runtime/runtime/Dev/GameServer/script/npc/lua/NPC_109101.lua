-- 베일누스
--[[
function NPC_109101:OnTryHit(Actor, TalentID)
	if (Actor:IsPlayer() == true) then
		if (AsPlayer(Actor):CheckCondition(1090071) == true) then
			AsPlayer(Actor):UpdateQuestVar(109007, 3)
			AsPlayer(Actor):Tip("압도적인 힘 퀘스트를 완료하였습니다.")
		end
	end
end
--]]


