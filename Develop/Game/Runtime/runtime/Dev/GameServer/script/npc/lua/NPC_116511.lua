-- 하프메인 (아레크의 둥지:트라이얼 필드)

function NPC_116511:OnSpawn(SpawnInfo) -- 하프메인 스폰시 설정
	if (SpawnInfo.NPCID == 116511) then		
		SpawnInfo.NPC:GainBuff(110076)		
	end		
end

function NPC_116511:OnDialogExit(Player, DialogID, Exit)
	if (1160311 == DialogID) then	-- 공용 >>> 트라이얼 필드로
		if (1 == Exit) then
			Player:GateToTrial(1160310, true)
		end
	end
	if (1160312 == DialogID) then 	-- 트라이얼 >> 공용 필드로
		if (1 == Exit) then
			Player:GateToMarker(116004, 2)
		end
	end	
end