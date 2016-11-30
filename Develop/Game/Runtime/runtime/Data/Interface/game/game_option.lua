--[[
	Game option LUA script
--]]


-- Global instance
luaOption = {};


-- Changed option
luaOption.g_bChangedOption = false;


-- Define
STR_RESOLUTION = " x ";							-- ex : "1024 x 768"





-- OnShowOptionFrame
function luaOption:OnShowOptionFrame()

	-- Show	
	if ( frmOption:GetShow() == true)  then
	
		luaOption.g_bChangedOption = false;
		
		btnApplyOption:Enable( false);
	
		luaOption:RefreshOptionFrame();	
		luaOption:MoveOptionFrameToCenter();
		
		labRequiredReboot:Show( false);
		
		gameoption:BeginModifyOption();
	
	-- Hide
	else
	
		luaOption:CancelOption();

		gameoption:EndModifyOption();
	end
	
	
	luaGame:ShowWindow( frmOption);
end





-- MoveOptionFrameToCenter
function luaOption:MoveOptionFrameToCenter()

	local x = ( gamefunc:GetWindowWidth() - frmOption:GetWidth()) * 0.5;
	local y = ( gamefunc:GetWindowHeight() - frmOption:GetHeight()) * 0.5;
	frmOption:SetPosition( x, y);
end





-- RefreshOptionFrame
function luaOption:RefreshOptionFrame()

	if ( frmOption:GetShow() == false)  then  return;
	end
	

	local nTabNum = tbcOptionTabCtrl:GetSelIndex();

	if ( nTabNum == 0)  then		luaOption:RefreshGameOption();
	elseif ( nTabNum == 1)  then	luaOption:RefreshGraphicOption();
	elseif ( nTabNum == 2)  then	luaOption:RefreshSoundOption();
	elseif ( nTabNum == 3)  then	luaOption:RefreshControlOption();
	end
end





-- RefreshGameOption
function luaOption:RefreshGameOption()

	btnAutoContinuousAttack:SetCheck( gameoption:IsEnableAutoContinuousAttack());
    btnCombatStanceSitting:SetCheck( gameoption:IsEnableCombatStanceSitting());
	btnShowBuffName:SetCheck( gameoption:IsShowBuffName());
	btnShowHelpMessage:SetCheck( gameoption:IsShowHelpMessage());
	btnShowChatMsg:SetCheck( gameoption:IsShowChatMsg());
	btnShowWhisperMsg:SetCheck( gameoption:IsShowWhisperMsg());
	btnShowPartyMsg:SetCheck( gameoption:IsShowPartyMsg());
	btnShowGuildMsg:SetCheck( gameoption:IsShowGuildMsg());
	btnShowBubbleChat:SetCheck( gameoption:IsShowBubbleChat());
	btnShowIndicator:SetCheck( gameoption:IsShowIndicator());
	btnShowMIniHPBar:SetCheck( gameoption:IsShowMIniHPBar());
	btnShowCaption:SetCheck( gameoption:IsShowCaption());
	btnRecipeRemove:SetCheck( gameoption:IsRecipeRemove());
    btnAutoParty:SetCheck( gameoption:IsAutoPartyMatch());	
    
	btnRejectParty:SetCheck( gameoption:IsRejectParty());
	btnRejectGuild:SetCheck( gameoption:IsRejectGuild());
	btnRejectDuel:SetCheck( gameoption:IsRejectDuel());
	btnRejectTrading:SetCheck( gameoption:IsRejectTrading());
	
	btnShowMyPlayerName:SetCheck( gameoption:IsShowMyPlayerName());
	btnShowMyPlayerGuildName:SetCheck( gameoption:IsShowMyPlayerGuildName());
	btnShowOtherPlayerName:SetCheck( gameoption:IsShowOtherPlayerName());
	btnShowOtherPlayerGuildName:SetCheck( gameoption:IsShowOtherPlayerGuildName());
	btnShowNpcName:SetCheck( gameoption:IsShowNpcName());
	btnShowNpcGuildName:SetCheck( gameoption:IsShowNpcGuildName());

	-- Cross hair	
	cmbCrossHairSelecter:ResetContent();
	for i = 0, (gameoption:GetCrossHairComboListCount() - 1) do
		
		local strCrossHairName = gameoption:GetCrossHairName(i);
		
		if(strCrossHairNamae ~= "") then
			cmbCrossHairSelecter:AddString(strCrossHairName);
		end		
	end	
	
	local strCrossHairSelect = gameoption:GetCrossHairCurrentType();
	for j = 0, (cmbCrossHairSelecter:GetItemCount() - 1) do
	
		if( cmbCrossHairSelecter:GetItemText(j) == strCrossHairSelect) then 
			
			cmbCrossHairSelecter:SetCurSel(j);
			return;
		end
	end

	cmbCrossHairSelecter:SetCurSel(0);
	gameoption:SetCrossHairCurrentType(cmbCrossHairSelecter:GetItemText(0));
end





-- RefreshGraphicOption
function luaOption:RefreshGraphicOption()

	cmbScreenResolution:ResetContent();
	
	gameoption:SnapshotDisplayResolutionList();
	for  i = 0, (gameoption:GetDisplayResolutionListCount() - 1)  do
	
		local w, h = gameoption:GetDisplayResolutionList( i);
		cmbScreenResolution:AddString( w .. STR_RESOLUTION .. h);
	end
	cmbScreenResolution:SetCurSel( 0);

	local w, h = gameoption:GetScreenResolution();
	local strResolution = w .. STR_RESOLUTION .. h;
	for  i = 0, (cmbScreenResolution:GetItemCount() - 1)  do
	
		if ( strResolution == cmbScreenResolution:GetItemText( i))  then
		
			cmbScreenResolution:SetCurSel( i);
			break;
		end
	end

	
	local _index = selTextureReduction:GetItemFromValue( gameoption:GetTextureReduction());
	selTextureReduction:SetCurSel( _index);

	local _index = selLighting:GetItemFromValue( gameoption:GetLighting());
	selLighting:SetCurSel( _index);

--	local _index = selTextureMipmapBias:GetItemFromValue( gameoption:GetTextureMipmapBias());
--	selTextureMipmapBias:SetCurSel( _index);

	local _index = selGrndObjVisibleRange:GetItemFromValue( gameoption:GetGrndObjVisibleRange());
	selGrndObjVisibleRange:SetCurSel( _index);

	btnNormalMapping:SetCheck( gameoption:IsEnableNormalMapping());
	btnFullScreen:SetCheck( gameoption:IsEnableFullScreen());

	btnHDR:SetCheck( gameoption:IsEnableHDR());
	btnDOF:SetCheck( gameoption:IsEnableDOF());
	btnDistortion:SetCheck( gameoption:IsEnableDistortion());
	btnMotionBlur:SetCheck( gameoption:IsEnableMotionBlur());
	btnSoftParticle:SetCheck( gameoption:IsEnableSoftParticle());

	local _index = selShadow:GetItemFromValue( gameoption:GetShadow());
	selShadow:SetCurSel( _index);

	local _index = selSSAO:GetItemFromValue( gameoption:GetSSAO());
	selSSAO:SetCurSel( _index);

	
	local strEncordingType = gameoption:GetEncodingType();
	for  i = 0, (cmbEncodingType:GetItemCount() - 1)  do
		if ( cmbEncodingType:GetItemText( i) == strEncordingType)  then  cmbEncodingType:SetCurSel( i);
		end
	end
	
	cmbEncodingResolution:SetCurSel( gameoption:GetEncodingResolution());
	btnShowUIWhenRecording:SetCheck( gameoption:IsShowUIWhenRecording());
	
	local strScreenShotFormaType = gameoption:GetScreenShotFormatType();
	for j = 0, (cmbScreenShotFormatType:GetItemCount() - 1) do
		if( cmbScreenShotFormatType:GetItemText(j) == strScreenShotFormaType) then cmbScreenShotFormatType:SetCurSel(j);
		end
	end
end





-- RefreshSoundOption
function luaOption:RefreshSoundOption()

	cmbSpeakerMode:SetCurSel( gameoption:GetSpeakerMode());
	
	btnMuteAll:SetCheck( gameoption:IsMuteAll());
	btnMuteGeneric:SetCheck( gameoption:IsMuteGenericSound());
	btnMuteBGM:SetCheck( gameoption:IsMuteBGMSound());
	btnMuteEffect:SetCheck( gameoption:IsMuteEffectSound());
	btnEnableHardwareAcc:SetCheck( gameoption:IsEnableHardwareAccelerate());
	btnEnableReverb:SetCheck( gameoption:IsEnableReverb());
	btnEnableCompressor:SetCheck( gameoption:IsEnableCompressor());
	btnActiveEffect:SetCheck( gameoption:IsInActiveSound());
	
	-- btn

	local _index = selNarrationVox:GetItemFromValue( gameoption:GetSystemMessage());
	selNarrationVox:SetCurSel( _index);
		
	local _index = selMasterVolumn:GetItemFromValue( gameoption:GetMasterVolumn());
	selMasterVolumn:SetCurSel( _index);

	local _index = selGenericVolumn:GetItemFromValue( gameoption:GetGenericVolumn());
	selGenericVolumn:SetCurSel( _index);

	local _index = selBGMVolumn:GetItemFromValue( gameoption:GetBGMVolumn());
	selBGMVolumn:SetCurSel( _index);

	local _index = selEffectVolumn:GetItemFromValue( gameoption:GetEffectVolumn());
	selEffectVolumn:SetCurSel( _index);
end





-- RefreshControlOption
function luaOption:RefreshControlOption()

	btnInvertedMouse:SetCheck( gameoption:IsInvertedMouse());
	sldMouseSensitivity:SetScrollValue( gameoption:GetMouseSensitivity());
end





-- ChangeScreenResolution
function luaOption:ChangeScreenResolution()

	local nCurSel = cmbScreenResolution:GetCurSel();
	if ( nCurSel < 0)  then  return;
	end
	

	local strResolution = cmbScreenResolution:GetItemText( nCurSel);

	local findStart, findEnd = string.find( strResolution, STR_RESOLUTION);
	local w = tonumber( string.sub( strResolution, 1, findStart - 1) );
	local h = tonumber( string.sub( strResolution, findEnd + 1, string.len( strResolution)) );
	

	luaOption:ChangedOption();

	w, h = gameoption:SetScreenResolution( w, h);
	strResolution = w .. STR_RESOLUTION .. h;
	

	for  i = 0, (cmbScreenResolution:GetItemCount() - 1)  do
	
		if ( strResolution == cmbScreenResolution:GetItemText( i))  then
		
			cmbScreenResolution:SetCurSel( i);
			return;
		end
	end
	
	
	luaOption:MoveOptionFrameToCenter();
end





-- ChangedOption
function luaOption:ChangedOption( _reboot)

	if ( _reboot == true)  then  labRequiredReboot:Show( true)
	end
	
	
	if ( luaOption.g_bChangedOption == false)  then
	
		luaOption.g_bChangedOption = true;
		
		btnApplyOption:Enable( true);
	end
end





-- SetDefaultOption
function luaOption:SetDefaultOption()

	gameoption:SetDefaultSetting();
	
	luaOption:ChangedOption();
	luaOption:RefreshOptionFrame();
end





-- ApplyOption
function luaOption:ApplyOption()

	gameoption:EndModifyOption();
	

	if ( luaOption.g_bChangedOption == true)  then  gameoption:SaveOption();
	end
	
	luaOption.g_bChangedOption = false;


	frmOption:Show( false);
end





-- CancelOption
function luaOption:CancelOption()

	gameoption:EndModifyOption();


	if ( luaOption.g_bChangedOption == true)  then  gameoption:LoadOption();
	end
	
	luaOption.g_bChangedOption = false;
	

	frmOption:Show( false);
end


-- Add CrossHair
function luaOption:RefreshCrossHair()
	
	-- 리셋
	cmbCrossHairSelecter:ResetContent();
	
	-- 재입력
	for i = 0, (gameoption:GetCrossHairComboListCount() - 1) do
		
		local strCrossHairName = gameoption:GetCrossHairName(i);
		
		if(strCrossHairNamae ~= "") then
			cmbCrossHairSelecter:AddString(strCrossHairName);
		end		
	end	
	
	-- 선택
	local strCrossHairSelect = gameoption:GetCrossHairCurrentType();
	for j = 0, (cmbCrossHairSelecter:GetItemCount() - 1) do
	
		if( cmbCrossHairSelecter:GetItemText(j) == strCrossHairSelect) then 
			
			cmbCrossHairSelecter:SetCurSel(j);
			return;
		end
	end
	
	-- 디볼트로 설정
	cmbCrossHairSelecter:SetCurSel(0);
	gameoption:SetCrossHairCurrentType(cmbCrossHairSelecter:GetItemText(0));
end