#include "stdafx.h"
#include "CSGuideBookMgr.h"
#include "CSGuideBook.h"
#include "MTypes.h"
#include "MXml.h"
#include "MLocale.h"
#include "AStlUtil.h"

CSGuideBookMgr::CSGuideBookMgr()
{
}

CSGuideBookMgr::~CSGuideBookMgr()
{
	Clear();
}

void CSGuideBookMgr::Clear()
{
	SAFE_DELETE_MAP(m_GuideBookMap);
}

bool CSGuideBookMgr::Load(const TCHAR* szFileName)
{
	MXml xml;
	if (!xml.LoadFile(MLocale::ConvTCHARToAnsi(szFileName).c_str())) return false;

	MXmlHandle docHandle = xml.DocHandle();
	MXmlElement* pElement = docHandle.FirstChild(GUIDEBOOK_XML_TAG_MAIET).FirstChildElement().Element();

	for (; pElement; pElement = pElement->NextSiblingElement())
	{
		if (!_stricmp(pElement->Value(), GUIDEBOOK_XML_TAG_GUIDEBOOK))
		{
			CSGuideBook* pNewGuideBook = New();
			if (ParseGuideBook(pElement, pNewGuideBook))
			{
				Insert(pNewGuideBook);
			}
			else
			{
				SAFE_DELETE(pNewGuideBook);
				//return false;
			}
		}
	}

	return true;
}

void CSGuideBookMgr::Insert(CSGuideBook* pGuideBook)
{
	if (m_GuideBookMap.find(pGuideBook->m_nID) != m_GuideBookMap.end())
		return;

	m_GuideBookMap[pGuideBook->m_nID] = pGuideBook;
}

CSGuideBook* CSGuideBookMgr::Get(int nID)
{
	GUIDEBOOK_MAP::iterator iter = m_GuideBookMap.find(nID);
	return iter != m_GuideBookMap.end() ? iter->second : NULL;
}

std::vector<CSGuideBook*> CSGuideBookMgr::FindByLevelEqualOrGreaterThan(int nLevel)
{
	vector<CSGuideBook*> vecRet;
	for (const GUIDEBOOK_MAP::value_type& gb : m_GuideBookMap)
	{
		CSGuideBook* pGuideBook = gb.second;

		if (pGuideBook->m_eType == GBT_LEVEL &&
			pGuideBook->m_nParam <= nLevel)
			vecRet.push_back(pGuideBook);
	}

	return vecRet;
}

CSGuideBook* CSGuideBookMgr::FindByFieldID(int nFieldID)
{
	for (const GUIDEBOOK_MAP::value_type& gb : m_GuideBookMap)
	{
		CSGuideBook* pGuideBook = gb.second;

		if (pGuideBook->m_eType == GBT_FIELD &&
			pGuideBook->m_nParam == nFieldID)
			return pGuideBook;
	}

	return NULL;
}

bool CSGuideBookMgr::ParseGuideBook(MXmlElement* pElement, CSGuideBook* pGuideBook)
{
	if (!_Attribute(pGuideBook->m_nID, pElement, GUIDEBOOK_XML_ATTR_ID))
	{
		_ASSERT(0 && "Could not parse GuideBook ID.");
		return false;
	}

	if (Get(pGuideBook->m_nID))
	{
		_ASSERT(0 && "GuideBook is duplicated.");
		return false;
	}

	ParseType(pElement, pGuideBook->m_eType);
	_Attribute(pGuideBook->m_nParam, pElement, GUIDEBOOK_XML_ATTR_PARAM);

	return true;
}

bool CSGuideBookMgr::ParseType(MXmlElement* pElement, GUIDEBOOK_TYPE& outType)
{
	string strValue;
	if (!_Attribute(strValue, pElement, GUIDEBOOK_XML_ATTR_TYPE))
	{
		_ASSERT(0 && "Could not parse GuideBook Type.");
		return false;
	}

	if (strValue == GUIDEBOOK_XML_VALUE_TYPE_LEVEL)
	{
		outType = GBT_LEVEL;
	}
	else if (strValue == GUIDEBOOK_XML_VALUE_TYPE_FIELD)
	{
		outType = GBT_FIELD;
	}
	else
	{
		_ASSERT(0 && "Invalid GuideBook Type.");
		return false;
	}

	return true;
}
