#pragma once

#include "MXml.h"
#include "CSCommonLib.h"
#include "CSDef.h"

class CSSetItemEffect;

#define SETITEM_XML_TAG_MAIET			"maiet"
#define SETITEM_XML_TAG_SETITEM			"SETITEM"
#define SETITEM_XML_ATTR_ID				"id"
#define SETITEM_XML_ATTR_NAME			"name"
#define SETITEM_XML_ATTR_ITEM_ID		"itemid"
#define SETITEM_XML_ATTR_BUFF_ID		"buffid"

class CSCOMMON_API CSSetItemEffectManager
{
protected:
	virtual CSSetItemEffect*	NewSetItemEffect() = 0;
	virtual void				Clear() { }
	virtual bool				ParseSetItem(MXmlElement* pElement, CSSetItemEffect* pSetItemEffect, MXml* pXml);
	virtual CSSetItemEffect*	Get(int nID) = 0;

public:
	CSSetItemEffectManager();
	virtual ~CSSetItemEffectManager();

	bool						LoadFromFile(const TCHAR* filename);
};
