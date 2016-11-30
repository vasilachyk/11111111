--[[
	Game loading LUA script
--]]


-- Global instance
luaGameLoading = {};


-- Progress value
luaGameLoading.m_fProgress = 0.0;
luaGameLoading.m_fTimer = 0;





-- ResetLoadingProgress
function luaGameLoading:ResetLoadingProgress(nZoneID)

	-- Field image
	picGameLoadingFieldImage:SetImage( gamefunc:GetLoadingBkgrndImage(nZoneID));
	

	-- Field description
	local nFieldID = gamefunc:GetCurrentFieldID();
	local strFieldName = gamefunc:GetFieldName( nFieldID);
	local strDesc = "{FONT name=\"fntLarge\"}{COLOR r=230 g=230 b=230}" .. strFieldName .. "{/COLOR}{/FONT}\n" ..
		"{INDENT}{FONT name=\"fntScript\"}{COLOR r=75 g=140 b=100}" .. gamefunc:GetLoadingFieldDesc();
	tvwGameLoadingFieldDesc:SetText( strDesc);

	
	-- Contents
	local strContents = "{FONT name=\"fntLarge\"}{COLOR r=230 g=230 b=230}" .. STR( "UI_LOADING_ACTIVITY") .. "{/COLOR}{/FONT}\n" ..
		"{INDENT}{FONT name=\"fntScript\"}{COLOR r=75 g=140 b=100}" ..
		"{ALIGN hor=\"left\"}" .. STR( "UI_LOADING_NEWQUESTS") .. "{CR h=0}{ALIGN hor=\"right\"}" .. gamefunc:GetRecievedQuestCount() .. "{CR}" ..
		"{ALIGN hor=\"left\"}" .. STR( "UI_LOADING_COMPLETEDQUESTS") .. "{CR h=0}{ALIGN hor=\"right\"}" .. gamefunc:GetCompletedQuestCount() .. "{CR}" ..
		"{ALIGN hor=\"left\"}" .. STR( "UI_LOADING_NEWRECIPES") .. "{CR h=0}{ALIGN hor=\"right\"}" .. gamefunc:GetRecievedRecipeCount() .. "{CR}" ..
		"{ALIGN hor=\"left\"}" .. STR( "UI_LOADING_USEDRECIPES") .. "{CR h=0}{ALIGN hor=\"right\"}" .. gamefunc:GetCompletedRecipeCount() .. "{CR}" ..
		"{ALIGN hor=\"left\"}" .. STR( "UI_LOADING_MONSTERSDEFEATED") .. "{CR h=0}{ALIGN hor=\"right\"}" .. gamefunc:GetKilledEnemyCount() .. "{CR}" ..
		"{ALIGN hor=\"left\"}" .. STR( "UI_LOADING_EPICMONSTERSDEFEATED") .. "{CR h=0}{ALIGN hor=\"right\"}" .. gamefunc:GetKilledEpicEnemyCount();
	tvwGameLoadingContents:SetText( strContents);
	
	
	-- Tip message
	lbGameLoadingTipMsg:SetText( gamefunc:GetLoadingTipMsg());
	
	
	-- Reset progressbar
	luaGameLoading.m_fProgress = 0.0;
	luaGameLoading.m_fTimer = gamefunc:GetUpdateTime();
end





-- OnUpdateLoadingProgress
function luaGameLoading:OnUpdateLoadingProgress()

	local fCurrTime = gamefunc:GetUpdateTime();
	local fElapsed = fCurrTime - luaGameLoading.m_fTimer;
	local fProgress = luaGameLoading.m_fProgress + ( fElapsed * 0.0005);
	
	local fCurrProgress = gamefunc:GetLoadingProgress();
	if ( fCurrProgress ~= luaGameLoading.m_fProgress)  then
	
		luaGameLoading.m_fProgress = fCurrProgress;
		luaGameLoading.m_fTimer = fCurrTime;
	end

	pcGameLoadingProgress:SetPos( fProgress * 10.0);
end





-- ShowLoadingContext
function luaGameLoading:ShowLoadingContext(bShow, nZoneID)

	if( bShow == false) then
		-- Zone image
		picGameLoadingFieldImage:SetImage( gamefunc:GetLoadingBkgrndImage(nZoneID));
	end
	
	tvwGameLoadingFieldDesc:Show( bShow);
	tvwGameLoadingContents:Show( bShow);
	lbGameLoadingTipMsg:Show( bShow);
	pcGameLoadingProgress:Show( bShow);
end