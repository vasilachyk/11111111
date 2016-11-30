-- 8898 변성체 10마리 -> 지그니프

function Field_8898:OnDie(DespawnInfo)
	if (DespawnInfo.NPCID == 8896031) and (this:GetNPCCount(8896031) == 0) then
		this:SpawnByID(1)
	end
end