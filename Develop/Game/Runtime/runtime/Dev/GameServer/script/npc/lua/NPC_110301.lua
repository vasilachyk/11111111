-- 전투 지원 트라이얼 필드 : 상급기사 세네스
function NPC_110301:OnDialogExit(Player, DialogID, ExitID)
	if (1100002 == DialogID) and (1 == ExitID) then
		--GLog("what")		
		Player:GateToMarker(110, 118)
		--GLog("the")		
	end
end


-- 테레스 트라이얼 필드 : 상급기사 세네스  -- 원본
-- function NPC_110301:OnDialogExit(Player, DialogID, ExitID)
	-- if (1100001 == DialogID) and (1 == ExitID) then
		-- Player:GateToMarker(110, 118)
	-- end
-- end
