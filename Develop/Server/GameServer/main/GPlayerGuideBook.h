#pragma once

typedef set<int>	SET_GUIDEBOOKID;

class GPlayerGuideBook : public MTestMemPool<GPlayerGuideBook>
{
private:
	SET_GUIDEBOOKID	m_setGuideBookID;
	GEntityPlayer*	m_pOwner;

public:
	GPlayerGuideBook(GEntityPlayer* pOwner);
	~GPlayerGuideBook(void);

	void Insert(int nGuideBookID);

	bool IsExist(int nGuideBookID);
	bool IsEmpty();

	const SET_GUIDEBOOKID& GetContainer();
};
