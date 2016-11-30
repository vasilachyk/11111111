

function Field_5000:OnSensorEnter_2(Actor)
	local Player = AsPlayer(Actor);
	Player:GateToTrial(5001);
end

function Field_5000:OnSensorEnter_4(Actor)
	local NPC = AsNPC(Actor);
	if (5000111 == NPC:GetID()) then
		NPC:Say("$$Field_5000_9");
		this:SpawnDelay(5000112, vec3(24290, 2363, 3), 3);
		this:SpawnDelay(5000112, vec3(24635, 2333, 3), 3);
	end
end

function Field_5000:OnSensorEnter_5(Actor)
	local NPC = AsNPC(Actor);
	if (5000111 == NPC:GetID()) then
		NPC:Say("$$Field_5000_18");
		this:SpawnDelay(5000113, vec3(24664, 3702, 3), 3);
		this:SpawnDelay(5000113, vec3(24319, 3733, 3), 3);
	end
end

function Field_5000:OnSensorEnter_6(Actor)
	local NPC = AsNPC(Actor);
	if (5000111 == NPC:GetID()) then
		NPC:Say("$$Field_5000_27");
		NPC:Despawn(true);
	end
end

---퀘스트 센서 테스트--
function Field_5000:OnSensorEnter_117215(Actor)
	GLog("2".."/n");
	if (Actor:IsPlayer() == true) then
		AsPlayer(Actor):UpdateQuestVar(117001,1)		
		GLog("aaa".."/n");
		-- GetVar(117001)
	end
end

function Field_5000:OnSensorEnter_117216(Actor)
	GLog("3".."/n");
	if (Actor:IsPlayer() == true) then
		AsPlayer(Actor):UpdateQuestVar(117001,2)		
		GLog("bbb".."/n");
		-- GetVar(117001)
	end
end
 
 
 
 
 
 