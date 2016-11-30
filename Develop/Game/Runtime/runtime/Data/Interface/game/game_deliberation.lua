--[[
	Game Deliberation LUA script
--]]


-- Global instance
luaDeliberation = {};
luaDeliberation.LOGO_STATE	= { LOGO_NONE = 1, LOGO_FADEIN = 2, LOGO_FADEOUT = 3 };
luaDeliberation.Logostate	= luaDeliberation.LOGO_STATE.LOGO_NONE;
luaDeliberation.FadeTime	= 0;

-- OnGameDeliberation
function luaDeliberation:OnGameDeliberation( dwNowTime, nCycle )
	
	-- 이미지
	luaDeliberation:OnGameDeliberationLogo();
	
	-- 메세지
	luaDeliberation:OnGameDeliberationMsg( dwNowTime, nCycle );
	
end

-- OnShowGameDeliberationLogo
function luaDeliberation:OnShowGameDeliberationLogo()

	if( true == GameDeliberationLogo:GetShow() )	then
		-- Timer
		local Timer		= gamefunc:GetGameDeliberationLogoDelay();
		if( 0 ~= Timer )	then
			GameDeliberationLogo:SetTimer( Timer, 0 );
		end

	else
		GameDeliberationLogo:KillTimer();
		luaDeliberation.Logostate	= luaDeliberation.LOGO_STATE.LOGO_NONE;
	end
	
end

-- OnGameDeliberationLogo
function luaDeliberation:OnGameDeliberationLogo()
	
	luaDeliberation.Logostate	= luaDeliberation.LOGO_STATE.LOGO_FADEIN;
	luaDeliberation.FadeTime	= gamefunc:GetUpdateTime();
	GameDeliberationLogo:SetOpacity( 0 );
	GameDeliberationLogo:Show( true );
	
end

-- OnUpdateGameDeliberationLogo
function luaDeliberation:OnUpdateGameDeliberationLogo()
	
	local nOpa		= GameDeliberationLogo:GetOpacity();
	local fElapsed	= ( gamefunc:GetUpdateTime() - luaDeliberation.FadeTime ) / 800;
	
	if( luaDeliberation.LOGO_STATE.LOGO_NONE == luaDeliberation.Logostate )	then
		return ;
	elseif( luaDeliberation.LOGO_STATE.LOGO_FADEIN == luaDeliberation.Logostate )	then
		nOpa		= nOpa + fElapsed;
				
		if( 0.8 < nOpa )	then
			nOpa		= 0.8;
			luaDeliberation.Logostate = luaDeliberation.LOGO_STATE.LOGO_NONE;
		end
	
	elseif( luaDeliberation.LOGO_STATE.LOGO_FADEOUT == luaDeliberation.Logostate )	then
		
		nOpa		= nOpa - fElapsed;
		if( 0 > nOpa )	then
			nOpa		= 0;
			luaDeliberation.Logostate = luaDeliberation.LOGO_STATE.LOGO_NONE;
			GameDeliberationLogo:Show( false );
		end
		
	end
	
	--gamedebug:Log( "nOpa " .. nOpa .. "fElapsed " .. fElapsed );
	
	GameDeliberationLogo:SetOpacity( nOpa );
	
end

-- OnTimerGameDeliberationLogo
function luaDeliberation:OnTimerGameDeliberationLogo()
	
	luaDeliberation.Logostate = luaDeliberation.LOGO_STATE.LOGO_FADEOUT;
	luaDeliberation.FadeTime	= gamefunc:GetUpdateTime();
	pbDeliberationPresentation:Clear();	
	
end

-- OnTimerGameDeliberationLogo
function luaDeliberation:OnGameDeliberationMsg( dwNowTime, nCycle )
	
	local nHour		= luaDeliberation:GetGamePlayTime( dwNowTime );
	
	strStringTime	= STR( "UI_GAME_DELIBERATION_MSG" ) .. "{CR}" .. FORMAT( "UI_GAME_DELIBERATION_TIME_MSG", nHour );
	
	pbDeliberationPresentation:Clear();	
	pbDeliberationPresentation:Add( "{FONT name=\"fntHeadlineNotice\"}" .. strStringTime, 0 );
		
end

-- GetGamePlayTime
function luaDeliberation:GetGamePlayTime( dwNowTime )
	
	if( 60000 > dwNowTime )	then		-- 1분미만은 표시 제외 
		return ;
	end
	
	local strString = "";
	local nSec	= dwNowTime / 1000;
	local _hour = math.floor( nSec / 3600 );
	
	return _hour;
	
end

-- GetGameDeliberationMsg
function luaDeliberation:GetGameDeliberationMsg( nCycle )
	
	local strString = "";
	if( 1 == nCycle )		then
		strString = STR( "UI_GAME_DELIBERATION_CYCLE_1" );
	elseif( 2 == nCycle )	then
		strString = STR( "UI_GAME_DELIBERATION_CYCLE_2" );
	else
		strString = STR( "UI_GAME_DELIBERATION_CYCLE_3" );
	end
	
	return strString;
	
end