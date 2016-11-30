--[[
	Create character LUA script
--]]


-- Global instance
luaCharacterCreate = {};


-- Panels
luaCharacterCreate.panels = {};
luaCharacterCreate.panelcount = 0;
luaCharacterCreate.SelStyle	= 0;


-- Scroll
luaCharacterCreate.scroll = {};
	luaCharacterCreate.scroll._run = false;
	luaCharacterCreate.scroll._begin = 0;
	luaCharacterCreate.scroll._end = 0;
	luaCharacterCreate.scroll._timer = 0;


-- Usable style
luaCharacterCreate.STYLE = { TALENT_TYPE.DEFENDER, TALENT_TYPE.BERSERKER, TALENT_TYPE.CLERIC, TALENT_TYPE.SORCERER, TALENT_TYPE.ASSASSIN };
luaCharacterCreate.STYLEICON = { "iconDefender", "iconBerserker", "iconCleric", "iconSorcerer", "iconAssassin" };


-- Tattoo
luaCharacterCreate.TATTOO = {};
	luaCharacterCreate.TATTOO.x = 0;
	luaCharacterCreate.TATTOO.y = 0;


-- Test Voices
luaCharacterCreate.VOICE = { "_1hb_active1", "_1hb_active2", "_1hb_active3" };


-- 캐릭터 생성 시 왼쪽 밑에 나오는 스타일별 스킬 아이콘
luaCharacterCreate.DEFENDER_SKILLICON = { 10703, 10605, 11503 };
luaCharacterCreate.BERSERKER_SKILLICON = { 21905, 20605, 20803 };
luaCharacterCreate.CLERIC_SKILLICON = { 60601, 63002, 61201 };
luaCharacterCreate.SORCERER_SKILLICON = { 52774, 52904, 52930 };
luaCharacterCreate.ASSASSIN_SKILLICON = { 34500, 33500, 33800 };


-- CreateTag
luaCharacterCreate.CREATETAG		= { CREATETAG_STYLE = 0, CREATETAG_MAKEFACE = 1, CREATETAG_HEAD = 2, CREATETAG_TATTOO = 3, CREATETAG_ETC = 4 };
luaCharacterCreate.nCurrTag			= -1;
luaCharacterCreate.fCamMoveDelta	= 0.0;
luaCharacterCreate.Tags				= {};

luaCharacterCreate.strMovieName		= "";
luaCharacterCreate.SKILLMOVIENAME	= { "video_skill_defender", "video_skill_berserker", "video_skill_cleric", "video_skill_sorcerer", "video_skill_assassin" };
luaCharacterCreate.MainCycleDelta	= -1;
luaCharacterCreate.MainCycleIndex	= 1;
luaCharacterCreate.MainCycleTimer	= 200;

-- EnterCharCreate
function luaCharacterCreate:EnterCharCreate()

	-- Change scene
	gamefunc:ChangeCampaignScene( 2 );
	
	-- Refresh UI
	luaCharacterCreate:CloseConfirmCreateCharacter();
	
	luaCharacterCreate:InitData();
	luaCharacterCreate:InitControls();
	
	-- Set random new character
	lcCharacterSex:SetCurSel( math.random( 0, 1) );
	lcCharacterMakeUp:SetCurSel( math.random( 0, lcCharacterMakeUp:GetItemCount() - 1) );
	luaCharacterCreate:SetRandomModel();
	
end





-- LeaveCharCreate
function luaCharacterCreate:LeaveCharCreate()
	
end

-- InitData
function luaCharacterCreate:InitData()
	
	luaCharacterCreate.SelStyle			= -1;
	luaCharacterCreate.TATTOO.x			= 0;
	luaCharacterCreate.TATTOO.y			= 0;
	luaCharacterCreate.strMovieName		= "";
	luaCharacterCreate.MainCycleDelta	= -1;
	luaCharacterCreate.MainCycleIndex	= 1;
	
end

-- InitControls
function luaCharacterCreate:InitControls()
	
	luaCharacterCreate:OnClickCreateTagBtn( luaCharacterCreate.CREATETAG.CREATETAG_STYLE );
	
	edtCharacterName:SetText( "" );
	luaCharacterCreate:CheckCharacterNameValidate();
	lcCharacterPreviewEquip:SetCurSel( 0 );
	
	luaCharacterCreate:InitStyleControl();
	luaCharacterCreate:InitTattooControl();
	luaCharacterCreate:InitETCControl();
	
	local width, height = pnlCharCreate:GetParent():GetSize();
	local x, y, w, h = pnlCharCreate:GetRect();
	y = height - h;
	if( y > 0 )	then
		y = y * 0.5;
	else
		y = 0;
	end
	
	x	= width - w;
	if( 1200 > width )	then
		x = x + 45;
	end
	
	pnlCharCreate:SetPosition( x, y );
	
	width, height = pnlCreateName:GetParent():GetSize();
    x, y, w, h = edtCharacterName:GetRect();
    local nX	= ( (width - w) * 0.5 ) - 40;
    x, y, w, h = pnlCreateName:GetRect();
    pnlCreateName:SetPosition( nX, y );
    
    for _nIdx, _Tag  in pairs( luaCharacterCreate.Tags )  do
		
		luaCharacterCreate:CreateLeftPanelRefresh( _Tag._pnl );
			
	end
	
	pnlVideoSkill:Show( false );
	
end

-- InitStyleControl
function luaCharacterCreate:InitStyleControl()
	
	lcCharacterStyle:SetCurSel( -1 );
	lcCharacterSex:SetCurSel( 1 );
	lcCharacterSex:Show( false );
	
	tvwMainSkill:Show( false );
	picMainSkill1Base:Show( false );
	picMainSkill1:Show( false );
	picMainSkill2Base:Show( false );
	picMainSkill2:Show( false );
	picMainSkill3Base:Show( false );
	picMainSkill3:Show( false );
	tvwMainSkilDesc:Show( false );
	
end

-- InitTattooControl
function luaCharacterCreate:InitTattooControl()
	
	lcCharacterTattoo:SetCurSel( 0 );
	sldTattoScale:SetScrollValue( 5 );
	
end

-- InitETCControl
function luaCharacterCreate:InitETCControl()
	
	lcCharacterVoice:SetCurSel( 0 );
	
end

-- OnLoadedCreateTagBtn
function luaCharacterCreate:OnLoadedCreateTagBtn( nTag, _btn, bBattle, fMoveDelta )
	
	if( nil == luaCharacterCreate.Tags[ nTag ] )	then
		luaCharacterCreate.Tags[ nTag ] = {};
		luaCharacterCreate.Tags[ nTag ].nTag = nTag;
	end
	
	luaCharacterCreate.Tags[ nTag ]._btn		= _btn;
	luaCharacterCreate.Tags[ nTag ].bBattle		= bBattle;
	luaCharacterCreate.Tags[ nTag ].fMoveDelta	= fMoveDelta;
	
end

-- OnClickCreateTagBtn
function luaCharacterCreate:OnClickCreateTagBtn( nTag )
	
	local bBattle		= false;
	local fMoveDelta	= 0.0;
	for _nIdx, _Tag  in pairs( luaCharacterCreate.Tags )  do
		
		if( _Tag.nTag ~= nTag )	then
			_Tag._btn:SetCheck( false );
			_Tag._pnl:Show( false );
		else
			_Tag._btn:SetCheck( true );
			_Tag._pnl:Show( true );
			bBattle		= _Tag.bBattle;
			fMoveDelta	= _Tag.fMoveDelta;
		end
	
	end
	
	if( nTag == luaCharacterCreate.nCurrTag )	then
		return ;
	end
	
	luaCharacterCreate.nCurrTag = nTag;
	
	luaCharacterCreate:RefreshCharacter( bBattle );
	
end

-- OnLoadedCreateTagPnl
function luaCharacterCreate:OnLoadedCreateTagPnl( nTag, _pnl )
	
	if( nil == luaCharacterCreate.Tags[ nTag ] )	then
		luaCharacterCreate.Tags[ nTag ] = {};
		luaCharacterCreate.Tags[ nTag ].nTag = nTag;
	end
	
	luaCharacterCreate.Tags[ nTag ]._pnl = _pnl;
	
	luaCharacterCreate:CreateLeftPanelRefresh( luaCharacterCreate.Tags[ nTag ]._pnl );
	
end

-- OnDrawItemBkgrndlcCharacterStyle
function luaCharacterCreate:OnDrawItemBkgrndlcCharacterStyle()
	
	local nIndex = EventArgs:GetItemIndex();
	local nSubIndex = EventArgs:GetItemSubItem();
	
	local nStyle = lcCharacterStyle:GetItemData( nIndex );
	
	if ( nSubIndex == 0)  then

		local x, y, w, h = EventArgs:GetItemRect();
		gamedraw:SetBitmap( "bmpCharFrameCreateStyle"..nStyle );
		gamedraw:Draw( x, y, w, h);
	end
	
end

-- OnLoadedCharStyleListCtrl
function luaCharacterCreate:OnLoadedCharStyleListCtrl()

	for  i = 1, 5  do
		
		local nStyle = luaCharacterCreate.STYLE[ i];
		local nStyleName = GetStyleTypeName( nStyle);
	
		if (nStyleName ~= nil) then
			local nIndex = lcCharacterStyle:AddItem( " " .. nStyleName, luaCharacterCreate.STYLEICON[ i]);
			lcCharacterStyle:SetItemData( nIndex, nStyle);
		end		
	end
	
end

-- OnLoadedlcCharacterSex
function luaCharacterCreate:OnLoadedlcCharacterSex()
	
	lcCharacterSex:AddItem( "", "iconCharFrameCreateSexM" );
	lcCharacterSex:AddItem( "", "iconCharFrameCreateSexW" );
	
end

-- OnDrawItemlcCharacterSex
function luaCharacterCreate:OnDrawItemlcCharacterSex()

--[[
	local nIndex = EventArgs:GetItemIndex();
	local x, y, w, h = EventArgs:GetItemRect();
	
	gamedraw:SetBitmap( "bmpGlassPanel");
	gamedraw:Draw( x, y, w, h);
]]--

end

-- OnSelChangelcCharacterStyle
function luaCharacterCreate:OnSelChangelcCharacterStyle()
	
	local nCurSel	= lcCharacterStyle:GetCurSel();
	if( nCurSel == luaCharacterCreate.SelStyle )	then
		return ;
	end
	
	luaCharacterCreate:UpdateCharacterSex();
	
	luaCharacterCreate:SetMainSkill( -1 );
		
	luaCharacterCreate.SelStyle = nCurSel;
	
	lcCharacterPreviewEquip:SetCurSel( lcCharacterStyle:GetCurSel() + 1);
	luaCharacterCreate:RefreshCharacter( true );
	
	luaCharacterCreate:SetMainSkill( luaCharacterCreate.SelStyle );
	

end

-- UpdateMainSkill
function luaCharacterCreate:SetMainSkill( nCurSel )
	
	local strSkill1, strSkill2, strSkill3;
	
	if ( nCurSel >= 0)  then
	
		local nStyle = lcCharacterStyle:GetItemData( nCurSel);
		
		if ( nStyle == TALENT_TYPE.DEFENDER)  then
		
			strSkill1		= gamefunc:GetTalentImage( luaCharacterCreate.DEFENDER_SKILLICON[ 1 ] );
			strSkill2		= gamefunc:GetTalentImage( luaCharacterCreate.DEFENDER_SKILLICON[ 2 ] );
			strSkill3		= gamefunc:GetTalentImage( luaCharacterCreate.DEFENDER_SKILLICON[ 3 ] );
			
		elseif ( nStyle == TALENT_TYPE.BERSERKER)  then

			strSkill1		= gamefunc:GetTalentImage( luaCharacterCreate.BERSERKER_SKILLICON[ 1 ] );
			strSkill2		= gamefunc:GetTalentImage( luaCharacterCreate.BERSERKER_SKILLICON[ 2 ] );
			strSkill3		= gamefunc:GetTalentImage( luaCharacterCreate.BERSERKER_SKILLICON[ 3 ] );
			
		elseif ( nStyle == TALENT_TYPE.CLERIC)  then

			strSkill1		= gamefunc:GetTalentImage( luaCharacterCreate.CLERIC_SKILLICON[ 1 ] );
			strSkill2		= gamefunc:GetTalentImage( luaCharacterCreate.CLERIC_SKILLICON[ 2 ] );
			strSkill3		= gamefunc:GetTalentImage( luaCharacterCreate.CLERIC_SKILLICON[ 3 ] );
			
		elseif ( nStyle == TALENT_TYPE.SORCERER)  then

			strSkill1		= gamefunc:GetTalentImage( luaCharacterCreate.SORCERER_SKILLICON[ 1 ] );
			strSkill2		= gamefunc:GetTalentImage( luaCharacterCreate.SORCERER_SKILLICON[ 2 ] );
			strSkill3		= gamefunc:GetTalentImage( luaCharacterCreate.SORCERER_SKILLICON[ 3 ] );
			
		elseif ( nStyle == TALENT_TYPE.ASSASSIN)  then

			strSkill1		= gamefunc:GetTalentImage( luaCharacterCreate.ASSASSIN_SKILLICON[ 1 ] );
			strSkill2		= gamefunc:GetTalentImage( luaCharacterCreate.ASSASSIN_SKILLICON[ 2 ] );
			strSkill3		= gamefunc:GetTalentImage( luaCharacterCreate.ASSASSIN_SKILLICON[ 3 ] );
			
		end
	
	else
	
		tvwMainSkill:Show( false );
		picMainSkill1Base:Show( false );
		picMainSkill1:Show( false );
		picMainSkill2Base:Show( false );
		picMainSkill2:Show( false );
		picMainSkill3Base:Show( false );
		picMainSkill3:Show( false );
		tvwMainSkilDesc:Show( false );
		return ;
	
	end
	
	tvwMainSkill:Show( true );
	picMainSkill1Base:Show( true );
	picMainSkill1:Show( true );
	picMainSkill2Base:Show( true );
	picMainSkill2:Show( true );
	picMainSkill3Base:Show( true );
	picMainSkill3:Show( true );
	tvwMainSkilDesc:Show( true );
		
	picMainSkill1:SetImage( strSkill1 );
	picMainSkill2:SetImage( strSkill2 );
	picMainSkill3:SetImage( strSkill3 );
		
end

-- UpdateCharacterSex
function luaCharacterCreate:UpdateCharacterSex()
	
	local nCurSel = lcCharacterStyle:GetCurSel();
	if( 0 > nCurSel )  then
		lcCharacterSex:Show( false );
	  return;
	end
		
	lcCharacterSex:Show( true );
	
	local nX		= 200;
	local nY		= ( 49 * nCurSel ) + 50;
	lcCharacterSex:SetPosition( nX, nY );
	
end

-- OnClickCheckNameDuplicate
function luaCharacterCreate:OnClickCheckNameDuplicate()

--[[	
	if( false == gamefunc:IsValidateCharName( edtCharacterName:GetText() ) )	then
		tvwErrorMsg:SetText( strString);
		frmErrorMsgBox:DoModal();
		return ;
	end
	
	gamefunc:FindMatchUser( edtCharacterName:GetText() );
	
	]]--
		
end

-- CreateLeftPanelRefresh
function luaCharacterCreate:CreateLeftPanelRefresh( _wnd )
	
	if( nil == _wnd )	then
		return ;
	end
	
    local width, height = _wnd:GetParent():GetSize();
    height = height - 80;
    local x, y, w, h = _wnd:GetRect();
    local nY		= height * 0.1;
    
    if( ( nY + h ) > height )	then
		_wnd:SetPosition( x, ( height-h ) * 0.5 );
	else
		_wnd:SetPosition( x, nY );
    end

end

-- OnNcHitTestpicMainSkill
function luaCharacterCreate:OnNcHitTestpicMainSkill( _wnd, nIdx )
	
	if( 0 > luaCharacterCreate.SelStyle )	then
		return ;
	end
	
	local strName		= "";
	
	local px, py			= gamefunc:GetCursorPos();
	local x1, y1, w1, h1	= picMainSkill1:GetWindowRect();
	local x2, y2, w2, h2	= picMainSkill2:GetWindowRect();
	local x3, y3, w3, h3	= picMainSkill3:GetWindowRect();
	local x,y;
	
	if( ( px >= x1 ) and ( px < ( x1 + w1 ) ) and ( py >= y1 ) and ( py < ( y1 + h1 ) ) )		then
		strName		= luaCharacterCreate.SKILLMOVIENAME[ luaCharacterCreate.SelStyle + 1 ] .. "_1";
		x = x1;
		y = y1;
	elseif( ( px >= x2 ) and ( px < ( x2 + w2 ) ) and ( py >= y2 ) and ( py < ( y2 + h2 ) ) )	then
		strName		= luaCharacterCreate.SKILLMOVIENAME[ luaCharacterCreate.SelStyle + 1 ] .. "_2";
		x = x2;
		y = y2;
	elseif( ( px >= x3 ) and ( px < ( x3 + w3 ) ) and ( py >= y3 ) and ( py < ( y3 + h3 ) ) )	then
		strName		= luaCharacterCreate.SKILLMOVIENAME[ luaCharacterCreate.SelStyle + 1 ] .. "_3";
		x = x3;
		y = y3;
	end
	
	if(  "" == strName )	then
		if( "" ~= luaCharacterCreate.strMovieName )	then
			luaCharacterCreate:CloseMovie();
		end
		return ;
	end
	
	if( strName == luaCharacterCreate.strMovieName )		then
		return ;
	elseif( "" ~= luaCharacterCreate.strMovieName )			then
		luaCharacterCreate:CloseMovie();
	end
	
	local vx, vy, vw, vh = pnlVideoSkill:GetWindowRect();
	luaCharacterCreate.strMovieName = strName;
	if( true == videoSkill:Open("Data\\Video\\" .. luaCharacterCreate.strMovieName .. ".avi", true ) )	then
		pnlVideoSkill:Show( true );
		pnlVideoSkill:SetPosition( x, y - vh - 10 );
	else
		pnlVideoSkill:Show( false );
	end
	
	
end

-- CloseMovie
function luaCharacterCreate:CloseMovie()
	
	--videoSkill:Close();
	pnlVideoSkill:Show( false );
	luaCharacterCreate.strMovieName		= "";
		
end

-- RefreshCharacter
function luaCharacterCreate:RefreshCharacter( bChangeMotion )

	luaCharacterCreate:OnSelChangeCharListCtrl();

	luaCharacterCreate:RefreshCharacterModel( bChangeMotion );
	luaCharacterCreate:RefreshControls();
end

-- RefreshCharacterModel
function luaCharacterCreate:RefreshCharacterModel( bChangeMotion )

	local tCharacter = {};
	if( 0 == lcCharacterSex:GetCurSel() )	then
		tCharacter.sex = 0
	else
		tCharacter.sex = 1
	end
	
	-- Character model
	tCharacter.style = lcCharacterStyle:GetItemData( math.max( 0, lcCharacterStyle:GetCurSel()) );
	tCharacter.face = lcCharacterFace:GetItemData( math.max( 0, lcCharacterFace:GetCurSel()) );
	tCharacter.hair = lcCharacterHair:GetItemData( math.max( 0, lcCharacterHair:GetCurSel()) );
	tCharacter.skin_col = lcCharacterSkinColor:GetItemData( math.max( 0, lcCharacterSkinColor:GetCurSel()) );
	tCharacter.hair_col = lcCharacterHairColor:GetItemData( math.max( 0, lcCharacterHairColor:GetCurSel()) );
	tCharacter.voice = lcCharacterVoice:GetItemData( math.max( 0, lcCharacterVoice:GetCurSel()) );
	tCharacter.eye_col = lcCharacterEyeColor:GetItemData( math.max( 0, lcCharacterEyeColor:GetCurSel()) );
	tCharacter.makeup = lcCharacterMakeUp:GetItemData( math.max( 0, lcCharacterMakeUp:GetCurSel()) );
	--tCharacter.equip = lcCharacterEquipment:GetItemData( math.max( 0, lcCharacterEquipment:GetCurSel()) );
	tCharacter.equip = 0;
	tCharacter.equip_col = lcCharacterEquipColor:GetItemData( math.max( 0, lcCharacterEquipColor:GetCurSel()) );
	tCharacter.battlestance	= False;
	
	-- Tattoo
	tCharacter.tattoo = lcCharacterTattoo:GetItemData( math.max( 0, lcCharacterTattoo:GetCurSel()) );
	tCharacter.tattoocolor = lcCharacterTatooColor:GetItemData( math.max( 0, lcCharacterTatooColor:GetCurSel()) );
	local tattooscale = sldTattoScale:GetScrollValue() / 5.0;
	if ( tattooscale < 1.0)  then  tattooscale = tattooscale * 0.5 + 0.5;  end
	tCharacter.tattooscale = ( 1.0 / tattooscale) * 2.0;
	tCharacter.tattooposx = (( 1.0 - tCharacter.tattooscale) * 0.5) - ( luaCharacterCreate.TATTOO.x * 0.7) / tattooscale;
	tCharacter.tattooposy = (( 1.0 - tCharacter.tattooscale) * 0.5) - ( luaCharacterCreate.TATTOO.y * 0.7 - 0.5) / tattooscale;

	tCharacter.tattooposx = (luaCharacterCreate.TATTOO.x * 0.7) / (3.0 - tattooscale);
	tCharacter.tattooposy = 0.25 - (luaCharacterCreate.TATTOO.y * 0.7) / (3.0 - tattooscale);

	-- Equipment
	local nCurSel = lcCharacterPreviewEquip:GetCurSel();
	if ( nCurSel >= 0)  then
	
		local nData = lcCharacterPreviewEquip:GetItemData( nCurSel);
		if ( nData > 0)  then  tCharacter.equip = nData;
		end
	end
	
	if( true == bChangeMotion )	then
		tCharacter.battlestance = true;
	else--if( "iconStanceNormal" == picCharStanceBattle:GetImage() ) then
		tCharacter.battlestance = false;
	end
	
	if( luaCharacterCreate.CREATETAG.CREATETAG_STYLE == luaCharacterCreate.nCurrTag )	then
		tCharacter.battlestance = true;
	end
	
	
	gamefunc:ChangeNewCharacterModel( tCharacter, bChangeMotion );
end

-- RefreshControls
function luaCharacterCreate:RefreshControls()

	local strText = "";

	local nCurSel = lcCharacterStyle:GetCurSel();
	if ( nCurSel >= 0)  then
	
		local nStyle = lcCharacterStyle:GetItemData( nCurSel);
		if ( nStyle == TALENT_TYPE.DEFENDER)  then
		
			strText = STR( "UI_SELCHAR_DEFENDER_DESC");
			
		elseif ( nStyle == TALENT_TYPE.BERSERKER)  then

			strText = STR( "UI_SELCHAR_BERSERKER_DESC");

		elseif ( nStyle == TALENT_TYPE.CLERIC)  then

			strText = STR( "UI_SELCHAR_CLERIC_DESC");

		elseif ( nStyle == TALENT_TYPE.SORCERER)  then

			strText = STR( "UI_SELCHAR_SORCERER_DESC");
	
		elseif ( nStyle == TALENT_TYPE.ASSASSIN)  then

			strText = STR( "UI_SELCHAR_ASSASSIN_DESC");
			
		end

	end
	
	tvwStyleDesc:SetText( strText );	
	

	-- layerCharCreate
	nCurSel = lcCharacterTattoo:GetCurSel();
	lbCharacterTatooColorNone:Show( true );
	lcCharacterTatooColor:Show( false );
	
end

-- OnLoadedPanel
function luaCharacterCreate:OnLoadedPanel( _wnd, _tag, bForceChange )

	local _depth = luaCharacterCreate.panelcount + 1;
	luaCharacterCreate.panelcount = luaCharacterCreate.panelcount + 1;

	luaCharacterCreate.panels[ _depth] = {};
	luaCharacterCreate.panels[ _depth].wnd = _wnd;
	luaCharacterCreate.panels[ _depth].tag = _tag;
	luaCharacterCreate.panels[ _depth].bForceChange = bForceChange;
end

-- SetRandomModel
function luaCharacterCreate:SetRandomModel()
	
	--lcCharacterSex:SetCurSel( math.random( 0, 1) );
	lcCharacterFace:SetCurSel( math.random( 0, lcCharacterFace:GetItemCount() - 1) );
	lcCharacterHair:SetCurSel( math.random( 0, lcCharacterHair:GetItemCount() - 1) );
	lcCharacterSkinColor:SetCurSel( math.random( 0, lcCharacterSkinColor:GetItemCount() - 1) );
	lcCharacterHairColor:SetCurSel( math.random( 0, lcCharacterHairColor:GetItemCount() - 1) );
	lcCharacterEyeColor:SetCurSel( math.random( 0, lcCharacterEyeColor:GetItemCount() - 1) );
	lcCharacterTatooColor:SetCurSel( math.random( 0, lcCharacterTatooColor:GetItemCount() - 1) );
	--lcCharacterMakeUp:SetCurSel( math.random( 0, lcCharacterMakeUp:GetItemCount() - 1) );
	--lcCharacterEquipment:SetCurSel( math.random( 0, lcCharacterEquipment:GetItemCount() - 1) );
	lcCharacterEquipColor:SetCurSel( math.random( 0, lcCharacterEquipColor:GetItemCount() - 1) );
	lcCharacterVoice:SetCurSel( math.random( 0, lcCharacterVoice:GetItemCount() - 1) );
	
	-- Refresh character
	luaCharacterCreate:RefreshCharacter( false );
end

-- CheckCharacterNameValidate
function luaCharacterCreate:CheckCharacterNameValidate()

	local strName = edtCharacterName:GetText();
	local bValidate = gamefunc:IsValidateCharName( strName);

	local strString = "{ALIGN hor=\"right\" ver=\"center\"}{BITMAP name=\"iconDefExclamation\" w=16 h=16}{SPACE w=5 h=23}{CR h=0}{ALIGN hor=\"left\"}{SPACE w=5 h=23}";
	if ( edtCharacterName:IsFocus() == true)  then
	
		if ( bValidate == true)  then
		
			twvCharacterNameValidate:Show( false);
			--btnNameDuplicate:Enable( true );
		
		else
		
			twvCharacterNameValidate:Show( true);
			twvCharacterNameValidate:SetText( strString);
			--btnNameDuplicate:Enable( false );
		
		end
		
	else
	
		if ( bValidate == true)  then
		
			twvCharacterNameValidate:Show( false);
			--btnNameDuplicate:Enable( true );
			
		elseif ( strName == "")  then
			
			twvCharacterNameValidate:Show( true);
			twvCharacterNameValidate:SetText( strString .. "{FONT name=\"fntScript\"}{COLOR r=196 g=162 b=69}" .. STR( "UI_SELCHAR_ENTERNAME"));
			--btnNameDuplicate:Enable( false );
		else
		
			twvCharacterNameValidate:Show( true);
			twvCharacterNameValidate:SetText( strString);
			--btnNameDuplicate:Enable( false );
		end
	end
end

-- OnLoadedCharVoiceListCtrl
function luaCharacterCreate:OnLoadedCharVoiceListCtrl()

	for  i = 1, 3  do
	
		local nIndex = lcCharacterVoice:AddItem( i, "iconVoice");
		lcCharacterVoice:SetItemData( nIndex, i);
	end
end

-- OnDrawItemCharVoiceListCtrl
function luaCharacterCreate:OnDrawItemCharVoiceListCtrl()
	local nIndex = EventArgs:GetItemIndex();
	local x, y, w, h = EventArgs:GetItemRect();
	
	gamedraw:SetBitmap( "bmpGlassPanel");
	gamedraw:Draw( x, y, w, h);
end

-- OnSelChangeCharVoiceListCtrl
function luaCharacterCreate:OnSelChangeCharVoiceListCtrl()

	local nCurSel = lcCharacterVoice:GetCurSel();
	if ( nCurSel < 0)  then  return;
	end
	
	local nVoice = lcCharacterVoice:GetItemData( nCurSel);
	local nIndex = math.random( 1, table.getn( luaCharacterCreate.VOICE));
	
	local szSound;
	if( 0 == lcCharacterSex:GetCurSel() )	then
		szName = "m" .. tostring( nVoice) .. luaCharacterCreate.VOICE[ nIndex];
	else
		szName = "w" .. tostring( nVoice) .. luaCharacterCreate.VOICE[ nIndex];
	end
	
	gamefunc:PlaySound( szName);
	gamefunc:ChangeFaceAni( "facial_yell_4");
	
	luaCharacterCreate:RefreshCharacter( false );
end

function luaCharacterCreate:GetCurrentSexString()

	local strSex = "_female";
	if( 0 == lcCharacterSex:GetCurSel() )	then
		strSex = "_male"
	end

	return strSex;
end

-- OnLoadedCharFaceListCtrl
function luaCharacterCreate:OnLoadedCharFaceListCtrl()

	local strSex = luaCharacterCreate:GetCurrentSexString();

	local nSelIndex = lcCharacterFace:GetCurSel();

	lcCharacterFace:DeleteAllItems();

	local nCount = gamefunc:GetCharacterFaceCount(0);
	for  i = 1, nCount  do
	
		local nIndex = lcCharacterFace:AddItem( i, "iconFace" .. strSex .. tostring(i));
		lcCharacterFace:SetItemData( nIndex, i - 1);
	end
	
	lcCharacterFace:SetCurSel(nSelIndex);
end

-- OnDrawItemCharFaceListCtrl
function luaCharacterCreate:OnDrawItemCharFaceListCtrl()

	local nIndex = EventArgs:GetItemIndex();
	local x, y, w, h = EventArgs:GetItemRect();
		
	gamedraw:SetBitmap( "bmpGlassPanel");
	gamedraw:Draw( x, y, w, h);
end

function luaCharacterCreate:OnSelChangeCharListCtrl()

	luaCharacterCreate:OnLoadedCharFaceListCtrl();

	luaCharacterCreate:OnLoadedCharMakeUpListCtrl();

	luaCharacterCreate:OnLoadedCharHairListCtrl();
end

-- OnLoadedCharHairListCtrl
function luaCharacterCreate:OnLoadedCharHairListCtrl()

	local strSex = luaCharacterCreate:GetCurrentSexString();

	local nSelIndex = lcCharacterHair:GetCurSel();

	lcCharacterHair:DeleteAllItems();

	local nCount = gamefunc:GetCharacterHairCount(0);
	for  i = 1, nCount  do
	
		local nIndex = lcCharacterHair:AddItem( i, "iconHair" .. strSex .. tostring(i));
		lcCharacterHair:SetItemData( nIndex, i - 1);
	end
	
	lcCharacterHair:SetCurSel(nSelIndex);
end

-- OnDrawItemCharHairListCtrl
function luaCharacterCreate:OnDrawItemCharHairListCtrl()

	local nIndex = EventArgs:GetItemIndex();
	local x, y, w, h = EventArgs:GetItemRect();
	
	gamedraw:SetBitmap( "bmpGlassPanel");
	gamedraw:Draw( x, y, w, h);
end

-- OnLoadedCharMakeUpListCtrl
function luaCharacterCreate:OnLoadedCharMakeUpListCtrl()

	local strSex = luaCharacterCreate:GetCurrentSexString();

	local nSelIndex = lcCharacterMakeUp:GetCurSel();

	lcCharacterMakeUp:DeleteAllItems();

	for  i = 1, 3  do
	
		local nFace = lcCharacterFace:GetCurSel() + 1;
		local nIndex = lcCharacterMakeUp:AddItem( i, "iconMakeUp" .. strSex .. tostring(nFace) .. "_" .. tostring(i));
		lcCharacterMakeUp:SetItemData( nIndex, i - 1);
	end
	
	lcCharacterMakeUp:SetCurSel(nSelIndex);
end

-- OnDrawItemCharMakeUpListCtrl
function luaCharacterCreate:OnDrawItemCharMakeUpListCtrl()

	local nIndex = EventArgs:GetItemIndex();
	local x, y, w, h = EventArgs:GetItemRect();
		
	gamedraw:SetBitmap( "bmpGlassPanel");
	gamedraw:Draw( x, y, w, h);
end

-- OnLoadedCharTattooListCtrl
function luaCharacterCreate:OnLoadedCharTattooListCtrl()

	for  i = 0, 49  do	-- 타투 갯수 + 1 이 되어야 한다.
	
		local nIndex = lcCharacterTattoo:AddItem( i, "iconTattoo");
		lcCharacterTattoo:SetItemData( nIndex, i);
	end
	
	lcCharacterTattoo:SetCurSel( 0);
end

-- OnDrawItemCharTattooListCtrl
function luaCharacterCreate:OnDrawItemCharTattooListCtrl()

	local nIndex = EventArgs:GetItemIndex();
	local x, y, w, h = EventArgs:GetItemRect();
		
	if ( nIndex == 0)  then
	
		gamedraw:SetFont( "fntSmallStrong");
		gamedraw:SetColor( 255, 255, 255);
		gamedraw:SetTextAlign( "center", "center");
		gamedraw:TextEx( x, y, w, h, "none");

	else
	
		gamedraw:SetFont( "fntRegularStrong");
		gamedraw:SetColor( 255, 255, 255);
		gamedraw:SetTextAlign( "center", "center");
		gamedraw:TextEx( x, y, w, h, lcCharacterTattoo:GetItemText( nIndex, 0));
	end
	
	gamedraw:SetBitmap( "bmpGlassPanel");
	gamedraw:Draw( x, y, w, h);
end

-- OnLoadedCharSkinColorListCtrl
function luaCharacterCreate:OnLoadedCharSkinColorListCtrl()

	for  i = 0, ( gamefunc:GetCharColorCount( "skin") - 1)  do
	
		local nID = gamefunc:GetCharColorID( "skin", i);
		if ( nID > 0)  then

			local r, g, b = gamefunc:GetCharColor( "skin", nID);
			local nIndex = lcCharacterSkinColor:AddItem( "", "bmpGlassPanel");
			lcCharacterSkinColor:SetItemText( nIndex, 1, r);
			lcCharacterSkinColor:SetItemText( nIndex, 2, g);
			lcCharacterSkinColor:SetItemText( nIndex, 3, b);
			lcCharacterSkinColor:SetItemData( nIndex, nID);
		end
	end
end

-- OnDrawItemBkgrndCharSkinColorListCtrl
function luaCharacterCreate:OnDrawItemBkgrndCharSkinColorListCtrl()

	local nIndex = EventArgs:GetItemIndex();
	local x, y, w, h = EventArgs:GetItemRect();
		
	local r = lcCharacterSkinColor:GetItemText( nIndex, 1);
	local g = lcCharacterSkinColor:GetItemText( nIndex, 2);
	local b = lcCharacterSkinColor:GetItemText( nIndex, 3);
	
	r = ( 103 + r) * 0.7;
	g = ( 79 + g) * 0.7;
	b = ( 75 + b) * 0.7;

--	r = r;
--	g = g;
--	b = b;

	gamedraw:SetColor( r, g, b);
	gamedraw:FillRect( x, y, w, h);
end

-- OnLoadedCharHairColorListCtrl
function luaCharacterCreate:OnLoadedCharHairColorListCtrl()

	for  i = 0, ( gamefunc:GetCharColorCount( "hair") - 1)  do
	
		local nID = gamefunc:GetCharColorID( "hair", i);
		if ( nID > 0)  then
		
			local r, g, b = gamefunc:GetCharColor( "hair", nID);
			local nIndex = lcCharacterHairColor:AddItem( "", "bmpGlassPanel");
			lcCharacterHairColor:SetItemText( nIndex, 1, r);
			lcCharacterHairColor:SetItemText( nIndex, 2, g);
			lcCharacterHairColor:SetItemText( nIndex, 3, b);
			lcCharacterHairColor:SetItemData( nIndex, nID);
		end
	end
end

-- OnDrawItemBkgrndCharHairColorListCtrl
function luaCharacterCreate:OnDrawItemBkgrndCharHairColorListCtrl()

	local nIndex = EventArgs:GetItemIndex();
	local x, y, w, h = EventArgs:GetItemRect();
		
	local r = lcCharacterHairColor:GetItemText( nIndex, 1);
	local g = lcCharacterHairColor:GetItemText( nIndex, 2);
	local b = lcCharacterHairColor:GetItemText( nIndex, 3);
	gamedraw:SetColor( r, g, b);
	gamedraw:FillRect( x, y, w, h);
end

-- OnLoadedCharEyeColorListCtrl
function luaCharacterCreate:OnLoadedCharEyeColorListCtrl()

	for  i = 0, ( gamefunc:GetCharColorCount( "eye") - 1)  do
	
		local nID = gamefunc:GetCharColorID( "eye", i);
		if ( nID > 0)  then
		
			local r, g, b = gamefunc:GetCharColor( "eye", nID);
			local nIndex = lcCharacterEyeColor:AddItem( "", "bmpGlassPanel");
			lcCharacterEyeColor:SetItemText( nIndex, 1, r);
			lcCharacterEyeColor:SetItemText( nIndex, 2, g);
			lcCharacterEyeColor:SetItemText( nIndex, 3, b);
			lcCharacterEyeColor:SetItemData( nIndex, nID);
		end
	end
end

-- OnDrawItemBkgrndCharEyeColorListCtrl
function luaCharacterCreate:OnDrawItemBkgrndCharEyeColorListCtrl()

	local nIndex = EventArgs:GetItemIndex();
	local x, y, w, h = EventArgs:GetItemRect();
		
	local r = lcCharacterEyeColor:GetItemText( nIndex, 1);
	local g = lcCharacterEyeColor:GetItemText( nIndex, 2);
	local b = lcCharacterEyeColor:GetItemText( nIndex, 3);
	gamedraw:SetColor( r, g, b);
	gamedraw:FillRect( x, y, w, h);
end

-- OnLoadedCharTatooColorListCtrl
function luaCharacterCreate:OnLoadedCharTatooColorListCtrl()

	for  i = 0, ( gamefunc:GetCharColorCount( "eye") - 1)  do
	
		local nID = gamefunc:GetCharColorID( "eye", i);
		if ( nID > 0)  then
		
			local r, g, b = gamefunc:GetCharColor( "eye", nID);
			local nIndex = lcCharacterTatooColor:AddItem( "", "bmpGlassPanel");
			lcCharacterTatooColor:SetItemText( nIndex, 1, r);
			lcCharacterTatooColor:SetItemText( nIndex, 2, g);
			lcCharacterTatooColor:SetItemText( nIndex, 3, b);
			lcCharacterTatooColor:SetItemData( nIndex, nID);
		end
	end
end

-- OnDrawItemBkgrndCharTatooColorListCtrl
function luaCharacterCreate:OnDrawItemBkgrndCharTatooColorListCtrl()

	local nIndex = EventArgs:GetItemIndex();
	local x, y, w, h = EventArgs:GetItemRect();
		
	local r = lcCharacterTatooColor:GetItemText( nIndex, 1);
	local g = lcCharacterTatooColor:GetItemText( nIndex, 2);
	local b = lcCharacterTatooColor:GetItemText( nIndex, 3);
	gamedraw:SetColor( r, g, b);
	gamedraw:FillRect( x, y, w, h);
end

-- OnLoadedCharEquipmentListCtrl
function luaCharacterCreate:OnLoadedCharEquipmentListCtrl()

	--[[
	for  i = 1, 2  do
	
		local nIndex = lcCharacterEquipment:AddItem( i, "iconEquipment");
		lcCharacterEquipment:SetItemData( nIndex, i - 1);
	end
	]]--
	
end

-- OnDrawItemCharEquipmentListCtrl
function luaCharacterCreate:OnDrawItemCharEquipmentListCtrl()

	--[[
	local nIndex = EventArgs:GetItemIndex();
	local x, y, w, h = EventArgs:GetItemRect();
		
	gamedraw:SetFont( "fntLargeStrong");
	gamedraw:SetColor( 255, 255, 255);
	gamedraw:SetTextAlign( "center", "center");
	gamedraw:TextEx( x, y, w, h, lcCharacterEquipment:GetItemText( nIndex, 0));
	
	gamedraw:SetBitmap( "bmpGlassPanel");
	gamedraw:Draw( x, y, w, h);
	]]--
end

-- OnLoadedCharEquipColorListCtrl
function luaCharacterCreate:OnLoadedCharEquipColorListCtrl()

	for  i = 0, 27  do
	
		local nID = gamefunc:GetCharColorID( "item_dyed", i);
		if ( nID > 0)  then
		
			local r, g, b = gamefunc:GetCharColor( "item_dyed", nID);
			local nIndex = lcCharacterEquipColor:AddItem( "", "bmpGlassPanel");
			lcCharacterEquipColor:SetItemText( nIndex, 1, r);
			lcCharacterEquipColor:SetItemText( nIndex, 2, g);
			lcCharacterEquipColor:SetItemText( nIndex, 3, b);
			lcCharacterEquipColor:SetItemData( nIndex, nID);
		end
	end
end

-- OnDrawItemBkgrndCharEquipColorListCtrl
function luaCharacterCreate:OnDrawItemBkgrndCharEquipColorListCtrl()

	local nIndex = EventArgs:GetItemIndex();
	local x, y, w, h = EventArgs:GetItemRect();
		
	local r = lcCharacterEquipColor:GetItemText( nIndex, 1);
	local g = lcCharacterEquipColor:GetItemText( nIndex, 2);
	local b = lcCharacterEquipColor:GetItemText( nIndex, 3);
	gamedraw:SetColor( r, g, b);
	gamedraw:FillRect( x, y, w, h);
end

-- OnLoadedCharPreviewEquipListCtrl
function luaCharacterCreate:OnLoadedCharPreviewEquipListCtrl()

	for  i = 0, 5  do
	
		local strText = "";
		if ( i > 0)  then  strText = i;
		end

		local nData = -1;
		if ( i > 0)  then  nData = i + 2;
		end

		local nIndex = lcCharacterPreviewEquip:AddItem( strText, "iconPreview");
		lcCharacterPreviewEquip:SetItemData( nIndex, nData);
	end
	
	lcCharacterPreviewEquip:Show( false );
end

-- OnDrawItemCharPreviewEquipListCtrl
function luaCharacterCreate:OnDrawItemCharPreviewEquipListCtrl()

	local nIndex = EventArgs:GetItemIndex();
	local x, y, w, h = EventArgs:GetItemRect();
	
	gamedraw:SetFont( "fntLargeStrong");
	gamedraw:SetColor( 255, 255, 255);
	gamedraw:SetTextAlign( "center", "center");
	gamedraw:TextEx( x, y, w, h, lcCharacterPreviewEquip:GetItemText( nIndex, 0));

	if ( nIndex == 0)  then

		gamedraw:SetColorEx( 0, 0, 0, 160);
		gamedraw:FillRect( x, y, w, h);
	end

	
	gamedraw:SetBitmap( "bmpGlassPanel");
	gamedraw:Draw( x, y, w, h);
end

-- SetTattooPos
function luaCharacterCreate:SetTattooPos( px, py)

	if ( lcCharacterTattoo:GetCurSel() <= 0)  then  return;
	end
	
	local w, h = picTattooHeadGrid:GetSize();
	local half_w, half_h = w * 0.5, h * 0.5;
	
	luaCharacterCreate.TATTOO.x = math.max( -half_w,  math.min( half_w,  px - half_w)) / half_w;
	luaCharacterCreate.TATTOO.y = math.max( -half_h,  math.min( half_h,  py - half_h)) / half_h;
end

-- OnDrawTattooHeadGrid
function luaCharacterCreate:OnDrawTattooHeadGrid()

	if ( lcCharacterTattoo:GetCurSel() <= 0)  then  return;
	end

	local w, h = picTattooHeadGrid:GetSize();
	local half_w, half_h = w * 0.5, h * 0.5;
	local x =  half_w + ( half_w * luaCharacterCreate.TATTOO.x);
	local y =  half_h + ( half_h * luaCharacterCreate.TATTOO.y);

	gamedraw:SetBitmap( "bmpTattoo");
	gamedraw:Draw( x - 16, y - 16, 32, 32);
end

-- OpenConfirmCreateCharacter
function luaCharacterCreate:OpenConfirmCreateCharacter()

	-- Check validate
	local strCharName = edtCharacterName:GetText();
	if ( strCharName == "")  then
	
		luaCharacterCreate:ShowErrorMsgBox( STR( "UI_SELCHAR_ERROR_ENTERNAME"));
		
		return;
	end
	
	local bValidate = gamefunc:IsValidateCharName( strCharName);
	if ( bValidate == false)  then

		luaCharacterCreate:ShowErrorMsgBox( STR( "UI_SELCHAR_ERROR_INVALIDNAME"));
		
		return;
	end
	
	local bSel = lcCharacterStyle:GetCurSel();
	if ( bSel == -1 ) then

		luaCharacterCreate:ShowErrorMsgBox( STR( "UI_SELCHAR_ERROR_STYLE"));
		
		return;
	end

	luaCharacterCreate:RefreshCharacter( false );

	-- Reposition frame
	local x, y = frmConfirmCreateCharacter:GetParent():GetPosition();
	local w, h = frmConfirmCreateCharacter:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmConfirmCreateCharacter:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);
	frmConfirmCreateCharacter:DoModal();
end

-- CloseConfirmDeleteMailFrame
function luaCharacterCreate:CloseConfirmCreateCharacter()

	-- Refresh UI
	frmConfirmCreateCharacter:Show( false);
	btnCharacterConfirmCreate:Enable( true);
end

-- OnClickConfirmCharCreateOK
function luaCharacterCreate:OnClickConfirmCharCreateOK()

	-- Close create confirm frame
	luaCharacterCreate:CloseConfirmCreateCharacter();
	
	-- Create character
	local strName = edtCharacterName:GetText();

	local tCharacter = {};
		if( 0 == lcCharacterSex:GetCurSel() )	then
		tCharacter.sex = 0
	else
		tCharacter.sex = 1
	end
	
	-- Character model
	tCharacter.style = lcCharacterStyle:GetItemData( math.max( 0, lcCharacterStyle:GetCurSel()) );
	tCharacter.face = lcCharacterFace:GetItemData( math.max( 0, lcCharacterFace:GetCurSel()) );
	tCharacter.hair = lcCharacterHair:GetItemData( math.max( 0, lcCharacterHair:GetCurSel()) );
	tCharacter.skin_col = lcCharacterSkinColor:GetItemData( math.max( 0, lcCharacterSkinColor:GetCurSel()) );
	tCharacter.hair_col = lcCharacterHairColor:GetItemData( math.max( 0, lcCharacterHairColor:GetCurSel()) );
	tCharacter.voice = lcCharacterVoice:GetItemData( math.max( 0, lcCharacterVoice:GetCurSel()) );
	tCharacter.eye_col = lcCharacterEyeColor:GetItemData( math.max( 0, lcCharacterEyeColor:GetCurSel()) );
	tCharacter.makeup = lcCharacterMakeUp:GetItemData( math.max( 0, lcCharacterMakeUp:GetCurSel()) );
	--tCharacter.equip = lcCharacterEquipment:GetItemData( math.max( 0, lcCharacterEquipment:GetCurSel()) );
	tCharacter.equip = 0;
	tCharacter.equip_col = lcCharacterEquipColor:GetItemData( math.max( 0, lcCharacterEquipColor:GetCurSel()) );
	
	-- Tattoo
	tCharacter.tattoo = lcCharacterTattoo:GetItemData( math.max( 0, lcCharacterTattoo:GetCurSel()) );
	tCharacter.tattoocolor = lcCharacterTatooColor:GetItemData( math.max( 0, lcCharacterTatooColor:GetCurSel()) );
	local tattooscale = sldTattoScale:GetScrollValue() / 5.0;
	if ( tattooscale < 1.0)  then  tattooscale = tattooscale * 0.5 + 0.5;  end
	tCharacter.tattooscale = ( 1.0 / tattooscale) * 2.0;
	tCharacter.tattooposx = (( 1.0 - tCharacter.tattooscale) * 0.5) - ( luaCharacterCreate.TATTOO.x * 0.7) / tattooscale;
	tCharacter.tattooposy = (( 1.0 - tCharacter.tattooscale) * 0.5) - ( luaCharacterCreate.TATTOO.y * 0.7 - 0.5) / tattooscale;

	tCharacter.tattooposx = (luaCharacterCreate.TATTOO.x * 0.7) / (3.0 - tattooscale);
	tCharacter.tattooposy = 0.25 - (luaCharacterCreate.TATTOO.y * 0.7) / (3.0 - tattooscale);
	
	gamefunc:CreateNewCharacter( strName, tCharacter);
end

-- OnEventCreateCharacter
function luaCharacterCreate:OnEventCreateCharacter( nSuccess, nErrorCode)

	if ( nSuccess > 0)  then
	
		-- Select new character at select character
		luaCharacterSelect.m_nCurSel = gamefunc:GetCharacterAccountMaxCount();
		
		luaCharacterFrame:SwitchScene( luaCharacter.SwitchToCharSelect);
		
	else
	
		-- Show error message box
		luaCharacterCreate:ShowErrorMsgBox( STR( "UI_SELCHAR_ERROR_NOTCREATED"), nErrorCode);
	end
end

-- ShowErrorMsgBox
function luaCharacterCreate:ShowErrorMsgBox( strMsg, nErrorCode)

	local strString = strMsg;
	if ( nErrorCode ~= nil)  then  strString = strString .. "{CR}" .. gamefunc:GetResultString( nErrorCode);
	end
	tvwErrorMsg:SetText( strString);

	frmErrorMsgBox:DoModal();
end

-- OnPositionCharCreateFrameBar
function luaCharacterCreate:OnPositionCharCreateFrameBar()

	local w, h = pnlCharCreateFrameBar:GetSize();
	local win_w, win_h = gamefunc:GetWindowSize();
	
	local x = (win_w - w) * 0.5;
	local y = win_h - h;
	pnlCharCreateFrameBar:SetPosition( x, y);
end

-- UpdateMainCycle
function luaCharacterCreate:UpdateMainCycle()
	
	if( 0 > luaCharacterCreate.MainCycleDelta )	then
		luaCharacterCreate.MainCycleDelta = gamefunc:GetUpdateTime();
		return ;
	end
	
	if( luaCharacterCreate.MainCycleTimer < gamefunc:GetUpdateTime() - luaCharacterCreate.MainCycleDelta )	then
		
		luaCharacterCreate.MainCycleIndex	= luaCharacterCreate.MainCycleIndex + 1;
		if( 4 < luaCharacterCreate.MainCycleIndex )	then
			luaCharacterCreate.MainCycleIndex	= 1;
		end

		local strImageName	= "bmpCharFrameMainCycle" .. luaCharacterCreate.MainCycleIndex;
		picCreateMainCycle:SetImage( strImageName );
		
		luaCharacterCreate.MainCycleDelta = gamefunc:GetUpdateTime();
		
	end
	
end

-- OnClickCharTurn
function luaCharacterCreate:OnClickCharTurn( fDelta )
	
	if( nil == fDelta )	then
		return ;
	end
	
	gamefunc:CameraRotZ( fDelta );
	
end

-- lcCharacterStyleOnSelChange
function luaCharacterCreate:edtCharacterNameOnLoaded()

	local nMin, nMax;
	nMin, nMax		= gamefunc:GetCharacterNameLengthEng();
	
	local strToolTip = FORMAT( "UI_SELCHAR_TOOLTIPENTERNAME", nMin .. "~" .. nMax );
    this:SetToolTip( strToolTip);
    
end