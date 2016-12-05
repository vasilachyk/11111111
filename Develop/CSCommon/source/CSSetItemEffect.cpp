#include "stdafx.h"
#include "CSSetItemEffect.h"

CSSetItemEffect::CSSetItemEffect() :
	m_nEffectID(INVALID_ID)
{
	for (int i = 0; i < MAX_SET_ITEM_COUNT; i++)
	{
		m_nConditionItemIDs[i] = INVALID_ID;
		m_nTriggeredBuffIDs[i] = INVALID_BUFF_ID;
	}
}

CSSetItemEffect::~CSSetItemEffect()
{
}

bool CSSetItemEffect::IsConditiomItemID(int nItemID)
{
	for (int i = 0; i < MAX_SET_ITEM_COUNT; i++)
	{
		if (m_nConditionItemIDs[i] == INVALID_ID)	continue;
		if (m_nConditionItemIDs[i] != nItemID)		continue;

		return true;
	}

	return false;
}

int CSSetItemEffect::GetTriggeredBuffID(int nConditionItemCount)
{
	if (nConditionItemCount <= 0 || nConditionItemCount > MAX_SET_ITEM_COUNT)
		return INVALID_BUFF_ID;

	return m_nTriggeredBuffIDs[nConditionItemCount - 1];
}
