
--Äù½ºÆ®: ½ÇÇè 104010 

function NPC_104113:OnSpawn(Spawn)

	-- this:DisableCombat()		
end


function NPC_104113:OnTryHit(Actor, TalentID)	
	if (TalentID == 140602) then	
		-- local Field = AsPlayer(Actor):GetField()
		this:GainBuff(40904)				
		this:Say("$$NPC_104113_001") 			--this:Say("Ä¼¾Ç!!") 			
		AsPlayer(Actor):UpdateQuestVar(104010, 1)		
		-- GLog("HIt!!")		
		this:Die(Actor)
		
	end
end
