-- 너도 나도 모두 속은 거야 -- 토템을 설치하면 생명의 전달자 스폰
function Quest_104025:OnObjComplete(Player, ObjectiveID)	
	if (ObjectiveID == 1) then		
		local Field = Player:GetField()				
		Field:EnableSensor(10402500)
	end
	
	if (ObjectiveID == 2) then		
		local Field = Player:GetField()
		
		Field:SpawnByID(104255) -- x50
		
		local x50 =  Field:GetSpawnNPC(104255)		
		local totem =  Field:GetSpawnNPC(104289)		
		
		totem:WaitFor(x50)
		x50:Say("$$Quest_104025_001",5)   --x50:Say("아아.. 여기가 어디죠? 난 아마도 아르케나 에너지에 중독 되어 있었나봐요.. 이런 일이.",5)
		x50:Say("$$Quest_104025_002",10)					 --x50:Say("내가 생명의 전달자에게 받은 영혼의 돌은 아마도 생명력을 빨아드리는 토템인 것 같아요.. 생명의 전달자가 생명 에너지를 빼앗기 위해서 우리 모두를 속인 것 같군요.",10)	
		x50:ScriptSelf("Field_104_Despawnx50")		
	end
end

function Field_104_Despawnx50(Self)
	Self:Despawn(false)
end

