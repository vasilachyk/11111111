--[[
	Game lowhp LUA script
--]]

-- Global instance
luaLowHP = {};

-- Show LowHP warning Percentage
luaLowHP.m_fHPPercentage = 10;

-- frmRebirth state
luaLowHP.m_bfrmRebirthState = false;

-- lowhp state
luaLowHP.STATE = { NONE = 0, DIE = 1, SHOW1 = 2, SHOW2 = 3,SHOW3 = 4,HIDE = 5 }
luaLowHP.m_nState = luaLowHP.STATE.NONE;
luaLowHP.m_nPreState = luaLowHP.STATE.NONE;

-- lowhp Sound
luaLowHP.m_strSound = "lowhp_1";
luaLowHP.m_strSoundID = "lowhp";

-- OnUpdateLowHPFrame
function luaLowHP:OnUpdateLowHPFrame()

	
	local fRemainHPPercentage = gamefunc:GetHP() / gamefunc:GetMaxHP() * 100.0;

	-- Die
	if (luaLowHP.m_bfrmRebirthState == true) then
		luaLowHP.m_nState = luaLowHP.STATE.DIE;
		
		if(luaLowHP.m_nPreState ~= luaLowHP.m_nState) then
			luaLowHP:EndLowHPFrame()
		end

	-- Show
	elseif ( luaLowHP.m_fHPPercentage > fRemainHPPercentage)  then

		local fAlphaIntensity = (luaLowHP.m_fHPPercentage - fRemainHPPercentage) / luaLowHP.m_fHPPercentage;
		local fIntensity = 0;
		local fSpeed = 0;

		if ( fAlphaIntensity >= 0.5)  then
			luaLowHP.m_nState = luaLowHP.STATE.SHOW1;
			fIntensity = 1,0;
			fSpeed = 0.01;

			if(luaLowHP.m_nPreState ~= luaLowHP.m_nState) then
				luaLowHP.m_strSound = "lowhp_3";
				frmLowHP:SetTimer( 100, 0);
			end
		elseif ( fAlphaIntensity >= 0.23)  then
			luaLowHP.m_nState = luaLowHP.STATE.SHOW2;
			fIntensity = 0.8;
			fSpeed = 0.0075;

			if(luaLowHP.m_nPreState ~= luaLowHP.m_nState) then
				luaLowHP.m_strSound = "lowhp_2";
				frmLowHP:SetTimer( 100, 0);
			end
		else
			luaLowHP.m_nState = luaLowHP.STATE.SHOW3;
			fIntensity = 0.6;
			fSpeed = 0.005;

			if(luaLowHP.m_nPreState ~= luaLowHP.m_nState) then
				luaLowHP.m_strSound = "lowhp_1";
				frmLowHP:SetTimer( 100, 0);
			end
		end
		
		local fOpacity = fIntensity - 0.2 * (math.sin( gamefunc:GetUpdateTime() * fSpeed) + 1.0);
		frmLowHP:SetOpacity( math.min( 1.0, fOpacity));

	-- Hide	
	else
		luaLowHP.m_nState = luaLowHP.STATE.HIDE;

		if(luaLowHP.m_nPreState ~= luaLowHP.m_nState) then
			luaLowHP:EndLowHPFrame();
		end
	end

	luaLowHP.m_nPreState = luaLowHP.m_nState;

end

-- EndLowHPFrame
function luaLowHP:EndLowHPFrame()
	frmLowHP:Show( false);
	frmLowHP:KillTimer();
end

-- OnTimerLowHPSound
function luaLowHP:OnTimerLowHPSound()
	gamefunc:PlaySound( luaLowHP.m_strSound, luaLowHP.m_strSoundID);
end
