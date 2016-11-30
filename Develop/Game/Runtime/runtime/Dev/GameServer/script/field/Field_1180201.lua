F_D_1180201_VarNPCID = 200  -- 상수처리용NPC아이디





F_D_1180201 = {{{}}}; F_D_1180201 =Init_3DArray(F_D_1180201,99,99,99)
  --배열초기화(x=스테이지, y=단계, z= 구문)
F_D_1180201_BoolEnd = 3  -- 마지막스테이지인지?
F_D_1180201_StackTID = 4  -- 킬타이머스폰정보
F_D_1180201_WSpawnID = 5  -- 투명벽시작스폰아이디/남길벽정보
F_D_1180201_WNPCID = 6  -- 투명벽NPC아이디
F_D_1180201_WQ = 7  -- 투명벽최대수량
F_D_1180201_Msg1 = 8  -- 게임 오버 메시지 
F_D_1180201_Msg6 = 9  -- 단계별 전환시 메시지
F_D_1180201_TimerID = 10  -- 단계별타이머ID
F_D_1180201_LT_Mpos = 11  -- 라이프시작지점
F_D_1180201_LE_Mpos = 12  -- 리더시작지점
F_D_1180201_LastEPM_TimerID = 13  -- 마지막보스출현단계
F_D_1180201_KM_NPCID = 14  -- 모두디스폰할NPC아이디
F_D_1180201_KM_TimerID = 15  -- 몬스터NPC사망타이머ID
F_D_1180201_ADD_LT_NPCID = 16  -- 보너스생명력NPC아이디
F_D_1180201_ADD_LT_SpawnID = 17  -- 보너스생명력스폰아이디
F_D_1180201_RW_NPCID = 18  -- 보상NPC아이디
F_D_1180201_RW_SpawnID = 19  -- 보상스폰아이디
F_D_1180201_LE_SpawnID = 20  -- _씬시작연출NPC스폰아이디
F_D_1180201_LT_NPCID = 21  -- 생명력NPC아이디
F_D_1180201_LT_SpawnID = 22  -- 생명력스폰아이디
F_D_1180201_IS_ID = 23  -- 스테이지체크센서
F_D_1180201_Msg4 = 24  -- 에픽몬스터 출현 메시지
F_D_1180201_LMMID = 25  -- 완료시라이프이동마커시작ID
F_D_1180201_NS_ID = 26  -- 완료이동센서ID
F_D_1180201_NS_Time = 27  -- 완료이동센서딜레이시간
F_D_1180201_LMMQ = 28  -- 이동마커수량
F_D_1180201_Msg5 = 29  -- 인카운터 몬스터 출현 메시지
F_D_1180201_LT_Q = 30  -- 최초생명력개수
F_D_1180201_Msg2 = 31  -- 클리어 메시지
F_D_1180201_Msg3 = 32  -- 한명씩 사망 메시지





F_D_1180201[1][1][F_D_1180201_BoolEnd] = {"false"}  -- 마지막스테이지인지?
F_D_1180201[1][1][F_D_1180201_StackTID] = {101000,102000,103000,101100,102100,103100}  -- 킬타이머스폰정보
F_D_1180201[1][1][F_D_1180201_WSpawnID] = {1028300}  -- 투명벽시작스폰아이디/남길벽정보
F_D_1180201[1][1][F_D_1180201_WNPCID] = {283}  -- 투명벽NPC아이디
F_D_1180201[1][1][F_D_1180201_WQ] = {10}  -- 투명벽최대수량
F_D_1180201[1][1][F_D_1180201_Msg1] = {"안타깝지만 조사대원이 모두 사망하였습니다"}  -- 게임 오버 메시지 
F_D_1180201[1][1][F_D_1180201_Msg6] = {"주변 수풀에서 심상치 않은 기척이 들려옵니다. 조심하십시오","끈적한 벌레 냄새가 더욱 풍기고 있습니다","작업이 얼마 남지 않았습니다","땅끝을 울리는 강한 진동이 느껴집니다"}  -- 단계별 전환시 메시지
F_D_1180201[1][1][F_D_1180201_TimerID] = {30}  -- 단계별타이머ID
F_D_1180201[1][1][F_D_1180201_LT_Mpos] = {90110000}  -- 라이프시작지점
F_D_1180201[1][1][F_D_1180201_LE_Mpos] = {80110000}  -- 리더시작지점
F_D_1180201[1][1][F_D_1180201_LastEPM_TimerID] = {5}  -- 마지막보스출현단계
F_D_1180201[1][1][F_D_1180201_KM_NPCID] = {118510, 118600, 118601}  -- 모두디스폰할NPC아이디
F_D_1180201[1][1][F_D_1180201_KM_TimerID] = {9999}  -- 몬스터NPC사망타이머ID
F_D_1180201[1][1][F_D_1180201_ADD_LT_NPCID] = {118403}  -- 보너스생명력NPC아이디
F_D_1180201[1][1][F_D_1180201_ADD_LT_SpawnID] = {200}  -- 보너스생명력스폰아이디
F_D_1180201[1][1][F_D_1180201_RW_NPCID] = {118498}  -- 보상NPC아이디
F_D_1180201[1][1][F_D_1180201_RW_SpawnID] = {10700}  -- 보상스폰아이디
F_D_1180201[1][1][F_D_1180201_LE_SpawnID] = {200}  -- _씬시작연출NPC스폰아이디
F_D_1180201[1][1][F_D_1180201_LT_NPCID] = {118403}  -- 생명력NPC아이디
F_D_1180201[1][1][F_D_1180201_LT_SpawnID] = {100}  -- 생명력스폰아이디
F_D_1180201[1][1][F_D_1180201_IS_ID] = {10}  -- 스테이지체크센서
F_D_1180201[1][1][F_D_1180201_Msg4] = {"강한 진동이 느껴집니다!"}  -- 에픽몬스터 출현 메시지
F_D_1180201[1][1][F_D_1180201_LMMID] = {1010000}  -- 완료시라이프이동마커시작ID
F_D_1180201[1][1][F_D_1180201_NS_ID] = {999999}  -- 완료이동센서ID
F_D_1180201[1][1][F_D_1180201_NS_Time] = {20}  -- 완료이동센서딜레이시간
F_D_1180201[1][1][F_D_1180201_LMMQ] = {5}  -- 이동마커수량
F_D_1180201[1][1][F_D_1180201_Msg5] = {""}  -- 인카운터 몬스터 출현 메시지
F_D_1180201[1][1][F_D_1180201_LT_Q] = {4}  -- 최초생명력개수
F_D_1180201[1][1][F_D_1180201_Msg2] = {"조사작업을 무사히 마쳤습니다"}  -- 클리어 메시지
F_D_1180201[1][1][F_D_1180201_Msg3] = {"조사대원이 ", "명 남았습니다"}  -- 한명씩 사망 메시지
F_D_1180201[2][1][F_D_1180201_BoolEnd] = {"false"}  -- 마지막스테이지인지?
F_D_1180201[2][1][F_D_1180201_StackTID] = {201000,202000,201100,202100,203000}  -- 킬타이머스폰정보
F_D_1180201[2][1][F_D_1180201_WSpawnID] = {2028300}  -- 투명벽시작스폰아이디/남길벽정보
F_D_1180201[2][1][F_D_1180201_WNPCID] = {283}  -- 투명벽NPC아이디
F_D_1180201[2][1][F_D_1180201_WQ] = {10}  -- 투명벽최대수량
F_D_1180201[2][1][F_D_1180201_Msg1] = {"안타깝지만 조사대원이 모두 사망하였습니다"}  -- 게임 오버 메시지 
F_D_1180201[2][1][F_D_1180201_Msg6] = {"숲 속의 분위기가 심상치 않습니다","끈적한 벌레 냄새가 더욱 풍기고 있습니다","작업이 얼마 남지 않았습니다","땅끝을 울리는 강한 진동이 느껴집니다"}  -- 단계별 전환시 메시지
F_D_1180201[2][1][F_D_1180201_TimerID] = {30}  -- 단계별타이머ID
F_D_1180201[2][1][F_D_1180201_LT_Mpos] = {90210000}  -- 라이프시작지점
F_D_1180201[2][1][F_D_1180201_LE_Mpos] = {80220000}  -- 리더시작지점
F_D_1180201[2][1][F_D_1180201_LastEPM_TimerID] = {5}  -- 마지막보스출현단계
F_D_1180201[2][1][F_D_1180201_KM_NPCID] = {118520,118620,118621,118622}  -- 모두디스폰할NPC아이디
F_D_1180201[2][1][F_D_1180201_KM_TimerID] = {9999}  -- 몬스터NPC사망타이머ID
F_D_1180201[2][1][F_D_1180201_ADD_LT_NPCID] = {118403}  -- 보너스생명력NPC아이디
F_D_1180201[2][1][F_D_1180201_ADD_LT_SpawnID] = {200}  -- 보너스생명력스폰아이디
F_D_1180201[2][1][F_D_1180201_RW_NPCID] = {118497}  -- 보상NPC아이디
F_D_1180201[2][1][F_D_1180201_RW_SpawnID] = {10701}  -- 보상스폰아이디
F_D_1180201[2][1][F_D_1180201_LE_SpawnID] = {200}  -- _씬시작연출NPC스폰아이디
F_D_1180201[2][1][F_D_1180201_LT_NPCID] = {118403}  -- 생명력NPC아이디
F_D_1180201[2][1][F_D_1180201_LT_SpawnID] = {100}  -- 생명력스폰아이디
F_D_1180201[2][1][F_D_1180201_IS_ID] = {20}  -- 스테이지체크센서
F_D_1180201[2][1][F_D_1180201_Msg4] = {"강한 진동이 느껴집니다!"}  -- 에픽몬스터 출현 메시지
F_D_1180201[2][1][F_D_1180201_LMMID] = {2010000}  -- 완료시라이프이동마커시작ID
F_D_1180201[2][1][F_D_1180201_NS_ID] = {999999}  -- 완료이동센서ID
F_D_1180201[2][1][F_D_1180201_NS_Time] = {20}  -- 완료이동센서딜레이시간
F_D_1180201[2][1][F_D_1180201_LMMQ] = {4}  -- 이동마커수량
F_D_1180201[2][1][F_D_1180201_Msg5] = {""}  -- 인카운터 몬스터 출현 메시지
F_D_1180201[2][1][F_D_1180201_LT_Q] = {4}  -- 최초생명력개수
F_D_1180201[2][1][F_D_1180201_Msg2] = {"조사작업을 무사히 마쳤습니다"}  -- 클리어 메시지
F_D_1180201[2][1][F_D_1180201_Msg3] = {"조사대원이 ", "명 남았습니다"}  -- 한명씩 사망 메시지
F_D_1180201[3][1][F_D_1180201_BoolEnd] = {"true"}  -- 마지막스테이지인지?
F_D_1180201[3][1][F_D_1180201_StackTID] = {301000,302000,303000}  -- 킬타이머스폰정보
F_D_1180201[3][1][F_D_1180201_WSpawnID] = {3028300}  -- 투명벽시작스폰아이디/남길벽정보
F_D_1180201[3][1][F_D_1180201_WNPCID] = {283}  -- 투명벽NPC아이디
F_D_1180201[3][1][F_D_1180201_WQ] = {10}  -- 투명벽최대수량
F_D_1180201[3][1][F_D_1180201_Msg1] = {"안타깝지만 조사대원이 모두 사망하였습니다"}  -- 게임 오버 메시지 
F_D_1180201[3][1][F_D_1180201_Msg6] = {"숲 속의 분위기가 심상치 않습니다","끈적한 벌레 냄새가 더욱 풍기고 있습니다","작업이 얼마 남지 않았습니다","땅끝을 울리는 강한 진동이 느껴집니다"}  -- 단계별 전환시 메시지
F_D_1180201[3][1][F_D_1180201_TimerID] = {30}  -- 단계별타이머ID
F_D_1180201[3][1][F_D_1180201_LT_Mpos] = {90310000}  -- 라이프시작지점
F_D_1180201[3][1][F_D_1180201_LE_Mpos] = {80320000}  -- 리더시작지점
F_D_1180201[3][1][F_D_1180201_LastEPM_TimerID] = {3}  -- 마지막보스출현단계
F_D_1180201[3][1][F_D_1180201_KM_NPCID] = {118501,118640}  -- 모두디스폰할NPC아이디
F_D_1180201[3][1][F_D_1180201_KM_TimerID] = {9999}  -- 몬스터NPC사망타이머ID
F_D_1180201[3][1][F_D_1180201_ADD_LT_NPCID] = {118403}  -- 보너스생명력NPC아이디
F_D_1180201[3][1][F_D_1180201_ADD_LT_SpawnID] = {200}  -- 보너스생명력스폰아이디
F_D_1180201[3][1][F_D_1180201_RW_NPCID] = {118496}  -- 보상NPC아이디
F_D_1180201[3][1][F_D_1180201_RW_SpawnID] = {10702}  -- 보상스폰아이디
F_D_1180201[3][1][F_D_1180201_LE_SpawnID] = {200}  -- _씬시작연출NPC스폰아이디
F_D_1180201[3][1][F_D_1180201_LT_NPCID] = {118403}  -- 생명력NPC아이디
F_D_1180201[3][1][F_D_1180201_LT_SpawnID] = {100}  -- 생명력스폰아이디
F_D_1180201[3][1][F_D_1180201_IS_ID] = {30}  -- 스테이지체크센서
F_D_1180201[3][1][F_D_1180201_Msg4] = {"강한 진동이 느껴집니다!"}  -- 에픽몬스터 출현 메시지
F_D_1180201[3][1][F_D_1180201_LMMID] = {3010000}  -- 완료시라이프이동마커시작ID
F_D_1180201[3][1][F_D_1180201_NS_ID] = {999999}  -- 완료이동센서ID
F_D_1180201[3][1][F_D_1180201_NS_Time] = {20}  -- 완료이동센서딜레이시간
F_D_1180201[3][1][F_D_1180201_LMMQ] = {12}  -- 이동마커수량
F_D_1180201[3][1][F_D_1180201_Msg5] = {""}  -- 인카운터 몬스터 출현 메시지
F_D_1180201[3][1][F_D_1180201_LT_Q] = {4}  -- 최초생명력개수
F_D_1180201[3][1][F_D_1180201_Msg2] = {"조사작업을 무사히 마쳤습니다"}  -- 클리어 메시지
F_D_1180201[3][1][F_D_1180201_Msg3] = {"조사대원이 ", "명 남았습니다"}  -- 한명씩 사망 메시지



F_D_1180201_ChangeTime = 33  -- 단계전환까지남은시간
F_D_1180201_ENM_NPCID = 34  -- 인카운터몬스터NPC아이디
F_D_1180201_ENM_SpawnID = 35  -- 인카운터몬스터스폰아이디
F_D_1180201_ENM_SQ = 36  -- 인카운터몬스터스폰개수
F_D_1180201_ENM_Stime = 37  -- 단계별인카운터몬스터기준스폰시간
F_D_1180201_ENM_DMintime = 38  -- 인카운터몬스터반복딜레이최소시간
F_D_1180201_ENM_DMaxtime = 39  -- 인카운터몬스터반복딜레이최대시간
F_D_1180201_EPM_NPCID = 40  -- 에픽몬스터NPC아이디
F_D_1180201_EPM_SpawnID = 41  -- 에픽몬스터스폰아이디
F_D_1180201_EPM_SQ = 42  -- 에픽몬스터스폰개수
F_D_1180201_EPM_Stime = 43  -- 단계별에픽몬스터반복스폰시간
F_D_1180201_EPM_DMintime = 44  -- 에픽몬스터반복딜레이최소시간
F_D_1180201_EPM_DMaxtime = 45  -- 에픽몬스터반복딜레이최대시간
F_D_1180201_NM_NPCID = 46  -- 일반몬스터NPC아이디
F_D_1180201_NM_SpawnID = 47  -- 일반몬스터스폰아이디(루트1,루트2…)
F_D_1180201_NM_SQ = 48  -- 일반몬스터스폰개수
F_D_1180201_NM_Stime = 49  -- 일반몬스터반복스폰시간
F_D_1180201_NM_DMintime = 50  -- 일반몬스터반복딜레이최소시간
F_D_1180201_NM_DMaxtime = 51  -- 일반몬스터반복딜레이최대시간


F_D_1180201[1][2][F_D_1180201_ChangeTime] = {30}  -- 단계전환까지남은시간
F_D_1180201[1][2][F_D_1180201_ENM_NPCID] = {0}  -- 인카운터몬스터NPC아이디
F_D_1180201[1][2][F_D_1180201_ENM_SpawnID] = {0}  -- 인카운터몬스터스폰아이디
F_D_1180201[1][2][F_D_1180201_ENM_SQ] = {0}  -- 인카운터몬스터스폰개수
F_D_1180201[1][2][F_D_1180201_ENM_Stime] = {0}  -- 단계별인카운터몬스터기준스폰시간
F_D_1180201[1][2][F_D_1180201_ENM_DMintime] = {0}  -- 인카운터몬스터반복딜레이최소시간
F_D_1180201[1][2][F_D_1180201_ENM_DMaxtime] = {0}  -- 인카운터몬스터반복딜레이최대시간
F_D_1180201[1][2][F_D_1180201_EPM_NPCID] = {118510}  -- 에픽몬스터NPC아이디
F_D_1180201[1][2][F_D_1180201_EPM_SpawnID] = {10109000}  -- 에픽몬스터스폰아이디
F_D_1180201[1][2][F_D_1180201_EPM_SQ] = {1}  -- 에픽몬스터스폰개수
F_D_1180201[1][2][F_D_1180201_EPM_Stime] = {1}  -- 단계별에픽몬스터반복스폰시간
F_D_1180201[1][2][F_D_1180201_EPM_DMintime] = {0}  -- 에픽몬스터반복딜레이최소시간
F_D_1180201[1][2][F_D_1180201_EPM_DMaxtime] = {0}  -- 에픽몬스터반복딜레이최대시간
F_D_1180201[1][2][F_D_1180201_NM_NPCID] = {118600,118600,118600}  -- 일반몬스터NPC아이디
F_D_1180201[1][2][F_D_1180201_NM_SpawnID] = {101000,102000,103000}  -- 일반몬스터스폰아이디(루트1,루트2…)
F_D_1180201[1][2][F_D_1180201_NM_SQ] = {5,5,5}  -- 일반몬스터스폰개수
F_D_1180201[1][2][F_D_1180201_NM_Stime] = {10,10,10}  -- 일반몬스터반복스폰시간
F_D_1180201[1][2][F_D_1180201_NM_DMintime] = {0,0,0}  -- 일반몬스터반복딜레이최소시간
F_D_1180201[1][2][F_D_1180201_NM_DMaxtime] = {0,0,0}  -- 일반몬스터반복딜레이최대시간
F_D_1180201[1][3][F_D_1180201_ChangeTime] = {90}  -- 단계전환까지남은시간
F_D_1180201[1][3][F_D_1180201_ENM_NPCID] = {0}  -- 인카운터몬스터NPC아이디
F_D_1180201[1][3][F_D_1180201_ENM_SpawnID] = {0}  -- 인카운터몬스터스폰아이디
F_D_1180201[1][3][F_D_1180201_ENM_SQ] = {0}  -- 인카운터몬스터스폰개수
F_D_1180201[1][3][F_D_1180201_ENM_Stime] = {0}  -- 단계별인카운터몬스터기준스폰시간
F_D_1180201[1][3][F_D_1180201_ENM_DMintime] = {0}  -- 인카운터몬스터반복딜레이최소시간
F_D_1180201[1][3][F_D_1180201_ENM_DMaxtime] = {0}  -- 인카운터몬스터반복딜레이최대시간
F_D_1180201[1][3][F_D_1180201_EPM_NPCID] = {118510}  -- 에픽몬스터NPC아이디
F_D_1180201[1][3][F_D_1180201_EPM_SpawnID] = {10109000}  -- 에픽몬스터스폰아이디
F_D_1180201[1][3][F_D_1180201_EPM_SQ] = {1}  -- 에픽몬스터스폰개수
F_D_1180201[1][3][F_D_1180201_EPM_Stime] = {1}  -- 단계별에픽몬스터반복스폰시간
F_D_1180201[1][3][F_D_1180201_EPM_DMintime] = {0}  -- 에픽몬스터반복딜레이최소시간
F_D_1180201[1][3][F_D_1180201_EPM_DMaxtime] = {0}  -- 에픽몬스터반복딜레이최대시간
F_D_1180201[1][3][F_D_1180201_NM_NPCID] = {118600,118600,118600}  -- 일반몬스터NPC아이디
F_D_1180201[1][3][F_D_1180201_NM_SpawnID] = {101000,102000,103000}  -- 일반몬스터스폰아이디(루트1,루트2…)
F_D_1180201[1][3][F_D_1180201_NM_SQ] = {6,6,6}  -- 일반몬스터스폰개수
F_D_1180201[1][3][F_D_1180201_NM_Stime] = {15,15,15}  -- 일반몬스터반복스폰시간
F_D_1180201[1][3][F_D_1180201_NM_DMintime] = {0,0,0,0}  -- 일반몬스터반복딜레이최소시간
F_D_1180201[1][3][F_D_1180201_NM_DMaxtime] = {0,0,0,0}  -- 일반몬스터반복딜레이최대시간
F_D_1180201[1][4][F_D_1180201_ChangeTime] = {180}  -- 단계전환까지남은시간
F_D_1180201[1][4][F_D_1180201_ENM_NPCID] = {0}  -- 인카운터몬스터NPC아이디
F_D_1180201[1][4][F_D_1180201_ENM_SpawnID] = {0}  -- 인카운터몬스터스폰아이디
F_D_1180201[1][4][F_D_1180201_ENM_SQ] = {0}  -- 인카운터몬스터스폰개수
F_D_1180201[1][4][F_D_1180201_ENM_Stime] = {0}  -- 단계별인카운터몬스터기준스폰시간
F_D_1180201[1][4][F_D_1180201_ENM_DMintime] = {0}  -- 인카운터몬스터반복딜레이최소시간
F_D_1180201[1][4][F_D_1180201_ENM_DMaxtime] = {0}  -- 인카운터몬스터반복딜레이최대시간
F_D_1180201[1][4][F_D_1180201_EPM_NPCID] = {118510}  -- 에픽몬스터NPC아이디
F_D_1180201[1][4][F_D_1180201_EPM_SpawnID] = {10109000}  -- 에픽몬스터스폰아이디
F_D_1180201[1][4][F_D_1180201_EPM_SQ] = {1}  -- 에픽몬스터스폰개수
F_D_1180201[1][4][F_D_1180201_EPM_Stime] = {1}  -- 단계별에픽몬스터반복스폰시간
F_D_1180201[1][4][F_D_1180201_EPM_DMintime] = {0}  -- 에픽몬스터반복딜레이최소시간
F_D_1180201[1][4][F_D_1180201_EPM_DMaxtime] = {0}  -- 에픽몬스터반복딜레이최대시간
F_D_1180201[1][4][F_D_1180201_NM_NPCID] = {118600,118600,118600,118601}  -- 일반몬스터NPC아이디
F_D_1180201[1][4][F_D_1180201_NM_SpawnID] = {101000,102000,103000,102100}  -- 일반몬스터스폰아이디(루트1,루트2…)
F_D_1180201[1][4][F_D_1180201_NM_SQ] = {8,8,8,1}  -- 일반몬스터스폰개수
F_D_1180201[1][4][F_D_1180201_NM_Stime] = {15,15,15,10}  -- 일반몬스터반복스폰시간
F_D_1180201[1][4][F_D_1180201_NM_DMintime] = {0,0,0,0,0,10}  -- 일반몬스터반복딜레이최소시간
F_D_1180201[1][4][F_D_1180201_NM_DMaxtime] = {0,0,0,20}  -- 일반몬스터반복딜레이최대시간
F_D_1180201[1][5][F_D_1180201_ChangeTime] = {180}  -- 단계전환까지남은시간
F_D_1180201[1][5][F_D_1180201_ENM_NPCID] = {0}  -- 인카운터몬스터NPC아이디
F_D_1180201[1][5][F_D_1180201_ENM_SpawnID] = {0}  -- 인카운터몬스터스폰아이디
F_D_1180201[1][5][F_D_1180201_ENM_SQ] = {0}  -- 인카운터몬스터스폰개수
F_D_1180201[1][5][F_D_1180201_ENM_Stime] = {0}  -- 단계별인카운터몬스터기준스폰시간
F_D_1180201[1][5][F_D_1180201_ENM_DMintime] = {0}  -- 인카운터몬스터반복딜레이최소시간
F_D_1180201[1][5][F_D_1180201_ENM_DMaxtime] = {0}  -- 인카운터몬스터반복딜레이최대시간
F_D_1180201[1][5][F_D_1180201_EPM_NPCID] = {118510}  -- 에픽몬스터NPC아이디
F_D_1180201[1][5][F_D_1180201_EPM_SpawnID] = {10109000}  -- 에픽몬스터스폰아이디
F_D_1180201[1][5][F_D_1180201_EPM_SQ] = {1}  -- 에픽몬스터스폰개수
F_D_1180201[1][5][F_D_1180201_EPM_Stime] = {1}  -- 단계별에픽몬스터반복스폰시간
F_D_1180201[1][5][F_D_1180201_EPM_DMintime] = {0}  -- 에픽몬스터반복딜레이최소시간
F_D_1180201[1][5][F_D_1180201_EPM_DMaxtime] = {0}  -- 에픽몬스터반복딜레이최대시간
F_D_1180201[1][5][F_D_1180201_NM_NPCID] = {118600,118600,118600,118601,118601,118601}  -- 일반몬스터NPC아이디
F_D_1180201[1][5][F_D_1180201_NM_SpawnID] = {101000,102000,103000,101100,102100,103100}  -- 일반몬스터스폰아이디(루트1,루트2…)
F_D_1180201[1][5][F_D_1180201_NM_SQ] = {7,7,7,1,1,1}  -- 일반몬스터스폰개수
F_D_1180201[1][5][F_D_1180201_NM_Stime] = {20,20,20,20,20,20}  -- 일반몬스터반복스폰시간
F_D_1180201[1][5][F_D_1180201_NM_DMintime] = {0,0,0,10,10,10}  -- 일반몬스터반복딜레이최소시간
F_D_1180201[1][5][F_D_1180201_NM_DMaxtime] = {5,5,5,15,15,15}  -- 일반몬스터반복딜레이최대시간
F_D_1180201[2][2][F_D_1180201_ChangeTime] = {30}  -- 단계전환까지남은시간
F_D_1180201[2][2][F_D_1180201_ENM_NPCID] = {0}  -- 인카운터몬스터NPC아이디
F_D_1180201[2][2][F_D_1180201_ENM_SpawnID] = {0}  -- 인카운터몬스터스폰아이디
F_D_1180201[2][2][F_D_1180201_ENM_SQ] = {0}  -- 인카운터몬스터스폰개수
F_D_1180201[2][2][F_D_1180201_ENM_Stime] = {0}  -- 단계별인카운터몬스터기준스폰시간
F_D_1180201[2][2][F_D_1180201_ENM_DMintime] = {0}  -- 인카운터몬스터반복딜레이최소시간
F_D_1180201[2][2][F_D_1180201_ENM_DMaxtime] = {0}  -- 인카운터몬스터반복딜레이최대시간
F_D_1180201[2][2][F_D_1180201_EPM_NPCID] = {118520}  -- 에픽몬스터NPC아이디
F_D_1180201[2][2][F_D_1180201_EPM_SpawnID] = {20109000}  -- 에픽몬스터스폰아이디
F_D_1180201[2][2][F_D_1180201_EPM_SQ] = {1}  -- 에픽몬스터스폰개수
F_D_1180201[2][2][F_D_1180201_EPM_Stime] = {1}  -- 단계별에픽몬스터반복스폰시간
F_D_1180201[2][2][F_D_1180201_EPM_DMintime] = {10}  -- 에픽몬스터반복딜레이최소시간
F_D_1180201[2][2][F_D_1180201_EPM_DMaxtime] = {10}  -- 에픽몬스터반복딜레이최대시간
F_D_1180201[2][2][F_D_1180201_NM_NPCID] = {118620,118621}  -- 일반몬스터NPC아이디
F_D_1180201[2][2][F_D_1180201_NM_SpawnID] = {201000,201100}  -- 일반몬스터스폰아이디(루트1,루트2…)
F_D_1180201[2][2][F_D_1180201_NM_SQ] = {6,4}  -- 일반몬스터스폰개수
F_D_1180201[2][2][F_D_1180201_NM_Stime] = {10,10}  -- 일반몬스터반복스폰시간
F_D_1180201[2][2][F_D_1180201_NM_DMintime] = {0,10}  -- 일반몬스터반복딜레이최소시간
F_D_1180201[2][2][F_D_1180201_NM_DMaxtime] = {20,20}  -- 일반몬스터반복딜레이최대시간
F_D_1180201[2][3][F_D_1180201_ChangeTime] = {90}  -- 단계전환까지남은시간
F_D_1180201[2][3][F_D_1180201_ENM_NPCID] = {0}  -- 인카운터몬스터NPC아이디
F_D_1180201[2][3][F_D_1180201_ENM_SpawnID] = {0}  -- 인카운터몬스터스폰아이디
F_D_1180201[2][3][F_D_1180201_ENM_SQ] = {0}  -- 인카운터몬스터스폰개수
F_D_1180201[2][3][F_D_1180201_ENM_Stime] = {0}  -- 단계별인카운터몬스터기준스폰시간
F_D_1180201[2][3][F_D_1180201_ENM_DMintime] = {0}  -- 인카운터몬스터반복딜레이최소시간
F_D_1180201[2][3][F_D_1180201_ENM_DMaxtime] = {0}  -- 인카운터몬스터반복딜레이최대시간
F_D_1180201[2][3][F_D_1180201_EPM_NPCID] = {118520}  -- 에픽몬스터NPC아이디
F_D_1180201[2][3][F_D_1180201_EPM_SpawnID] = {20109000}  -- 에픽몬스터스폰아이디
F_D_1180201[2][3][F_D_1180201_EPM_SQ] = {1}  -- 에픽몬스터스폰개수
F_D_1180201[2][3][F_D_1180201_EPM_Stime] = {1}  -- 단계별에픽몬스터반복스폰시간
F_D_1180201[2][3][F_D_1180201_EPM_DMintime] = {10}  -- 에픽몬스터반복딜레이최소시간
F_D_1180201[2][3][F_D_1180201_EPM_DMaxtime] = {10}  -- 에픽몬스터반복딜레이최대시간
F_D_1180201[2][3][F_D_1180201_NM_NPCID] = {118620,118621, 118620,118621}  -- 일반몬스터NPC아이디
F_D_1180201[2][3][F_D_1180201_NM_SpawnID] = {201000,201100,202000,202100}  -- 일반몬스터스폰아이디(루트1,루트2…)
F_D_1180201[2][3][F_D_1180201_NM_SQ] = {8,6,8,6}  -- 일반몬스터스폰개수
F_D_1180201[2][3][F_D_1180201_NM_Stime] = {15,15,10,10}  -- 일반몬스터반복스폰시간
F_D_1180201[2][3][F_D_1180201_NM_DMintime] = {10,10,0,0}  -- 일반몬스터반복딜레이최소시간
F_D_1180201[2][3][F_D_1180201_NM_DMaxtime] = {20,20,10,10}  -- 일반몬스터반복딜레이최대시간
F_D_1180201[2][4][F_D_1180201_ChangeTime] = {180}  -- 단계전환까지남은시간
F_D_1180201[2][4][F_D_1180201_ENM_NPCID] = {0}  -- 인카운터몬스터NPC아이디
F_D_1180201[2][4][F_D_1180201_ENM_SpawnID] = {0}  -- 인카운터몬스터스폰아이디
F_D_1180201[2][4][F_D_1180201_ENM_SQ] = {0}  -- 인카운터몬스터스폰개수
F_D_1180201[2][4][F_D_1180201_ENM_Stime] = {0}  -- 단계별인카운터몬스터기준스폰시간
F_D_1180201[2][4][F_D_1180201_ENM_DMintime] = {0}  -- 인카운터몬스터반복딜레이최소시간
F_D_1180201[2][4][F_D_1180201_ENM_DMaxtime] = {0}  -- 인카운터몬스터반복딜레이최대시간
F_D_1180201[2][4][F_D_1180201_EPM_NPCID] = {118520}  -- 에픽몬스터NPC아이디
F_D_1180201[2][4][F_D_1180201_EPM_SpawnID] = {20109000}  -- 에픽몬스터스폰아이디
F_D_1180201[2][4][F_D_1180201_EPM_SQ] = {1}  -- 에픽몬스터스폰개수
F_D_1180201[2][4][F_D_1180201_EPM_Stime] = {1}  -- 단계별에픽몬스터반복스폰시간
F_D_1180201[2][4][F_D_1180201_EPM_DMintime] = {10}  -- 에픽몬스터반복딜레이최소시간
F_D_1180201[2][4][F_D_1180201_EPM_DMaxtime] = {10}  -- 에픽몬스터반복딜레이최대시간
F_D_1180201[2][4][F_D_1180201_NM_NPCID] = {118620,1186210,118621,118621,118622}  -- 일반몬스터NPC아이디
F_D_1180201[2][4][F_D_1180201_NM_SpawnID] = {201000,201100,202000,202100,203000}  -- 일반몬스터스폰아이디(루트1,루트2…)
F_D_1180201[2][4][F_D_1180201_NM_SQ] = {10,8,10,8,1}  -- 일반몬스터스폰개수
F_D_1180201[2][4][F_D_1180201_NM_Stime] = {20,20,20,20,30}  -- 일반몬스터반복스폰시간
F_D_1180201[2][4][F_D_1180201_NM_DMintime] = {10,10,10,10,15}  -- 일반몬스터반복딜레이최소시간
F_D_1180201[2][4][F_D_1180201_NM_DMaxtime] = {30,30,30,30,40}  -- 일반몬스터반복딜레이최대시간
F_D_1180201[2][5][F_D_1180201_ChangeTime] = {180}  -- 단계전환까지남은시간
F_D_1180201[2][5][F_D_1180201_ENM_NPCID] = {0}  -- 인카운터몬스터NPC아이디
F_D_1180201[2][5][F_D_1180201_ENM_SpawnID] = {0}  -- 인카운터몬스터스폰아이디
F_D_1180201[2][5][F_D_1180201_ENM_SQ] = {0}  -- 인카운터몬스터스폰개수
F_D_1180201[2][5][F_D_1180201_ENM_Stime] = {0}  -- 단계별인카운터몬스터기준스폰시간
F_D_1180201[2][5][F_D_1180201_ENM_DMintime] = {0}  -- 인카운터몬스터반복딜레이최소시간
F_D_1180201[2][5][F_D_1180201_ENM_DMaxtime] = {0}  -- 인카운터몬스터반복딜레이최대시간
F_D_1180201[2][5][F_D_1180201_EPM_NPCID] = {118520}  -- 에픽몬스터NPC아이디
F_D_1180201[2][5][F_D_1180201_EPM_SpawnID] = {20109000}  -- 에픽몬스터스폰아이디
F_D_1180201[2][5][F_D_1180201_EPM_SQ] = {1}  -- 에픽몬스터스폰개수
F_D_1180201[2][5][F_D_1180201_EPM_Stime] = {1}  -- 단계별에픽몬스터반복스폰시간
F_D_1180201[2][5][F_D_1180201_EPM_DMintime] = {10}  -- 에픽몬스터반복딜레이최소시간
F_D_1180201[2][5][F_D_1180201_EPM_DMaxtime] = {10}  -- 에픽몬스터반복딜레이최대시간
F_D_1180201[2][5][F_D_1180201_NM_NPCID] = {118620,1186210,118621,118621,118622}  -- 일반몬스터NPC아이디
F_D_1180201[2][5][F_D_1180201_NM_SpawnID] = {201000,201100,202000,202100,203000}  -- 일반몬스터스폰아이디(루트1,루트2…)
F_D_1180201[2][5][F_D_1180201_NM_SQ] = {4,2,4,2,3}  -- 일반몬스터스폰개수
F_D_1180201[2][5][F_D_1180201_NM_Stime] = {20,20,20,20,20}  -- 일반몬스터반복스폰시간
F_D_1180201[2][5][F_D_1180201_NM_DMintime] = {10,10,10,10,10}  -- 일반몬스터반복딜레이최소시간
F_D_1180201[2][5][F_D_1180201_NM_DMaxtime] = {20,20,20,20,20}  -- 일반몬스터반복딜레이최대시간
F_D_1180201[3][2][F_D_1180201_ChangeTime] = {30}  -- 단계전환까지남은시간
F_D_1180201[3][2][F_D_1180201_ENM_NPCID] = {0}  -- 인카운터몬스터NPC아이디
F_D_1180201[3][2][F_D_1180201_ENM_SpawnID] = {0}  -- 인카운터몬스터스폰아이디
F_D_1180201[3][2][F_D_1180201_ENM_SQ] = {0}  -- 인카운터몬스터스폰개수
F_D_1180201[3][2][F_D_1180201_ENM_Stime] = {0}  -- 단계별인카운터몬스터기준스폰시간
F_D_1180201[3][2][F_D_1180201_ENM_DMintime] = {0}  -- 인카운터몬스터반복딜레이최소시간
F_D_1180201[3][2][F_D_1180201_ENM_DMaxtime] = {0}  -- 인카운터몬스터반복딜레이최대시간
F_D_1180201[3][2][F_D_1180201_EPM_NPCID] = {118501}  -- 에픽몬스터NPC아이디
F_D_1180201[3][2][F_D_1180201_EPM_SpawnID] = {30109000}  -- 에픽몬스터스폰아이디
F_D_1180201[3][2][F_D_1180201_EPM_SQ] = {1}  -- 에픽몬스터스폰개수
F_D_1180201[3][2][F_D_1180201_EPM_Stime] = {1}  -- 단계별에픽몬스터반복스폰시간
F_D_1180201[3][2][F_D_1180201_EPM_DMintime] = {10}  -- 에픽몬스터반복딜레이최소시간
F_D_1180201[3][2][F_D_1180201_EPM_DMaxtime] = {10}  -- 에픽몬스터반복딜레이최대시간
F_D_1180201[3][2][F_D_1180201_NM_NPCID] = {118640,118640,118640}  -- 일반몬스터NPC아이디
F_D_1180201[3][2][F_D_1180201_NM_SpawnID] = {301000,302000,303000}  -- 일반몬스터스폰아이디(루트1,루트2…)
F_D_1180201[3][2][F_D_1180201_NM_SQ] = {5,5,5}  -- 일반몬스터스폰개수
F_D_1180201[3][2][F_D_1180201_NM_Stime] = {10,10,10}  -- 일반몬스터반복스폰시간
F_D_1180201[3][2][F_D_1180201_NM_DMintime] = {0,0,0}  -- 일반몬스터반복딜레이최소시간
F_D_1180201[3][2][F_D_1180201_NM_DMaxtime] = {10,10,10}  -- 일반몬스터반복딜레이최대시간
F_D_1180201[3][3][F_D_1180201_ChangeTime] = {60}  -- 단계전환까지남은시간
F_D_1180201[3][3][F_D_1180201_ENM_NPCID] = {0}  -- 인카운터몬스터NPC아이디
F_D_1180201[3][3][F_D_1180201_ENM_SpawnID] = {0}  -- 인카운터몬스터스폰아이디
F_D_1180201[3][3][F_D_1180201_ENM_SQ] = {0}  -- 인카운터몬스터스폰개수
F_D_1180201[3][3][F_D_1180201_ENM_Stime] = {0}  -- 단계별인카운터몬스터기준스폰시간
F_D_1180201[3][3][F_D_1180201_ENM_DMintime] = {0}  -- 인카운터몬스터반복딜레이최소시간
F_D_1180201[3][3][F_D_1180201_ENM_DMaxtime] = {0}  -- 인카운터몬스터반복딜레이최대시간
F_D_1180201[3][3][F_D_1180201_EPM_NPCID] = {118501}  -- 에픽몬스터NPC아이디
F_D_1180201[3][3][F_D_1180201_EPM_SpawnID] = {30109000}  -- 에픽몬스터스폰아이디
F_D_1180201[3][3][F_D_1180201_EPM_SQ] = {1}  -- 에픽몬스터스폰개수
F_D_1180201[3][3][F_D_1180201_EPM_Stime] = {1}  -- 단계별에픽몬스터반복스폰시간
F_D_1180201[3][3][F_D_1180201_EPM_DMintime] = {10}  -- 에픽몬스터반복딜레이최소시간
F_D_1180201[3][3][F_D_1180201_EPM_DMaxtime] = {10}  -- 에픽몬스터반복딜레이최대시간
F_D_1180201[3][3][F_D_1180201_NM_NPCID] = {118640,118640,118640}  -- 일반몬스터NPC아이디
F_D_1180201[3][3][F_D_1180201_NM_SpawnID] = {301000,302000,303000}  -- 일반몬스터스폰아이디(루트1,루트2…)
F_D_1180201[3][3][F_D_1180201_NM_SQ] = {2,2,2}  -- 일반몬스터스폰개수
F_D_1180201[3][3][F_D_1180201_NM_Stime] = {30,30,30}  -- 일반몬스터반복스폰시간
F_D_1180201[3][3][F_D_1180201_NM_DMintime] = {0,0,0}  -- 일반몬스터반복딜레이최소시간
F_D_1180201[3][3][F_D_1180201_NM_DMaxtime] = {20,20,20}  -- 일반몬스터반복딜레이최대시간

function Field_1180201:OnCreate()				
end


function Field_1180201:OnSensorEnter_1(Actor)
	local var = this:GetSpawnNPC(F_D_1180201_VarNPCID)				
	var:Say("여기까지 오느라 힘이 다 빠지는구만, 배도 고프고 말이야, 일단 먹을 것이 있다면 건네주게")	
end


function Field_1180201:OnSensorTalent_1(Actor, TalentID)	
	local var = this:GetSpawnNPC(F_D_1180201_VarNPCID)	
	
	if (AsPlayer(Actor):CheckCondition(1180201) ==  true ) and (TalentID == 140807) then		
		this:DisableSensor(1)		
		
		AsPlayer(Actor):Tip("대장 레온과 대화가 가능해졌습니다")
		var:Say("{ani=cheer}다행이구만 마침 허기져서 모두 지쳐있었거든 더욱 힘이 나는 구만!")
		var:EnableInteraction()
	end
end


function Field_1180201:OnSensorEnter_999(Actor)			
	-- this:EnableSensor(100)		
	-- this:DisableSensor(999)		
	this:DisableSensor(999)			
	
	local var = this:GetSpawnNPC(F_D_1180201_VarNPCID)			
		
	-- 0 : stage , 1 : Phase	
	var:DisableInteraction()
	var:Say("이제 마법진을 시전하겠네")
	var:Say("시간이 걸리니 경계를 늦추지 말도록!")
	
	var:SetUserData(1, 1)
	var:SetUserData(2, 1)	
	
	GLog("DefStage : "..var:GetUserData(1).." DefPhase : "..var:GetUserData(2).."\n")
	-- this:SetTimer(F_D_1180201[var:GetUserData(1)][1][F_D_1180201_IS_ID][1], 15, false)					
	this:SetTimer(F_D_1180201[var:GetUserData(1)][1][F_D_1180201_LT_SpawnID][1], 1, false)							
	
	
	var:Narration("곧 마법사단이 "..var:GetUserData(1).." 번째 핵으로 이동합니다. 그들을 안전하게 호위하십시오")		
	var:ScriptSelf("Field_1180201_Begin")	
end

function Field_1180201_Begin(Self)
	local Field = Self:GetField()
	Field:MakeSession("LifeMove", {var})					
end
--변수 처리용 스테이지 생성용
--스테이지1
-- function Field_1180201:OnSensorEnter_100(Actor)			
	-- Def_Ready(this, Actor, 100, 1,1, "이제 마법진을 시전하겠네", "시간이 걸리니 경계를 늦추지 말도록!", "곧 마법사단이 첫 번째 핵으로 이동합니다. 그들을 안전하게 호위하십시오")	
-- end

--스테이지2
-- function Field_1180201:OnSensorEnter_200(Actor)			
	-- Def_Ready(this, Actor, 200, "볼라스", "죽여라", "소환사의 협곡에 오신것을 환영합니다")	
-- end


--1Stage
function Field_1180201:OnSensorEnter_10(Actor)				
	Def_Stage_1180201(this, Actor, F_D_1180201_VarNPCID, 10 )				
end

--2Stage
function Field_1180201:OnSensorEnter_20(Actor)				
	Def_Stage_1180201(this, Actor, F_D_1180201_VarNPCID, 20 )	
end
--3Stage
function Field_1180201:OnSensorEnter_30(Actor)				
	Def_Stage_1180201(this, Actor, F_D_1180201_VarNPCID, 30 )	
end



--NPC 사망시 체크용 센서
function Field_1180201:OnSensorEnter_2(Actor)			
	local var = this:GetSpawnNPC(F_D_1180201_VarNPCID)
	--생존자가 모두 죽으면
	if (this:GetNPCCount(F_D_1180201[var:GetUserData(1)][1][F_D_1180201_LT_NPCID][1]) == 0) then				
		-- GLog("All Die Life \n")			
		AsPlayer(Actor):NarrationNow(F_D_1180201[var:GetUserData(1)][1][F_D_1180201_Msg1][1])						
		
		this:SetTimer(F_D_1180201[var:GetUserData(1)][1][F_D_1180201_KM_TimerID][1], 1, false)
		
		---레온을 삭제
		this:DespawnByID(F_D_1180201_VarNPCID, false)		
		
		--10초 뒤에 필드이동 처리				
		
		this:DisableSensor(2)
	
	--생존자의 남은 수를 체크 
	elseif (this:GetNPCCount(F_D_1180201[var:GetUserData(1)][1][F_D_1180201_LT_NPCID]) ~= 0) or (this:GetNPCCount(F_D_1180201[var:GetUserData(1)][1][F_D_1180201_LT_NPCID]) ~= nil) then	
		-- GLog("progress\n")	
		local life = this:GetNPCCount(F_D_1180201[var:GetUserData(1)][1][F_D_1180201_LT_NPCID][1])
		AsPlayer(Actor):NarrationNow(F_D_1180201[var:GetUserData(1)][1][F_D_1180201_Msg3][1] ..life.. F_D_1180201[var:GetUserData(1)][1][F_D_1180201_Msg3][2])
		
		this:DisableSensor(2)		
	end
	
end

--MON 사망시 체크용 센서 : 스테이지 완료처리
function Field_1180201:OnSensorEnter_3(Actor)				

	local var = this:GetSpawnNPC(F_D_1180201_VarNPCID)
	
	local st = var:GetUserData(1)
	local ph = var:GetUserData(2)
	
	if (this:GetNPCCount(F_D_1180201[var:GetUserData(1)][1][F_D_1180201_EPM_NPCID][1]) == 0) then 
		-- GLog("done")		
		this:SetTimer(F_D_1180201[var:GetUserData(1)][1][F_D_1180201_KM_TimerID][1], 1, false)		
		this:SpawnByID(F_D_1180201[var:GetUserData(1)][1][F_D_1180201_RW_SpawnID][1]) --보물상자				
			
		if (F_D_1180201[var:GetUserData(1)][1][F_D_1180201_BoolEnd][1] == "false") then	
			AsPlayer(Actor):NarrationNow(F_D_1180201[var:GetUserData(1)][1][F_D_1180201_Msg2][1])
			
			--완료시 라이프들이 이동할 마커 지정
			this:SetTimer(F_D_1180201[var:GetUserData(1)][1][F_D_1180201_LMMID][1], 1, false)			
		else											
			this:MakeSession("Ending", {var})
			AsPlayer(Actor):UpdateQuestVar(118020, 2)
		end
		
		this:DisableSensor(3)			
	end
	
	-- this:DisableSensor(3)		
end

function Field_1180201:OnSessionScene_Ending_Begin(Session)	

	local var = this:GetSpawnNPC(F_D_1180201_VarNPCID)
	
	local st = var:GetUserData(1)
	local ph = var:GetUserData(2)
	
	var:Narration("볼라스를 처치했습니다. 20초 뒤 장벽 정문에 출구가 생성됩니다")
	var:Say("수고많았네.")
	
	this:SetTimer(F_D_1180201[st][1][F_D_1180201_KM_TimerID][1], 1, false)				
	
	--출구 센서 활성
	this:SetTimer(F_D_1180201[st][1][F_D_1180201_NS_ID][1], 20, false)				
	
	--조사단원 모두 삭제
	for i = F_D_1180201[st][1][F_D_1180201_LT_SpawnID][1] , F_D_1180201[st][1][F_D_1180201_LT_SpawnID][1] - 1 + F_D_1180201[st][1][F_D_1180201_LT_Q][1] do														
		local SpawnNPC = this:GetSpawnNPC(i)
		Session:RemoveNPC(SpawnNPC)
		this:DespawnByID(i, false)
		GLog("Despawn Life" ..i.." \n")
	end					
	
	Session:EndSession()
	GLog("ENd session \n")
end


function Field_1180201:OnTimer(TimerID)	
	
	local var = this:GetSpawnNPC(F_D_1180201_VarNPCID)	
	local st = var:GetUserData(1)
	local ph = var:GetUserData(2)
			
	-- GLog("var : "..var.."\n")
	-- GLog("st : "..st.."\n")
	-- GLog("ph : "..ph.."\n")
	
	--일반몬스터
	for k,v in ipairs(F_D_1180201[st][ph][F_D_1180201_NM_SpawnID]) do						
		if (TimerID == v) then			
			-- GLog("NORMALTIMER ON"..v.."\n")						
			SpawnBy_SpawnID(this,v, F_D_1180201[st][ph][F_D_1180201_NM_SQ][k],F_D_1180201[st][ph][F_D_1180201_NM_DMintime][k],F_D_1180201[st][ph][F_D_1180201_NM_DMaxtime][k])
		end
	end
	
	--에픽몬스터
	for k,v in ipairs(F_D_1180201[st][ph][F_D_1180201_EPM_SpawnID]) do
		if (TimerID == v) then
			GLog("EPICTIMER ON"..v.."\n")							
			SpawnBy_SpawnID(this,v, F_D_1180201[st][ph][F_D_1180201_EPM_SQ][k],F_D_1180201[st][ph][F_D_1180201_EPM_DMintime][k],F_D_1180201[st][ph][F_D_1180201_EPM_DMaxtime][k])
		end
	end	
	
	--조사단원
	for k,v in ipairs(F_D_1180201[st][1][F_D_1180201_LT_SpawnID]) do
		if (TimerID == v) then			
			GLog("LIFE SPawn : "..v.."\n")		
			SpawnBy_SpawnID(this,v, F_D_1180201[st][1][F_D_1180201_LT_Q][k],0,0)								
			-- this:SetTimer(1,1,false)
		end
	end
	
	---몬스터 모두 사망
	if (TimerID == F_D_1180201[st][1][F_D_1180201_KM_TimerID][1]) then						
		
		DespawnBy_NPCID(this, F_D_1180201[st][1][F_D_1180201_KM_NPCID])		
		GLog("ALL Kill\n")		
		
		--스테이지증가 타이머 
		
		this:KillTimer(F_D_1180201[st][1][F_D_1180201_TimerID][1])				
		GLog("this Kill timer stage\n")
		
		
		Stacked_KillTimer(this,F_D_1180201[st][ph][F_D_1180201_NM_SpawnID])			
		GLog("Satacked kill timer nmSpawnID\n")
		
		-- 투명벽을 해제		
		DespawnBy_SpawnID(this, F_D_1180201[st][1][F_D_1180201_WSpawnID][1], F_D_1180201[st][1][F_D_1180201_WQ][1]) 
		GLog("inviwall despawn\n")
		
	end
	
	---Phase 단계를 전환 +1씩 한다
	if (TimerID == F_D_1180201[st][1][F_D_1180201_TimerID][1]) then									
		
		GLog("OnPhase" .. ph .. "\n")
		
		
		-- local SayNPC = this:GetSpawnNPC(F_D_1180201_VarNPCID)
		-- SayNPC:Narration("곧 마법사단이 첫 번째 핵으로 이동합니다. 그들을 안전하게 호위하십시오")		
		var:SetUserData(2,var:GetUserData(2) + 1)		
		this:EnableSensor(F_D_1180201[st][1][F_D_1180201_IS_ID][1])
		
			--파스가 넘어가면 파스단계를 ㄹ올리고 센서를 활성화
	end
	
	--각 스테이지 시작시 몬스터 스폰 센서를 활성화
	if (TimerID == F_D_1180201[st][1][F_D_1180201_IS_ID][1]) then							
		var:SetUserData(2,var:GetUserData(2) + 1)
		GLog("SpawnSensor on : "..var:GetUserData(2).."\n")		
		this:EnableSensor(F_D_1180201[st][1][F_D_1180201_IS_ID][1])		
	end
	
	---클리어시 라이프들이 패트롤할 마커
	if (TimerID == F_D_1180201[st][1][F_D_1180201_LMMID][1]) then											
		DespawnBy_NPCID(this, F_D_1180201[st][1][F_D_1180201_KM_NPCID])						
		
		if st == 1 then
			this:MakeSession("Field_1180201_StageClear",{var})		
			return
		end
		
		local Session = this:FindSession("Field_1180201_StageClear")		
		
		if Session == nil then
			GLog("Session \n")
		end
		
		-- this:MakeSession("Field_1180201_Stage"..st.."Clear", {var})
		Session:ChangeScene("Begin")
		
	end		
	
	--다음 필드로 이동하는 센서 활성
	if (TimerID == F_D_1180201[st][1][F_D_1180201_NS_ID][1]) then													
		this:EnableSensor(F_D_1180201[st][1][F_D_1180201_NS_ID][1])	
	end	
end


function Field_1180201:OnSessionScene_LifeMove_Begin(Session)

	local var = this:GetSpawnNPC(F_D_1180201_VarNPCID)
	local st = var:GetUserData(1)
	local ph = var:GetUserData(2)
	
	local v = 0				
	
	var:Say("대원들은 다음 핵으로 이동하라! ")	
	
	Session:NonBlocking()	
	
	for i = F_D_1180201[st][1][F_D_1180201_LT_SpawnID][1] , F_D_1180201[st][1][F_D_1180201_LT_SpawnID][1] - 1 + F_D_1180201[st][1][F_D_1180201_LT_Q][1] do																				
	
		
		-- local SpawnNPC = this:GetSpawnNPC(i)
		local SpawnNPC = SpawnID_MoveToMarker(this, i, F_D_1180201[st][1][F_D_1180201_LT_Mpos][1] + v )
		SpawnNPC:SayNow("이얏!")		
		SpawnNPC:UseTalentSelf(140808)
		
		v = v + 1
	end			
	
	Session:Blocking()	
	Session:CombatAll()	
	-- GLog("DefStage : "..var:GetUserData(1).." DefPhase : "..var:GetUserData(2).."\n")	
	this:SetTimer(F_D_1180201[var:GetUserData(1)][1][F_D_1180201_IS_ID][1], 10, false)
	-- Session:EndSession()		
	Session:EndSession()
end



function Field_1180201:OnSessionScene_Field_1180201_StageClear_Begin(Session)		
	Session:CombatAll()		
	local var = this:GetSpawnNPC(F_D_1180201_VarNPCID)
	local st = var:GetUserData(1)
	local ph = var:GetUserData(2)	
	local F_D_1180201_LMM = {}	

	local v = 0
	local z = 0
		
	for i = F_D_1180201[st][1][F_D_1180201_LMMID][1], (F_D_1180201[st][1][F_D_1180201_LMMID][1] - 1  + F_D_1180201[st][1][F_D_1180201_LMMQ][1]) do				
		-- GLog("LIFE PATROL in for - Stack Marker'"..i.."\n")
		table.insert(F_D_1180201_LMM, i)		
		-- GLog("Stack Marker'"..i.."\n")
	end	
	var:Say("대원들은 다음 핵으로 이동하라! 난 나머지 녀석들을 처리한 후에 가겠다")		
	
	Session:NonBlocking()
	
	for i = F_D_1180201[st][1][F_D_1180201_LT_SpawnID][1] , F_D_1180201[st][1][F_D_1180201_LT_SpawnID][1] - 1 + F_D_1180201[st][1][F_D_1180201_LT_Q][1] do					
		local SpawnNPC = this:GetSpawnNPC(i)														
		SpawnNPC:ClearJob()
		-- Session:AddNPC(SpawnNPC)														
		SpawnNPC:Patrol(F_D_1180201_LMM, PT_ONCE)							
		-- SpawnNPC:MoveToMarker(F_D_1180201[st + 1][1][F_D_1180201_LT_Mpos][1] + v)
		v = v + 1
		-- SpawnNPC:MoveRandom(SpawnNPC,500)
	end		
	
	var:Patrol(F_D_1180201_LMM, PT_ONCE)		
	Session:Blocking()		
		
	-- var:Say("다시 마법진을 시전하겠네")
	-- var:Say("시간이 걸리니 경계를 늦추지 말도록!")
	
	-- this:SetTimer(F_D_1180201[var:GetUserData(1)][1][F_D_1180201_IS_ID][1], 10, false)	
	-- Session:ChangeScene("NextAction")	
		
	-- Session:NonBlocking()		
	var:SetUserData(1, var:GetUserData(1) + 1)
	var:SetUserData(2, 1)		
	
	Session:NonBlocking()	
	for i = F_D_1180201[var:GetUserData(1)][1][F_D_1180201_LT_SpawnID][1] , F_D_1180201[var:GetUserData(1)][1][F_D_1180201_LT_SpawnID][1] - 1 + F_D_1180201[var:GetUserData(1)][1][F_D_1180201_LT_Q][1] do																					
		
		local SpawnNPC = SpawnID_MoveToMarker(this, i, F_D_1180201[var:GetUserData(1)][1][F_D_1180201_LT_Mpos][1] + z )		
		SpawnNPC:Say("이얍~")				
		SpawnNPC:UseTalentSelf(140808)		
		z = z + 1		
		
	end		
	Session:Blocking()		
	
	var:Say("준비됏나?")	
	var:Say("시작하지")
	
	-- this:SetTimer(F_D_1180201[var:GetUserData(1)][1][F_D_1180201_IS_ID][1], 5, false)	
	var:ScriptSelf("Field_1180201_StartStage")			
	-- Session:RemoveNPC(var)		
	-- Session:EndSession()
end

function Field_1180201_StartStage(Self)
	local Field = Self:GetField()	
	local var = Field:GetSpawnNPC(F_D_1180201_VarNPCID)	
	-- var:SayNow("시작하지")
	Field:SetTimer(F_D_1180201[var:GetUserData(1)][1][F_D_1180201_IS_ID][1], 5, false)	
end
	
function Field_1180201:OnDie(DespawnInfo)	

	local var = this:GetSpawnNPC(F_D_1180201_VarNPCID)
	
	--라이프 체크
	if (DespawnInfo.NPCID == F_D_1180201[var:GetUserData(1)][1][F_D_1180201_LT_NPCID][1]) then									
		-- GLog("DespawnInfo : "..DespawnInfo.NPCID.."\n")		
		this:EnableSensor(2)	
	end
	
	--에픽몬스터가 사망하면
	if (DespawnInfo.NPCID == F_D_1180201[var:GetUserData(1)][var:GetUserData(2)][F_D_1180201_EPM_NPCID][1]) then	
		-- GLog("DespawnInfo : "..DespawnInfo.NPCID.."\n")		
		this:EnableSensor(3)
	end	
	
end


function Field_1180201:OnSpawn(SpawnInfo)			
	
	local var = this:GetSpawnNPC(F_D_1180201_VarNPCID)
	local st = var:GetUserData(1)
	local ph = var:GetUserData(2)
	
	
	if st >= 1 and ph >= 2 then
		for k,v in ipairs(F_D_1180201[st][ph][F_D_1180201_EPM_NPCID]) do	
			if SpawnInfo.NPCID == v then
				SpawnInfo.NPC:GainBuff(111409)	
			else		
				SpawnInfo.NPC:SetDecayTime(10)
				SpawnInfo.NPC:SetAlwaysRun(true)				
			end
		end			
	
		for k, v in ipairs(F_D_1180201[st][1][F_D_1180201_LT_SpawnID]) do
			if SpawnInfo.SpawnID == v then
				SpawnInfo.NPC:SetAlwaysRun(true)							
			end
		end
	end	
end



----------------------------------------------------------------------------------------------------------------------
--디펜스 로직 처리
function Def_Stage_1180201(ThisField, ThisActor, ThisNPC ,ThisSensorID)
	--일반몬스터		
	GLog("ONsensor".. ThisSensorID .."\n")
	
	-- GLog(""..F_D_1180201[var:GetUserData(1)][1][F_D_1180201_LMMID][1].."\n")
	-- GLog(""..F_D_1180201[var:GetUserData(1)][1][F_D_1180201_LMMID][1] + F_D_1180201[var:GetUserData(1)][1][F_D_1180201_LMMQ][1].."\n")
		
	
	local var = ThisField:GetSpawnNPC(ThisNPC)		
	
	for k, v in ipairs(F_D_1180201[var:GetUserData(1)][var:GetUserData(2)][F_D_1180201_NM_SpawnID]) do													
		-- GLog("SetTimer to "..v.."\n")
		ThisField:SetTimer(v,F_D_1180201[var:GetUserData(1)][var:GetUserData(2) - 1][F_D_1180201_NM_Stime][k], true)
		-- SetTimer_Stack(ThisField, v, F_D_1180201[var:GetUserData(1)][var:GetUserData(2)][F_D_1180201_NM_Stime][k], true, F_D_1180201[var:GetUserData(1)][1][F_D_1180201_StackTID])					
		
	end
	
	GLog("Stage : "..var:GetUserData(1).." Phase : "..var:GetUserData(2) .."\n")
	
	--Phase를 증가시킨다	
	ThisField:SetTimer(F_D_1180201[var:GetUserData(1)][1][F_D_1180201_TimerID][1], F_D_1180201[var:GetUserData(1)][var:GetUserData(2)][F_D_1180201_ChangeTime][1], false)		
	AsPlayer(ThisActor):NarrationNow(F_D_1180201[var:GetUserData(1)][1][F_D_1180201_Msg6][var:GetUserData(2) - 1 ])
	
	-- 라이프 토큰 스폰
	if (var:GetUserData(2) == 2) then		
		
		-- if (F_D_1180201[var:GetUserData(1)][1][F_D_1180201_WSpawnID][1]) == nil return else
		-- ---투명벽 생성
		-- ThisField:SetTimer(F_D_1180201[var:GetUserData(1)][1][F_D_1180201_WSpawnID][1], 1, false)					
		-- end
		--라이프에 이동마커를 지정
		ThisField:SetTimer(F_D_1180201[var:GetUserData(1)][1][F_D_1180201_LT_NPCID][1], 1, false)
		
	end
	
		
	---중간 보스 스폰 처리가능
	
	-- 마지막 에픽몹 스폰
	
	if (var:GetUserData(2) == F_D_1180201[var:GetUserData(1)][1][F_D_1180201_LastEPM_TimerID][1]) then									
		-- GLog("EPICwwwwwwwwww SPawn\n")
		ThisField:KillTimer(F_D_1180201[var:GetUserData(1)][1][F_D_1180201_TimerID][1])
		ThisField:SetTimer(F_D_1180201[var:GetUserData(1)][var:GetUserData(2)][F_D_1180201_EPM_SpawnID][1], 1, false)									
		--Phase를 중지시킨다
		
		-- AsPlayer(ThisActor):Tip(F_D_1180201[1][F_D_1180201_Msg4][1])
	end

	ThisField:DisableSensor(ThisSensorID)				
	
end




