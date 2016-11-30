--[[
	Game guidebook LUA script
--]]


-- Global instance
luaGuideBook = {};

-- RefreshGuideBook
function luaGuideBook:RefreshGuideBook()

	if( 0 < ctvGuideBookList:GetCategoryCount() )	then
		luaGuideBook:SaveGuideBookCategoryState();
	end
	
	luaGuideBook:RefreshGuideBookList();
	luaGuideBook:RefreshGuideBookDescription();
end


-- RefreshGuideBookList
function luaGuideBook:RefreshGuideBookList()

	if (frmJournal:GetShow() == false)	then
		return ;
	end
	--if (frmJournal:GetShow() == false)  or  (tbcJournalTabCtrl:GetSelIndex() ~= 2)  then  return;
	--end

	-- Add GuideBook item
	local arrayCategory = {};
		arrayCategory.strCategoryName = {};
		arrayCategory.nIndex = {};
	local nCategoryCount = 0;


	--RefreshGuideBookList
	local nCurSelCategory, nCurSelItem = ctvGuideBookList:GetCurSel();
	ctvGuideBookList:DeleteAllItems();

	
	for  i = 0, (gamefunc:GetGuideBookCount() - 1)  do

		local nGuideBookID = gamefunc:GetGuideBookID( i);
		local strGuideBookType = gamefunc:GetGuideBookType( nGuideBookID);
		local nGuideBookParam = gamefunc:GetGuideBookParam( nGuideBookID);
		local strName = "";
		local strCategory = "";

		-- Set strName(Level, Field)
		if ( strGuideBookType == "level")  then		strName = FORMAT( "UI_JOURNAL_LEVELCATEGORYNAME_GUIDEBOOK", nGuideBookParam);
		elseif ( strGuideBookType == "field")  then	strName = gamefunc:GetFieldName(nGuideBookParam);
		end

		-- Set strCategory(Level, Field)
		if ( strGuideBookType == "level")  then		strCategory = STR( "UI_JOURNAL_LEVELGUIDEBOOK");
		elseif ( strGuideBookType == "field")  then	strCategory = STR( "UI_JOURNAL_FIELDGUIDEBOOK");
		end
		

		-- Find category
		local nCategoryIndex = -1;
		for j = 0, (nCategoryCount - 1)  do
		
			if ( arrayCategory.strCategoryName[ j] == strCategory)  then
			
				-- Exist category
				nCategoryIndex = arrayCategory.nIndex[ j];
				break;
			end
		end

		-- Add category
		if ( nCategoryIndex < 0)  then

			nCategoryIndex = ctvGuideBookList:AddCategory( strCategory);
			
			local nExpand	= gamefunc:GetCharAccountParam( "GuideBookCategory", strCategory );
			if( ( nil == nExpand ) or ( "false" ~= nExpand ) )	then
				ctvGuideBookList:SetCategoryExpand( nCategoryIndex, true );
			else
				ctvGuideBookList:SetCategoryExpand( nCategoryIndex, false );
			end
			
			arrayCategory.strCategoryName[ nCategoryCount] = strCategory;
			arrayCategory.nIndex[ nCategoryCount] = nCategoryIndex;
			nCategoryCount = nCategoryCount + 1;
		end

		-- Get icon
		local strIcon = "iconScroll";

		-- Add GuideBook
		local nIndex = ctvGuideBookList:AddItem( nCategoryIndex, strName, strIcon);
		ctvGuideBookList:SetItemData( nCategoryIndex, nIndex, nGuideBookID);
	
		-- Check direct view
		if ( luaJournal.DirectViewVar.nType == JOURNALOBJ_TYPE.GUIDEBOOK)  and  ( luaJournal.DirectViewVar.nID == nGuideBookID)  then
		
			nCurSelCategory = nCategoryIndex;
			nCurSelItem = nIndex;
		end
		
	end

	ctvGuideBookList:SetCurSel( nCurSelCategory, nCurSelItem);

	luaJournal.DirectViewVar.nType = 0;
	luaJournal.DirectViewVar.nID = 0;
end

-- SaveGuideBookCategoryState
function luaGuideBook:SaveGuideBookCategoryState()
	
	local nCategoryCount	= ctvGuideBookList:GetCategoryCount();
	local bExpand			= false;
	
	--gamedebug:Log( "°¡ÀÌµåºÏcategory " .. nCategoryCount );
	gamefunc:DeleteCharAccountParam( "GuideBookCategory" );
	
	for  i = 0, nCategoryCount-1  do
		
		bExpand		= ctvGuideBookList:GetCategoryExpand( i );
		
		if( false == bExpand )	then
			gamefunc:SetCharAccountParam( "GuideBookCategory", ctvGuideBookList:GetCategoryText( i ), "false" );	
		end
		
	end
	
end


-- RefreshGuideBookDescription
function luaGuideBook:RefreshGuideBookDescription()

	if (frmJournal:GetShow() == false)  or  (tbcJournalTabCtrl:GetSelIndex() ~= 2)  then  return;
	end

	tvwJournalDesc:Clear();

	local nCurSelCategory, nCurSelItem = ctvGuideBookList:GetCurSel();
	if ( nCurSelCategory < 0)  or  ( nCurSelItem < 0)  then  return;
	end

	local nGuideBookID = ctvGuideBookList:GetItemData( nCurSelCategory, nCurSelItem);
	if ( nGuideBookID <= 0)  then  return;
	end
	
	local strText = "";
	if(gamefunc:GetSex() == 0) then
		strText = "{CR}{CR}" .. gamefunc:GetGuideBookJournalMaleString( nGuideBookID);
	elseif(gamefunc:GetSex() == 1) then
		strText = "{CR}{CR}" .. gamefunc:GetGuideBookJournalFemaleString( nGuideBookID);
	end
	
	--gamedebug:Log( " Text : " .. strText );
	tvwJournalDesc:SetText( luaGame:ConvertStrToDialogSentence( strText));
end

-- OnSelChangeGuideBookList
function luaGuideBook:OnSelChangeGuideBookList()

	luaGuideBook:RefreshGuideBookDescription();
end
