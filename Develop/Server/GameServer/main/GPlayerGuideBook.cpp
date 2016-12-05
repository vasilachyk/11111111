#include "stdafx.h"
#include "GPlayerGuideBook.h"

GPlayerGuideBook::GPlayerGuideBook(GEntityPlayer* pOwner)
	: m_pOwner(pOwner)
{
}

GPlayerGuideBook::~GPlayerGuideBook(void)
{
}

void GPlayerGuideBook::Insert(int nGuideBookID)
{
	m_setGuideBookID.insert(nGuideBookID);
}

bool GPlayerGuideBook::IsExist(int nGuideBookID)
{
	if (m_setGuideBookID.end() == m_setGuideBookID.find(nGuideBookID)) return false;

	return true;
}

bool GPlayerGuideBook::IsEmpty()
{
	return m_setGuideBookID.empty();
}

const SET_GUIDEBOOKID& GPlayerGuideBook::GetContainer()
{
	return m_setGuideBookID;
}
