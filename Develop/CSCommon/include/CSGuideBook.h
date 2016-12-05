#pragma once

#include "CSCommonLib.h"

enum GUIDEBOOK_TYPE
{
	GBT_LEVEL,
	GBT_FIELD,
	GBT_MAX,
};

class CSCOMMON_API CSGuideBook
{
public:
	CSGuideBook();
	virtual ~CSGuideBook();

public:
	int					m_nID;
	GUIDEBOOK_TYPE		m_eType;
	int					m_nParam;
};
