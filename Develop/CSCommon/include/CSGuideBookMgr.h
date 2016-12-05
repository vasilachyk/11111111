#pragma once

#include "CSDef.h"
#include "CSCommonLib.h"
#include "MXml.h"
#include <vector>
#include <map>

class CSGuideBook;
enum GUIDEBOOK_TYPE;

#define GUIDEBOOK_XML_TAG_MAIET						"maiet"
#define GUIDEBOOK_XML_TAG_GUIDEBOOK					"GUIDEBOOK"
#define GUIDEBOOK_XML_ATTR_ID						"id"
#define GUIDEBOOK_XML_ATTR_TYPE						"type"
#define GUIDEBOOK_XML_ATTR_PARAM					"param"
#define GUIDEBOOK_XML_ATTR_POPUPHELPID				"popuphelpid"
#define GUIDEBOOK_XML_ATTR_JOURNALMALESTRING		"journalmalestring"
#define GUIDEBOOK_XML_ATTR_JOURNALFEMALESTRING		"journalfemalestring"
#define GUIDEBOOK_XML_VALUE_TYPE_LEVEL				"level"
#define GUIDEBOOK_XML_VALUE_TYPE_FIELD				"field"

class CSCOMMON_API CSGuideBookMgr
{
public:
	CSGuideBookMgr();
	virtual ~CSGuideBookMgr();

	void Clear();

	bool Load(const TCHAR* szFileName);
	virtual CSGuideBook* New() = 0;

	void Insert(CSGuideBook* pGuideBook);
	CSGuideBook* Get(int nID);

	std::vector<CSGuideBook*> FindByLevelEqualOrGreaterThan(int nLevel);
	CSGuideBook* FindByFieldID(int nFieldID);

protected:
	virtual bool ParseGuideBook(MXmlElement* pElement, CSGuideBook* pGuideBook);
private:
	bool ParseType(MXmlElement* pElement, GUIDEBOOK_TYPE& outType);

protected:
	typedef std::map<int, CSGuideBook*> GUIDEBOOK_MAP;
	GUIDEBOOK_MAP m_GuideBookMap;
};
