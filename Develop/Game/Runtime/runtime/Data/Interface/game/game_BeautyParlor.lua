--[[
	BeautyParlor LUA script
--]]


E_FT_NONE			= 0
E_FT_HAIR			= 1;
E_FT_FACE			= 2;
E_FT_HAIR_COLOR		= 3;
E_FT_SKIN_COLOR		= 4;
E_FT_EYE_COLOR		= 5;
E_FT_VOICE			= 6;
E_FT_TATTOO			= 7;
E_FT_TATTOO_COLOR	= 8;
E_FT_FACE_MAKEUP	= 9; -- UI에서만 쓰임(장바구니 인덱스 추가)
E_FT_MAX			= 10;
	

-- Global instance

luaBeautyParlor	= {};
luaBeautyShopBasket = {};
luaBeautyShopBasket.basketinfo = {};


--Panels
luaBeautyParlor.panels = {};
luaBeautyParlor.panelcount = 0;
luaBeautyParlor.SelStyle = 0;

-- Scroll

luaBeautyParlor.scroll = {};
	luaBeautyParlor.scroll._run = false;
	luaBeautyParlor.scroll._begin = 0;
	luaBeautyParlor.scroll._end = 0;
	luaBeautyParlor.scroll.timer = 0;
	
--Tattoo
luaBeautyParlor.TATTOO = {};
	luaBeautyParlor.TATTOO.x = 0;
	luaBeautyParlor.TATTOO.y = 0;
	luaBeautyParlor.TATTOO.fScale = 0.0;
	
--Test Voices
luaBeautyParlor.VOICE = { "_1hb_active1", "_1hb_active2", "_1hb_active3" };

	
--BeautyParlorTag
luaBeautyParlor.BEAUTYPARLORTAG = {BEAUTYPARLOR_MAKEFACE = 0 ,BEAUTYPARLOR_HEAD = 1 , BEAUTYPARLOR_TATTOO = 2 , BEAUTYPARLOR_VOICE = 3 };
luaBeautyParlor.nCurrTag		 = -1;
luaBeautyParlor.fCamMoveDelta	 = 0.0;
luaBeautyParlor.Tags			 = {};

luaBeautyParlor.MainCycleDelta   = -1;
luaBeautyParlor.MainCycleIndex	 = 1;
luaBeautyParlor.MainCycleTimer	 = 200;


luaBeautyParlor.nGoldBelpesoID = 1000;
luaBeautyParlor.nSilverBelpesoID = 1001;
luaBeautyParlor.nLookChangeTicketID = 2010950;


function luaBeautyParlor:EnterBeautyParlor()

	-- gamedebug:Log(" -- EnterBeautyParlor -- ");

	--Refresh UI
	luaBeautyParlor.CloseConfirmCreateCharacter();
	
	luaBeautyParlor:InitData();
	luaBeautyParlor:InitControls();		
	luaBeautyParlor:InitBasket();
	luaBeautyParlor:HelmButtonVisible();
	
	
end

--InitBasket
function luaBeautyParlor:InitBasket()
	
	for index = E_FT_HAIR, E_FT_MAX-1 do

		local basketinfo ={}
		basketinfo.nBelpeso = 0;
		basketinfo.nItemStyle = 0;
		basketinfo.strDrawImage = "";
		basketinfo.nItemIndex = 0;

		luaBeautyShopBasket.basketinfo[index] = {};
		luaBeautyShopBasket.basketinfo[index] = basketinfo;
	end

	lcBeautyParlorBasketList:DeleteAllItems();

	luaBeautyParlor:RefreshBasketText();
end

function luaBeautyParlor:RefreshBasketText()

	local strHasBelpeso = luaGame:ConvertBelpesoToStr( luaBeautyParlor:GetHasBelpeso());
	local strBasketTotalBelpeso = luaGame:ConvertBelpesoToStr( luaBeautyParlor:GetBasketTotalBelpeso());

	tvwHasBelpeso:SetText(STR( "UI_BEAUTYSHOP_HAS_BELPESO") .. strHasBelpeso);
	tvwTotalBelpeso:SetText(STR( "UI_BEAUTYSHOP_TOTAL_BELPESO") .. strBasketTotalBelpeso);
end

-- InitData
function luaBeautyParlor:InitData()
	
	luaBeautyParlor.TATTOO.x = 0.0;
	luaBeautyParlor.TATTOO.y = 0.0 ;
	luaBeautyParlor.MainCycleDelta = -1;
	luaBeautyParlor.MainCycleIndex = 1;
	
end

--InitControls
function luaBeautyParlor:InitControls()

	
	
	local nFace = gamefunc:GetFace();
		if(nFace > 0) then
			nFace = math.floor( nFace / 3);
		end
	local nMakeUp = gamefunc:GetMakeUp();
	local nHair = gamefunc:GetHair();
	local nHairColor = gamefunc:GetHairColor() -1;
	local nSkinColor = gamefunc:GetSkinColor() -1;
	local nEyeColor = gamefunc:GetEyeColor() -1;
	
	lcCharacterFace:SetCurSel(nFace);	
	lcCharacterMakeUp:SetCurSel(nMakeUp);
	lcCharacterSkinColor:SetCurSel(nSkinColor);
	lcCharacterEyeColor:SetCurSel(nEyeColor);
	lcCharacterHair:SetCurSel(nHair);
	lcCharacterHairColor:SetCurSel(nHairColor);
	
	luaBeautyParlor:InitVoice();
	luaBeautyParlor:InitTattooControl(true);

	luaBeautyParlor:OnClickCreateTagBtn( luaBeautyParlor.BEAUTYPARLORTAG.BEAUTYPARLOR_MAKEFACE );
	
	
end

-- InitTattooControl
function luaBeautyParlor:InitTattooControl(bResetColor)

	local nTattoo = gamefunc:GetTattooType();
	local nTattooPosX = gamefunc:GetTattooPosX() * 0.01;
	local nTattooPosY = gamefunc:GetTattooPosY() * 0.01;
	local nTattooScale = gamefunc:GetTattooScale() * 0.02;

	local scale = 2/nTattooScale;
	luaBeautyParlor.TATTOO.x = (nTattooPosX*3.0 - nTattooPosX*scale) / 0.7;
	luaBeautyParlor.TATTOO.y = -(nTattooPosY*3.0 - 0.75 - nTattooPosY*scale + 0.25*scale) / 0.7;
	
	if(scale < 1.0) then
		scale = (scale - 0.5) * 2.0;
	end
	
	lcCharacterTattoo:SetCurSel( nTattoo );
	if(bResetColor == true) then
		lcCharacterTatooColor:SetCurSel(gamefunc:GetTattooColor() -1);
	end
	sldTattoScale:SetScrollValue(scale*5.0);
	luaBeautyParlor:VisibleTattooColor();
end

function luaBeautyParlor:ConvertScale(Scale)
	
	local fScale = Scale;
	fScale = 2.0 / fScale;

	if( (fScale - 0.5) * 2.0 < 1.0) then
		fScale = (fScale - 0.5) * 2.0 ;
	end

	return (2.0 / Scale);
end
-- InitVoice
function luaBeautyParlor:InitVoice()

	lcCharacterVoice:SetCurSel( gamefunc:GetVoice()-1 );
	
end


function luaBeautyParlor:GetBasketIndex(nStyle)
	
	for i = 0, lcBeautyParlorBasketList:GetItemCount() - 1 do

		local nBasketStyle = lcBeautyParlorBasketList:GetItemData(i);
		if(nBasketStyle == nStyle) then
			return i;
		end
	end

	return -1;
end

function luaBeautyParlor:AddBasket(bShow , StrImage , strTitle , nPrice , nItemStyle , nItemIndex, bNonChoice)

	luaBeautyShopBasket.basketinfo[nItemStyle].nBelpeso = nPrice;
	luaBeautyShopBasket.basketinfo[nItemStyle].nItemStyle = nItemStyle;
	luaBeautyShopBasket.basketinfo[nItemStyle].strDrawImage = StrImage;
	luaBeautyShopBasket.basketinfo[nItemStyle].strTitle = strTitle;
	luaBeautyShopBasket.basketinfo[nItemStyle].nItemIndex = nItemIndex;

	local strHasBelpeso = luaBeautyParlor:ConvertVelpeso(luaBeautyParlor:GetHasBelpeso());
	local nIndex = 0;

	if(luaBeautyParlor:GetBasketIndex(nItemStyle) == -1) then
		nIndex = lcBeautyParlorBasketList:AddItem( "", StrImage);
		lcBeautyParlorBasketList:SetItemData( nIndex, nItemStyle);
	else
		nIndex = luaBeautyParlor:GetBasketIndex(nItemStyle);
		lcBeautyParlorBasketList:SetItemImage( nIndex, StrImage);
	end

	lcBeautyParlorBasketList:SetCurSel( nIndex);
	lcBeautyParlorBasketList:SetScrollValue(nIndex);


	-- face 일 경우 makeup 갱신
	if(nItemStyle == E_FT_FACE and luaBeautyParlor:GetBasketIndex(E_FT_FACE_MAKEUP) ~= -1) then
		
		local nSelIndex = lcCharacterMakeUp:GetCurSel();
		strDrawImage = gamefunc:GetBeautyParlorFaceIconPath() .. "\\" .. gamefunc:GetBeautyParlorIcon(E_FT_FACE , nItemIndex + nSelIndex) .. ".tga";
		luaBeautyShopBasket.basketinfo[nItemStyle].strDrawImage = strDrawImage;

		local nIndex = luaBeautyParlor:GetBasketIndex(E_FT_FACE_MAKEUP);
		lcBeautyParlorBasketList:SetItemImage( nIndex, strDrawImage);
	end

	-- 문신일 경우 색상이 없는 문신이면 제거
	if(nItemStyle == E_FT_TATTOO) then

		local nTattooIndex = lcCharacterTattoo:GetCurSel();		
		if( (gamefunc:IsBeautyParlorColorChoice( E_FT_TATTOO , nTattooIndex) == false) or (nTattooIndex == 0) )then
			
			local nTattooColorIndex = luaBeautyParlor:GetBasketIndex(E_FT_TATTOO_COLOR);
			luaBeautyParlor:BeautyParlorListSeleteCancel(nTattooColorIndex, E_FT_TATTOO_COLOR)
		end
	end


	if(bNonChoice == true)then 
		luaBeautyParlor:BeautyParlorListSeleteCancel(nIndex, nItemStyle)
	end
end

function luaBeautyParlor:DrawBasket()
	
	local nSubItem = EventArgs:GetItemSubItem();
	if ( nSubItem ~= 0 ) then return;
	end

	local nListIndex = EventArgs:GetItemIndex();
	if ( nListIndex < 0)  then  return;
	end

	local x, y, w, h = EventArgs:GetItemRect();
	w = 40;
	h = 40;

	local nStyle = lcBeautyParlorBasketList:GetItemData(nListIndex);
	local nIndex = luaBeautyShopBasket.basketinfo[nStyle].nItemIndex;
		
	if(nStyle == E_FT_HAIR_COLOR) then

		local r = lcCharacterHairColor:GetItemText( nIndex, 1);
		local g = lcCharacterHairColor:GetItemText( nIndex, 2);
		local b = lcCharacterHairColor:GetItemText( nIndex, 3);

		gamedraw:SetColor( r, g, b);
		gamedraw:FillRect( x, y, w, h);

	elseif(nStyle == E_FT_SKIN_COLOR) then

		local r = lcCharacterSkinColor:GetItemText( nIndex, 1);
		local g = lcCharacterSkinColor:GetItemText( nIndex, 2);
		local b = lcCharacterSkinColor:GetItemText( nIndex, 3);

		r = ( 103 + r) * 0.7;
		g = ( 79 + g) * 0.7;
		b = ( 75 + b) * 0.7;

		gamedraw:SetColor( r, g, b);
		gamedraw:FillRect( x, y, w, h);

	elseif(nStyle == E_FT_EYE_COLOR) then

		local r = lcCharacterEyeColor:GetItemText( nIndex, 1);
		local g = lcCharacterEyeColor:GetItemText( nIndex, 2);
		local b = lcCharacterEyeColor:GetItemText( nIndex, 3);

		gamedraw:SetColor( r, g, b);
		gamedraw:FillRect( x, y, w, h);

	elseif(nStyle == E_FT_TATTOO_COLOR) then

		local r = lcCharacterTatooColor:GetItemText( nIndex, 1);
		local g = lcCharacterTatooColor:GetItemText( nIndex, 2);
		local b = lcCharacterTatooColor:GetItemText( nIndex, 3);

		gamedraw:SetColor( r, g, b);
		gamedraw:FillRect( x, y, w, h);

	elseif(nStyle == E_FT_VOICE) then

	elseif(nStyle == E_FT_TATTOO) then
	
		gamedraw:SetFont( "fntRegularStrong");
		gamedraw:SetColor( 255, 255, 255);
		gamedraw:SetTextAlign( "center", "center");
		if( nIndex == 0) then
			gamedraw:TextEx( x, y, w, h, "none");
		else
			gamedraw:TextEx( x, y, w, h, nIndex);
		end
	end

	gamedraw:SetBitmap( "bmpGlassPanel");
	gamedraw:Draw( x, y, w, h);


	local strTitle = luaBeautyShopBasket.basketinfo[nStyle].strTitle;
	local nPrice = luaBeautyShopBasket.basketinfo[nStyle].nBelpeso;
	local nGold = math.floor( nPrice / 100);
	local nSilver = nPrice % 100;

	if(nStyle == E_FT_TATTOO and nIndex == 0) then
		strTitle = strTitle .. " " .. STR("UI_REMOVE");
	end

	gamedraw:SetFont( "fntRegular");
	gamedraw:SetColor( 255, 255, 255);
	gamedraw:SetTextAlign( "left", "center");
	gamedraw:TextEx( x + 50, y, 300, h, strTitle);

	gamedraw:SetBitmap( "bmpGoldVelpeso");
	gamedraw:Draw( x + 200, y+10, 20, 20);

	gamedraw:SetColor( 230, 180, 20);
	gamedraw:TextEx( x + 230, y, 300, h, nGold);

	gamedraw:SetBitmap( "bmpSilverVelpeso");
	gamedraw:Draw( x + 300, y+10, 20, 20);

	gamedraw:SetColor( 200, 200, 200);
	gamedraw:TextEx( x + 330, y, 300, h, nSilver);
	

end

function luaBeautyParlor:OnClickItem(nStyle)
	
	
	local nBelpeso = 0;
	local nItemStyle = nStyle;
	local strDrawImage = "";
	local strTitle = "";
	local nItemIndex = "";
	local bNonChoice = false;
	

	if(nStyle == E_FT_HAIR) then 

		strTitle = STR("UI_SELCHAR_CREATE_HAIR");
		nItemIndex = lcCharacterHair:GetCurSel();

		if(nItemIndex == gamefunc:GetHair()) then
			bNonChoice = true;
		end
		strDrawImage = gamefunc:GetBeautyParlorHairIconPath() .. "\\" .. gamefunc:GetBeautyParlorIcon(nStyle , nItemIndex) .. ".tga";
		
	elseif(nStyle == E_FT_FACE) then

		strTitle = STR("UI_SELCHAR_CREATE_FACE");
		nItemIndex = lcCharacterFace:GetCurSel() * 3;

		if( nItemIndex == gamefunc:GetFace()) then
			bNonChoice = true;
		end

		strDrawImage = gamefunc:GetBeautyParlorFaceIconPath() .. "\\" .. gamefunc:GetBeautyParlorIcon(nStyle , nItemIndex) .. ".tga";

	elseif(nStyle == E_FT_FACE_MAKEUP) then

		strTitle = STR("UI_SELCHAR_CREATE_MAKEUP");
		local nSelIndex = lcCharacterMakeUp:GetCurSel();
		nItemIndex = lcCharacterFace:GetCurSel() * 3 + nSelIndex;
		strDrawImage = gamefunc:GetBeautyParlorFaceIconPath() .. "\\" .. gamefunc:GetBeautyParlorIcon(E_FT_FACE , nItemIndex) .. ".tga";

		local nMakeUp = gamefunc:GetMakeUp() % 3;
		if(nMakeUp == nSelIndex) then				
			bNonChoice = true;
		end
		
	elseif(nStyle == E_FT_HAIR_COLOR) then

		strTitle = STR("UI_SELCHAR_CREATE_HAIRCOLOR");
		nItemIndex = lcCharacterHairColor:GetCurSel();

		local nHairColor = gamefunc:GetHairColor() -1;
		if(nItemIndex == nHairColor)then			
			bNonChoice = true;
		end

	elseif(nStyle == E_FT_SKIN_COLOR) then

		strTitle = STR("UI_SELCHAR_CREATE_SKINCOLOR");
		nItemIndex = lcCharacterSkinColor:GetCurSel();

		local nSkinColor = gamefunc:GetSkinColor() -1;
		if(nItemIndex == nSkinColor)then
			bNonChoice = true;
		end

	elseif(nStyle == E_FT_EYE_COLOR) then

		strTitle = STR("UI_SELCHAR_CREATE_EYECOLOR");
		nItemIndex = lcCharacterEyeColor:GetCurSel();

		local nEyeColor = gamefunc:GetEyeColor() -1;
		if(nItemIndex == nEyeColor)then
			bNonChoice = true;
		end

	elseif(nStyle == E_FT_VOICE) then

		strTitle = STR("UI_SELCHAR_CREATE_VOICE");
		nItemIndex = lcCharacterVoice:GetCurSel();
		strTitle = strTitle .. " " .. nItemIndex+1;
		strDrawImage = "iconVoice";

		local nVoice = gamefunc:GetVoice() - 1;
		if(nItemIndex == nVoice)then
			bNonChoice = true;
		end

	elseif(nStyle == E_FT_TATTOO) then

		strTitle = STR("UI_SELCHAR_CREATE_TATTOO");
		nItemIndex = lcCharacterTattoo:GetCurSel();
		local nTattoo = gamefunc:GetTattooType();

		if(nItemIndex == nTattoo) then
			bNonChoice = true;
		end

	elseif(nStyle == E_FT_TATTOO_COLOR) then

		strTitle = STR("UI_SELCHAR_CREATE_TATTOO_COLOR");
		nItemIndex = lcCharacterTatooColor:GetCurSel();

		local nTattooColor = gamefunc:GetTattooColor() -1;

		if(nItemIndex == nTattooColor) then
			bNonChoice = true;
		end

	end

	if(nStyle == E_FT_FACE_MAKEUP) then
		nBelpeso = luaBeautyParlor:GetMakeUpPrice(nItemIndex);
	else
		nBelpeso = gamefunc:GetBeautyParlorPrice(nStyle , nItemIndex);
	end

	if(bNonChoice == true)then
		nBelpeso = 0;
		strTitle = STR("UI_BEAUTYSHOP_CURRENT_LOOK");
	end

	luaBeautyParlor:AddBasket(true, strDrawImage ,strTitle , nBelpeso, nStyle , nItemIndex, bNonChoice);
	luaBeautyParlor:RefreshCharacter( false );
	luaBeautyParlor:RefreshBasketText();

end

--OnLadedCreateTagBtn
function luaBeautyParlor:OnLoadedCreateTagBtn( nTag, _btn , bBattle, fMoveDelta )

	if(nil == luaBeautyParlor.Tags[nTag])	then
		luaBeautyParlor.Tags[nTag] = {};
		luaBeautyParlor.Tags[nTag].nTag = nTag
	end
		
	luaBeautyParlor.Tags[ nTag ]._btn		=	_btn;
	luaBeautyParlor.Tags[ nTag ].bBattle	=	bBattle;
	luaBeautyParlor.Tags[ nTag ].fMoveDelta	=	fMoveDelta;
end


--OnClickCreateTagBtn
function luaBeautyParlor:OnClickCreateTagBtn( nTag )

	local	bBattle		=	false;
	local	fMoveDela	=	0.0;
	
	for _nIdx, _Tag  in pairs( luaBeautyParlor.Tags )  do
		
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
	
	if(nTag == luaBeautyParlor.nCurrTag ) then
		return;
	end
	
	luaBeautyParlor.nCurrTag = nTag;

	
	luaBeautyParlor:OnSelChangeCharListCtrl();


end

-- OnLoadedCreateTagPnl
function luaBeautyParlor:OnLoadedCreateTagPnl( nTag, _pnl )

	if(nil == luaBeautyParlor.Tags[ nTag ] )	then
		luaBeautyParlor.Tags[ nTag ] = {};
		luaBeautyParlor.Tags[ nTag ].nTag = nTag;
	end
	
	luaBeautyParlor.Tags[ nTag ]._pnl = _pnl;
	
	luaBeautyParlor.CreateLeftPanelRefresh( luaBeautyParlor.Tags[ nTag ]._pnl);
end



-- CreateLeftpanelRefresh
function luaBeautyParlor:CreateLeftPanelRefresh( _wnd )

	if(nil == _wnd) then
		return;
	end
	
	local whdth, height = _wnd:GetParent():GetSize();
	height = height - 80;
	local x, y, w , h = _wnd:GetRect();
	local nY		  = height * 0.1;
	
	if( ( nY + h) > height ) then
		_wnd:SetPosition( x, (height - h) * 0.5 );
	else
		_wnd:SetPosition( x, nY );
	end

end

-- RefreshCharacter
function luaBeautyParlor:RefreshCharacter( bChangeMotion )

	luaBeautyParlor:OnSelChangeCharListCtrl();
	
	luaBeautyParlor:RefreshCharacterModel( bChangeMotion );
end

function luaBeautyParlor:GetItemIndex(nType , nNum)

	local	strID = gamefunc:GetBeautyParlorItemID(nType , nNum);
	local	nIndex = gamefunc:GetBeautyParlorItemIndex(nType , strID);

	return nIndex;
end


--RefreshCharacterModel
function luaBeautyParlor:RefreshCharacterModel( bChangeMotion )

	local tCharacter = {};
	

	-- Character model	
	tCharacter.style = 0;
	tCharacter.sex = gamefunc:GetSex();
	tCharacter.face = luaBeautyParlor:GetItemIndex(E_FT_FACE , math.max( 0, lcCharacterFace:GetCurSel() ) * 3) ;
	tCharacter.hair = luaBeautyParlor:GetItemIndex(E_FT_HAIR , math.max( 0, lcCharacterHair:GetCurSel() ));
	tCharacter.skin_col = luaBeautyParlor:GetItemIndex( E_FT_SKIN_COLOR , math.max( 0, lcCharacterSkinColor:GetCurSel() ));
	tCharacter.hair_col = luaBeautyParlor:GetItemIndex(E_FT_HAIR_COLOR , math.max( 0, lcCharacterHairColor:GetCurSel() ));
	tCharacter.voice = luaBeautyParlor:GetItemIndex(E_FT_VOICE , math.max( 0, lcCharacterVoice:GetCurSel() ));
	tCharacter.eye_col = luaBeautyParlor:GetItemIndex(E_FT_EYE_COLOR , math.max( 0, lcCharacterEyeColor:GetCurSel() ));
	tCharacter.makeup = math.max( 0, lcCharacterMakeUp:GetCurSel());
	tCharacter.equip = 0;
	tCharacter.equip_col = 0;	
	
	-- Tattoo
	tCharacter.tattoo = luaBeautyParlor:GetItemIndex(E_FT_TATTOO , lcCharacterTattoo:GetCurSel() );
	tCharacter.tattoocolor =luaBeautyParlor:GetItemIndex(E_FT_TATTOO_COLOR , math.max( 0, lcCharacterTatooColor:GetCurSel()) );
	local tattooscale = sldTattoScale:GetScrollValue() / 5.0;
	if ( tattooscale < 1.0)  then  
		tattooscale = tattooscale * 0.5 + 0.5; 
	end
	tCharacter.tattooscale = ( 1.0 / tattooscale) * 2.0;
	tCharacter.tattooposx = (( 1.0 - tCharacter.tattooscale) * 0.5) - ( luaBeautyParlor.TATTOO.x * 0.7) / tattooscale;
	tCharacter.tattooposy = (( 1.0 - tCharacter.tattooscale) * 0.5) - ( luaBeautyParlor.TATTOO.y * 0.7 - 0.5) / tattooscale;

	tCharacter.tattooposx = (luaBeautyParlor.TATTOO.x * 0.7) / (3.0 - tattooscale);
	tCharacter.tattooposy = 0.25 - (luaBeautyParlor.TATTOO.y * 0.7) / (3.0 - tattooscale);

	tCharacter.battlestance = false;

	
	gamefunc:ReformBeautyParlorCharacterModel( tCharacter);
end

-- OnLoadedPanel
function luaBeautyParlor:OnLoadedpanel( _wnd, _tag, bForceChange )

	local _depth = luaBeautyParlor.panelcount + 1;
	luaBeautyParlor.panelcount = luaBeautyParlor.panelcount + 1;
	
	luaBeautyParlor.panels[ _depth] = {};
	luaBeautyParlor.panels[ _depth].wnd = _wnd;
	luaBeautyParlor.panels[ _depth].tag = _tag;
	luaBeautyParlor.panels[ _depth].bForceChange = bForceChange;
end


--OnLoadedCharVoiceListCtrl
function luaBeautyParlor:OnLoadedCharVoiceListCtrl()

	
	local nCount = gamefunc:GetBeautyParlorItemCount(E_FT_VOICE) ;
	for i = 1, nCount do
	
		local nIndex = lcCharacterVoice:AddItem( i , "iconVoice");
		lcCharacterVoice:SetItemData( nIndex, i);
	end
end

--OnDrawItemCharVoiceListCtrl
function luaBeautyParlor:OnDrawItemCharVoiceListCtrl()
	local nIndex = EventArgs:GetItemIndex();
	local x, y, w, h = EventArgs:GetItemRect();
	
	gamedraw:SetBitmap( "bmpGlassPanel");
	gamedraw:Draw( x, y, w, h);


	local nCurIndex = gamefunc:GetVoice() - 1;
	if(nIndex == nCurIndex) then
		luaBeautyParlor:DrawCurrentLookImage(x, y, w, h);
	end
end

--OnSelChangeCharVoiceListCtrl
function luaBeautyParlor:OnSelChangeCharVoiceListCtrl()

	local nCurSel = lcCharacterVoice:GetCurSel();
	if( nCurSel < 0) then return;
	end
	
	local nVoice = lcCharacterVoice:GetItemData( nCurSel);
	local nIndex = math.random( 1, table.getn( luaBeautyParlor.VOICE));
	
	local szSound;
	local nSex = gamefunc:GetSex();
	if(0 == nSex ) then
		szName = "m" .. tostring(nVoice) .. luaBeautyParlor.VOICE[ nIndex];
	else
		szName = "w" .. tostring( nVoice) .. luaBeautyParlor.VOICE[ nIndex];
	end
	
	gamefunc:PlaySound( szName);
	gamefunc:ChangeFaceAni( "facial_yell_4");
		
	luaBeautyParlor.RefreshCharacter( false);
end

function luaBeautyParlor:GetCurrentSexString()

	local strSex = "_female";
	local nSex = gamefunc:GetSex();
	if( 0== nSex ) then
		strSex = "_male";
	end
	
	return strSex;
end

--OnLoadedCharFaceListCtrl
function luaBeautyParlor:OnLoadedCharFaceListCtrl()

	local nSelIndex = lcCharacterFace:GetCurSel();
	

	
	lcCharacterFace:DeleteAllItems();	
	
	local nCount = gamefunc:GetBeautyParlorItemCount(E_FT_FACE) -1;	

	local strIconPath = gamefunc:GetBeautyParlorFaceIconPath();
		
	for i =0 , nCount do
			
		local strItemID = gamefunc:GetBeautyParlorIcon(E_FT_FACE , i);
		local nLen = string.len(strItemID);

		if(string.sub(strItemID , nLen , nLen) == "0")	then
			strItemID = strIconPath .. "\\" .. strItemID .. ".tga";
			local nIndex = lcCharacterFace:AddItem(i , strItemID);			
			lcCharacterFace:SetItemData( nIndex,  i/3);		
		end
		
	end
	
	lcCharacterFace:SetCurSel(nSelIndex);
end

--OnDrawItemCharFaceListCtrl
function luaBeautyParlor:OnDrawItemCharFaceListCtrl()

	local nIndex = EventArgs:GetItemIndex();
	local x, y, w, h = EventArgs:GetItemRect();
	
	gamedraw:SetBitmap( "bmpGlassPanel");
	gamedraw:Draw( x, y, w, h);


	local nFaceIndex = gamefunc:GetFace();
	if(nFaceIndex > 0) then
		nFaceIndex = math.floor( nFaceIndex / 3);
	end
	
	if(nIndex == nFaceIndex) then
		luaBeautyParlor:DrawCurrentLookImage(x, y, w, h);
	end
end

function luaBeautyParlor:OnSelChangeCharListCtrl()

	luaBeautyParlor:OnLoadedCharFaceListCtrl();
	
	luaBeautyParlor:OnLoadedCharMakeUpListCtrl();
	
	luaBeautyParlor:OnLoadedCharHairListCtrl();
end

--OnLoadedCharHairListCtrl
function luaBeautyParlor:OnLoadedCharHairListCtrl()
	
	local nSelIndex = lcCharacterHair:GetCurSel();
		
	lcCharacterHair:DeleteAllItems();
	
	local nCount = gamefunc:GetBeautyParlorItemCount(E_FT_HAIR) -1;

	local strIconPath = gamefunc:GetBeautyParlorHairIconPath();


	for i = 0, nCount do
	
		local strItemID = gamefunc:GetBeautyParlorIcon(E_FT_HAIR , i);
	
		strItemID = strIconPath .. "\\" .. strItemID .. ".tga";
		local nIndex = lcCharacterHair:AddItem(i , strItemID);
		lcCharacterHair:SetItemData( nIndex, i);		
	end
	
	lcCharacterHair:SetCurSel(nSelIndex);
end

--OnDrawItemCharHairListCtrl	
function luaBeautyParlor:OnDrawItemCharHairListCtrl()

	local nIndex = EventArgs:GetItemIndex();
	local x, y, w, h = EventArgs:GetItemRect();
	
	gamedraw:SetBitmap( "bmpGlassPanel" );
	gamedraw:Draw( x, y , w, h);


	local nCurIndex = gamefunc:GetHair();
	if(nIndex == nCurIndex) then
		luaBeautyParlor:DrawCurrentLookImage(x, y, w, h);
	end
end

--OnLoadedCharMakeUplistCtrl
function luaBeautyParlor:OnLoadedCharMakeUpListCtrl()

	local nSelIndex = lcCharacterMakeUp:GetCurSel();
	local nFaceIndex = lcCharacterFace:GetCurSel() * 3;

	local strIconPath = gamefunc:GetBeautyParlorFaceIconPath();
	
	lcCharacterMakeUp:DeleteAllItems();
	
	for i=0 , 2 do
		
		local strItemID = gamefunc:GetBeautyParlorIcon(E_FT_FACE , nFaceIndex );

		strItemID = strIconPath .. "\\" .. strItemID;		
		
		local nLen = string.len(strItemID);
		
		strItemID = string.sub(strItemID , 1 , nLen -1) .. i .. ".tga";

		
		local nIndex = lcCharacterMakeUp:AddItem( i , strItemID);
		lcCharacterMakeUp:SetItemData( nIndex, i );
	end
	
	lcCharacterMakeUp:SetCurSel(nSelIndex);
end

--OnDrawItemCharMakeUpListCtrl
function luaBeautyParlor:OnDrawItemCharMakeUpListCtrl()

	local nIndex = EventArgs:GetItemIndex();
	local x, y, w, h = EventArgs:GetItemRect();
	
	gamedraw:SetBitmap( "bmpGlassPanel");
	gamedraw:Draw(x, y , w, h);

	local nCurIndex = gamefunc:GetMakeUp();
	if(nIndex == nCurIndex) then
		luaBeautyParlor:DrawCurrentLookImage(x, y, w, h);
	end
end

--OnDrawItemCharTattooListCtrl
function luaBeautyParlor:OnDrawItemCharTattooListCtrl()

	local nIndex = EventArgs:GetItemIndex();
	local x, y, w, h = EventArgs:GetItemRect();
	
	if( nIndex == 0) then
	
		gamedraw:SetFont( "fntSmallStrong");
		gamedraw:SetColor( 255, 255, 255);
		gamedraw:SetTextAlign( "center" , "center");
		gamedraw:TextEx( x, y, w, h, "none");
		
	else
	
		gamedraw:SetFont( "fntRegularStrong");
		gamedraw:SetColor( 255, 255, 255);
		gamedraw:SetTextAlign( "center", "center");
		gamedraw:TextEx( x, y, w, h, lcCharacterTattoo:GetItemText( nIndex, 0));
	end
	
	gamedraw:SetBitmap( "bmpGlassPanel");
	gamedraw:Draw( x, y, w, h);


	local nCurIndex = gamefunc:GetTattooType();
	if(nIndex == nCurIndex) then
		luaBeautyParlor:DrawCurrentLookImage(x, y, w, h);
	end
end

--OnLoadedCharSkinColorListCtrl
function luaBeautyParlor:OnLoadedCharSkinColorListCtrl()

	for		i = 0, (gamefunc:GetBeautyParlorItemCount(E_FT_SKIN_COLOR )) do
	
		local nID = gamefunc:GetCharColorID( "skin" , i);
		if( nID > 0) then
		
			local r, g, b = gamefunc:GetCharColor( "skin" , nID);
			local nIndex = lcCharacterSkinColor:AddItem( "", "bmpGlassPanel" );
			lcCharacterSkinColor:SetItemText( nIndex, 1, r);
			lcCharacterSkinColor:SetItemText( nIndex, 2 , g);
			lcCharacterSkinColor:SetItemText( nIndex, 3, b);
			lcCharacterSkinColor:SetItemData( nIndex, nID);
		end
	end
end

--OnDrawItemBkgrndCharSkinColorListCtrl
function luaBeautyParlor:OnDrawItemBkgrndCharSkinColorListCtrl()

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


	local nCurIndex = gamefunc:GetSkinColor() - 1;
	if(nIndex == nCurIndex) then
		luaBeautyParlor:DrawCurrentLookImage(x, y, w, h);
	end
end

--OnLoadedcharHairColorListCtrl
function luaBeautyParlor:OnLoadedCharHairColorListCtrl()

	local nCount = gamefunc:GetBeautyParlorItemCount(E_FT_HAIR_COLOR);

	for		i = 0, nCount do
	
		local nID = gamefunc:GetCharColorID( "hair", i);
		if (nID > 0) then
		
			local r, g, b = gamefunc:GetCharColor( "hair", nID);
			local nIndex = lcCharacterHairColor:AddItem( "", "bmpGlassPanel");
			lcCharacterHairColor:SetItemText( nIndex, 1, r);
			lcCharacterHairColor:SetItemText( nIndex, 2, g);
			lcCharacterHairColor:SetItemText( nIndex, 3, b);
			lcCharacterHairColor:SetItemData( nIndex, nID);
		end
	end
end

--OnDrawItemBkgrndCharHairColorListCtrl
function luaBeautyParlor:OnDrawItemBkgrndCharHairColorListCtrl()

	local nIndex = EventArgs:GetItemIndex();
	local x, y, w, h = EventArgs:GetItemRect();
	
	local r = lcCharacterHairColor:GetItemText( nIndex, 1);
	local g = lcCharacterHairColor:GetItemText( nIndex, 2);
	local b = lcCharacterHairColor:GetItemText( nIndex, 3);
	gamedraw:SetColor( r, g, b);
	gamedraw:FillRect( x, y, w, h);

	
	local nCurIndex = gamefunc:GetHairColor() - 1;
	if(nIndex == nCurIndex) then
		luaBeautyParlor:DrawCurrentLookImage(x, y, w, h);
	end
end

-- OnLoadedCharEyeColorListCtrl
function luaBeautyParlor:OnLoadedCharEyeColorListCtrl()

	for		i = 0, ( gamefunc:GetBeautyParlorItemCount(E_FT_EYE_COLOR )) do
	
		local nID = gamefunc:GetCharColorID( "eye", i);
		if( nID > 0) then
		
			local r, g, b = gamefunc:GetCharColor( "eye" , nID)
			local nIndex = lcCharacterEyeColor:AddItem( "", "bmpGlassPanel");
			lcCharacterEyeColor:SetItemText( nIndex, 1, r);
			lcCharacterEyeColor:SetItemText( nIndex, 2, g);
			lcCharacterEyeColor:SetItemText( nIndex, 3, b);
			lcCharacterEyeColor:SetItemData( nIndex, nID);
		end
	end
end

--OnLoadedCharTatooColorListCtrl
function luaBeautyParlor:OnLoadedCharTatooColorListCtrl()

	for		i = 0, (gamefunc:GetBeautyParlorItemCount(E_FT_TATTOO_COLOR )) do
	
		local nID = gamefunc:GetCharColorID( "eye", i);
		if( nID > 0) then
		
			local r, g, b = gamefunc:GetCharColor( "eye", nID);
			local nIndex = lcCharacterTatooColor:AddItem( "" , "bmpGlassPanel");
			lcCharacterTatooColor:SetItemText( nIndex, 1, r);
			lcCharacterTatooColor:SetItemText( nIndex, 2, g);
			lcCharacterTatooColor:SetItemText( nIndex, 3, b);
			lcCharacterTatooColor:SetItemData( nIndex, nID);
		end
	end
end

function luaBeautyParlor:VisibleTattooColor()

	local nTattooIndex = lcCharacterTattoo:GetCurSel();
	if( (gamefunc:IsBeautyParlorColorChoice(E_FT_TATTOO , nTattooIndex) == false) or (nTattooIndex == 0) )then
		lcCharacterTatooColor:Show(false);
		lbCharacterTatooColorNone:SetText(STR( "UI_SELCHAR_CREATE_TATTOO_NOCOLOR" ));
		return;
	else
		lcCharacterTatooColor:Show(true);
		lbCharacterTatooColorNone:SetText("");
	end
end
--OnDrawItemBkgrndCharTatooColorListCtrl
function luaBeautyParlor:OnDrawItemBkgrndCharTatooColorListCtrl()
	
	local nIndex = EventArgs:GetItemIndex();
	if(nIndex < 0)then
		return;
	end
	local x, y, w, h = EventArgs:GetItemRect();
	
	local r = lcCharacterTatooColor:GetItemText( nIndex, 1);
	local g = lcCharacterTatooColor:GetItemText( nIndex, 2);
	local b = lcCharacterTatooColor:GetItemText( nIndex, 3);
	gamedraw:SetColor( r, g, b);
	gamedraw:FillRect( x, y, w, h);

	local nCurIndex = gamefunc:GetTattooColor() - 1;
	if(nIndex == nCurIndex) then
		luaBeautyParlor:DrawCurrentLookImage(x, y, w, h);
	end
end

-- OnLoadedCharEquipmentListCtrl
function luaBeautyParlor:OnLoadedCharEquipmentListCtrl()
	
	for i = 1, 2 do
	
		local nIndex = lcCharacterEquipment:AddItem( i , "iconEquipment" );
		lcCharacterEquipment:SetItemData( nIndex, i -1 );
	end
	
end

-- OnDrawItemCharEquipmentListCtrl
function luaBeautyParlor:OnDrawItemCharEquipmentListCtrl()

	local nIndex = EventArgs:GetItemIndex();
	local x, y, w, h = EventArgs:GetItemRect();
	
	gamedraw:SetFont( "fntLargeStrong");
	gamedraw:SetColor( 255, 255, 255);
	gamedraw:SetTextAlign( "center", "center" );
	gamedraw:TextEx( x, y, w, h, lcCharacterEquipment:GetItemText( nIndex, 0 ));
	
	gamedraw:SetBitmap( "bmpGlassPanel");
	gamedraw:Draw( x, y, w, h);
end

--OnLoadedCharEquipColorListCtrl
function luaBeautyParlor:OnLoadedCharEquipColorListCtrl()

	for	i = 0, 27	do
		
		local nID = gamefunc:GetCharColorID( "item_dyed", i);
		
		if(nID > 0 ) then
		
			local r, g, b = gamefunc:GetCharColor( "item_dyed", nID);
			local nIndex = lcCharacterEquipColor:AddItem( "" , "bmpGlassPanel");
			lcCharacterEquipColor:SetItemText( nIndex, 1, r);
			lcCharacterEquipColor:SetItemText( nIndex, 2, g);
			lcCharacterEquipColor:SetItemText( nIndex, 3, b);
			InCharacterEquipColor:SetItemData( nIndex, nID);
		end
	end
end

--OnDrawItemBkgrndCharEquipColorListCtrl
function luaBeautyParlor:OnDrawItemBkgrndCharEquipColorListCtrl()

	local nIndex = EventArgs:GetItemIndex();
	local x, y, w, h = EventArgs:GetItemRect();
	
	local r = lcCharacterEquipColor:GetItemText( nIndex, 1);
	local g = lcCharacterEquipColor:GetItemText( nIndex, 2);
	local b = lcCharacterEquipColor:GetItemText( nIndex, 3);
	gamedraw:SetColor( r,g,b);
	gamedraw:FillRect( x, y, w, h);
end

-- OnLoadedCharPreviewEquipListCtrl
function luaBeautyParlor:OnLoadedCharPreviewEquipListCtrl()

	for		i = 0, 5 do
	
		local	strText = "";
		if( i > 0) then strText = i;
		end
		
		local nData = -1;
		if( i > 0 ) then nData = i + 2;
		end
		
		local nIndex = lcCharacterPreviewEquip:AddItem( strText, "iconPreview");
		lcCharacterPreviewEquip:SetItemData( nIndex, nData);
	end
	
	lcCharacterPreviewEquip:Show( false);
end

--OnDrawItemCharPreviewEquipListCtrl
function luaBeautyParlor:OnDrawItemCharPreviewEquipListCtrl()

	local nIndex = EventArgs:GetItemIndex();
	local x, y, w, h = EventArgs:GetItemRect();
	
	gamedraw:SetFont( "fntLargeStrong");
	gamedraw:SetColor( 255, 255, 255);
	gamedraw:SetTextAlign( "center" , "center");
	gamedraw:TextEx( x, y, w, h, lcCharacterPreviewEquip:GetItemText( nIndex, 0));
	
	if( nIndex == 0) then
	
		gamedraw:SetColorEx( 0 , 0, 0, 160);
		gamedraw:FillRect( x, y, w, h);
	end
	
	gamedraw:SetBitmap( "bmpGlassPanel");
	gamedraw:Draw( x, y, w, h);
end

--SetTattooPos

function luaBeautyParlor:SetTattooPos( px ,py)

	if( lcCharacterTattoo:GetCurSel() <=0) then return;
	end
	
	local w, h = picTattooHeadGrid:GetSize();
	local half_w, half_h = w * 0.5, h * 0.5;

	luaBeautyParlor.TATTOO.x = math.max( -half_w,  math.min( half_w,  px - half_w)) / half_w;
	luaBeautyParlor.TATTOO.y = math.max( -half_h,  math.min( half_h,  py - half_h)) / half_h;
end

--OnDrawTattooHeadGrid
function luaBeautyParlor:OnDrawTattooHeadGrid()

	if( lcCharacterTattoo:GetCurSel() <= 0) then return;
	end
	
	local w, h = picTattooHeadGrid:GetSize();
	local half_w, half_h = w * 0.5 , h * 0.5;
	local x = half_w + ( half_w * luaBeautyParlor.TATTOO.x);
	local y = half_h + ( half_h * luaBeautyParlor.TATTOO.y);
	
	gamedraw:SetBitmap( "bmpTattoo");
	gamedraw:Draw( x - 16, y - 16, 32 , 32);
end

--OpenConfirmCreateCharacter
function luaBeautyParlor:OnClickConfirmChangeCharacter(bUsedLookChangeTicket)


	if(luaBeautyParlor:GetHasBelpeso() < luaBeautyParlor:GetBasketTotalBelpeso()) and
		(bUsedLookChangeTicket == false) then

		luaBeautyParlor:CloseShowChangePopup();
		luaBeautyParlor:ShowErrorMsgBox( STR( "UI_BEAUTYSHOP_ERROR_LACK_BELPESO"));
		return;
	end

	tCharacter = {};	
	
	tCharacter.face = gamefunc:GetBeautyParlorItemID(E_FT_FACE , math.max( 0, lcCharacterFace:GetCurSel() *3));
	tCharacter.hair = gamefunc:GetBeautyParlorItemID(E_FT_HAIR , math.max( 0, lcCharacterHair:GetCurSel() ));
	tCharacter.skin_col = gamefunc:GetBeautyParlorItemID(E_FT_SKIN_COLOR , math.max( 0, lcCharacterSkinColor:GetCurSel() ));
	tCharacter.hair_col = gamefunc:GetBeautyParlorItemID( E_FT_HAIR_COLOR , math.max( 0, lcCharacterHairColor:GetCurSel() ));
	tCharacter.voice = gamefunc:GetBeautyParlorItemID(E_FT_VOICE , math.max( 0, lcCharacterVoice:GetCurSel() ));
	tCharacter.eye_col = gamefunc:GetBeautyParlorItemID(E_FT_EYE_COLOR , math.max( 0, lcCharacterEyeColor:GetCurSel() ));
	tCharacter.makeup = math.max( 0, lcCharacterMakeUp:GetCurSel());

	
		
	-- Tattoo
	tCharacter.tattoo = gamefunc:GetBeautyParlorItemID(E_FT_TATTOO , math.max( 0, lcCharacterTattoo:GetCurSel()));
	tCharacter.tattoocolor = gamefunc:GetBeautyParlorItemID(E_FT_TATTOO_COLOR , math.max( 0, lcCharacterTatooColor:GetCurSel() ));
	local tattooscale = sldTattoScale:GetScrollValue() / 5.0;
	if ( tattooscale < 1.0)  then  tattooscale = tattooscale * 0.5 + 0.5;  end
	tCharacter.tattooscale = ( 1.0 / tattooscale) * 2.0;
	tCharacter.tattooposx = (( 1.0 - tCharacter.tattooscale) * 0.5) - ( luaBeautyParlor.TATTOO.x * 0.7) / tattooscale;
	tCharacter.tattooposy = (( 1.0 - tCharacter.tattooscale) * 0.5) - ( luaBeautyParlor.TATTOO.y * 0.7 - 0.5) / tattooscale;

	tCharacter.tattooposx = (luaBeautyParlor.TATTOO.x * 0.7) / (3.0 - tattooscale);
	tCharacter.tattooposy = 0.25 - (luaBeautyParlor.TATTOO.y * 0.7) / (3.0 - tattooscale);

	gamefunc:ReformMyBeautyParlorCharacterModel(tCharacter , bUsedLookChangeTicket);

end

-- CloseConfirmDeleteMailFrame
function luaBeautyParlor:CloseConfirmCharChange()

	--Refresh UI
	fremConfirmCreateCharacter:Show(false);
	btnCharacterConfirmChainge:Enable( true);
end

-- OnEventCreateCharacter
function luaBeautyParlor:OnEventCreateCharacter( nSuccess, nErrorCode)

	if( nSuccess > 0 ) then
	
	--Select new Character ac select character
	luaBeautyParlorCharSelect.m_nCurSel = gamefunc:GetCharacterAccountmaxCount();
	
	luaBrautyParlorFrame:SwitchScene( luaCharacter.SwitchToCharSelect);
	
	else
		
		--Show error message box
		luaBeautyParlor:ShowErrorMsgBox( STR( "UI_SELCHAR_ERROR_NOTCREATED"), nErrorCode);
	end
end

--ShowErrorMsgBox
function luaBeautyParlor:ShowErrorMsgBox( strMsg , nErrorCode)

	local strString = strMsg;
	if( nErrorCode ~= nil) then strString = strString .. "{CR}" .. gamefunc:GetResultString( nErrorCode);
	end
	tvwErrorMsg:SetText( strString);
	
	frmErrorMsgBox:DoModal();
end

--UpdateMainCycle
function luaBeautyParlor:UpdateMainCycle()

	if( 0 > luaBeautyParlor.MainCycleDelta )then
		luaBeautyParlor.MainCycleDelta = gamefunc:GetUpdateTime();
		return;
	end
	
	if( luaBeautyParlor.MainCycleTimer < gamefunc:GetUpdateTime() - luaBeautyParlor.MainCycleDelta )	then
	
	
		luaBeautyParlor.MainCycleIndex = luaBeautyParlor.MainCycleIndex + 1;
		if( 4 < luaBeautyParlor.MainCycleIndex ) then
			luaBeautyParlor.MainCycleIndex = 1;
		end
		
		local strImageName = "bmpCharFrameMainCycle" .. luaBeautyParlor.MainCycleIndex;
		picCreateMainCycle:SetImage( strImageName );
		
		luaBeautyParlor.MainCycleDelta = gamefunc:GetUpdateTime();
	end
	
end

--OnClickCharTyrn
function luaBeautyParlor:OnClickCharTurn( fDelta )

	if( nil == fDelta ) then
		return;
	end
	
	gamefunc:CameraRotZ( fDelta );
end



-- CloseConfirmDeleteMailFrame
function luaBeautyParlor:CloseConfirmCreateCharacter()

	-- Refresh UI
	--frmConfirmChangeCharacter:Show( false);
	--btnCharacterConfirmChainge:Enable( true);
	pnlBeautyParlorFace:Show(true);
	pnlBeautyParlorHead:Show(false);
	pnlBeautyParlorTattoo:Show( false);
	pnlBeautyParlorVoice:Show( false);
	
end

-- OnLoadedCharTattooListCtrl
function luaBeautyParlor:OnLoadedCharTattooListCtrl()

	local nCount = gamefunc:GetBeautyParlorItemCount(E_FT_TATTOO );
	local nCursel = lcCharacterTattoo:GetCurSel();
	for  i = 0, nCount - 1  do
	
		local nIndex = lcCharacterTattoo:AddItem( i, "iconTattoo");
		lcCharacterTattoo:SetItemData( nIndex, i);
	end
	
	lcCharacterTattoo:SetCurSel( nCursel);
end

-- OnDrawItemBkgrndCharEyeColorListCtrl
function luaBeautyParlor:OnDrawItemBkgrndCharEyeColorListCtrl()

	local nIndex = EventArgs:GetItemIndex();
	local x, y, w, h = EventArgs:GetItemRect();
		
	local r = lcCharacterEyeColor:GetItemText( nIndex, 1);
	local g = lcCharacterEyeColor:GetItemText( nIndex, 2);
	local b = lcCharacterEyeColor:GetItemText( nIndex, 3);
	gamedraw:SetColor( r, g, b);
	gamedraw:FillRect( x, y, w, h);

	local nCurIndex = gamefunc:GetEyeColor() - 1;
	if(nIndex == nCurIndex) then
		luaBeautyParlor:DrawCurrentLookImage(x, y, w, h);
	end
end

function luaBeautyParlor:BeautyParlorErrorMsg( ErrorMsg )
	luaGame:OnEventErrorMessageBox(ErrorMsg);

end


function luaBeautyParlor:AddItemBasketList(nItemKind )
	
	lcBasket:SetCurSel()
	
end

 --SwitchSkillSet Form
function luaBeautyParlor:OnShowfrmSwitchBeautyShop( )

	local x, y = frmSwitchBeautyShop:GetParent():GetPosition();
	local w, h = frmSwitchBeautyShop:GetSize();
    	local width, height = gamefunc:GetWindowSize();

    	frmSwitchBeautyShop:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);
	frmSwitchBeautyShop:DoModal();
end

function luaBeautyParlor:OnSwitchBeautyShopOK()

	frmSwitchBeautyShop:Show( false);	
	gamefunc:BeautyParlorEnter();
end

function luaBeautyParlor:CloseSwitchBeautyShop()

	frmSwitchBeautyShop:Show( false);
	gamefunc:RequestNpcInteractionEnd();
	
end

function luaBeautyParlor:OnDrawBasketInfo(tBasketInfo)

	
end

function luaBeautyParlor:CheckCancel()

	local x , y , w, h = EventArgs:GetItemRect();

	
end


function luaBeautyParlor:BeautyParlorListAllCancel()
	
	for i = 0, lcBeautyParlorBasketList:GetItemCount() - 1 do

		local nStyle = lcBeautyParlorBasketList:GetItemData(0);
		luaBeautyParlor:BeautyParlorListSeleteCancel(0, nStyle);
	end
end


function luaBeautyParlor:BeautyParlorListSeleteCancelCurSel()
	
	local nCurSel = lcBeautyParlorBasketList:GetCurSel();
	if(nCurSel < 0) then
		return;
	end

	local nStyle = lcBeautyParlorBasketList:GetItemData(nCurSel);

	luaBeautyParlor:BeautyParlorListSeleteCancel(nCurSel, nStyle);

end


function luaBeautyParlor:BeautyParlorListSeleteCancel(nCurSel, nStyle)
	
	if(nCurSel < 0) then
		return;
	end

	if(nStyle == E_FT_HAIR)then

		local nHair = gamefunc:GetHair();
		lcCharacterHair:SetCurSel(nHair);
		
	elseif(nStyle == E_FT_FACE)then

		local nFace = gamefunc:GetFace();
		if(nFace > 0) then
			nFace = math.floor( nFace / 3);
		end
		lcCharacterFace:SetCurSel(nFace);

	elseif(nStyle == E_FT_FACE_MAKEUP)then
		
		local nMakeUp = gamefunc:GetMakeUp();
		lcCharacterMakeUp:SetCurSel(nMakeUp);

	elseif(nStyle == E_FT_HAIR_COLOR)then

		local nHairColor = gamefunc:GetHairColor() -1;
		lcCharacterHairColor:SetCurSel(nHairColor);
	

	elseif(nStyle == E_FT_SKIN_COLOR)then

		local nSkinColor = gamefunc:GetSkinColor() -1;
		lcCharacterSkinColor:SetCurSel(nSkinColor);


	elseif(nStyle == E_FT_EYE_COLOR)then

		local nEyeColor = gamefunc:GetEyeColor() -1;
		lcCharacterEyeColor:SetCurSel(nEyeColor);


	elseif(nStyle == E_FT_VOICE)then

		luaBeautyParlor:InitVoice();

	elseif(nStyle == E_FT_TATTOO)then

		luaBeautyParlor:InitTattooControl(false);

	elseif(nStyle == E_FT_TATTOO_COLOR)then

		lcCharacterTatooColor:SetCurSel(gamefunc:GetTattooColor() -1);
	end

	luaBeautyShopBasket.basketinfo[nStyle].nBelpeso = 0;
	luaBeautyShopBasket.basketinfo[nStyle].nItemStyle = 0;
	luaBeautyShopBasket.basketinfo[nStyle].strDrawImage = "";
	luaBeautyShopBasket.basketinfo[nStyle].strTitle = "";
	luaBeautyShopBasket.basketinfo[nStyle].nItemIndex = 0;

	lcBeautyParlorBasketList:DeleteItem(nCurSel);

	luaBeautyParlor:RefreshBasketText();

	local nCount = lcBeautyParlorBasketList:GetItemCount();
	if(nCount ~= 0) then
		if(nCurSel == 0) then
			lcBeautyParlorBasketList:SetCurSel( nCurSel);
			lcBeautyParlorBasketList:SetScrollValue(nCurSel);
		else
			lcBeautyParlorBasketList:SetCurSel( nCurSel-1);
			lcBeautyParlorBasketList:SetScrollValue(nCurSel-1);
		end
	end

	luaBeautyParlor:RefreshCharacter( false );
	luaBeautyParlor:RefreshBasketText();
end


function luaBeautyParlor:OnShowChangePopup()

	if(lcBeautyParlorBasketList:GetItemCount() == 0) then
		luaBeautyParlor:ShowErrorMsgBox( STR( "UI_BEAUTYSHOP_ERROR_NON_SELETE_LOOK"));
		return;
	end

	tvwConfirmChangeCharacter:SetText( FORMAT( "UI_BEAUTYSHOP_FEATURE", luaBeautyParlor:GetBasketTotalBelpeso() * 0.01 ));

	local w, h = frmConfirmChangeCharacter:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmConfirmChangeCharacter:SetPosition( width*0.5 - w*0.5, height*0.5 - h*0.5);

	frmConfirmChangeCharacter:DoModal();
end
	
function luaBeautyParlor:CloseShowChangePopup()

	frmConfirmChangeCharacter:Show(false);
end


function luaBeautyParlor:OnShowUseLookChangeTicketPopup()

	if(luaBeautyParlor:GetLookChangeTicket() == 0) then
		luaBeautyParlor:ShowErrorMsgBox( STR( "UI_BEAUTYSHOP_ERROR_LACK_TICKET"));
		return;
	end
	
	local w, h = frmConfirmLookChangeTicket:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmConfirmLookChangeTicket:SetPosition( width*0.5 - w*0.5, height*0.5 - h*0.5);

	frmConfirmLookChangeTicket:DoModal();
end
	
function luaBeautyParlor:HideUseLookChangeTicketPopup()

	frmConfirmLookChangeTicket:Show(false);
end




function luaBeautyParlor:BeautyParlorLeave()
	
	gamefunc:PlaySound( "button_out" );
    gamefunc:BeautyParlorLeave();
	gamefunc:RequestNpcInteractionEnd();
	frmErrorMsgBox:Show(false);
	frmConfirmChangeCharacter:Show(false);
	-- gamedebug:Log("BeautyParlor Leave");
end


function luaBeautyParlor:GetLookChangeTicket()

	return gamefunc:GetInvenItemQuantityByIDInBeautyState(luaBeautyParlor.nLookChangeTicketID);
end

function luaBeautyParlor:GetHasBelpeso()

	local nBelpeso = 0;

	nBelpeso = nBelpeso + gamefunc:GetInvenItemQuantityByIDInBeautyState(luaBeautyParlor.nGoldBelpesoID) * 100;
	nBelpeso = nBelpeso + gamefunc:GetInvenItemQuantityByIDInBeautyState(luaBeautyParlor.nSilverBelpesoID);

	return nBelpeso;
end

function luaBeautyParlor:GetBasketTotalBelpeso()

	local nBelpeso = 0;

	if(lcBeautyParlorBasketList:GetItemCount() == 0) then
		return nBelpeso;
	end


	for i = 0, lcBeautyParlorBasketList:GetItemCount() - 1 do

		local nStyle = lcBeautyParlorBasketList:GetItemData(i);
		nBelpeso = nBelpeso + luaBeautyShopBasket.basketinfo[nStyle].nBelpeso;
	end

	return nBelpeso;
end

-- OnToolTipPartPrice
function luaBeautyParlor:OnToolTipPartPrice(nType)

	if(nType >= E_FT_MAX) then
		return;
	end

	if(nType <= E_FT_NONE)then
		return;
	end

	local strString = "";


	local nCurSel = luaBeautyParlor:GetTooltipCurSel(nType);

	
		
	local nPrice = 0;

	-- 메이크업일경우 1번 인덱스 가격을 빼서 2,3번 메이크업 가격을 측정
	if(nType == E_FT_FACE_MAKEUP)then
		nPrice = luaBeautyParlor:GetMakeUpPrice(nCurSel);
	else
		nPrice = gamefunc:GetBeautyParlorPrice(nType , nCurSel);
	end
		
	if(nPrice >= 0)then
	
		-- 현재 아이템이거나 타투가 None일때
		if(luaBeautyParlor:IsPriceZero(nType) == true)then 
			nPrice = 0;
			strString = STR("UI_BEAUTYSHOP_CURRENT_LOOK");
		else
			strString = STR("UI_BEAUTYSHOP_BYE_COST").. luaBeautyParlor:ConvertVelpeso(nPrice);
		end	
	end	
	
	luaBeautyParlor:SetTooltipData(nType , strString);
end

function luaBeautyParlor:IsPriceZero(nType)

	local bCheck = false;
	local nCurSel = -1;
	local nItemIndex = -1;
	if(nType == E_FT_HAIR)then

		nCurSel = lcCharacterHair:GetMouseOver();
		local nItemIndex = gamefunc:GetHair();

		if(nCurSel == nItemIndex)then
			bCheck = true;
		end
		
	elseif(nType == E_FT_FACE)then
		
		local nFaceIndex = gamefunc:GetFace();
		if(nFaceIndex > 0) then
			nFaceIndex = math.floor( nFaceIndex / 3);
		end

		nCurSel = lcCharacterFace:GetMouseOver();

		if(nCurSel == nFaceIndex)then
			bCheck = true;
		end		

	elseif(nType == E_FT_FACE_MAKEUP)then
		
		nCurSel = lcCharacterMakeUp:GetMouseOver();
		nItemIndex = gamefunc:GetMakeUp();
		if(nCurSel == nItemIndex )then
			bCheck = true;
		end

	elseif(nType == E_FT_HAIR_COLOR)then

		nCurSel = lcCharacterHairColor:GetMouseOver() +1;
		nItemIndex = gamefunc:GetHairColor();
		if(nCurSel == nItemIndex )then
			bCheck = true;
		end		

	elseif(nType == E_FT_SKIN_COLOR)then

		nCurSel = lcCharacterSkinColor:GetMouseOver() +1;
		nItemIndex = gamefunc:GetSkinColor();
		if(nCurSel == nItemIndex)then
			bCheck = true;
		end	

	elseif(nType == E_FT_EYE_COLOR)then

		nCurSel = lcCharacterEyeColor:GetMouseOver() +1;
		nItemIndex = gamefunc:GetEyeColor();
		if(nCurSel == nItemIndex)then
			bCheck = true;
		end	

	elseif(nType == E_FT_VOICE)then

		nCurSel = lcCharacterVoice:GetMouseOver();
		nItemIndex = gamefunc:GetVoice() - 1;

		if(nCurSel == nItemIndex)then
			bCheck = true;
		end	
	elseif(nType == E_FT_TATTOO)then

		nCurSel = lcCharacterTattoo:GetMouseOver();
		nItemIndex = gamefunc:GetTattooType();

		if(nCurSel == nItemIndex) then
			bCheck = true;
		end	

	elseif(nType == E_FT_TATTOO_COLOR)then

		nCurSel = lcCharacterTatooColor:GetMouseOver();
		nItemIndex = gamefunc:GetTattooColor() -1;

		if( nCurSel == nItemIndex )then
			bCheck = true;
		end	
	end

	return bCheck;

end

function luaBeautyParlor:ConvertVelpeso(nPrice)

	local _gold = math.floor( nPrice / 100);
	local _silver = nPrice % 100;
	
	strString = "{COLOR r=230 g=180 b=20}" .. "{BITMAP name=\"bmpGoldVelpeso\" w=20 h=20}{SPACE w=2}" .. _gold .. "{/COLOR}{SPACE w=10}" ..
				"{COLOR r=200 g=200 b=200}" .. "{BITMAP name=\"bmpSilverVelpeso\" w=20 h=20}{SPACE w=2}" .. _silver .. "{/COLOR}";

	return strString;
end

function luaBeautyParlor:SetTooltipData(nType , strString)
	
	if(nType == E_FT_HAIR)then

		lcCharacterHair:SetToolTip( strString);
	elseif(nType == E_FT_FACE)then
		
		lcCharacterFace:SetToolTip( strString);

	elseif(nType == E_FT_FACE_MAKEUP)then

		lcCharacterMakeUp:SetToolTip( strString);	

	elseif(nType == E_FT_HAIR_COLOR)then

		lcCharacterHairColor:SetToolTip( strString);	

	elseif(nType == E_FT_SKIN_COLOR)then

		lcCharacterSkinColor:SetToolTip( strString);

	elseif(nType == E_FT_EYE_COLOR)then

		lcCharacterEyeColor:SetToolTip( strString);

	elseif(nType == E_FT_VOICE)then
		
		lcCharacterVoice:SetToolTip( strString);
	elseif(nType == E_FT_TATTOO)then

		lcCharacterTattoo:SetToolTip( strString);
	elseif(nType == E_FT_TATTOO_COLOR)then

		lcCharacterTatooColor:SetToolTip( strString);
	end

end

function luaBeautyParlor:GetTooltipCurSel(nType)

	local nCurSel = 0;
	
	if(nType == E_FT_HAIR)then

		nCurSel = lcCharacterHair:GetMouseOver();		

	elseif(nType == E_FT_FACE)then

		nCurSel = lcCharacterFace:GetMouseOver();
		nCurSel = nCurSel * 3;
	elseif(nType == E_FT_FACE_MAKEUP)then
		
		nCurSel = lcCharacterFace:GetCurSel();
		nCurSel = nCurSel * 3 + lcCharacterMakeUp:GetMouseOver();		
	elseif(nType == E_FT_HAIR_COLOR)then

		nCurSel = lcCharacterHairColor:GetMouseOver();	
	elseif(nType == E_FT_SKIN_COLOR)then

		nCurSel = lcCharacterSkinColor:GetMouseOver();
	elseif(nType == E_FT_EYE_COLOR)then

		nCurSel = lcCharacterEyeColor:GetMouseOver();
	elseif(nType == E_FT_VOICE)then

		nCurSel = lcCharacterVoice:GetMouseOver();
	elseif(nType == E_FT_TATTOO)then

		nCurSel = lcCharacterTattoo:GetMouseOver();
	elseif(nType == E_FT_TATTOO_COLOR)then
		nCurSel = lcCharacterTatooColor:GetMouseOver();
	end

	return nCurSel;
end


function luaBeautyParlor:GetMakeUpPrice(nCurSel)

	-- 메이크업일경우 1번 인덱스 가격을 빼서 2,3번 메이크업 가격을 측정
	local nPrice = gamefunc:GetBeautyParlorPrice(E_FT_FACE , nCurSel);
	local nDefaultMakeUpSel= lcCharacterFace:GetCurSel() * 3;
	local nDefaultPrice = gamefunc:GetBeautyParlorPrice(E_FT_FACE , nDefaultMakeUpSel);
	return nPrice - nDefaultPrice;
end


function luaBeautyParlor:ChangeFeatureComplete()

	luaBeautyParlor:RefreshCharacterModel( false );
	luaBeautyParlor:EnterBeautyParlor();
	frmCompleteMsgBox:DoModal();
end

function luaBeautyParlor:HelmShow()

	if(gamefunc:IsBeautyParlorHelm() == true) then
		gamefunc:SetBeautyShopHelm(false);
		btnHelmShow:SetText( STR( "UI_BEAUTYSHOP_HELM_SHOW"));
	else
		gamefunc:SetBeautyShopHelm(true);
		btnHelmShow:SetText( STR( "UI_BEAUTYSHOP_HELM_VISIBLE"));
	end	
	luaBeautyParlor:RefreshCharacterModel( false );
end

function luaBeautyParlor:HelmButtonVisible()

	if(gamefunc:IsBeautyParlorHelmButtonVisible() == false)then
		btnHelmShow:Show(false);
	else
		btnHelmShow:Show(true);
	end
end


function luaBeautyParlor:DrawCurrentLookImage(x, y, w, h)

	gamedraw:SetBitmap( "bmpBeautyParlorCurrent");
	gamedraw:Draw( x, y, 13, 13);

end