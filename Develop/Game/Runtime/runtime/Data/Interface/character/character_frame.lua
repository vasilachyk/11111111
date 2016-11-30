--[[
	Character frame LUA script
--]]


-- Global instance
luaCharacterFrame = {};


-- Switching scene info
luaCharacterFrame.SwitchInfo = {};
luaCharacterFrame.SwitchInfo.fTimer = 0;
luaCharacterFrame.SwitchInfo.bFadeOut = false;
luaCharacterFrame.SwitchInfo.callback = nil;
luaCharacterFrame.DirectLogin = false;

-- 심의
luaCharacterFrame.LOGO_STATE	= { LOGO_NONE = 1, LOGO_FADEIN = 2, LOGO_FADEOUT = 3 };
luaCharacterFrame.Logostate		= luaCharacterFrame.LOGO_STATE.LOGO_NONE;
luaCharacterFrame.FadeTime		= 0;



-- InitCharFrame
function luaCharacterFrame:InitCharFrame()

	luaCharacterFrame:FinishCharBlackScreen();
	
	luaCharacterFrame.SwitchInfo.fTimer = 0;
	luaCharacterFrame.SwitchInfo.bFadeOut = false;
	luaCharacterFrame.SwitchInfo.callback = nil;
	
	-- Direct Login Check
	luaCharacterFrame.DirectLogin = gamefunc:IsDirectLoginToLoginFrame();
end


-- FinishCharBlackScreen
function luaCharacterFrame:FinishCharBlackScreen()

	pntCharBlackScreen:SetOpacity( 0.0 );
	pntCharBlackScreen:Show( false);
	luaCharacterFrame.DirectLogin = false;

	if( false == layerCharCredit:GetShow() )	then
		luaCharacterFrame:ShowQuickOption( true );
	end
	
end


-- SwitchScene
function luaCharacterFrame:SwitchScene( _callback)

	layerCharSelect:Enable( false);
	layerCharCreate:Enable( false);
	layerCharCredit:Enable( false);
	

	pntCharBlackScreen:SetOpacity( 0.0);
	pntCharBlackScreen:Show( true);
	
	luaCharacterFrame:ShowQuickOption( false );
	
	luaCharacterFrame.SwitchInfo.fTimer = gamefunc:GetUpdateTime();
	luaCharacterFrame.SwitchInfo.bFadeOut = false;
	luaCharacterFrame.SwitchInfo.callback = _callback;
end


-- OnUpdateCharBlackScreen
function luaCharacterFrame:OnUpdateCharBlackScreen()

	if( true == luaCharacterFrame.DirectLogin )	then
		luaCharacterFrame:OnUpdateCharBlackScreenDirectLogin();
	else
		luaCharacterFrame:OnUpdateCharBlackScreenNormal();
	end
	
end


-- OnUpdateCharBlackScreen
function luaCharacterFrame:OnUpdateCharBlackScreenDirectLogin()

	if ( luaCharacterFrame.SwitchInfo.fTimer == 0)  then  return;
	end
	
	local fCurr = gamefunc:GetUpdateTime();
	local fElapsed = fCurr - luaCharacterFrame.SwitchInfo.fTimer;
	
	if( luaCharacterFrame.SwitchInfo.bFadeOut == false )	then
		pntCharBlackScreen:SetOpacity( 1.0 );
		
		if ( fElapsed > 1000)  then
			luaCharacterFrame.SwitchInfo.fTimer = fCurr;
			luaCharacterFrame.SwitchInfo.bFadeOut = true;
			if ( luaCharacterFrame.SwitchInfo.callback ~= nil)  then  luaCharacterFrame.SwitchInfo.callback();
			end
			fElapsed = 0;
		end
		
		return;
		
	else
		if ( fElapsed > 2000)  then
			luaCharacterFrame:FinishCharBlackScreen();
			return;
		else
			local fOpacity = math.min( fElapsed / 2000.0);
			fOpacity = 1.0 - fOpacity;

			pntCharBlackScreen:SetOpacity( fOpacity);
		end
	end
end

function luaCharacterFrame:OnUpdateCharBlackScreenNormal()

	if ( luaCharacterFrame.SwitchInfo.fTimer == 0)  then  return;
	end
	
	
	local fCurr = gamefunc:GetUpdateTime();
	local fElapsed = fCurr - luaCharacterFrame.SwitchInfo.fTimer;
	if ( fElapsed > 2000)  then
	
		if ( luaCharacterFrame.SwitchInfo.bFadeOut == false)  then
		
			luaCharacterFrame.SwitchInfo.fTimer = fCurr;
			luaCharacterFrame.SwitchInfo.bFadeOut = true;

			if ( luaCharacterFrame.SwitchInfo.callback ~= nil)  then  luaCharacterFrame.SwitchInfo.callback();
			end
			
			fElapsed = 0;

		else
		
			luaCharacterFrame:FinishCharBlackScreen();
			return;
		end
	end
	
	
	local fOpacity = math.min( fElapsed / 1000.0);
	if ( luaCharacterFrame.SwitchInfo.bFadeOut == true)  then  fOpacity = 1.0 - fOpacity;
	end
	
	pntCharBlackScreen:SetOpacity( fOpacity);
end

function luaCharacterFrame:OnClickCharacterError()

	frmCharacterErrorMsgBox:Show( false);
	
	if( 0 == btnCharacterErrorOk:GetUserData() )		then
		gamefunc:Quit();
	else
		gamefunc:PlaySound( "button_agree" );
	end
	
end

-- ShowQuickOption
function luaCharacterFrame:ShowQuickOption( bShow )
	
	btnCharQuickOption:Show( bShow );
	
end

-- OnGameDeliberation
function luaCharacterFrame:OnGameDeliberation( dwNowTime, nCycle )
	
	-- 이미지
	luaCharacterFrame:OnGameDeliberationLogo();
	
	-- 메세지
	luaCharacterFrame:OnGameDeliberationMsg( dwNowTime, nCycle );
	
end

-- OnShowGameDeliberationLogo
function luaCharacterFrame:OnShowGameDeliberationLogo()

	if( true == CharDeliberationLogo:GetShow() )	then
		-- Timer
		local Timer		= gamefunc:GetGameDeliberationLogoDelay();
		if( 0 ~= Timer )	then
			CharDeliberationLogo:SetTimer( Timer, 0 );
		end

	else
		CharDeliberationLogo:KillTimer();
		luaCharacterFrame.Logostate	= luaCharacterFrame.LOGO_STATE.LOGO_NONE;
	end
	
end

-- OnGameDeliberationLogo
function luaCharacterFrame:OnGameDeliberationLogo()
	
	luaCharacterFrame.Logostate	= luaCharacterFrame.LOGO_STATE.LOGO_FADEIN;
	luaCharacterFrame.FadeTime	= gamefunc:GetUpdateTime();
	CharDeliberationLogo:SetOpacity( 0 );
	CharDeliberationLogo:Show( true );
	
end

-- OnUpdateGameDeliberationLogo
function luaCharacterFrame:OnUpdateGameDeliberationLogo()
	
	local nOpa		= CharDeliberationLogo:GetOpacity();
	local fElapsed	= ( gamefunc:GetUpdateTime() - luaCharacterFrame.FadeTime ) / 800;
	
	if( luaCharacterFrame.LOGO_STATE.LOGO_NONE == luaCharacterFrame.Logostate )	then
		return ;
	elseif( luaCharacterFrame.LOGO_STATE.LOGO_FADEIN == luaCharacterFrame.Logostate )	then
		nOpa		= nOpa + fElapsed;
				
		if( 0.8 < nOpa )	then
			nOpa		= 0.8;
			luaCharacterFrame.Logostate = luaCharacterFrame.LOGO_STATE.LOGO_NONE;
		end
	
	elseif( luaCharacterFrame.LOGO_STATE.LOGO_FADEOUT == luaCharacterFrame.Logostate )	then
		
		nOpa		= nOpa - fElapsed;
		if( 0 > nOpa )	then
			nOpa		= 0;
			luaCharacterFrame.Logostate = luaCharacterFrame.LOGO_STATE.LOGO_NONE;
			CharDeliberationLogo:Show( false );
		end
		
	end
	
	CharDeliberationLogo:SetOpacity( nOpa );
	
end

-- OnTimerGameDeliberationLogo
function luaCharacterFrame:OnTimerGameDeliberationLogo()
	
	luaCharacterFrame.Logostate = luaCharacterFrame.LOGO_STATE.LOGO_FADEOUT;
	luaCharacterFrame.FadeTime	= gamefunc:GetUpdateTime();
	CharDeliberationPresentation:Clear();	
	
end

-- OnTimerGameDeliberationLogo
function luaCharacterFrame:OnGameDeliberationMsg( dwNowTime, nCycle )
	
	local nHour		= luaCharacterFrame:GetGamePlayTime( dwNowTime );
	
	strStringTime	= STR( "UI_GAME_DELIBERATION_MSG" ) .. "{CR}" .. FORMAT( "UI_GAME_DELIBERATION_TIME_MSG", nHour );
	
	CharDeliberationPresentation:Clear();	
	CharDeliberationPresentation:Add( "{FONT name=\"fntHeadlineNotice\"}" .. strStringTime, 0 );
		
end

-- GetGamePlayTime
function luaCharacterFrame:GetGamePlayTime( dwNowTime )
	
	if( 60000 > dwNowTime )	then		-- 1분미만은 표시 제외 
		return ;
	end
	
	local strString = "";
	local nSec	= dwNowTime / 1000;
	local _hour = math.floor( nSec / 3600 );
	
	return _hour;
	
end