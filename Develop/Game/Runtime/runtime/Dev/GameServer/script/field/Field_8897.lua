-- 8897 오우거 10마리 -> 디아고

function Field_8897:OnDie(DespawnInfo)
	if (DespawnInfo.NPCID == 8896021) and (this:GetNPCCount(8896021) == 0) then
		this:SpawnByID(1)
	end
end