#pragma once

#include "CSSetItemEffectManager.h"
#include "GSetItemEffect.h"
#include <map>
#include <vector>

class GEquipmentSlot;

class GSetItemEffectManager : public CSSetItemEffectManager, public MTestMemPool<GSetItemEffectManager>
{
protected:
	virtual GSetItemEffect*		NewSetItemEffect();
	virtual void				Clear();
	virtual bool				ParseSetItem(MXmlElement* pElement, CSSetItemEffect* pSetItemEffect, MXml* pXml);
	virtual GSetItemEffect*		Get(int nID);

private:
	typedef std::map<int, GSetItemEffect*> SETITEM_EFFECT_MAP;
	SETITEM_EFFECT_MAP			m_mapSetItemEffect;

public:
	GSetItemEffectManager();
	virtual ~GSetItemEffectManager();

	virtual bool				Add(GSetItemEffect* pNewSetItemEffect);
	GSetItemEffect*				FindByItemID(int nItemID);
	int							CollectTriggeredBuffIDs(GEquipmentSlot& equipmentSlot, std::vector<int>& outvecBuffIDs);
};
