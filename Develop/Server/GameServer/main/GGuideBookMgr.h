#pragma once

#include "CSGuideBookMgr.h"

class CSGuideBook;
class GGuideBook;

class GGuideBookMgr : public CSGuideBookMgr, public MTestMemPool<GGuideBookMgr>
{
public:
	GGuideBookMgr();
	virtual ~GGuideBookMgr();

	virtual CSGuideBook* New();

	virtual GGuideBook* Get(int nID);

	virtual std::vector<GGuideBook*> FindByLevelEqualOrGreaterThan(int nLevel);
	virtual GGuideBook* FindByFieldID(int nFieldID);
};
