#pragma once

#include "MTString.h"
#include "CSCommonLib.h"
#include "CSDef.h"

class CSCOMMON_API CSSetItemEffect
{
public:
	int					m_nEffectID;
	std::tstring		m_strEffectName;

	int					m_nConditionItemIDs[MAX_SET_ITEM_COUNT];
	int					m_nTriggeredBuffIDs[MAX_SET_ITEM_COUNT];

	bool				IsConditiomItemID(int nItemID);
	int					GetTriggeredBuffID(int nConditionItemCount);

public:
	CSSetItemEffect();
	virtual ~CSSetItemEffect();
};
