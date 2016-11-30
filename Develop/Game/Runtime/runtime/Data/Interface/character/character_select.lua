--[[
	Select character LUA script
--]]


-- Global instance
luaCharacterSelect = {};


-- Current selected character
luaCharacterSelect.m_nCurSel = nil;


-- Lamp image height position
luaCharacterSelect.m_nLampCurHeight = 220;
luaCharacterSelect.m_nLampTarHeight = 200;
luaCharacterSelect.m_fLampTimer = 0;

-- 비디오 끝
luaCharacterSelect.m_bEnd	= false;
luaCharacterSelect.MainCycleDelta	= -1;
luaCharacterSelect.MainCycleIndex	= 1;
luaCharacterSelect.MainCycleTimer	= 200;



-- EnterCharSel
function luaCharacterSelect:EnterCharSel()

	-- Hide privious UI
	if ( layerLogin ~= nil)  then			layerLogin:Show( false);  end
	if ( layerLoginFrame ~= nil)  then		layerLoginFrame:Show( false);  end
	if ( layerLoginLoading ~= nil)  then	layerLoginLoading:Show( false);  end


	-- Change scene
	gamefunc:ChangeCampaignScene( 1 );
	
	luaCharacterSelect.MainCycleDelta	= -1;
	luaCharacterSelect.MainCycleIndex	= 1;

	-- Refresh character list
	luaCharacterSelect:RefreshCharacter();
	
	luaCharacterSelect:InitControl();
	
end

-- LeaveCharSel
function luaCharacterSelect:LeaveCharSel()
end

-- InitControl
function luaCharacterSelect:InitControl()
	
	-- pc방 유/무 판별( 한국에서만 판별하도록 )
	pnlPCBenefit:Show( false );
	
	local width, height = pnlCharList:GetParent():GetSize();
	local x, y, w, h = pnlCharList:GetRect();
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
	
	pnlCharList:SetPosition( x, y );
	
end

-- RefreshCharacter
function luaCharacterSelect:RefreshCharacter()

	if ( layerCharSelect:GetShow() == false)  then  return;
	end

	luaCharacterSelect:RefreshCharacterList();
	luaCharacterSelect:RefreshControls();
end

-- RefreshCharacterList
function luaCharacterSelect:RefreshCharacterList()

	-- Hide all name tag
	local nMaxCount = gamefunc:GetCharacterAccountMaxCount();
	for  i = 0, (nMaxCount - 1)  do
	
		local _window = rawget( _G, "btnCharacterName" .. i);
		_window:Enable( false );
		_window:SetCheck( false);
		_window:SetText( "" );
	end
	

	-- Set name tag
	local nCount = gamefunc:GetCharacterAccountCount();
	
	-- 캐릭터 갯수 저장( 생성/삭제가 일어날때도 대응하기 위해 여기 넣음 )
	--gamefunc:SetLastWorldCharNum( nCount );
	for  i = 0, (nCount - 1)  do

		local strName = gamefunc:GetCharacterAccountName( i);

		local _window = rawget( _G, "btnCharacterName" .. i);
		_window:SetText( strName);
		_window:Enable( true );
	end
	
	
	-- Get current selected character index
	if ( luaCharacterSelect.m_nCurSel == nil)  then
		
		luaCharacterSelect.m_nCurSel = tonumber( gamefunc:GetHistory( "SelCharIndex"));
		--luaCharacterSelect.m_nCurSel = gamefunc:GetCurrWorldSelCharIdx();
		if ( luaCharacterSelect.m_nCurSel == nil)  then  luaCharacterSelect.m_nCurSel = -1;
		end
	end
	
	luaCharacterSelect.m_nCurSel = math.min( luaCharacterSelect.m_nCurSel, nCount - 1);
	
	
	-- Select character
	gamefunc:SelChangedCharacter( luaCharacterSelect.m_nCurSel);
	
	if ( luaCharacterSelect.m_nCurSel >= 0)  then
	
		rawget( _G, "btnCharacterName" .. luaCharacterSelect.m_nCurSel):SetCheck( true);

		local nLevel = gamefunc:GetCharacterAccountLevel( luaCharacterSelect.m_nCurSel);
		local strLocation = gamefunc:GetCharacterAccountLocation( luaCharacterSelect.m_nCurSel);
		local strName = gamefunc:GetCharacterAccountName( luaCharacterSelect.m_nCurSel );

		local strString = "{ALIGN hor=\"center\"}{FONT name=\"fntRegular\"}{COLOR r=237 g=219 b=197}" .. STR( "LEVEL_SHORT" ) .. nLevel .. "  " .. "" .. strName .. "\n" ..
			"{FONT name=\"fntScript\"}" .. strLocation;
			
		-- 필드 레벨 표시
		twvCharState:SetText( strString );
	else
	
		-- 필드 레벨 표시
		twvCharState:SetText( "" );
		
	end

	TextViewPCCafeLogo:Show( false );

end

-- RefreshControls
function luaCharacterSelect:RefreshControls()

	local nCount = gamefunc:GetCharacterAccountCount();
	local nMaxCount = gamefunc:GetCharacterAccountMaxCount();
	
	if ( nCount < nMaxCount)  then		btnCreateCharacter:Enable( true);
	else								btnCreateCharacter:Enable( false);
	end
	

	if ( luaCharacterSelect.m_nCurSel < 0)  then
	
		btnDeleteCharacter:Enable( false);
		btnEnterGame:Enable( false);
	
	else

		btnDeleteCharacter:Enable( true);
		btnEnterGame:Enable( true);
	end
end

-- OnClickCharacterSel
function luaCharacterSelect:OnClickCharacterSel( nIndex)
	
	local _window = rawget( _G, "btnCharacterName" .. nIndex);
	if ( _window:GetCheck() == true)  then
	
		_window:SetCheck( not _window:GetCheck());
		return;
	end
	

	-- Reset buttons
	for  i = 0, (gamefunc:GetCharacterAccountMaxCount() - 1)  do
	
		if ( i ~= nIndex)  then
	
			local _window = rawget( _G, "btnCharacterName" .. i);
			_window:SetCheck( false);
		end
	end


	-- Select character
	luaCharacterSelect.m_nCurSel = nIndex;
	gamefunc:SelChangedCharacter( nIndex);
	
	
	-- Update selected character info
	if ( luaCharacterSelect.m_nCurSel >= 0)  then
	
		local nLevel = gamefunc:GetCharacterAccountLevel( luaCharacterSelect.m_nCurSel);
		local strLocation = gamefunc:GetCharacterAccountLocation( luaCharacterSelect.m_nCurSel);
		local strName = gamefunc:GetCharacterAccountName( luaCharacterSelect.m_nCurSel );

		local strString = "{ALIGN hor=\"center\"}{FONT name=\"fntRegular\"}{COLOR r=237 g=219 b=197}" .. STR( "LEVEL_SHORT" ) .. nLevel .. "  " .. "" .. strName .. "\n" ..
			"{FONT name=\"fntScript\"}" .. strLocation;
		
		-- 필드 레벨 표시
		twvCharState:SetText( strString );
	else
	
		-- 필드 레벨 표시
		twvCharState:SetText( "" );
		
	end

	
	
	-- Refresh controls
	luaCharacterSelect:RefreshControls();

end

-- OnDblClickCharacterSel
function luaCharacterSelect:OnDblClickCharacterSel( nIndex)

	local _window = rawget( _G, "btnCharacterName" .. nIndex);
	_window:SetCheck( not _window:GetCheck());
	--_window:Enable( false);	
	
	
	if ( luaCharacterSelect:EnterGame() == false)  then  _window:Enable( true);
	end
end

-- OnClickCreateCharacter
function luaCharacterSelect:OnClickCreateCharacter()

	local _nMaxCount = gamefunc:GetCharacterAccountMaxCount();
	local _nCurrentCount = gamefunc:GetCharacterAccountCount();
	
	if ( _nCurrentCount < _nMaxCount)  then  luaCharacterFrame:SwitchScene( luaCharacter.SwitchToCharCreate);
	end
end

-- OnClickDeleteCharacter
function luaCharacterSelect:OnClickDeleteCharacter()

	if ( luaCharacterSelect.m_nCurSel < 0)  then  return;
	end
	
	frmConfirmDeleteCharacter:DoModal();
end

-- OnClickEnterGame
function luaCharacterSelect:OnClickEnterGame()

	luaCharacterSelect:EnterGame();
end

-- OnClickCredit
function luaCharacterSelect:OnClickCredit()

	luaCharacterFrame:SwitchScene( luaCharacter.SwitchToCredit);
	
	-- 진입준비( BGM 종료/백업 )
	luaCredit:ReadyCredit();
	
end

-- OnClickExitCharacterSel
function luaCharacterSelect:OnClickLogoutCharacterSel()

	luaCharacterFrame:SwitchScene( luaCharacter.SwitchToLogin);
	
end


function luaCharacterSelect:OnClickExitCharacterSel()

	frmConfirmQuitGame:Show(true);
end


-- EnterGame
function luaCharacterSelect:EnterGame()

	if ( luaCharacterSelect.m_nCurSel < 0)  then  return false;
	end

	local nLevel = gamefunc:GetCharacterAccountLevel( luaCharacterSelect.m_nCurSel);
	--local bFirst = gamefunc:IsPlayDoneCharName(luaCharacterSelect.m_nCurSel);
	--gamefunc:SetHistory( "SelCharIndex", tostring( luaCharacterSelect.m_nCurSel));
	--gamefunc:SetLastWorldSelCharIdx( luaCharacterSelect.m_nCurSel );
	
	gamefunc:SelectCharacter( luaCharacterSelect.m_nCurSel);
	
	return true;
	
end




function luaCharacterSelect:ShowPreVideo()

	luaCharacterFrame:SwitchScene( luaCharacter.SwitchToVideo);

	luaCredit:ReadyCredit();
end



function luaCharacterSelect:EndVideo()

	if (luaCharacterSelect.m_bEnd == true) then return
	end

	if (gamevideo:IsPlayEnd() == true) then

		luaCharacterSelect.m_bEnd = true;
		
		luaCharacterFrame:SwitchScene( luaCharacter.SwitchToLogin);
		
		luaCharacterSelect:EnterGame();
	end	
end




function luaCharacterSelect:OnSizeVideo()

    local nWidth = gamefunc:GetWindowWidth();
    local nHeight = gamefunc:GetWindowHeight();
    local nDefWidth = 1280;
    local nDefHeight = 720;
    local nRatio = nWidth/nDefWidth;
    gamevideo:SetSize(nWidth, nDefHeight * nRatio);

    local x, y, w, h = gamevideo:GetRect();
    x = ( gamefunc:GetWindowWidth() - w) * 0.5;
    y = ( gamefunc:GetWindowHeight() - h) * 0.5;
    gamevideo:SetPosition( X, y);
end










-- OnShowCharacterDeleteFrame
function luaCharacterSelect:OnShowCharacterDeleteFrame()

	if ( frmConfirmDeleteCharacter:GetShow() == true)  then

		local x = ( gamefunc:GetWindowWidth() - frmConfirmDeleteCharacter:GetWidth()) * 0.5;
		local y = ( gamefunc:GetWindowHeight() - frmConfirmDeleteCharacter:GetHeight()) * 0.5;
		frmConfirmDeleteCharacter:SetPosition( x, y);

		edtDeleteCharacterName:SetText( "");
		edtDeleteCharacterName:SetFocus();
		edtDeleteCharacterName:SetSel( 0, edtDeleteCharacterName:GetLength());
	end
end

-- OnClickCharacterDelete
function luaCharacterSelect:OnClickCharacterDelete()

	frmConfirmDeleteCharacter:Show( false);


	local strName = edtDeleteCharacterName:GetText();

	-- Delete character
	if(strName ~= "" and strName == gamefunc:GetCharacterAccountName( luaCharacterSelect.m_nCurSel)) then
		frmConfirmDeleteCharacterAgain:DoModal();
	end
end

-- OnShowCharacterDeleteFrameAgain
function luaCharacterSelect:OnShowCharacterDeleteFrameAgain()

	if ( frmConfirmDeleteCharacterAgain:GetShow() == true)  then

		local x = ( gamefunc:GetWindowWidth() - frmConfirmDeleteCharacterAgain:GetWidth()) * 0.5;
		local y = ( gamefunc:GetWindowHeight() - frmConfirmDeleteCharacterAgain:GetHeight()) * 0.5;
		frmConfirmDeleteCharacterAgain:SetPosition( x, y);
	end
end

-- OnClickCharacterDelete
function luaCharacterSelect:OnClickCharacterDeleteAgain()

	gamefunc:DeleteCharacter( luaCharacterSelect.m_nCurSel);

	frmConfirmDeleteCharacterAgain:Show( false);
end

-- OnToolTipPCBenefitIcon1
function luaCharacterSelect:OnToolTipPCBenefitIcon1()
	
	tvwPCBenefitIcon1:SetToolTip( STR( "UI_PC_BENEFIT_ICON1_TOOLTIP" ) );
end

-- OnToolTipPCBenefitIcon2
function luaCharacterSelect:OnToolTipPCBenefitIcon2()
	
	tvwPCBenefitIcon2:SetToolTip( STR( "UI_PC_BENEFIT_ICON2_TOOLTIP" ) );
end

-- OnToolTipPCBenefitIcon3
function luaCharacterSelect:OnToolTipPCBenefitIcon3()
	
	tvwPCBenefitIcon3:SetToolTip( STR( "UI_PC_BENEFIT_ICON3_TOOLTIP" ) );
end

-- OnToolTipPCBenefitIcon4
function luaCharacterSelect:OnToolTipPCBenefitIcon4()
	
	tvwPCBenefitIcon4:SetToolTip( STR( "UI_PC_BENEFIT_ICON4_TOOLTIP" ) );
end

-- OnPositionCharCreateFrameBar
function luaCharacterSelect:UpdateMainCycle()
	
	if( 0 > luaCharacterSelect.MainCycleDelta )	then
		luaCharacterSelect.MainCycleDelta = gamefunc:GetUpdateTime();
		return ;
	end
	
	if( luaCharacterSelect.MainCycleTimer < gamefunc:GetUpdateTime() - luaCharacterSelect.MainCycleDelta )	then
		
		luaCharacterSelect.MainCycleIndex	= luaCharacterSelect.MainCycleIndex + 1;
		if( 4 < luaCharacterSelect.MainCycleIndex )	then
			luaCharacterSelect.MainCycleIndex	= 1;
		end

		local strImageName	= "bmpCharFrameMainCycle" .. luaCharacterSelect.MainCycleIndex;
		picSelectMainCycle:SetImage( strImageName );
		
		luaCharacterSelect.MainCycleDelta = gamefunc:GetUpdateTime();
		
	end
	
end