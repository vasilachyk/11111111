
--퀘스트: 실험 104010 

function NPC_104114:OnSpawn(Spawn)
end


function NPC_104114:OnTryHit(Actor, TalentID)	
	if (TalentID == 140602) then
		this:GainBuff(40904)		
		this:Say("$$NPC_104114_001") 			--this:Say("커억!!") 			
		AsPlayer(Actor):UpdateQuestVar(104010, 2)		
		-- GLog("HIt!!")
		this:Die(Actor)			
	end
end
