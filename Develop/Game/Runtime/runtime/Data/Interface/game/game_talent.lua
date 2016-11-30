--[[
	Game Talent LUA script
--]]


-- Global instance
luaTalent = {};


-- Current selected slot
luaTalent.TalentSlot = nil;

luaTalent.Active = false;


-- Default Position
luaTalent.nDefaultX	= 72;
luaTalent.nDefaultY	= 50;


-- OnShowTalentFrame
function luaTalent:OnShowTalentFrame()

	luaTalent.TalentSlot = nil;
	frmConfirmLearnTalent:Show( false);
	frmConfirmCheckStyle:Show(false);

	-- SetMainTalent	
	luaTalent:SetMainTalent();

	-- Show
	if ( frmTalent:GetShow() == true )  then


		luaTalent:OnRefreshTalent();
				
	-- Hide
	else

	end
				
	luaGame:ShowWindow( frmTalent);
end


-- SetMainTalent
function luaTalent:SetMainTalent()

	--local MaxTP		= 0;
	--local CurrTP	= 0;
	--local nIdx		= 0;
	--for  i = TALENT_TYPE.DEFENDER, TALENT_TYPE.GESTURE, 1  do	
	--	CurrTP		= gamefunc:GetSpentTalentPoint( i );
	--	local strMsg = CurrTP;
	--	gamedebug:Log( strMsg );
	--end

	--[[
	local nDefTP, nBerTP, nCleTP, nSorTP, nCurrIdx;	
	nCurrIdx	= 0;
	nDefTP		= gamefunc:GetSpentTalentPoint( TALENT_TYPE.DEFENDER);
	nBerTP		= gamefunc:GetSpentTalentPoint( TALENT_TYPE.BERSERKER);
	nCleTP		= gamefunc:GetSpentTalentPoint( TALENT_TYPE.CLERIC);
	nSorTP		= gamefunc:GetSpentTalentPoint( TALENT_TYPE.SORCERER);
	
	if( nDefTP < nBerTP ) then
		if( nBerTP < nCleTP ) then
			nCurrIdx	= 2;
		else
			nCurrIdx	= 1;
		end
	else
		if( nDefTP < nCleTP ) then
		nCurrIdx	= 2;
		end
	end
	--]]

	local nTP, nCurrIdx, nTabCount;	
	nTP 		= {}
	nTabCount	= 5;
	nCurrIdx	= 0;
	
	nTP[0]		= gamefunc:GetSpentTalentPoint( TALENT_TYPE.DEFENDER);
	nTP[1]		= gamefunc:GetSpentTalentPoint( TALENT_TYPE.BERSERKER);
	nTP[2]		= gamefunc:GetSpentTalentPoint( TALENT_TYPE.CLERIC);
	nTP[3]		= gamefunc:GetSpentTalentPoint( TALENT_TYPE.SORCERER);
	nTP[4]		= gamefunc:GetSpentTalentPoint( TALENT_TYPE.ASSASSIN);

	for  i = 0, nTabCount-2  do
		if ( nTP[i] < nTP[i+1] ) then
			nCurrIdx = i+1
		else
			nTP[i+1] = nTP[i]
		end
	end
		
	tbcTalentTabCtrl:SetSelIndex( nCurrIdx );
end


-- OnRefreshTalent
function luaTalent:OnRefreshTalent()

	if ( frmTalent:GetShow() == false)  then  return;
	end
		

	-- Update talent slot
	local nTabNum = tbcTalentTabCtrl:GetSelIndex();
	local strTalentName = "";
	local strAddName = "";
	local nSpendTP = 0;
	
	-- Defender
	if ( nTabNum == 0)  then
	
		strTalentName = "tsTalent_Def";
		strAddName	= "btnTalent_Def";
		nSpendTP = gamefunc:GetSpentTalentPoint( TALENT_TYPE.DEFENDER);
		
	-- Berserk
	elseif ( nTabNum == 1)  then
	
		strTalentName = "tsTalent_Ber";
		strAddName	= "btnTalent_Ber";
		nSpendTP = gamefunc:GetSpentTalentPoint( TALENT_TYPE.BERSERKER);
	
	-- Cleric
	elseif ( nTabNum == 2)  then
	
		strTalentName = "tsTalent_Cle";
		strAddName	= "btnTalent_Cle";
		nSpendTP = gamefunc:GetSpentTalentPoint( TALENT_TYPE.CLERIC);

	-- Sorcerer
	elseif ( nTabNum == 3)  then
	
		strTalentName = "tsTalent_Sor";
		strAddName	= "btnTalent_Sor";
		nSpendTP = gamefunc:GetSpentTalentPoint( TALENT_TYPE.SORCERER);
	
	-- Asse	
	elseif ( nTabNum == 4)  then
	
		strTalentName = "tsTalent_Ass";
		strAddName	= "btnTalent_Ass";
		nSpendTP = gamefunc:GetSpentTalentPoint( TALENT_TYPE.ASSASSIN);

	end
		
--	elseif ( nTabNum == 4)  then

--		tempvideo:Open("sample_mpeg.avi");
--		return
--	end
		
	
	for  i = 0, 100  do

		local _wnd = _G[ strTalentName .. i];
		if _wnd ~= nil then
			_wnd:UpdateInfo();
			_wnd:Enable( true);

			local _btnwnd = _G[ strAddName .. i];
			if _btnwnd ~= nil then
					_btnwnd:Show(true);
			end
		end
	end

	offop = 0.1;
	if (luaTalent.Active == false) then
		picTalentFrameHide1:SetOpacity( offop );
		picTalentFrameHide2:SetOpacity( offop );
	else
		picTalentFrameHide1:SetOpacity( 0.0 );
		picTalentFrameHide2:SetOpacity( 0.0 );
	end
		
	-- Update talent point
	local strText
	
	strText = --"{ALIGN hor=\"center\"}{BITMAP name=\"bmpContentBar\" w=300 h=25}{CR h=1}{FONT name=\"fntLarge\"}{COLOR r=160 g=120 b=55}" .. STR("UI_TALENT_SKILLPOINT") .. "{/COLOR}{CR}" .. -- 1104 스킬 포인트 아래 내용 부분
		"{ALIGN hor=\"left\"}{FONT name=\"fntScript\"}" .. STR( "UI_TALENT_INVESTEDTALENTPOINT") .. " : {CR h=0}{ALIGN hor=\"right\"}{FONT name=\"fntLarge\"}{COLOR r=160 g=128 b=64}" .. gamefunc:GetSpentTalentPointAll() .. "{/COLOR}{CR}" .. -- 1104 사용한 스킬 포인트
		"{ALIGN hor=\"left\"}{INDENT dent=20}{FONT name=\"fntScript\"}" .. STR( "STYLE_DEFENDER") .. " " .. STR( "STYLE") .. " : {CR h=0}{ALIGN hor=\"right\"}{COLOR r=160 g=128 b=64}" ..  gamefunc:GetSpentTalentPoint( TALENT_TYPE.DEFENDER) .. "{/COLOR}{CR}{/INDENT}" .. -- 1104 디펜더 스타일
		"{ALIGN hor=\"left\"}{INDENT dent=20}{FONT name=\"fntScript\"}" .. STR( "STYLE_BERSERKER") .. " " ..  STR( "STYLE") .. " : {CR h=0}{ALIGN hor=\"right\"}{COLOR r=160 g=128 b=64}" ..  gamefunc:GetSpentTalentPoint( TALENT_TYPE.BERSERKER) .. "{/COLOR}{CR}{/INDENT}" .. -- 1104 버서커 스타일
		"{ALIGN hor=\"left\"}{INDENT dent=20}{FONT name=\"fntScript\"}" .. STR( "STYLE_CLERIC") ..  " " ..  STR( "STYLE") .. " : {CR h=0}{ALIGN hor=\"right\"}{COLOR r=160 g=128 b=64}" ..  gamefunc:GetSpentTalentPoint( TALENT_TYPE.CLERIC) .. "{/COLOR}{CR}{/INDENT}" .. -- 1104 클레릭 스타일
		"{ALIGN hor=\"left\"}{INDENT dent=20}{FONT name=\"fntScript\"}" .. STR( "STYLE_SORCERER") ..  " " ..  STR( "STYLE") .. " : {CR h=0}{ALIGN hor=\"right\"}{COLOR r=160 g=128 b=64}" ..  gamefunc:GetSpentTalentPoint( TALENT_TYPE.SORCERER ) .. "{/COLOR}{CR}{/INDENT}" .. -- 1104 소서러 스타일
		"{ALIGN hor=\"left\"}{INDENT dent=20}{FONT name=\"fntScript\"}" .. STR( "STYLE_ASSASSIN") ..  " " ..  STR( "STYLE") .. " : {CR h=0}{ALIGN hor=\"right\"}{COLOR r=160 g=128 b=64}" ..  gamefunc:GetSpentTalentPoint( TALENT_TYPE.ASSASSIN ) .. "{/COLOR}{CR}{/INDENT}" .. -- 1203  어쌔신 스타일
		"{CR h=10}" ..
		"{ALIGN hor=\"left\"}{FONT name=\"fntScript\"}" .. STR( "UI_TALENT_AVAILABLETALENTPOINT") .. " : {CR h=0}{ALIGN hor=\"right\"}{FONT name=\"fntLarge\"}{COLOR r=160 g=128 b=64}" ..  gamefunc:GetTalentPoint() .. "{/COLOR}{/INDENT}"; -- 사용 가능한 스킬 포인트
				
	tvwSpendTPInTalent:SetText( strText);
end





-- OnToolTipTalentSlot
function luaTalent:OnToolTipTalentSlot( bFocus)

	local _wnd = _G[ EventArgs:GetOwner():GetName()];

	local nTalentID = _wnd:GetTalentID();
	local strToolTip = luaToolTip:GetTalentToolTip( nTalentID, bFocus, false);
	_wnd:SetToolTip( strToolTip);
end





-- SetTalentStyleMsg
function luaTalent:SetTalentStyleMsg()

	local str;

	-- Defender	
	str = "{ALIGN hor=\"left\" ver=\"center\"}" .. 
		"{FONT name=\"fntLarge\"}{COLOR r=160 g=120 b=55}" .. STR( "STYLE_DEFENDER") .. "{SPACE w=5}" ..
		"{FONT name=\"fntRegular\"}" .. STR( "STYLE") .. "{/COLOR}";
    tvwStyleDefender:SetText( str);

	str = "{FONT name=\"fntScript\"}" .. STR( "UI_SKILL_DEFENDER_DESC");
    tvwStyleInfoDefender:SetText( str);

	str = "{ALIGN hor=\"left\" ver=\"center\"}" ..
		"{FONT name=\"fntLarge\"}{COLOR r=160 g=120 b=55}" .. gamefunc:GetTalentName( tsTalent_Def0:GetTalentID()) .. "{SPACE w=5}" ..
		"{FONT name=\"fntRegular\"}" .. STR( "FOCUS") .. "{/COLOR}";
    tvwFocusDefender:SetText( str);

	str = "{FONT name=\"fntScript\"}" .. STR( "UI_FOCUS_DEFENDER_DESC");
    tvwFocusInfoDefender:SetText( str);


	-- Berserker
	str = "{ALIGN hor=\"left\" ver=\"center\"}" .. 
		"{FONT name=\"fntLarge\"}{COLOR r=160 g=120 b=55}" .. STR( "STYLE_BERSERKER") .. "{SPACE w=5}" ..
		"{FONT name=\"fntRegular\"}" .. STR( "STYLE") .. "{/COLOR}";
    tvwStyleBerserker:SetText( str);

	str = "{FONT name=\"fntScript\"}" .. STR( "UI_SKILL_BERSERKER_DESC");
    tvwStyleInfoBerserker:SetText( str);

	str = "{ALIGN hor=\"left\" ver=\"center\"}" ..
		"{FONT name=\"fntLarge\"}{COLOR r=160 g=120 b=55}" .. gamefunc:GetTalentName( tsTalent_Ber0:GetTalentID()) .. "{SPACE w=5}" ..
		"{FONT name=\"fntRegular\"}" .. STR( "FOCUS") .. "{/COLOR}";
    tvwFocusBerserker:SetText( str);

	str = "{FONT name=\"fntScript\"}" .. STR( "UI_FOCUS_BERSERKER_DESC");
    tvwFocusInfoBerserker:SetText( str);


	-- Cleric
	str = "{ALIGN hor=\"left\" ver=\"center\"}" .. 
		"{FONT name=\"fntLarge\"}{COLOR r=160 g=120 b=55}" .. STR( "STYLE_CLERIC") .. "{SPACE w=5}" ..
		"{FONT name=\"fntRegular\"}" .. STR( "STYLE") .. "{/COLOR}";
    tvwStyleCleric:SetText( str);

	str = "{FONT name=\"fntScript\"}" .. STR( "UI_SKILL_CLERIC_DESC");
    tvwStyleInfoCleric:SetText( str);

	str = "{ALIGN hor=\"left\" ver=\"center\"}" ..
		"{FONT name=\"fntLarge\"}{COLOR r=160 g=120 b=55}" .. gamefunc:GetTalentName( tsTalent_Cle0:GetTalentID()) .. "{SPACE w=5}" ..
		"{FONT name=\"fntRegular\"}" .. STR( "FOCUS") .. "{/COLOR}";
    tvwFocusCleric:SetText( str);

	str = "{FONT name=\"fntScript\"}" .. STR( "UI_FOCUS_CLERIC_DESC");
    tvwFocusInfoCleric:SetText( str);


	-- Sorcerer	
	str = "{ALIGN hor=\"left\" ver=\"center\"}" .. 
		"{FONT name=\"fntLarge\"}{COLOR r=160 g=120 b=55}" .. STR( "STYLE_SORCERER") .. "{SPACE w=5}" ..
		"{FONT name=\"fntRegular\"}" .. STR( "STYLE") .. "{/COLOR}";
    tvwStyleSorcerer:SetText( str);

	str = "{FONT name=\"fntScript\"}" .. STR( "UI_SKILL_SORCERER_DESC");
    tvwStyleInfoSorcerer:SetText( str);

	str = "{ALIGN hor=\"left\" ver=\"center\"}" ..
		"{FONT name=\"fntLarge\"}{COLOR r=160 g=120 b=55}" .. gamefunc:GetTalentName( tsTalent_Sor0:GetTalentID()) .. "{SPACE w=5}" ..
		"{FONT name=\"fntRegular\"}" .. STR( "FOCUS") .. "{/COLOR}";
    tvwFocusSorcerer:SetText( str);

	str = "{FONT name=\"fntScript\"}" .. STR( "UI_FOCUS_SORCERER_DESC");
    tvwFocusInfoSorcerer:SetText( str);
	

	-- Assassin
	str = "{ALIGN hor=\"left\" ver=\"center\"}" .. 
		"{FONT name=\"fntLarge\"}{COLOR r=160 g=120 b=55}" .. STR( "STYLE_ASSASSIN") .. "{SPACE w=5}" ..
		"{FONT name=\"fntRegular\"}" .. STR( "STYLE") .. "{/COLOR}";
    tvwStyleAssassin:SetText( str);

	str = "{FONT name=\"fntScript\"}" .. STR( "UI_SKILL_ASSASSIN_DESC");
    tvwStyleInfoAssassin:SetText( str);

	str = "{ALIGN hor=\"left\" ver=\"center\"}" ..
		"{FONT name=\"fntLarge\"}{COLOR r=160 g=120 b=55}" .. gamefunc:GetTalentName( tsTalent_Ass0:GetTalentID()) .. "{SPACE w=5}" ..
		"{FONT name=\"fntRegular\"}" .. STR( "FOCUS") .. "{/COLOR}";
    tvwFocusAssassin:SetText( str);

	str = "{FONT name=\"fntScript\"}" .. STR( "UI_FOCUS_ASSASSIN_DESC");
    tvwFocusInfoAssassin:SetText( str);

end





-- OnClickTalentSlot
function luaTalent:OnClickTalentSlot(wnd)

	local _wnd;

	if ( wnd == nil) then 
		_wnd = _G[ EventArgs:GetOwner():GetName()];
	else
		_wnd = wnd
	end

	if ( _wnd:IsLearnable() == false)  then  return;
	end
	
	local nTalentID = _wnd:GetTalentID();
	if ( nTalentID == 0)  then  return;
	end	


	luaTalent.TalentSlot = _wnd;
	_wnd:Enable( false);

	luaTalent:OpenConfirmLearnTalent();
end











-- OpenConfirmLearnTalent
function luaTalent:OpenConfirmLearnTalent()

	if ( frmTalent:GetShow() == false)  then  return;
	end
	
	if ( luaTalent.TalentSlot == nil)  then  return;
	end

	local nTalentID = luaTalent.TalentSlot:GetTalentID();
	if ( nTalentID == 0)  then  return;
	end	
	
	
	-- Talent info	
	tvwLearnTalent:SetText( STR( "UI_TALENT_CONFIRMLEARNTALENT"));
	

	-- Show frame
	local x, y = frmConfirmLearnTalent:GetParent():GetPosition();
	local w, h = frmConfirmLearnTalent:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmConfirmLearnTalent:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);
	frmConfirmLearnTalent:DoModal();
end





-- CloseConfirmLearnTalent
function luaTalent:CloseConfirmLearnTalent()

	luaTalent.TalentSlot:Enable( true);
	luaTalent.TalentSlot = nil;

	frmConfirmLearnTalent:Show( false);
end





-- OnLearnTalentOK
function luaTalent:OnLearnTalentOK()

	if ( luaTalent.TalentSlot == nil)  then  return;
	end
	
	
	luaTalent.TalentSlot:DoLearnTalent();

	luaTalent:CloseConfirmLearnTalent()
end




-- OpenConfirmStyle
function luaTalent:OpenConfirmStyle()

	if ( frmTalent:GetShow() == false)  then  return;
	end
	
	if ( luaTalent.TalentSlot == nil)  then  return;
	end

	local nTalentID = luaTalent.TalentSlot:GetTalentID();
	if ( nTalentID == 0)  then  return;
	end	
	
	-- Talent info
	local nStyle = gamefunc:GetTalentStyle( nTalentID);
	local strStyle = "";
	if ( nStyle == TALENT_TYPE.DEFENDER)  then			strStyle = STR( "STYLE_DEFENDER");
	elseif ( nStyle == TALENT_TYPE.BERSERKER)  then		strStyle = STR( "STYLE_BERSERKER");
	elseif ( nStyle == TALENT_TYPE.ASSASSIN)  then		strStyle = STR( "STYLE_ASSASSIN");
	elseif ( nStyle == TALENT_TYPE.RANGER)  then		strStyle = STR( "STYLE_RANGER");
	elseif ( nStyle == TALENT_TYPE.SORCERER)  then		strStyle = STR( "STYLE_SORCERER");
	elseif ( nStyle == TALENT_TYPE.CLERIC)  then		strStyle = STR( "STYLE_CLERIC");
	elseif ( nStyle == TALENT_TYPE.COMMON)  then		strStyle = STR( "TALENT_COMMON");
	elseif ( nStyle == TALENT_TYPE.LICENSE)  then		strStyle = STR( "TALENT_LICENSE");
	end
	
	tvwCheckStyle:SetText( FORMAT( "UI_TALENT_CONFIRMSTYLE", strStyle));
	

	-- Show frame
	local x, y = frmConfirmCheckStyle:GetParent():GetPosition();
	local w, h = frmConfirmCheckStyle:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmConfirmCheckStyle:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);
	frmConfirmCheckStyle:DoModal();

end






-- CloseConfirmCheckStyle
function luaTalent:CloseConfirmCheckStyle()

	luaTalent.TalentSlot:Enable( true);
	luaTalent.TalentSlot = nil;
	
	frmConfirmCheckStyle:Show( false);
end





-- OnLearnTalentOK
function luaTalent:OnCheckStyleOK()

	if ( luaTalent.TalentSlot == nil)  then  return;
	end
	
	luaTalent.TalentSlot:DoLearnTalent();

	luaTalent:CloseConfirmCheckStyle()
end


-- OnUserArgumentTalent
function luaTalent:OnUserArgumentTalent()
	
	local arg = EventArgs:GetUserArgument();
    if ( arg == "RESTORE_UI")  then

		luaGame:RestoreUIPosition( frmTalent);
		if ( gamefunc:GetAccountParam( "frmTalent", "hold") ~= nil)  then  btnHoldTalent:SetCheck( true);
		end

    elseif ( arg == "RECORD_UI")  then

		luaGame:RecordUIPosition( frmTalent);
		if ( btnHoldTalent:GetCheck() == true)  then  gamefunc:SetAccountParam( "frmTalent", "hold", "1");
		end
		
	elseif ( arg == "RESET_UI")  then
	
	     luaTalent:ResetUI();

    end
    
end

-- ResetUI
function luaTalent:ResetUI()
	
	
	frmTalent:SetPosition( luaTalent.nDefaultX, luaTalent.nDefaultY );
	btnHoldTalent:SetCheck( false );
	
end

-- OnPositionTalentFrame
function luaTalent:OnPositionTalentFrame()	
end
