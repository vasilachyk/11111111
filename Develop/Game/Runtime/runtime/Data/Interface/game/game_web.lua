--[[
	Game web LUA script
--]]


-- Global instance
luaWeb = {};

luaWeb.bAnswer = false;
luaWeb.URL_QUEST = "http://help.pmang.com/Publishing/RaiderZ1/FMLB_MyQuestion.aspx";
luaWeb.URL_ANSWER = "http://help.pmang.com/Publishing/RaiderZ1/FMLB_MyQuestionList.aspx";



function luaWeb:OnInGameCSWeb( sParam, nParam1, nParam2 )
	
	if ( sParam == "SHOW")  then
		luaWeb:GetShowURLREQ();
		return true;
	elseif( sParam == "ANSWER" ) then
		luaWeb:InGameCSAnswer();
		return true
	elseif( sParam == "QUEST_URL" ) and (nParam1 ~= nil) then
		luaWeb.URL_QUEST = nParam1;
		frmWebFrame:Show(true);
		return true
	elseif( sParam == "ANSWER_URL" ) and (nParam1 ~= nil)  then
		luaWeb.URL_ANSWER = nParam1;
		frmWebFrame:Show(true);
		return true
	end
	
	return false;
end




function luaWeb:OnShowWebFrame()

	luaGame:ShowWindow( frmWebFrame);
	luaWeb:OnShow();

end


function luaWeb:OnPosition()

	local x, y, w, h = frmWeb:GetWindowRect();
	
	frmWeb:SetPos(x,y);
end

function luaWeb:GetShowURLREQ()

	if( luaWeb.bAnswer == true )	then	
		gamefunc:GetInGameCSAnswerURL();
	else
		gamefunc:GetInGameCSQuestURL();
	end
end

function luaWeb:OnShow()

	local webURL = luaWeb:GetWebURL();
	local bShow = frmWeb:GetShow() == false;
	frmWeb:OnWebShow( bShow, webURL );

	bAnswer	= false;
end

function luaWeb:GetWebURL()

	if( luaWeb.bAnswer == true ) then
		return luaWeb.URL_ANSWER;
	end

	return luaWeb.URL_QUEST;
end

function luaWeb:InGameCSAnswer()
	
	luaWeb.bAnswer = true;

	local strImgString = luaGame:GetMessageImgString("iconDefExclamation", STR( "UI_GAME_INGAMECS_ANSWER"));

	luaMessageBox:MessageBox( strImgString, 10000, "InGameCS", nil, luaWeb.OnInGameCSAnswer );

end

function luaWeb:OnInGameCSAnswer(keyClick)

	if( keyClick > 0 ) then
		luaWeb:GetShowURLREQ();
	end

end