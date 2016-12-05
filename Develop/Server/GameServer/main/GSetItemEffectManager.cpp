#include "stdafx.h"
#include "GSetItemEffectManager.h"
#include "GSetItemEffect.h"
#include "GEquipmentSlot.h"
#include <map>

GSetItemEffectManager::GSetItemEffectManager()
	: CSSetItemEffectManager()
{
}

GSetItemEffectManager::~GSetItemEffectManager()
{
	Clear();
}

bool GSetItemEffectManager::Add(GSetItemEffect* pNewSetItemEffect)
{
	if (!pNewSetItemEffect)
	{
		// invalid NULL parameter.
		_ASSERT(0);
		return false;
	}

	if (Get(pNewSetItemEffect->m_nEffectID))
	{
		// duplicated entry.
		_ASSERT(0);
		return false;
	}

	m_mapSetItemEffect.insert(SETITEM_EFFECT_MAP::value_type(pNewSetItemEffect->m_nEffectID, pNewSetItemEffect));
	return true;
}

GSetItemEffect* GSetItemEffectManager::NewSetItemEffect()
{
	return new GSetItemEffect();
}

void GSetItemEffectManager::Clear()
{
	for (SETITEM_EFFECT_MAP::iterator iter = m_mapSetItemEffect.begin(); iter != m_mapSetItemEffect.end(); iter++)
	{
		delete iter->second;
	}

	m_mapSetItemEffect.clear();
}

bool GSetItemEffectManager::ParseSetItem(MXmlElement* pElement, CSSetItemEffect* pSetItemEffect, MXml* pXml)
{
	GSetItemEffect* pGSetItemEffect = static_cast<GSetItemEffect*>(pSetItemEffect);

	if (!CSSetItemEffectManager::ParseSetItem(pElement, pGSetItemEffect, pXml))
		return false;

	Add(pGSetItemEffect);

	return true;
}

GSetItemEffect* GSetItemEffectManager::Get(int nID)
{
	SETITEM_EFFECT_MAP::iterator iter = m_mapSetItemEffect.find(nID);
	if (iter != m_mapSetItemEffect.end()) iter->second;

	return NULL;
}

GSetItemEffect* GSetItemEffectManager::FindByItemID(int nItemID)
{
	for (SETITEM_EFFECT_MAP::iterator iter = m_mapSetItemEffect.begin(); iter != m_mapSetItemEffect.end(); iter++)
	{
		GSetItemEffect* pEffect = iter->second;

		if (pEffect->IsConditiomItemID(nItemID))
			return pEffect;
	}

	return NULL;
}

int GSetItemEffectManager::CollectTriggeredBuffIDs(GEquipmentSlot& equipmentSlot, std::vector<int>& outvecBuffIDs)
{
	std::vector<GItem*> vecItems;
	equipmentSlot.CollectAllItem(vecItems);

	// Effect Info, Equipped Condition Item Count
	typedef std::map<GSetItemEffect*, int> MAP_TRIGGERED_EFFECT;
	MAP_TRIGGERED_EFFECT mapTriggeredEffects;

	for (GItem* pItem : vecItems)
	{
		GSetItemEffect* pEffect = FindByItemID(pItem->GetID());
		if (!pEffect) continue;

		MAP_TRIGGERED_EFFECT::iterator iter = mapTriggeredEffects.find(pEffect);
		if (iter == mapTriggeredEffects.end())
		{
			mapTriggeredEffects.insert(MAP_TRIGGERED_EFFECT::value_type(pEffect, 1));
		}
		else
		{
			iter->second++;
		}
	}

	for (MAP_TRIGGERED_EFFECT::iterator iter = mapTriggeredEffects.begin(); iter != mapTriggeredEffects.end(); iter++)
	{
		int nBuffID = iter->first->GetTriggeredBuffID(iter->second);
		if (nBuffID == INVALID_BUFF_ID) continue;

		outvecBuffIDs.push_back(nBuffID);
	}

	return static_cast<int>(outvecBuffIDs.size());
}
