-- 함정에 걸린 병사 (남)
function NPC_110218:OnSpawn(SpawnInfo)
	SpawnInfo.NPC:GainBuff(110000)
end
--[[
function NPC_110218:OnTryHit(Actor, TalentID)
	if (140001 == TalentID) then
		local Player = AsPlayer(Actor)
		if (this:CheckBuff(110000) == true) then
			this:FaceTo(Player)
			this:UseTalentSelf(211021801)
			Player:AddItem(10012, 1)
			this:RemoveBuff(110000)
			this:SetAlwaysRun(true)
			
			
			local dice = math.random(0,3)
			if( dice == 0) then 
				this:Balloon("$$NPC_110218_19")
			end
			if( dice == 1) then 
				this:Balloon("$$NPC_110218_22")
			end
			if( dice == 2) then 
				this:Balloon("$$NPC_110218_25")			
			end		
			if( dice == 2) then 
				this:Balloon("$$NPC_110218_28")
			end
			this:StayawayFrom(Player, 800)
			this:Despawn(true)
		end
	end
end
--]]