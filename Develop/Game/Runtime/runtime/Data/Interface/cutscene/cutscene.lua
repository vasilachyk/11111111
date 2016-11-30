
-- 자막 보이기

function shCutSceneEvent_CaptionViewReSize(nFontHeight)
	local boxW, boxH = LetterBoxTopView:GetSize();
	
	local textH = nFontHeight / 2;
	local letterboxH = boxH / 2;
	local h = gamefunc:GetWindowHeight() - letterboxH - textH;

	CaptionTextView:SetPosition(0, h);
end

function shCutSceneEvent_ShowCaptionScript(chScript, nFontHeight)
	shCutSceneEvent_CaptionViewReSize(nFontHeight);
	
	CaptionTextView:Show( true);
	
	chScript = "{ALIGN hor=\"center\"}" .. chScript;
	CaptionTextView:SetText(chScript);
end

function shCutSceneEvent_HideCaptionScript()
	CaptionTextView:Show( false);
end

-- 키 이벤트 보이기
function shCutSceneEvent_ShowKeyEvent(chText, nFontPosX, nFontPosY)
	KeyEventView:SetPosition(nFontPosX, nFontPosY);
	KeyEventView:Show( true);
	KeyEventView:SetText(chText);
end

function shCutSceneEvent_HideKeyEvent()
	KeyEventView:Show( false);
end

-- 레터 박스 사이즈 설정
function shCutSceneEvent_ShowLetterBox(screenW, screenH, letterBoxH)

	LetterBoxTopView:SetSize(screenW, letterBoxH);
	LetterBoxBottomView:SetSize(screenW, letterBoxH);
	
	LetterBoxTopView:SetPosition(0,0)
	LetterBoxBottomView:SetPosition(0, letterBoxH + screenH)
		
	LetterBoxTopView:Show( true)
	LetterBoxBottomView:Show( true)
end

function shCutSceneEvent_HideLetterBox()
	LetterBoxTopView:Show( false)
	LetterBoxBottomView:Show( false)
end
