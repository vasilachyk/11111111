
-- 콘솔창에 ds call 입력하면 호출된다.
function test_handler(Actor)
	GLog("test_handler(Actor)")
	
	local Field = Actor:GetField()
	local fieldID = Field:GetID()
	
	if fieldID == 501001 or fieldID == 501101 then -- 성 파넬 수도원
		Field:ActivateSpawnGroup(200) -- 2번방 전쟁의회랑
		Field:ActivateSpawnGroup(300) -- 3번 전쟁의 예배당
		Field:ActivateSpawnGroup(400) -- 4번 지하대기소, 5번 치료대기실
		Field:ActivateSpawnGroup(600) -- 6번/7번 치료실	
		Field:ActivateSpawnGroup(800) -- 8번 제단, 9번 고문실
		Field:ActivateSpawnGroup(1000) -- 10번/11번 성기사생활관
		Field:ActivateSpawnGroup(1200) -- 12번 감옥
		Field:ActivateSpawnGroup(1300) -- 13번 기도실	
	
	elseif fieldID == 508001 then -- 레나스 신전
		Field:ActivateSpawnGroup(100) -- 1번방 입구
		Field:ActivateSpawnGroup(200) -- 2번방 예배소 계단
		Field:ActivateSpawnGroup(300) -- 3번방 레나스석상 예배소
		Field:ActivateSpawnGroup(400) -- 4번방 성스러운 연못
		Field:ActivateSpawnGroup(500) -- 5번방 동굴
		Field:ActivateSpawnGroup(600) -- 6번방 집회소 앞
		Field:ActivateSpawnGroup(700) -- 7번방 집회소 - 베이누스 방
	end -- if
end
