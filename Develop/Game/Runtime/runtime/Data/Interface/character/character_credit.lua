
-- Global instance
luaCredit = {};


luaCredit.m_fScrollSpeed		= 42; 					-- text 스크롤 속도( 숫자가 클 수록 빨리 올라감 ※ 주의 : 해상도에 따라 스크롤되는 시간이 달리짐.)
luaCredit.m_fImageChangeTime	= 8.5;					-- 이미지 교체 시간( 초 )
luaCredit.m_nImageCount			= 15;					-- 이미지 갯수
luaCredit.m_fImageFadeTime		= 0.8;					-- 이미지 fade in/out 시간( 초 )
luaCredit.m_strBGM				= "bgm_credit";			-- 배경음 sound.xml
luaCredit.m_strFinishedImage	= "creditend";			-- 종료시 이미지 이름( 확장자 없이 )
luaCredit.m_nImageX				= 20;					-- 이미지 x좌표

luaCredit.IMAGE_STATE			= { IMAGE_NONE = 0, IMAGE_OUT = 1, IMAGE_IN = 2 };

luaCredit.m_fScrollTimer		= 0;
luaCredit.m_fScrollValue		= 0;
luaCredit.m_nImageIndex			= 0;
luaCredit.m_fImageTimer			= 0;
luaCredit.m_bImageFadeTime		= 0;
luaCredit.m_ImageState			= luaCredit.IMAGE_STATE.IMAGE_NONE;
luaCredit.m_strBGMBackup		= "";
luaCredit.m_bFinalState			= false;
luaCredit.m_bFinished			= false;
luaCredit.m_fImageInjuryTime	= 0;


-- LeaveToCharSelect
function luaCredit:LeaveToCharSelect()
	luaCharacterFrame:SwitchScene( luaCharacter.SwitchToCharSelect);
end

-- ReadyCredit
function luaCredit:ReadyCredit()
	
	luaCredit.m_strBGMBackup	= "";
	luaCredit.m_strBGMBackup	= gamefunc:GetPlayBGM();
	gamefunc:PlayBGM( "" );
	
	--gamedebug:Log( "ReadyCredit() " .. luaCredit.m_strBGMBackup );

end

-- EnterCredit
function luaCredit:EnterCredit()
	
	layerCharCredit:Enable( true );
	layerCharCredit:Show( true );
	pnlCharCredit:Show( true );
	
	luaCredit.m_fScrollTimer		= 0;
	luaCredit.m_fScrollValue		= 0;
	luaCredit.m_nImageIndex			= 0;
	luaCredit.m_fImageTimer			= 0;
	luaCredit.m_fImageInjuryTime	= 0;
	luaCredit.m_ImageState			= luaCredit.IMAGE_STATE.IMAGE_NONE;
	luaCredit.m_bFinalState			= false;
	luaCredit.m_bFinished			= false;
	
	luaCredit:RefreshImageControl();
	luaCredit:SetImage();
	
	-- BGM
	if( "" ~= luaCredit.m_strBGM )		then
		-- play
		gamefunc:PlayBGM( luaCredit.m_strBGM );
	end
	
end

-- LeaveCredit
function luaCredit:LeaveCredit()
	
	--gamedebug:Log( "LeaveCredit" .. luaCredit.m_strBGMBackup );
	
	if( "" ~= luaCredit.m_strBGMBackup )	then
		gamefunc:PlayBGM( luaCredit.m_strBGMBackup );
		luaCredit.m_strBGMBackup		= "";
	end
	
end

-- RefreshImageControl
function luaCredit:RefreshImageControl()
	
	local nWidth, nHeight	= gamefunc:GetWindowSize();
	local nW, nH	= pnlImage:GetSize();
	
	-- 이미지 크기 변경( 960:770 ) 비율 고정
	nH		= nHeight - 100;	-- 위/아래 50씩 확보
	nW		= ( 960 * nH ) / 770;
	pnlImage:SetSize( nW, nH );
	picCreditImage:SetSize( nW, nH );
	
	-- 창 크기에 따라 이지미 중앙배치
	local nX	= luaCredit.m_nImageX;
	local nY	= math.max( 0, ( ( nHeight - nH ) / 2 ) );
	pnlImage:SetPosition( luaCredit.m_nImageX, nY );
	
	-- 스텝롤 위치 조정( 이미지 오른쪽에 붙도록 )
	local nGW, nGH	= StepRollTextView:GetSize();
	local n = ( nWidth / 10 );
	n = nWidth - nGW - ( n/2 );
	StepRollTextView:SetPosition( n, 0 );
	
	-- 그라데이션
	local nGraHeight	= 150;
	picGradationTop:SetSize( nWidth, nGraHeight );
	picGradationTop:SetPosition( 0, 0 );
	
	picGradationBottom:SetSize( nWidth, nGraHeight );
	picGradationBottom:SetPosition( 0, nHeight - nGraHeight );
end

-- SetImageFinal
function luaCredit:SetImageFinal()
	
	-- 이미지 중앙 정렬
	local nWidth, nHeight	= gamefunc:GetWindowSize();
	local nW, nH	= pnlImage:GetSize();
	
	local nX	= math.max( 0, ( nWidth - nW ) / 2 );
	local nY	= math.max( 0, ( nHeight - nH ) / 2 );
	pnlImage:SetPosition( nX, nY );
	
end

-- SetImage
function luaCredit:SetImage()
	
	local strImage	= "";
	if( true == luaCredit.m_bFinalState )	then
		-- 종료 이미지로 변경
		strImage		= gamefunc:GetCreditImageString( luaCredit.m_strFinishedImage );
		luaCredit:SetImageFinal();
	else
		strImage		= gamefunc:GetCreditImage( luaCredit.m_nImageIndex );
		
		luaCredit.m_nImageIndex = luaCredit.m_nImageIndex +1;
		if( luaCredit.m_nImageIndex >= luaCredit.m_nImageCount )	then
			luaCredit.m_nImageIndex = 0;
		end
	end
	
	picCreditImage:SetImage( strImage );
	
end

-- SetImageChange
function luaCredit:SetImageChange()

	if( true == luaCredit.m_bFinalState )	then
		luaCredit:LeaveToCharSelect();
		luaCredit.m_bFinished		= true;
	else
		-- 스크롤 남은 시간이 이미지 한장을 보여주는 시간보다 작다면 그냥 마지막이미지로 변경해주자
		local nMin, nMax	= StepRollTextView:GetScrollBarRange();
		local nStepRollTime	= nMax - luaCredit.m_fScrollValue;
		--gamedebug:Log( "남은시간 " .. nStepRollTime );
		if( nStepRollTime > 0 )	then
			nStepRollTime	= nStepRollTime / luaCredit.m_fScrollSpeed;	
		
			if( ( luaCredit.m_fImageChangeTime + ( luaCredit.m_fImageFadeTime * 2 ) ) > nStepRollTime )	then		-- 0.1는 소숫점 계산등의 오차의 여유분
				-- 그냥 마지막 이미지로 변경
				luaCredit.m_bFinalState			= true;
				luaCredit.m_fImageInjuryTime	= nStepRollTime;
				--gamedebug:Log( "마지막으로 변경 스크롤 남은시간 " .. nStepRollTime );
			end
		end
		
		luaCredit.m_ImageState		= luaCredit.IMAGE_STATE.IMAGE_OUT;
	end
		
	luaCredit.m_bImageFadeTime	= gamefunc:GetUpdateTime();
	
end

-- UpdateImageChange
function luaCredit:UpdateImageChange()
	
	local nOpa		= picCreditImage:GetOpacity();
	local fElapsed	= ( gamefunc:GetUpdateTime() - luaCredit.m_bImageFadeTime ) / ( luaCredit.m_fImageFadeTime * 1000 );
	luaCredit.m_bImageFadeTime	= gamefunc:GetUpdateTime();
	
	if( luaCredit.IMAGE_STATE.IMAGE_OUT == luaCredit.m_ImageState )		then
		
		nOpa		= nOpa - fElapsed;
		if( 0 > nOpa )	then
			nOpa		= 0;
			luaCredit.m_ImageState = luaCredit.IMAGE_STATE.IMAGE_IN;
			
			luaCredit:SetImage();
		end
		
	elseif( luaCredit.IMAGE_STATE.IMAGE_IN == luaCredit.m_ImageState )	then
		
		nOpa		= nOpa + fElapsed;
		if( 1 < nOpa )	then
			nOpa		= 1;
			luaCredit.m_ImageState = luaCredit.IMAGE_STATE.IMAGE_NONE;
			
			-- 이미지 변경 시간 갱신
			luaCredit.m_fImageTimer = gamefunc:GetUpdateTime();

		end
	
	end
	
	--gamedebug:Log( "UpdateImageChange " .. nOpa );
	picCreditImage:SetOpacity( nOpa );
	
end

-- UpdateImage
function luaCredit:UpdateImage()
	
	if( true == luaCredit.m_bFinished )	then
		return ;
	end
	
	if( 0 == luaCredit.m_fImageTimer )	then
		luaCredit.m_fImageTimer		= gamefunc:GetUpdateTime();
	end
		
	local fElapsed = gamefunc:GetUpdateTime() - luaCredit.m_fImageTimer;
	if( ( ( luaCredit.m_fImageChangeTime + luaCredit.m_fImageInjuryTime ) * 1000 ) < fElapsed )	then
		--gamedebug:Log( "테스트1" );
		luaCredit:SetImageChange();		
	end
	
	--gamedebug:Log( "luaCredit:OnUpdateCredit() " .. fElapsed );
		
end

-- OnUpdateCredit
function luaCredit:OnUpdateCredit()
	
	if( luaCredit.IMAGE_STATE.IMAGE_NONE ~= luaCredit.m_ImageState )	then
		luaCredit:UpdateImageChange();
	else
		luaCredit:UpdateImage();
	end
	
end

-- OnUpdate
function luaCredit:OnUpdate()
		
	if( 0 == luaCredit.m_fScrollTimer ) then
		luaCredit.m_fScrollTimer = gamefunc:GetUpdateTime();
		luaCredit.m_fScrollValue = 0;
	end
	
	local fElapsed = gamefunc:GetUpdateTime() - luaCredit.m_fScrollTimer;
	luaCredit.m_fScrollTimer = gamefunc:GetUpdateTime();
	
	luaCredit.m_fScrollValue = luaCredit.m_fScrollValue + ( ( fElapsed / 1000.0 ) * luaCredit.m_fScrollSpeed );
	StepRollTextView:SetScrollValue( luaCredit.m_fScrollValue );
	
	local nMin, nMax	= StepRollTextView:GetScrollBarRange();
	
	if( true == luaCredit.m_bFinalState )	then
		return;
	end
	
	if( nMax < luaCredit.m_fScrollValue )	then
		luaCredit:SetFinalState();
	end
	
end

-- SetFinalState
function luaCredit:SetFinalState()
	-- 마지막 이미지 변경
	luaCredit:SetImageChange();
	--gamedebug:Log( "테스트2" );
	luaCredit.m_bFinalState		= true;
	
end

-- BeginSpaceText
function luaCredit:BeginSpaceText()
	
	local nWidth, nHeight	= gamefunc:GetWindowSize();
	local nFontHeight		= 10; -- 10 여백
	local nSpace			= ( nHeight / nFontHeight );
	
	return nSpace;	
	
end

-- SetupCreditText
function luaCredit:SetupCreditText()
	
	local s = "{FONT name=\"fntCreditTitle\"}";
	-- 시작 여백 넣기
	local nSpace = luaCredit:BeginSpaceText();
	for  i = 0, nSpace  do
		s = s .. "\n";
	end
	-- 수정 금지
	
	s = s .. "{ALIGN hor=\"center\"}";
	
	--for  i = 0, 10  do
		s = s .. "{FONT name=\"fntCreditMainTitle\"}{COLOR r=230 g=230 b=230}Raiderz{/COLOR}\n\n";
		s = s .. "{FONT name=\"fntCreditTitle\"}{COLOR r=212 g=130 b=1}Producer{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}조중필{/COLOR}\n\n";
		s = s .. "{FONT name=\"fntCreditTitle\"}{COLOR r=212 g=130 b=1}Director{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}남기룡{/COLOR}\n\n\n";

		s = s .. "{FONT name=\"fntCreditTitle\"}{COLOR r=212 g=130 b=1}ART{/COLOR}\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Art Director{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}김성환{/COLOR}\n\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Lead Artist{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}정희철{/COLOR}\n\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Background Concept Artists{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}장진원{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}김무준{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}최남식{/COLOR}\n\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Background Modelers{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}국훈{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}주신영{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}윤주흠{/COLOR}\n\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Character Concept Artists{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}박성진{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}배지혁{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}김윤미{/COLOR}\n\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Character Modelers{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}신정호{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}박성아{/COLOR}\n\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Animators{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}김진호{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}채종욱{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}정정우{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}강세희{/COLOR}\n\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Effect Artists{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}채승욱{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}윤선희{/COLOR}\n\n\n";

		s = s .. "{FONT name=\"fntCreditTitle\"}{COLOR r=212 g=130 b=1}Engineering{/COLOR}\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Lead Programmer{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}표효성{/COLOR}\n\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Server Programmers{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}차한근{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}원창현{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}류성훈{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}오창근{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}안중원{/COLOR}\n\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Client Programmers{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}권오현{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}박익성{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}정철희{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}장재진{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}김정민{/COLOR}\n\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Client & Platform Programmer{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}임동환{/COLOR}\n\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Lead DB Programmer{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}추교성{/COLOR}\n\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}DB Programmers{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}홍기주{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}오승민{/COLOR}\n\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Technical Director{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}나자영{/COLOR}\n\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Lead Engine Programmer{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}박근배{/COLOR}\n\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Engine Programmers{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}김준학{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}오지현{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}이수원{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}정호기{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}고정석{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}유종문{/COLOR}\n\n\n";

		s = s .. "{FONT name=\"fntCreditTitle\"}{COLOR r=212 g=130 b=1}Game Design{/COLOR}\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Lead Designer{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}이종혁{/COLOR}\n\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Assistant Lead Designers{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}김상훈{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}황충환{/COLOR}\n\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Game Designers{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}이재형{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}염현철{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}박상현{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}전태은{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}한상권{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}이경은{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}송영주{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}장재곤{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}조찬만{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}김정렬{/COLOR}\n\n\n";

		s = s .. "{FONT name=\"fntCreditTitle\"}{COLOR r=212 g=130 b=1}Sound{/COLOR}\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Sound Producer{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}문민호{/COLOR}\n\n\n";

		s = s .. "{FONT name=\"fntCreditTitle\"}{COLOR r=212 g=130 b=1}Development Support Team{/COLOR}\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Development PM{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}김동혁{/COLOR}\n\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}QA{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}정만기{/COLOR}\n\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}System Engineer{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}김윤하{/COLOR}\n\n\n";

		s = s .. "{FONT name=\"fntCreditTitle\"}{COLOR r=212 g=130 b=1}Business{/COLOR}\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Marketing Director{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}김용오{/COLOR}\n\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}International Brand Managers{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}이승애{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}이정훈{/COLOR}\n\n\n\n";

		s = s .. "{FONT name=\"fntCreditTitle\"}{COLOR r=212 g=130 b=1}- Neowiz Staff -{/COLOR}\n\n\n";
		
		s = s .. "{FONT name=\"fntCreditTitle\"}{COLOR r=212 g=130 b=1}Publishing Business Division{/COLOR}\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Project General Manager - Vice President{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}김정훈{/COLOR}\n\n";
		
		s = s .. "{FONT name=\"fntCreditTitle\"}{COLOR r=212 g=130 b=1}Business Team{/COLOR}\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Project Director{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}조웅희{/COLOR}\n\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Team Manager{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}윤주홍{/COLOR}\n\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Project Managers{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}최수영{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}정수환{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}이준호{/COLOR}\n\n";
		
		s = s .. "{FONT name=\"fntCreditTitle\"}{COLOR r=212 g=130 b=1}Service Product Management Team{/COLOR}\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Group Manager{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}이도형{/COLOR}\n\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Team Manager{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}이우진{/COLOR}\n\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Service Product Managers{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}김동욱{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}박중국{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}이정아{/COLOR}\n\n";
		
		s = s .. "{FONT name=\"fntCreditTitle\"}{COLOR r=212 g=130 b=1}Marketing Team{/COLOR}\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Group Manager{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}이신정{/COLOR}\n\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Team Manager{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}이진숙{/COLOR}\n\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Marketers{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}김은지{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}신상화{/COLOR}\n\n";
		
		s = s .. "{FONT name=\"fntCreditTitle\"}{COLOR r=212 g=130 b=1}Publishing Service Planning Team{/COLOR}\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Team Manager{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}공정윤{/COLOR}\n\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Publishing Service Planner{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}한희성{/COLOR}\n\n";
		
		s = s .. "{FONT name=\"fntCreditTitle\"}{COLOR r=212 g=130 b=1}Publishing PR Team{/COLOR}\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Group Manager{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}김준현{/COLOR}\n\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Team Manager{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}김창현{/COLOR}\n\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}PR Planner{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}임지웅{/COLOR}\n\n";
		
		s = s .. "{FONT name=\"fntCreditTitle\"}{COLOR r=212 g=130 b=1}Database Engineering Team{/COLOR}\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Team Manager{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}박필호{/COLOR}\n\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Engineer{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}조영재{/COLOR}\n\n";
		
		s = s .. "{FONT name=\"fntCreditTitle\"}{COLOR r=212 g=130 b=1}System Engineering Team{/COLOR}\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Team Manager{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}김동하{/COLOR}\n\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Engineer{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}문재우{/COLOR}\n\n";
		
		s = s .. "{FONT name=\"fntCreditTitle\"}{COLOR r=212 g=130 b=1}Service Operations Team{/COLOR}\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Service Operations Manager{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}이시대{/COLOR}\n\n";
		
		s = s .. "{FONT name=\"fntCreditTitle\"}{COLOR r=212 g=130 b=1}Publishing Development Group{/COLOR}\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Group Manager{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}김원기{/COLOR}\n\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Team Managers{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}김경환{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}김태양{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}장성국{/COLOR}\n\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Web / Infra Programmers{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}박성욱{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}정병태{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}한재현{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}이종호{/COLOR}\n\n";
		
		s = s .. "{FONT name=\"fntCreditTitle\"}{COLOR r=212 g=130 b=1}Publishing Design Team{/COLOR}\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Group Manager{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}정해원{/COLOR}\n\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Designers{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}배덕민{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}이동환{/COLOR}\n\n";
		
		s = s .. "{FONT name=\"fntCreditTitle\"}{COLOR r=212 g=130 b=1}Publishing Quality Assurance Team{/COLOR}\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Team Manager{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}이종호{/COLOR}\n\n";
		s = s .. "{FONT name=\"fntCreditSubTitle\"}{COLOR r=208 g=154 b=50}Testers{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}류지형{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}신현필{/COLOR}\n\n\n\n";
		
		
		s = s .. "{FONT name=\"fntCreditTitle\"}{COLOR r=212 g=130 b=1}- Outsourcing Staff -{/COLOR}\n\n\n";

		s = s .. "{FONT name=\"fntCreditTitle\"}{COLOR r=212 g=130 b=1}Translation{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}라이온브리지{/COLOR}\n\n";
		s = s .. "{FONT name=\"fntCreditTitle\"}{COLOR r=212 g=130 b=1}Modeling & Texture{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}아트코딩{/COLOR}\n"
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}아트리게임즈{/COLOR}\n\n"
		s = s .. "{FONT name=\"fntCreditTitle\"}{COLOR r=212 g=130 b=1}Sound{/COLOR}\n";
		s = s .. "{FONT name=\"fntRegular\"}{COLOR r=230 g=230 b=230}웨이브코어{/COLOR}\n\n\n"	
		
		s = s .. "{FONT name=\"fntCreditMainTitle\"}{COLOR r=230 g=230 b=230}Thank You{/COLOR}\n";
	--end
	
	-- 마지막 여백 넣기
	s = s .. "{FONT name=\"fntCreditTitle\"}";
	for  i = 0, nSpace  do
		s = s .. "\n";
	end
	-- 수정 금지

	StepRollTextView:SetText( s );
	
	--gamedebug:Log( "테스트4" );
end
