-- 라드의 저택 옥상


function Field_520004:OnDie(DespawnInfo)

	local Field = DespawnInfo.Field	
	
	if (DespawnInfo.SpawnID == 1) then -- 옥상 라드 변성체 죽었을 때
		
		--local Door1 = Field:GetSpawnNPC(3)
		
		
		--Door1:UseTalentSelf( 212102201 )	-- 보스가 죽으면 문열기				
		--DespawnInfo.NPC:NarrationNow( "$$Field_520001_2"  ) -- 잠겨진 문이 열립니다
		
	end
	

end



