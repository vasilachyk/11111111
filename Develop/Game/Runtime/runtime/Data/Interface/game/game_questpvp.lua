--[[
	Game mission progress LUA script
--]]


-- Global instance
luaQuestPVP = {};



-- Parameters of mission
luaQuestPVP.nCountTeam1 = 0;
luaQuestPVP.nCountTeam2 = 0;
luaQuestPVP.nPreCountTeam1 = 0;
luaQuestPVP.nPreCountTeam2 = 0;
luaQuestPVP.fRatioTeam1 = 0.0;
luaQuestPVP.fRatioTeam2 = 0.0;
luaQuestPVP.nHPTeam1 = 0;
luaQuestPVP.nHPTeam2 = 0;
luaQuestPVP.nCountEffectTime = 0.4;


luaQuestPVP.nKillCount = 0;
luaQuestPVP.fKillRatioTime = 0.0;






-- OpenQuestPVPFrame
function luaQuestPVP:OpenQuestPVPFrame()

	if ( frmQuestPVP:GetShow() == false)  then
		
		luaQuestPVP:QuestPVPFrameSetPosition();
	
		frmQuestPVP:Show( true);


		local strImage = "bmpQuestPVP";
        if (gamefunc:GetQPVPBoardImgName() ~= "" )  then
			strImage = gamefunc:GetQPVPBoardImgName();
		end

        picQuestPVP:SetImage( strImage);

	end
end


-- QuestPVPFrameSetPosition
function luaQuestPVP:QuestPVPFrameSetPosition()
	
	local x, y = frmPlayerInfo:GetPosition();
	local w, h = frmPlayerInfo:GetSize();
	
	if(x < 200) and (y < 100) then
		frmQuestPVP:SetPosition( x + w, y);
	else
		frmQuestPVP:SetPosition( 0, 0);
	end
		
end


-- CloseQuestPVPFrame
function luaQuestPVP:CloseQuestPVPFrame()

	if ( frmQuestPVP:GetShow() == false)  then  return
	end


	luaQuestPVP.nCountTeam1 = 0;
	luaQuestPVP.nCountTeam2 = 0;
	luaQuestPVP.nPreCountTeam1 = 0;
	luaQuestPVP.nPreCountTeam2 = 0;
	luaQuestPVP.fRatioTeam1 = 0.0;
	luaQuestPVP.fRatioTeam2 = 0.0;
	luaQuestPVP.nHPTeam1 = 0;
	luaQuestPVP.nHPTeam2 = 0;


	frmQuestPVP:Show( false);
	frmQuestPVP:KillTimer();
end


-- SetHP
function luaQuestPVP:SetHP(nParam1, nParam2)

	if(nParam1 == 1) then
		luaQuestPVP.nHPTeam1 = nParam2;
	elseif(nParam1 == 2) then
		luaQuestPVP.nHPTeam2 = nParam2;
	end

end


-- SetCount
function luaQuestPVP:SetCount(nParam1, nParam2)

	luaQuestPVP.nCountTeam1 = nParam1;
	luaQuestPVP.nCountTeam2 = nParam2;

	if(luaQuestPVP.nCountTeam1 ~= luaQuestPVP.nPreCountTeam1) then
		luaQuestPVP.fRatioTeam1 = gamefunc:GetUpdateTime();
	end

	if(luaQuestPVP.nCountTeam2 ~= luaQuestPVP.nPreCountTeam2) then
		luaQuestPVP.fRatioTeam2 = gamefunc:GetUpdateTime();
	end

	luaQuestPVP.nPreCountTeam1 = luaQuestPVP.nCountTeam1;
	luaQuestPVP.nPreCountTeam2 = luaQuestPVP.nCountTeam2;

end




-- OnNcHitTestQuestPVPFrame
function luaQuestPVP:OnNcHitTestQuestPVPFrame()

	EventArgs.hittest = HITTEST.NOWHERE;
	
	local x, y, w, h = frmQuestPVP:GetWindowRect();
	local px, py = gamefunc:GetCursorPos();
	
	if ( px >= x)  and  ( px < (x + w))  and  ( py >= y)  and  ( py < (y + h))  then

		EventArgs.hittest = HITTEST.CAPTION;
	end

	return true;
end


-- OnDrawHPInfoTeam1
function luaQuestPVP:OnDrawHPInfoTeam1()

	-- HP
	if(luaQuestPVP.nHPTeam1 >= 0) then
		
		local width = 68;
		local _x, _y = 5, 9;
		local _h = 5;
		gamedraw:SetBitmap( "bmpGauges2");

		-- Background
		gamedraw:DrawEx( _x - 6, _y, 7, 10,						0, 300, 30, 40);
		gamedraw:DrawEx( _x - 6, _y + 10, 7, _h,				0, 340, 30, 20);
		gamedraw:DrawEx( _x - 6, _y + 10 + _h, 7, 10,			0, 360, 30, 40);

		gamedraw:DrawEx( _x + 1, _y, width - 2, 10,				30, 300, 40, 40);
		gamedraw:DrawEx( _x + 1, _y + 10, width - 2, _h,		30, 340, 40, 20);
		gamedraw:DrawEx( _x + 1, _y + 10 + _h, width - 2, 10,	30, 360, 40, 40);
	
		gamedraw:DrawEx( _x + width - 1, _y, 7, 10,				70, 300, 30, 40);
		gamedraw:DrawEx( _x + width - 1, _y + 10, 7, _h,		70, 340, 30, 20);
		gamedraw:DrawEx( _x + width - 1, _y + 10 + _h, 7, 10,	70, 360, 30, 40);

		local i = 0;
		local len = width * ( luaQuestPVP.nHPTeam1 / 100.0);
		if ( len < 1)  then
		
			local _w = 30.0 * ( len / 1);
			gamedraw:DrawEx( _x, _y, len, 10,					0, i * 100, _w, 40);
			gamedraw:DrawEx( _x, _y + 10, len, _h,				0, i * 100 + 40, _w, 20);
			gamedraw:DrawEx( _x, _y + 10 + _h, len, 10,			0, i * 100 + 60, _w, 40);

		else

			gamedraw:DrawEx( width - 1, _y, 1, 10,						0, i * 100, 30, 40);
			gamedraw:DrawEx( width - 1, _y + 10, 1, _h,				0, i * 100 + 40, 30, 20);
			gamedraw:DrawEx( width - 1, _y + 10 + _h, 1, 10,			0, i * 100 + 60, 30, 40);


			local _len = math.min( len, width - 1) - 1;
			gamedraw:DrawEx( width- _len + 4, _y, _len+3, 10,				30, i * 100, 40, 40);
			gamedraw:DrawEx( width- _len + 4, _y + 10, _len+3, _h,			30, i * 100 + 40, 40, 20);
			gamedraw:DrawEx( width- _len + 4, _y + 10 + _h, _len+3, 10,	30, i * 100 + 60, 40, 40);
			
			
			if ( len > (width - 1))  then
			
				local _len = 1 - ( width - len);
				local _w = 30.0 * ( _len / 1);
				gamedraw:DrawEx( _x, _y, _len, 10,				70, i * 100, _w, 40);
				gamedraw:DrawEx( _x, _y + 10, _len, _h,			70, i * 100 + 40, _w, 20);
				gamedraw:DrawEx( _x, _y + 10 + _h, _len, 10,	70, i * 100 + 60, _w, 40);
			end
		end

		gamedraw:SetFont( "fntSmall");
		gamedraw:SetColorEx( 255, 255, 255, 255);

		gamedraw:SetTextAlign( "left", "center");
		gamedraw:TextEx( _x + 3, _y, width, 20 + _h, luaQuestPVP.nHPTeam1 .. "% ");
	end


	-- Title
	gamedraw:SetFont( "fntSmallStrong");
	gamedraw:SetColorEx( 255, 80, 80, 255);
	gamedraw:SetTextAlign( "center", "center");

	local strTeam1	= gamedraw:SubTextWidth( "fntSmallStrong", gamefunc:GetPvpTeamName(1), 80 );
	gamedraw:TextEx( 0, 27, 80, 30, strTeam1);


	-- Count
	local nHundred = math.floor(luaQuestPVP.nCountTeam1 * 0.01);
	local nTen = math.floor((luaQuestPVP.nCountTeam1 - nHundred*100.0) * 0.1);
	local nOne = luaQuestPVP.nCountTeam1 - nHundred*100.0 - nTen*10.0;
	local nImageSizeX = 20;
	local nImageSizeY = 25;
	local nRamdomX = 0.0;
	local nRamdomY = 0.0;

	local fElapsed = (gamefunc:GetUpdateTime() - luaQuestPVP.fRatioTeam1) * 0.001;

	gamedraw:SetOpacity(math.min(1.0, fElapsed + luaQuestPVP.nCountEffectTime));

	if(luaQuestPVP.nCountEffectTime > fElapsed) then
		nRamdomX = (math.sin(gamefunc:GetUpdateTime()) - 0.3) * 3.0;
		nRamdomY = (math.cos(gamefunc:GetUpdateTime()) - 0.3) * 3.0;
	end

		

	if(nHundred > 0) then
		
		local strImage = "bmpNumber" .. nHundred;
		gamedraw:SetBitmap( strImage);
		gamedraw:Draw( (nImageSizeX + 5) * 1.0 - 4 + nRamdomX, 64 + nRamdomY, nImageSizeX + nRamdomX, nImageSizeY + nRamdomY);

		strImage = "bmpNumber" .. nTen;
		gamedraw:SetBitmap( strImage);
		gamedraw:Draw( (nImageSizeX + 5) * 1.6 - 4 + nRamdomX, 64 + nRamdomY, nImageSizeX + nRamdomX, nImageSizeY + nRamdomY);

		strImage = "bmpNumber" .. nOne;
		gamedraw:SetBitmap( strImage);
		gamedraw:Draw( (nImageSizeX + 5) * 2.2 - 4 + nRamdomX, 64 + nRamdomY, nImageSizeX + nRamdomX, nImageSizeY + nRamdomY);

	elseif(nTen > 0) then
		
		strImage = "bmpNumber" .. nTen;
		gamedraw:SetBitmap( strImage);
		gamedraw:Draw( (nImageSizeX + 5) * 1.1 - 4 + nRamdomX, 64 + nRamdomY, nImageSizeX + nRamdomX, nImageSizeY + nRamdomY);

		strImage = "bmpNumber" .. nOne;
		gamedraw:SetBitmap( strImage);
		gamedraw:Draw( (nImageSizeX + 5) * 1.9 - 4 + nRamdomX, 64 + nRamdomY, nImageSizeX + nRamdomX, nImageSizeY + nRamdomY);

	else
	
		strImage = "bmpNumber" .. nOne;
		gamedraw:SetBitmap( strImage);
		gamedraw:Draw( (nImageSizeX + 5) * 1.5 - 4 + nRamdomX, 64 + nRamdomY, nImageSizeX + nRamdomX, nImageSizeY + nRamdomY);

	end

end


-- OnDrawHPInfoTeam2
function luaQuestPVP:OnDrawHPInfoTeam2()

	-- HP
	if(luaQuestPVP.nHPTeam2 >= 0) then
		
		local width = 68;
		local _x, _y = 5, 9;
		local _h = 5;
		gamedraw:SetBitmap( "bmpGauges2");

		-- Background
		gamedraw:DrawEx( _x - 6, _y, 7, 10,						0, 300, 30, 40);
		gamedraw:DrawEx( _x - 6, _y + 10, 7, _h,				0, 340, 30, 20);
		gamedraw:DrawEx( _x - 6, _y + 10 + _h, 7, 10,			0, 360, 30, 40);

		gamedraw:DrawEx( _x + 1, _y, width - 2, 10,				30, 300, 40, 40);
		gamedraw:DrawEx( _x + 1, _y + 10, width - 2, _h,		30, 340, 40, 20);
		gamedraw:DrawEx( _x + 1, _y + 10 + _h, width - 2, 10,	30, 360, 40, 40);
	
		gamedraw:DrawEx( _x + width - 1, _y, 7, 10,				70, 300, 30, 40);
		gamedraw:DrawEx( _x + width - 1, _y + 10, 7, _h,		70, 340, 30, 20);
		gamedraw:DrawEx( _x + width - 1, _y + 10 + _h, 7, 10,	70, 360, 30, 40);

		local i = 1;
		local len = width * ( luaQuestPVP.nHPTeam2 / 100.0);
		if ( len < 1)  then
		
			local _w = 30.0 * ( len / 1);
			gamedraw:DrawEx( _x, _y, len, 10,					0, i * 100, _w, 40);
			gamedraw:DrawEx( _x, _y + 10, len, _h,				0, i * 100 + 40, _w, 20);
			gamedraw:DrawEx( _x, _y + 10 + _h, len, 10,			0, i * 100 + 60, _w, 40);

		else

			gamedraw:DrawEx( _x, _y, 1, 10,						0, i * 100, 30, 40);
			gamedraw:DrawEx( _x, _y + 10, 1, _h,				0, i * 100 + 40, 30, 20);
			gamedraw:DrawEx( _x, _y + 10 + _h, 1, 10,			0, i * 100 + 60, 30, 40);


			local _len = math.min( len, width - 1) - 1;
			gamedraw:DrawEx( _x + 1, _y, _len, 10,				30, i * 100, 40, 40);
			gamedraw:DrawEx( _x + 1, _y + 10, _len, _h,			30, i * 100 + 40, 40, 20);
			gamedraw:DrawEx( _x + 1, _y + 10 + _h, _len, 10,	30, i * 100 + 60, 40, 40);
			
			
			if ( len > (width - 1))  then
			
				local _len = 1 - ( width - len);
				local _w = 30.0 * ( _len / 1);
				gamedraw:DrawEx( _x + width - 1, _y, _len, 10,				70, i * 100, _w, 40);
				gamedraw:DrawEx( _x + width - 1, _y + 10, _len, _h,			70, i * 100 + 40, _w, 20);
				gamedraw:DrawEx( _x + width - 1, _y + 10 + _h, _len, 10,	70, i * 100 + 60, _w, 40);
			end
		end

		gamedraw:SetFont( "fntSmall");
		gamedraw:SetColorEx( 255, 255, 255, 255);

		gamedraw:SetTextAlign( "right", "center");
		gamedraw:TextEx( _x + 3, _y, width, 20 + _h, luaQuestPVP.nHPTeam2 .. "% ");
	end


	-- Title
	gamedraw:SetFont( "fntSmallStrong");
	gamedraw:SetColorEx( 80, 80, 255, 255);
	gamedraw:SetTextAlign( "center", "center");

	local strTeam2	= gamedraw:SubTextWidth( "fntSmallStrong", gamefunc:GetPvpTeamName(2), 80 );
	gamedraw:TextEx( 0, 27, 80, 30, strTeam2);


	-- Count
	local nHundred = math.floor(luaQuestPVP.nCountTeam2 * 0.01);
	local nTen = math.floor((luaQuestPVP.nCountTeam2 - nHundred*100.0) * 0.1);
	local nOne = luaQuestPVP.nCountTeam2 - nHundred*100.0 - nTen*10.0;
	local nImageSizeX = 20;
	local nImageSizeY = 25;
	local nRamdomX = 0.0;
	local nRamdomY = 0.0;

	local fElapsed = (gamefunc:GetUpdateTime() - luaQuestPVP.fRatioTeam2) * 0.001;

	gamedraw:SetOpacity(math.min(1.0, fElapsed + luaQuestPVP.nCountEffectTime));

	if(luaQuestPVP.nCountEffectTime > fElapsed) then
		nRamdomX = (math.sin(gamefunc:GetUpdateTime()) - 0.3) * 3.0;
		nRamdomY = (math.cos(gamefunc:GetUpdateTime()) - 0.3) * 3.0;
	end

		

	if(nHundred > 0) then
		
		local strImage = "bmpNumber" .. nHundred;
		gamedraw:SetBitmap( strImage);
		gamedraw:Draw( (nImageSizeX + 5) * 1.0 + nRamdomX, 64 + nRamdomY, nImageSizeX + nRamdomX, nImageSizeY + nRamdomY);

		strImage = "bmpNumber" .. nTen;
		gamedraw:SetBitmap( strImage);
		gamedraw:Draw( (nImageSizeX + 5) * 1.6 + nRamdomX, 64 + nRamdomY, nImageSizeX + nRamdomX, nImageSizeY + nRamdomY);

		strImage = "bmpNumber" .. nOne;
		gamedraw:SetBitmap( strImage);
		gamedraw:Draw( (nImageSizeX + 5) * 2.2 + nRamdomX, 64 + nRamdomY, nImageSizeX + nRamdomX, nImageSizeY + nRamdomY);

	elseif(nTen > 0) then
		
		strImage = "bmpNumber" .. nTen;
		gamedraw:SetBitmap( strImage);
		gamedraw:Draw( (nImageSizeX + 5) * 1.1 + nRamdomX, 64 + nRamdomY, nImageSizeX + nRamdomX, nImageSizeY + nRamdomY);

		strImage = "bmpNumber" .. nOne;
		gamedraw:SetBitmap( strImage);
		gamedraw:Draw( (nImageSizeX + 5) * 1.9 + nRamdomX, 64 + nRamdomY, nImageSizeX + nRamdomX, nImageSizeY + nRamdomY);

	else
	
		strImage = "bmpNumber" .. nOne;
		gamedraw:SetBitmap( strImage);
		gamedraw:Draw( (nImageSizeX + 5) * 1.5 + nRamdomX, 64 + nRamdomY, nImageSizeX + nRamdomX, nImageSizeY + nRamdomY);

	end

end






-----------------------------------------------------------------------------
-- KILL EFFECT UI

-- ShowKillEffectUI
function luaQuestPVP:ShowKillEffectUI(nParam1)
	-- nParam1 : Kill Count

	--local w = gamefunc:GetWindowWidth();
	--local h = gamefunc:GetWindowHeight();
	

	--frmKillEffect:SetPosition( x * 0.5 - 200, y * 0.2 - 100);

	frmQPVPKillEffect:Show( true);
	luaQuestPVP.nKillCount = nParam1;
	luaQuestPVP.fKillRatioTime = gamefunc:GetUpdateTime();

end

-- OnDrawKillEffect
function luaQuestPVP:OnDrawKillEffect()

	if ( frmQPVPKillEffect:GetShow() == false)  then
		return;
	end


	local nthousand = math.floor(luaQuestPVP.nKillCount * 0.001);
	local nHundred = math.floor((luaQuestPVP.nKillCount - nthousand*1000.0) * 0.01);
	local nTen = math.floor((luaQuestPVP.nKillCount - nthousand*1000.0 - nHundred*100.0) * 0.1);
	local nOne = luaQuestPVP.nKillCount - nthousand*1000.0 - nHundred*100.0 - nTen*10.0;

	local w = gamefunc:GetWindowWidth();
	local h = gamefunc:GetWindowHeight();
	local x = w * 0.5;
	local y = h * 0.25;
	local nImageSizeX = 65;
	local nImageSizeY = 80;
	local nPosX = 0.0;
	local nPosY = 0.0;
	local nSizeX = 0.0;
	local nSizeY = 0.0;

	local fElapsed = (gamefunc:GetUpdateTime() - luaQuestPVP.fKillRatioTime) * 0.001;

	if(fElapsed < 0.2) then
		gamedraw:SetOpacity(fElapsed*5.0);
		nPosX = (1.0 - fElapsed*3.0) * 400.0;
		nPosY = (1.0 - fElapsed*3.0) * 400.0;
		nSizeX = nPosX;
		nSizeY = nPosY;

	elseif(fElapsed < 0.8) then
		gamedraw:SetOpacity(1.0);
		nPosX = (math.sin(gamefunc:GetUpdateTime()) - 0.3) * (50.0 - fElapsed * 30.0);
		nPosY = (math.cos(gamefunc:GetUpdateTime()) - 0.3) * (50.0 - fElapsed * 30.0);
		
	elseif(fElapsed < 1.5) then
		gamedraw:SetOpacity(1.0);

	elseif(fElapsed < 1.7) then
		gamedraw:SetOpacity(1.0 - (fElapsed-1.5)*5.0);
		nPosX = ((fElapsed-1.5)*5.0) * 400.0;
		nPosY = ((fElapsed-1.5)*5.0) * 400.0;
		nSizeX = nPosX;
		nSizeY = nPosY;
	else
		frmQPVPKillEffect:Show( false);
		return;
	end
	

	-- Kill Count Background Image

	gamedraw:SetBitmap( "bmpKillNumber_b");
	if(nthousand > 0) then
		gamedraw:Draw( x - 10 - nImageSizeX*4.0 - nPosX*0.5 , y - 13 - nPosY*0.5, (nImageSizeX*1.4 + nSizeX) * 4, nImageSizeY*1.4 + nSizeY);
	elseif(nHundred > 0) then
		gamedraw:Draw( x - 10 - nImageSizeX*3.0 - nPosX*0.5 , y - 13 - nPosY*0.5, (nImageSizeX*1.4 + nSizeX) * 3, nImageSizeY*1.4 + nSizeY);
	elseif(nTen > 0) then
		gamedraw:Draw( x - 10 - nImageSizeX*2.0 - nPosX*0.5 , y - 13 - nPosY*0.5, (nImageSizeX*1.4 + nSizeX) * 2, nImageSizeY*1.4 + nSizeY);
	else
		gamedraw:Draw( x - 10 - nImageSizeX*1.0 - nPosX*0.5 , y - 13 - nPosY*0.5, (nImageSizeX*1.4 + nSizeX) * 1, nImageSizeY*1.4 + nSizeY);
	end



	-- Kill Count Image
	local strImage;

	strImage = "bmpKillNumber" .. nOne;
	gamedraw:SetBitmap( strImage);
	gamedraw:Draw( x - nImageSizeX*1.0 - nPosX*0.5 , y - nPosY*0.5, nImageSizeX + nSizeX, nImageSizeY + nSizeY);

	if(luaQuestPVP.nKillCount >= 10) then
		strImage = "bmpKillNumber" .. nTen;
		gamedraw:SetBitmap( strImage);
		gamedraw:Draw( x - nImageSizeX*1.7 - nPosX*0.5 , y - nPosY*0.5, nImageSizeX + nSizeX, nImageSizeY + nSizeY);
	end

	if(luaQuestPVP.nKillCount >= 100) then
		strImage = "bmpKillNumber" .. nHundred;
		gamedraw:SetBitmap( strImage);
		gamedraw:Draw( x - nImageSizeX*2.4 - nPosX*0.5 , y - nPosY*0.5, nImageSizeX + nSizeX, nImageSizeY + nSizeY);
	end

	if(luaQuestPVP.nKillCount >= 1000) then
		strImage = "bmpKillNumber" .. nthousand;
		gamedraw:SetBitmap( strImage);
		gamedraw:Draw( x - nImageSizeX*3.1 - nPosX*0.5 , y - nPosY*0.5, nImageSizeX + nSizeX, nImageSizeY + nSizeY);
	end

	-- Kill Image
	nImageSizeX = 120;
	nImageSizeY = 60;
	gamedraw:SetBitmap( "bmpKill");
	gamedraw:Draw( x - nPosX*0.5 , y + 18 - nPosY*0.5, nImageSizeX + nSizeX, nImageSizeY + nSizeY);
	
end

-- ResetUI
function luaQuestPVP:ResetUI()
	
	luaQuestPVP:QuestPVPFrameSetPosition();
		
end