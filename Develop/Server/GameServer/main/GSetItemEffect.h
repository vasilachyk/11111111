#pragma once

#include "CSSetItemEffect.h"

class GSetItemEffect : public CSSetItemEffect, public MTestMemPool<GSetItemEffect>
{
public:
	GSetItemEffect();
	virtual ~GSetItemEffect();
};
