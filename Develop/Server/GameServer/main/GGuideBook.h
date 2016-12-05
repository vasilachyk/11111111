#pragma once

#include "CSGuideBook.h"

class GGuideBook : public CSGuideBook, public MTestMemPool<GGuideBook>
{
public:
	GGuideBook();
	virtual ~GGuideBook();
};
