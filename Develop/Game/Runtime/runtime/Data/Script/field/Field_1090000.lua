g_TutorialField = {};
g_TutorialField.bLockedCamera = false;		-- 크라울러에게 카메라 락이 한번 되었었는지 여부, 두 번 이상 락이 안되도록 하기 위함

TutorialNarration = {};
TutorialNarration.Strings = {};
TutorialNarration.StringsFlag = {};

function TutorialNarration:Show(nStrIndex)
	if (TutorialNarration.StringsFlag[nStrIndex] == false) then
		TutorialNarration.StringsFlag[nStrIndex] = true;
		gamefunc:Narration(TutorialNarration.Strings[nStrIndex]);
	end
end

TutorialNarration.Strings[0] = "앞에 있는 부관 몬트리올과 대화를 하십시오.";
TutorialNarration.StringsFlag[0] = false;

TutorialNarration.Strings[1] = "멀리서 크라울러의 울음소리가 들려옵니다. 해안가를 따라 신속히 움직이세요.";
TutorialNarration.StringsFlag[1] = false;

TutorialNarration.Strings[2] = "모켄의 해적들을 해치우며 앞으로 전진하세요.";
TutorialNarration.StringsFlag[2] = false;

TutorialNarration.Strings[3] = "강력한 공격은 회피를 사용해서 피하세요.";
TutorialNarration.StringsFlag[3] = false;

-- 튜토리얼 필드에 입장시 시작할 때 밟고 시작
function Field_1090000:OnSensorEnter_23(pActor)
	gamefunc:HelpTrigger(101);		--          [튜토리얼 도움말] 이동, 시점
end

function Field_1090000:OnSensorEnter_3(pActor)
	gamefunc:HelpTrigger(102);		--			[튜토리얼 도움말] NPC 대화
end

function Field_1090000:OnSensorEnter_4(pActor)
	gamefunc:HelpTrigger(103);		--			[튜토리얼 도움말] 무기 뽑기
end

function Field_1090000:OnSensorEnter_5(pActor)
	gamefunc:HelpTrigger(104);		--			[튜토리얼 도움말] 기본 공격
end

function Field_1090000:OnSensorEnter_6(pActor)
	gamefunc:HelpTrigger(108);		--			[튜토리얼 도움말] 스킬
end

function Field_1090000:OnSensorEnter_7(pActor)
	gamefunc:HelpTrigger(106);		--			[튜토리얼 도움말] 회피
end

function Field_1090000:OnSensorEnter_8(pActor)
	gamefunc:HelpTrigger(107);		--			[튜토리얼 도움말] 막기
end

function Field_1090000:OnSensorEnter_24(pActor)
	gamefunc:HelpTrigger(114);		--			[튜토리얼 도움말] 크라울러 공격
end


-- 센서 : 크라울러 카메라 락
function Field_1090000:OnSensorEnter_101(pActor)
	if (g_TutorialField.bLockedCamera == false) then
		gamefunc:PlayBGM("bgm_war_10");
		gamefunc:LockCameraToNPC(109809, "", 3);
		g_TutorialField.bLockedCamera = true;
	end
end