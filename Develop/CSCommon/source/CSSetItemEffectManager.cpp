#include "stdafx.h"
#include "CSSetItemEffectManager.h"
#include "CSSetItemEffect.h"
#include "CSDef.h"
#include "CSFormatString.h"
#include "MTypes.h"
#include "MLocale.h"

CSSetItemEffectManager::CSSetItemEffectManager()
{
}

CSSetItemEffectManager::~CSSetItemEffectManager()
{
	Clear();
}

bool CSSetItemEffectManager::LoadFromFile(const TCHAR* filename)
{
	MXml xml;
	if (!xml.LoadFile(MLocale::ConvTCHARToAnsi(filename).c_str()))
		return false;

	MXmlHandle docHandle = xml.DocHandle();
	MXmlElement* pElement = docHandle.FirstChild(SETITEM_XML_TAG_MAIET).FirstChildElement().Element();

	for (pElement; pElement != NULL; pElement = pElement->NextSiblingElement())
	{
		if (!_stricmp(pElement->Value(), SETITEM_XML_TAG_SETITEM))
		{
			CSSetItemEffect* pNewSetItemEffect = NewSetItemEffect();
			if (!ParseSetItem(pElement, pNewSetItemEffect, &xml))
			{
				SAFE_DELETE(pNewSetItemEffect);
				continue;
			}
		}
	}

	return true;
}

bool CSSetItemEffectManager::ParseSetItem(MXmlElement* pElement, CSSetItemEffect* pSetItemEffect, MXml* pXml)
{
	_Attribute(&pSetItemEffect->m_nEffectID, pElement, SETITEM_XML_ATTR_ID);
	pSetItemEffect->m_strEffectName = CSFormatString::Format(_T("SETITEM_NAME_{0}"), FSParam(pSetItemEffect->m_nEffectID));

	for (int i = 0; i < MAX_SET_ITEM_COUNT; i++)
	{
		char szSETITEM_XML_ATTR_ITEM_ID[64];
		sprintf_s(szSETITEM_XML_ATTR_ITEM_ID, SETITEM_XML_ATTR_ITEM_ID "%d", i + 1);
		_Attribute(&pSetItemEffect->m_nConditionItemIDs[i], pElement, szSETITEM_XML_ATTR_ITEM_ID);

		char szSETITEM_XML_ATTR_BUFF_ID[64];
		sprintf_s(szSETITEM_XML_ATTR_BUFF_ID, SETITEM_XML_ATTR_BUFF_ID "%d", i + 1);
		_Attribute(&pSetItemEffect->m_nTriggeredBuffIDs[i], pElement, szSETITEM_XML_ATTR_BUFF_ID);
	}

	return true;
}
