-- ·»°íÆ® ºÎ¶ô
function Field_110:OnSpawn(SpawnInfo)
	if (SpawnInfo.SpawnID == 67) or (SpawnInfo.SpawnID == 68) or (SpawnInfo.SpawnID == 77) then -- ·»°íÆ® ÇÏ±Þ ¼øÂû´ë
		
		SpawnInfo.NPC:Patrol({10,11,12,13,14,15,16,17,18}, PT_LOOP)
	elseif (SpawnInfo.SpawnID == 9004) then -- ·»°íÆ® ¼ö¼®³¬½Ã²Û1 ¼øÂû
		
		SpawnInfo.NPC:Patrol({28,20,21,22,23,24,25,26,27}, PT_LOOP_BACKORDER)
	elseif (SpawnInfo.SpawnID == 9005) then -- ·»°íÆ® ¼ö¼®³¬½Ã²Û2 ¼øÂû
		
		SpawnInfo.NPC:Patrol({27,26,25,24,23,22,21,20,28}, PT_LOOP_BACKORDER)	
	elseif (SpawnInfo.SpawnID == 616) or (SpawnInfo.SpawnID == 617) or (SpawnInfo.SpawnID == 618) or (SpawnInfo.SpawnID == 621) then -- ·»°íÆ® Á¤¿¹º´ ¼øÂû´ë
		
		SpawnInfo.NPC:Patrol({30,31,32,33,34,35,36,37,38,39}, PT_LOOP_BACKORDER)	
	elseif (SpawnInfo.SpawnID == 390) then -- ·»°íÆ® ¼ö¼®±¤ºÎ1 ¼øÂû
		
		SpawnInfo.NPC:Patrol({40,41,42,43,44}, PT_LOOP_BACKORDER)		
	elseif (SpawnInfo.SpawnID == 391) then -- ·»°íÆ® ¼ö¼®±¤ºÎ2 ¼øÂû
		
		SpawnInfo.NPC:Patrol({54,55,56,57}, PT_LOOP_BACKORDER)	
	elseif (SpawnInfo.SpawnID == 392) then -- ·»°íÆ® ¼ö¼®±¤ºÎ3 ¼øÂû
		
		SpawnInfo.NPC:Patrol({60,61,62,63,64}, PT_LOOP_BACKORDER)			
	elseif (SpawnInfo.SpawnID == 1300) then -- ·»°íÆ® »ç³É²Û1 ¼øÂû
		
		SpawnInfo.NPC:Patrol({13001,13002,13003,13004,13005}, PT_LOOP_BACKORDER)		
	elseif (SpawnInfo.SpawnID == 1301) then -- ·»°íÆ® »ç³É²Û2 ¼øÂû
		
		SpawnInfo.NPC:Patrol({13011,13012,13013,13014,13015,13016}, PT_LOOP_BACKORDER) -- ·»°íÆ® »ç³É²Û2 ¼øÂû
	elseif (SpawnInfo.SpawnID == 1302) then -- ·»°íÆ® »ç³É²Û3 ¼øÂû
		
		SpawnInfo.NPC:Patrol({13021,13022,13023,13024,13025}, PT_LOOP_BACKORDER)		
	elseif (SpawnInfo.SpawnID == 1303) then -- ·»°íÆ® »ç³É²Û4 ¼øÂû
		
		SpawnInfo.NPC:Patrol({13031,13032,13033,13034,13035,13036}, PT_LOOP_BACKORDER)		
	elseif (SpawnInfo.SpawnID == 1304) then -- ·»°íÆ® »ç³É²Û5 ¼øÂû
		
		SpawnInfo.NPC:Patrol({13041,13042,13043,13044}, PT_LOOP_BACKORDER)	
	elseif (SpawnInfo.SpawnID == 1305) then -- ·»°íÆ® »ç³É²Û6 ¼øÂû
		
		SpawnInfo.NPC:Patrol({13051,13052,13053,13054,13055}, PT_LOOP_BACKORDER)			
	elseif (SpawnInfo.SpawnID == 1306) then -- ·»°íÆ® »ç³É²Û7 ¼øÂû
		
		SpawnInfo.NPC:Patrol({13061,13062,13063,13064,13065,13066,13067,13068}, PT_LOOP)			
	elseif (SpawnInfo.SpawnID == 110223) then -- Á¤Âûº´ ¸°µ¥ÀÏ(Àº½Å)
		SpawnInfo.NPC:GainBuff(110110)	
	end
end
