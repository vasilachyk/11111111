#include "stdafx.h"
#include "GGuideBookMgr.h"
#include "GGuideBook.h"

GGuideBookMgr::GGuideBookMgr()
{
}

GGuideBookMgr::~GGuideBookMgr()
{
}

CSGuideBook* GGuideBookMgr::New()
{
	return static_cast<CSGuideBook*>(new GGuideBook);
}

GGuideBook* GGuideBookMgr::Get(int nID)
{
	return static_cast<GGuideBook*>(CSGuideBookMgr::Get(nID));
}

std::vector<GGuideBook*> GGuideBookMgr::FindByLevelEqualOrGreaterThan(int nLevel)
{
	std::vector<CSGuideBook*> vecCSRet = CSGuideBookMgr::FindByLevelEqualOrGreaterThan(nLevel);
	std::vector<GGuideBook*> vecRet;

	for (CSGuideBook* pGuideBook : vecCSRet)
		vecRet.push_back(static_cast<GGuideBook*>(pGuideBook));

	return vecRet;
}

GGuideBook* GGuideBookMgr::FindByFieldID(int nFieldID)
{
	return static_cast<GGuideBook*>(CSGuideBookMgr::FindByFieldID(nFieldID));
}
