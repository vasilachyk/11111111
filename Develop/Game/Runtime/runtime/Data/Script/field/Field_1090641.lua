function Field_1090641:OnSensorEnter_2001(pActor)
	gamefunc:HelpTrigger(101); -- 이동	
end

function Field_1090641:OnSensorEnter_2002(pActor)
	gamefunc:HelpTrigger(102); -- NPC와 대화
end


function Field_1090641:OnSensorEnter_2004(pActor)
	gamefunc:HelpTrigger(103); -- 공격
	gamefunc:PlaySound("narration_kor_4");	
end

function Field_1090641:OnSensorEnter_2007(pActor)
	gamefunc:HelpTrigger(105); -- 무기 넣고 빼기
end

function Field_1090641:OnSensorEnter_2005(pActor)
	gamefunc:HelpTrigger(106); -- 마우스 포인터
end

function Field_1090641:OnSensorEnter_2006(pActor)
	gamefunc:HelpTrigger(107); -- 자동달리기
end

function Field_1090641:OnSensorEnter_2008(pActor)
	gamefunc:HelpTrigger(108); -- 퀘스트 표시
end

function Field_1090641:OnSensorEnter_2009(pActor)
	gamefunc:HelpTrigger(112); -- 회피
end

function Field_1090641:OnSensorEnter_2020(pActor)
	gamefunc:HelpTrigger(114); -- E키 획득 	
end

function Field_1090641:OnSensorEnter_2021(pActor)		
	gamefunc:HelpTrigger(113); -- 비파츠 콤보설명	
	
end