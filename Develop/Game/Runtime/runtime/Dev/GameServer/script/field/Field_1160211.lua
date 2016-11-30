-- 아란바스 화산지대 : 트라이얼 (불의 정령과의 회담)

function Field_1160211:OnSpawn(SpawnInfo) -- 하프메인 스폰시 설정
	if (SpawnInfo.NPCID == 116301) then		
		SpawnInfo.NPC:DisableInteraction()	
	end		
	if (SpawnInfo.NPCID == 116504) then		
		SpawnInfo.NPC:DisableInteraction()	
	end			
end

function Field_1160211:OnSensorEnter_1(Actor) -- 이동 시작 센서
	if (Actor:IsPlayer() == true) then
		this:DisableSensor(1)	
		
		local Halfmain = this:GetSpawnNPC(116504)
		local Gaf = this:GetSpawnNPC(116305)
		local Guard1 = this:GetSpawnNPC(102)
		local Guard2 = this:GetSpawnNPC(103)			
	
		local Session = this:MakeSession("Moving", {Halfmain, Gaf, Guard1, Guard2})
		Session:AddBookmark("Player", Actor)
	end
end

function Field_1160211:OnSessionScene_Moving_Begin(Session)
	local Halfmain = this:GetSpawnNPC(116504)
	local Gaf = this:GetSpawnNPC(116305)
	local Guard1 = this:GetSpawnNPC(102)
	local Guard2 = this:GetSpawnNPC(103)
	
	Session:Blocking()
		Halfmain:FaceTo(Session:FindBookmark("Player"))
		Halfmain:Say("{sound=scene13_halfmain_1}왔군. 이제 가볼까.",1.7)
		Halfmain:MoveToMarker(5041)
		Halfmain:Say("{sound=scene13_halfmain_2}난 드래곤 슬레이어 길드장인 하프메인이다.",3.5)
		Halfmain:Say("{sound=scene13_halfmain_3}그대들의 군주를 만나러 이곳에 왔다.",2.6)
		Gaf:Say("{sound=scene13_fire_1}그대들이 왜 이곳에 왔는지 알고 있다.")
		Gaf:Say("{sound=scene13_fire_2}나를 따라오라.")		
	Session:ChangeScene("Move")	
end

function Field_1160211:OnSessionScene_Moving_Move(Session)
	local Halfmain = this:GetSpawnNPC(116504)
	local Gaf = this:GetSpawnNPC(116305)
	local Guard1 = this:GetSpawnNPC(102)
	local Guard2 = this:GetSpawnNPC(103)
	
	Session:NonBlocking()
		Guard1:MoveToMarker(102)
		Guard2:MoveToMarker(103)
		Gaf:Patrol({351,352},PT_ONCE)
		Halfmain:MoveToMarker(5042)			
	Session:Blocking()		
		Gaf:FaceTo(Halfmain)
	Session:ChangeScene("End")	
end

function Field_1160211:OnSessionScene_Moving_End(Session)
	local Halfmain = this:GetSpawnNPC(116504)
	local Gaf = this:GetSpawnNPC(116305)
	
		Gaf:FaceTo(Halfmain)
		this:EnableSensor(2)
	Session:EndSession()
end

function Field_1160211:OnSensorEnter_2(Actor) -- 대화 시작 센서
	if (Actor:IsPlayer() == true) then
		this:DisableSensor(2)
		
		local Halfmain = this:GetSpawnNPC(116504)
		local Vulcan = this:GetSpawnNPC(116301)	
		local Gaf = this:GetSpawnNPC(116305)		
		local Session = this:MakeSession("Talking", {Halfmain, Vulcan, Gaf})
		Session:AddBookmark("Player", Actor)		
	end
end

function Field_1160211:OnSessionScene_Talking_Begin(Session)
	local Halfmain = this:GetSpawnNPC(116504)
	local Vulcan = this:GetSpawnNPC(116301)	
	local Gaf = this:GetSpawnNPC(116305)	
	
	Session:Blocking()
		Gaf:FaceTo(Halfmain)
		Halfmain:FaceTo(Vulcan)
		Halfmain:Say("{sound=scene13_halfmain_4}{ani=talk1}내가 여기 왜 왔는지 안다니, 얘기가 빠르겠군.", 3.3)
		Halfmain:Say("{sound=scene13_halfmain_5}{ani=point}아레크의 둥지 입구를 막고 있는 결계는 그대들이 만든 것이겠지?", 4.3)
		Halfmain:Say("{sound=scene13_halfmain_6}{ani=ignore}난 아란바스 화산지대를 더럽히는 아레크를 처치할 것이다. 당장 결계를 해체해 달라.", 6.1)
		Vulcan:Say("{sound=scene13_vulcan_1}그 결계는 아레크를 보호하기 위해 불의 군주께서 만드신 것이다.", 4.7)
		Vulcan:Say("{sound=scene13_vulcan_2}우리가 함부로 해제할 수 있는 것이 아니다.", 2.4)
		Halfmain:Say("{sound=scene13_halfmain_7}{ani=point}무슨 말을 하는 건가! 그 미친 용을 보호한다니 말도 안 되는 소리!", 4.5)
		Halfmain:Say("{sound=scene13_halfmain_8}{ani=negative}모두 오염에 정신이라도 나가기라도 했나?", 2.9)
		Halfmain:Say("{sound=scene13_halfmain_9}더 이상 아레크가 폭주하게 놔둬서는 안 돼! 당장 놈을 없애야 한단 말이다!", 5.0)
		Vulcan:Say("{sound=scene13_vulcan_3}인간이여. 아레크는 아르케나 에너지에 오염되어 미쳐버린 것이다.", 4.2)
		Vulcan:Say("{sound=scene13_vulcan_4}하지만 불의 군주께서 아레크를 치료할 방법을 찾아내시었다.", 3.8)
		Halfmain:Say("{sound=scene13_halfmain_10}오염에서 회복한다고?", 1.7)
		Halfmain:Say("{sound=scene13_halfmain_11}{ani=negative}그런 건 불가능해!", 1.4)
		Halfmain:Say("{sound=scene13_halfmain_12}그 괴물에게 주어져야 할 것은 오직 죽음뿐이야!", 3.7)		
		Vulcan:Say("{sound=scene13_vulcan_5}인간이여. 그대가 이곳에 왔을 때부터 마음 깊숙이 숨겨둔 강렬한 분노를 느낄 수 있었다.", 6.4)
		Vulcan:Say("{sound=scene13_vulcan_6}하지만 우리는 아레크를 보호해야만 한다. 안됐지만 그대가 원하는 결과는 오지 않을 것이다.", 6.1)
	Session:ChangeScene("End")	
end

function Field_1160211:OnSessionScene_Talking_End(Session)
		this:EnableSensor(116021)
	Session:EndSession()
end

function Field_1160211:OnSensorEnter_116021(Actor) -- 퀘스트 완료 센서
	if (Actor:IsPlayer() == true) then
		this:DisableSensor(116021)
		local Halfmain = this:GetSpawnNPC(116504)
		local Session = this:MakeSession("Return", {Halfmain})
		Session:AddBookmark("Player", Actor)
	end
end

function Field_1160211:OnSessionScene_Return_Begin(Session)
	local Halfmain = this:GetSpawnNPC(116504)
	
	Session:Blocking()
		Halfmain:Say("......")	
		Halfmain:FaceTo(Session:FindBookmark("Player"))
		Halfmain:Say("{sound=scene13_halfmain_13}젠장...... 시간만 낭비했군.", 2.5)
		Halfmain:EnableInteraction()
	Session:EndSession()
end

