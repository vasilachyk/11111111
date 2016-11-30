--Äù½ºÆ®: ½ÇÇè 104010 
function NPC_104115:OnSpawn(Spawn)	
end


function NPC_104115:OnTryHit(Actor, TalentID)	
	if (TalentID == 140602) then	
		-- local Field = AsPlayer(Actor):GetField()				
		-- this:Say("Äí¿¢!!") 			
		this:GainBuff(40904)
		AsPlayer(Actor):UpdateQuestVar(104010,3)		
		GLog("HIt!!")		
		this:Die(Actor)
	end
end
