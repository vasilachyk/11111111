--[[
	Game help LUA script
--]]


-- Global instance
luaHelp = {};

g_HelpCategory = {
	"전투&퀘스트",
	"아이템",
	"인터페이스",
	"기타",};

g_HelpList = {};
g_HelpList.nIndex= {
	2,
	2,
	2,
	2,
	0,
	2,
	2,
	0,
	0,
	0,
	3,
	3,
	2,
	2,
	2,
	2,
	2,
	0,
	2,
	0,
	2,
	3,
	2,
	2,
	0,
	1,
	1,
	1,
	1
}

g_HelpList.strName = {
	"NPC 상호작용 방법",
	"채팅 방법",
	"PC 상호작용(거래, 결투, 파티맺기, 친구등록)",
	"아이템을 줍는 방법",
	"LP를 소모하여 스킬을 배우는 방법",
	"스킬을 팔레트에 넣는 방법",
	"마법 발사법",
	"퀘스트 확인하기",
	"퀘스트 화면에 표시하는 법",
	"퀘스트포기하는 법",
	"트라이얼 필드와 일반 필드와 다른점",
	"트라이얼필드에서 행동불능이 되었을 때 설명",
	"트라이얼 필드 퀘스트를 포기하고 나가는 방법",
	"인벤토리 여는법",
	"아이템 버리는법",
	"장비 장착하는 법",
	"아이템 팔레트에 넣는 법",
	"생명력,정신력,기력 회복하는 법",
	"마우스커서 활성화",
	"도전자 퀘스트",
	"버프에 대한 설명 보는 법",
	"부활 방법, 페털티에 대한 설명",
	"우호도 확인하는 법",
	"맵 사용법",
	"피로도 & 회복하는 방법",
	"파티플레이시 루팅룰 지정",
	"레시피 얻는 법",
	"아이템 제작법",
	"아이템 수리법"
}

g_HelpMessage = {}
g_HelpMessage[1] = "NPC에 가까이 다가가 {character}E키{/character}를 누르면 상호작용(말걸기, 아이템 줍기, 물건 조사하기 등)을 할 수 있습니다.";
g_HelpMessage[2] = "{CR}{character}엔터{/character}를 누르면 대화창이 활성화 되어 주변 유저들과 채팅을 할 수 있습니다.{CR}대화창에 명령어를 입력하면 다양한 채팅이 가능합니다.{CR}대화하기 : {COLOR r=220 g=220 b=100}/s, /say, /대화, /ㄴ{/COLOR} 주변 30m까지 플레이어들에게 메시지 전달(멀리 있거나 채널이 갈라진 경우에 들을 수 없음){CR}귓속말 :{COLOR r=220 g=220 b=100} /t, /tell, /귓말, /ㅈ, /ㅅ {/COLOR} 특정 플레이어에게 메시지 전달 {CR}귓속말 답장 :{COLOR r=220 g=220 b=100} /r, /ㄱ{/COLOR} 귓속말을 걸어왔던 플레이어에게 귓속말로 대답하기 {CR}파티대화 :{COLOR r=220 g=220 b=100} /p, /party, /파티, /ㅍ, /ㅔ{/COLOR} 동일 파티내 모든 플레이어에게 메시지 전달{CR}레이드 대화 :{COLOR r=220 g=220 b=100}/ra, /raid, /레이드{/COLOR} 동일 레이드 파티 내 모든 플레이어에게 메시지 전달(필드/채널에 무관){CR}길드 대화 :{COLOR r=220 g=220 b=100}/g, /guild, /길드{/COLOR} 동일 길드내 모든 플레이어에게 메시지 전달{CR}외침 :{COLOR r=220 g=220 b=100}/shout, /외침{/COLOR} 현재 채널내의 모든 플레이어들에게 메시지 전달{CR}거래 :{COLOR r=220 g=220 b=100}/trade, /거, /거래{/COLOR} 필드 전체 플레이어들에게 메시지 전달. 메시지를 보낼 수 있는 시간에 제약이 있음.(1분에 한번){CR}필드 :{COLOR r=220 g=220 b=100}/field, /f, /필드, /ㄹ{/COLOR} 현재 채널 동일 필드내 모든 플레이어에게 메시지 전달";
g_HelpMessage[3] = "{CR}거래, 결투, 파티맺기, 친구등록을 하려면 다른 플레이어에게 다가가서 {character}E키{/character}를 누릅니다.";
g_HelpMessage[4] = "{CR}쓰러뜨린 적의 시체에 다가가 {character}E키{/character}를 누릅니다.";
g_HelpMessage[5] = "{CR}레벨업을 할 때마다 1LP(스킬 학습 포인트)를 얻게 되면 스킬을 익힐 수 있습니다. {character}T키{/character}를 눌러서 스킬창을 열고 원하는 스킬을 클릭하면 익힐 수 있습니다.";
g_HelpMessage[6] = "{CR}{character}T키{/character}를 눌러 스킬창을 열고 원하는 스킬 아이콘을 드래그하여 팔레트에 드랍하면 해당하는 키를 눌러 스킬을 곧바로 실행 시킬 수 있습니다.";
g_HelpMessage[7] = "{CR}적 몬스터에 타겟을 맞춘 후 {character}클릭 버튼{/character}을 누르면 마법이 발사됩니다. 거리가 너무 멀면 발사가 취소됩니다.";
g_HelpMessage[8] = "{CR}{character}J키{/character}를 눌러 저널창을 열면 현재 수행하고 있는 퀘스트를 리스트별로 확인할 수 있습니다.";
g_HelpMessage[9] = "{CR}{character}J키{/character}를 눌러 저널창을 열어 퀘스트목록 중 화면에 표시하고 싶은 퀘스트를 {character}더블클릭{/character}하거나 하단의 '표시'를 클릭하면 화면에 표시됩니다.";
g_HelpMessage[10] = "{CR}{character}J키{/character}를 눌러 저널창을 열어 퀘스트목록 중 포기하고 싶은 퀘스트를 클릭한 후 하단의 포기하기를 누릅니다.";
g_HelpMessage[11] = "{CR}일반필드 : 다른 유저들의 모습을 보고 함께 활동 할 수 있는 오픈된 필드입니다.{CR}트라이얼필드 : 플레이어 혼자나 파티원만 입장할 수 있는 제한된 필드로 퀘스트나 특정한 상황에 입장합니다.";
g_HelpMessage[12] = "{CR}안전지대 : 트라이얼필드 내에서 부활합니다. {CR}영혼귀속한 장소 : 마지막으로 귀속한 영혼석에서 부활합니다. {CR} 제자리에서 부활 : 행동 불능이 된 장소에서 부활합니다.";
g_HelpMessage[13] = "{CR}트라이얼 필드 퀘스트를 포기하고 싶을 때는 화면 오른쪽상단(미니맵위)에 {character}'나가기'{/character}버튼을 눌러 이전의 필드로 돌아갑니다. 전투 중일 경우 사용할 수 없습니다.";
g_HelpMessage[14] = "{CR}인벤토리를 확인할 때는 {character}I키{/character}을 누릅니다.";
g_HelpMessage[15] = "{CR}버리고 싶은 아이템에 커서를 대고 오른쪽버튼을 눌러 {character}'버리기'{/character}를 클릭하거나 아이템을 드래그하여 인벤토리 밖에 드랍합니다.";
g_HelpMessage[16] = "{CR}장착하고 싶은 아이템에 커서를 대고 더블클릭을 하거나 오른쪽버튼을 눌러 {character}'장착하기'{/character}를 클릭합니다.";
g_HelpMessage[17] = "{CR}아이템을 드래그하여 원하는 팔레트에 드랍합니다.";
g_HelpMessage[18] = "{CR}전투중이 아닐때 자동으로 조금씩 회복됩니다. 생명력은 아이템을 먹거나 다른플레이어가 회복 스킬(예 : 클레릭의 스킬 '치유')를 써서 회복시킬 수 있습니다.";
g_HelpMessage[19] = "{CR}{character}Ctrl키{/character}를 눌러 마우스커서를 활성화 시킵니다.";
g_HelpMessage[20] = "{CR}도전자 퀘스트는 하루에 한번 보스몬스터를 쓰러뜨리는 높은 난이도의 퀘스트를 말합니다. {CR}퀘스트 조건 : 한번 쓰러뜨렸던 보스 몬스터{CR}퀘스트 수행단계 : {CR}1. 마을이나 필드에 있는 게시판을 조사한다{CR}2. 도전자퀘스트를 받고 해당 퀘스트마다 지정된 NPC에게 워프시켜달라고 말을 건다{CR}3. 보스 몬스터를 쓰러뜨린 후 오른쪽상단의 '나가기'버튼을 누른다{CR}4. 워프시켜줬던 NPC에게 보상을 받는다{CR}{CR}기타 : {CR}난이도가 높기 때문에 파티플레이를 권장합니다. {CR}도전자 퀘스트에서 선택할 수 있는 보스는 하루에 한번씩 랜덤으로 바뀝니다. {CR}한번 받은 도전자퀘스트는 취소할 수 없습니다.{CR}플레이어의 레벨에 따라 도전할 수 있는 보스는 달라집니다.{CR}수락한 도전자퀘스트는 새벽 4시에 모두 초기화 되어 사라집니다.";
g_HelpMessage[21] = "{CR}화면 오른쪽상단의 버프아이콘에 마우스커서를 올려놓습니다. 마우스커서는 {character}Ctrl키{/character}를 눌러 활성화 시킵니다";
g_HelpMessage[22] = "{CR}즉시부활 : 생명의 부적을 사용하여 캐릭터가 행동불능이 된 자리에서 부활 -> 1분 동안 재사용 불가 {CR}영혼귀속 지점에서 부활 : 마지막으로 영혼귀속한 영혼석에 부활 -> 생명력, 정신력, 기력 25%회복{CR}{CR}안전 지점에서 부활 : 마지막 체크포인트에서 부활 -> 생명력,정신력,기력 25%회복{CR}타인에의한 부활(클레릭의 스킬'빠른부활') : 생명력, 정신력, 기력 25%{CR}타인에의한 부활(클레릭의 스킬'부활') : 생명력, 정신력, 기력 50%{CR}공통사항 : 장착한 아이템의 내구도가 10%하락됩니다";
g_HelpMessage[23] = "{CR}{character}H키{/character}를 눌러서 [우호도]탭을 클릭합니다.";
g_HelpMessage[24] = "{CR}{character}M키{/character}를 눌러 지도 창을 열 수 있고 휠버튼으로 확대와 축소, 클릭하여 드래그하면 맵을 이동 시킵니다. 다른 지역의 맵을 확인 할 수도 있습니다.";
g_HelpMessage[25] = "{CR}캐릭터의 피로도 상태는 총 5단계로 구분되어 있고 획득하는 경험치에 영향을 줍니다.{CR}매우 좋음 : 경험치 200%{CR}좋음 : 경험치 180%{CR}보통 : 경험치 150%{CR}나쁨 : 경험치 100%{CR}매우 나쁨 : 경험치 100%{CR}{CR}피로도는 높은단계(매우좋음)에서 낮은단계(매우나쁨)로 조금씩 자동으로 낮아지는데 캐릭터가 마을에 있을 때보다 필드에 있을 때 더 빨리 낮아지며 여관에서 휴식을 취하면 회복이 됩니다.(클로즈베타에서는 적용되지 않음)";
g_HelpMessage[26] = "{CR}파티의 리더는 아이템 루팅룰을 지정할 수 있습니다.{CR}1. 루팅 룰(일반) : 프리포올 / 순차루팅{CR}2. 루팅 룰(레어) : 프리포올 / 순차루팅{CR}3. 적용대상 : 레어급 이상 / 전설급 이상 / 에픽급";
g_HelpMessage[27] = "{CR}장인NPC에게 레시피받음을 선택합니다. 확인은 {character}J버튼{/character}을 눌러 레시피탭을 클릭하십시오.";
g_HelpMessage[28] = "{CR}아이템을 만드는데 필요한 재료를 모은 후 장인NPC에게 말을 걸어 {character}아이템제작 버튼{/character}을 누릅니다. 장인NPC에 따라 무기, 방어구, 음식을 만들어 주며 제작비용과 레벨제한이 정해져있습니다.";
g_HelpMessage[29] = "{CR}수리가 가능한 NPC에게 말을 걸어 {character}수리{/character} 버튼을 클릭합니다.";



-- OnShowMainMenuFrame
function luaHelp:OnShowMainMenuFrame()

	-- Show
	if ( frmHelpMessage:GetShow() == true)  then
	
		luaHelp:Refresh()
		
	-- Hide
	else

	end
	
	luaGame:ShowWindow( frmHelpMessage);
end


function luaHelp:Refresh()

	ctvHelp:DeleteAllItems();
	

    -- 퍼팩트 월드에서 도움말 들어냅니다. 도움말 정리될때까지, 임시코드입니다.
    if (STR("HUMAN") ~= "인간") then
		return;
    end


	local nCategoryCount = table.getn(g_HelpCategory);
	for i = 1, nCategoryCount do
	
		ctvHelp:AddCategory( g_HelpCategory[i]);
	end

	local count = table.getn(g_HelpList.strName);
	for  i = 1, count do

		local nCategoryIndex = g_HelpList.nIndex[i];
		local strName = g_HelpList.strName[i];
		local strIcon;

		if (strName == nil)  or  (strName == "")  then  strName = "Unknown";
		end
		if (strIcon == nil)  or  (strIcon == "")  then  strIcon = "iconUnknown";
		end

		local nIndex = ctvHelp:AddItem( nCategoryIndex, strName, strIcon);
		ctvHelp:SetItemData( nCategoryIndex, nIndex, i);
	end

end

function luaHelp:OnSelChange()

	luaHelp:RefreshHelpDescription();
end

function luaHelp:RefreshHelpDescription()

	tvwHelpMsg:Clear();

	local nCurSelCategory, nCurSelItem = ctvHelp:GetCurSel();
	if ( nCurSelCategory < 0)  or  ( nCurSelItem < 0)  then  return;
	end
	
	local nIndex = ctvHelp:GetItemData( nCurSelCategory, nCurSelItem);
	if ( nIndex <= 0)  then  return;
	end
	
	local strText = "{CR}" .. g_HelpMessage[nIndex]
	tvwHelpMsg:SetText( luaGame:ConvertStrToDialogSentence( strText));
end
