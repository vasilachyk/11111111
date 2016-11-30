--[[
	Game web LUA script
--]]


-- Global instance
luaItemPreview = {};

-- Default Position
luaItemPreview.nDefaultX	= 550;
luaItemPreview.nDefaultY	= 100;



function luaItemPreview:OnShowItemPreviewFrame()

	if ( frmItemPreviewFrame:GetShow() == true)  then
		frmItemPreview:ShowItemPreviewUI();
	else
		frmItemPreview:HideItemPreviewUI();
	end

	luaGame:ShowWindow( frmItemPreviewFrame );
end



function luaItemPreview:OnClickItemPreview(nItemID)

	if(frmItemPreview:IsPossiblePreviewItem( nItemID) == false)	then	return;
	end

	if ( frmItemPreviewFrame:GetShow() == false)  then
		frmItemPreviewFrame:Show(true);
	end

	frmItemPreview:ChangeItem(nItemID);
	
	frmItemPreviewFrame:BringToTop();
	frmItemPreviewFrame:SetFocus();
	
end

-- ResetUI
function luaItemPreview:ResetUI()
	
	frmItemPreviewFrame:SetPosition( luaItemPreview.nDefaultX, luaItemPreview.nDefaultY );
	
end