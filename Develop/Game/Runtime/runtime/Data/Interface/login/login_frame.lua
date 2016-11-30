--[[
	Login frame LUA script
--]]


-- Global instance
luaLoginFrame = {};


-- Fade info
luaLoginFrame.fFadeTimer = 0;

-- 심의
luaLoginFrame.LOGO_STATE	= { LOGO_NONE = 1, LOGO_FADEIN = 2, LOGO_FADEOUT = 3 };
luaLoginFrame.Logostate		= luaLoginFrame.LOGO_STATE.LOGO_NONE;
luaLoginFrame.FadeTime		= 0;



-- InitLoginFrame
function luaLoginFrame:InitLoginFrame()

	pntLoginBlackScreen:Show( true);
	pntLoginBlackScreen:SetOpacity( 1.0);
	
	luaLoginFrame.fFadeTimer = 0;
end





-- FadeOut
function luaLoginFrame:FadeOut()

	pntLoginBlackScreen:Show( true);
	pntLoginBlackScreen:SetOpacity( 1.0);

	luaLoginFrame.fFadeTimer = gamefunc:GetUpdateTime() + 3000;
end





-- OnUpdateLoginBlackScreen
function luaLoginFrame:OnUpdateLoginBlackScreen()

	if ( luaLoginFrame.fFadeTimer == 0)  then  return;
	end
	
	
	local fCurr = gamefunc:GetUpdateTime();
	if ( fCurr > luaLoginFrame.fFadeTimer)  then
	
		pntLoginBlackScreen:Show( false);
		
		luaLoginFrame.fFadeTimer = 0;

		return;
	end
	
	
	local fOpacity = math.min( 1.0,  (luaLoginFrame.fFadeTimer - fCurr) / 1500.0);
	pntLoginBlackScreen:SetOpacity( fOpacity);
end

-- 심의
-- OnGameDeliberation
function luaLoginFrame:OnGameDeliberation( dwNowTime, nCycle )
	
	-- 이미지
	luaLoginFrame:OnGameDeliberationLogo();
	
	-- 메세지
	luaLoginFrame:OnGameDeliberationMsg( dwNowTime, nCycle );
	
end

-- OnShowGameDeliberationLogo
function luaLoginFrame:OnShowGameDeliberationLogo()

	if( true == LoginDeliberationLogo:GetShow() )	then
		-- Timer
		local Timer		= gamefunc:GetGameDeliberationLogoDelay();
		if( 0 ~= Timer )	then
			LoginDeliberationLogo:SetTimer( Timer, 0 );
		end

	else
		LoginDeliberationLogo:KillTimer();
		luaLoginFrame.Logostate	= luaLoginFrame.LOGO_STATE.LOGO_NONE;
	end
	
end

-- OnGameDeliberationLogo
function luaLoginFrame:OnGameDeliberationLogo()
	
	luaLoginFrame.Logostate	= luaLoginFrame.LOGO_STATE.LOGO_FADEIN;
	luaLoginFrame.FadeTime	= gamefunc:GetUpdateTime();
	LoginDeliberationLogo:SetOpacity( 0 );
	LoginDeliberationLogo:Show( true );
	
end



-- GetGamePlayTime
function luaLoginFrame:GetGamePlayTime( dwNowTime )
	
	if( 60000 > dwNowTime )	then		-- 1분미만은 표시 제외 
		return ;
	end
	
	local strString = "";
	local nSec	= dwNowTime / 1000;
	local _hour = math.floor( nSec / 3600 );
	
	return _hour;
	
end