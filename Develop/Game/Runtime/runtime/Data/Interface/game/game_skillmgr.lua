--[[
	Game talentmgr LUA script
--]]


-- Global instance
luaTalentmgr = {};

function luaTalentmgr:RefreshTalentmgr()

	hasExtraPassive = gamefunc:IsLearnedTalent( SKILLSET_LICENSE_TALENT );
	if ( hasExtraPassive == false) then
		luaTalent.Active = true;
		luaTalent:OnRefreshTalent();
		return;
	end

	local skillSetSelect = gamefunc:GetSelectSkillSetType();
	local skillSetActive = gamefunc:GetActiveSkillSetType();

	-- SKILLSET_TYPE
	if ( skillSetActive == SKILLSET_TYPE.SKILLSET_TYPE_FIRST ) and ( skillSetSelect == SKILLSET_TYPE.SKILLSET_TYPE_FIRST ) then 
		picTalent:SetImage("iconSkillSetSelect_e");
		picExTalent:SetImage("iconSkillSetUnselect_d");
	end
	if ( skillSetActive == SKILLSET_TYPE.SKILLSET_TYPE_FIRST ) and ( skillSetSelect == SKILLSET_TYPE.SKILLSET_TYPE_SECOND ) then 
		picTalent:SetImage("iconSkillSetUnselect_e");
		picExTalent:SetImage("iconSkillSetSelect_d");
	end
	if ( skillSetActive == SKILLSET_TYPE.SKILLSET_TYPE_SECOND ) and ( skillSetSelect == SKILLSET_TYPE.SKILLSET_TYPE_FIRST ) then 
		picTalent:SetImage("iconSkillSetSelect_d");
		picExTalent:SetImage("iconSkillSetUnselect_e");
	end
	if ( skillSetActive == SKILLSET_TYPE.SKILLSET_TYPE_SECOND ) and ( skillSetSelect == SKILLSET_TYPE.SKILLSET_TYPE_SECOND ) then 
		picTalent:SetImage("iconSkillSetUnselect_d");
		picExTalent:SetImage("iconSkillSetSelect_e");
	end

	-- is Select Talent Tab Active Talent Tab?
	if(skillSetSelect == skillSetActive) then
		luaTalent.Active = true;
	else
		luaTalent.Active = false;
	end

	luaTalent:OnRefreshTalent();
end

function luaTalentmgr:ShowTalentMgrFrame( bShow )
	if(bShow == false) then
		frmTalentMgr:Show( false );
		
		gamefunc:SetSelectSkillSetType( gamefunc:GetActiveSkillSetType( ) );
		luaTalentmgr:RefreshTalentmgr( );
	else
		hasExtraPassive = gamefunc:IsLearnedTalent( SKILLSET_LICENSE_TALENT );
		if( hasExtraPassive == true ) then
			frmTalentMgr:Show( true );
			gamefunc:SetSelectSkillSetType( gamefunc:GetActiveSkillSetType( ) );
			luaTalentmgr:RefreshTalentmgr( );
		else
			frmTalentMgr:Show( false );
		end
	end
end

function luaTalentmgr:OnClickTalent1Button( )

	gamefunc:SetSelectSkillSetType( SKILLSET_TYPE.SKILLSET_TYPE_FIRST );
	luaTalent:SetMainTalent();

	luaTalentmgr:RefreshTalentmgr();

end

function luaTalentmgr:OnClickTalent2Button( )

	gamefunc:SetSelectSkillSetType( SKILLSET_TYPE.SKILLSET_TYPE_SECOND );
	luaTalent:SetMainTalent();
	
	luaTalentmgr:RefreshTalentmgr();

end

 --SwitchSkillSet Form
function luaTalentmgr:OnShowfrmSwitchSkillSet( )

	tvSkillSetSwitch:SetText( FORMAT( "UI_SKILLSET_SWITCH" ));

	local x, y = frmSwitchSkillSet:GetParent():GetPosition();
	local w, h = frmSwitchSkillSet:GetSize();
    	local width, height = gamefunc:GetWindowSize();

    	frmSwitchSkillSet:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);
	frmSwitchSkillSet:DoModal();
end

function luaTalentmgr:OnSwitchSkillSetOK()

	frmSwitchSkillSet:Show( false);
	
	gamefunc:OnSkillSetSwitch();
end

function luaTalentmgr:CloseSwitchSkillSet()

	frmSwitchSkillSet:Show( false);
	gamefunc:RequestNpcInteractionEnd();
end