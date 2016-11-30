-- 불의 정령 거점

function NPC_116611:OnDialogExit(Player, DialogID, Exit)
	if ((116611 == DialogID) and (1 == Exit)) then
		local ItemCount_01 = Player:GetItem(9990060)
		
		if (10 <= ItemCount_01) then
			local Field = Player:GetField()
			local SpawnPos = Player:GetPos()
			
			Field:Spawn( 116615, SpawnPos )
		else
			this:Balloon("뭐야 재료가 부족하잖아!")
		end
	end
end

