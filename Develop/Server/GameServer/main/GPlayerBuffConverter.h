#pragma once

#include <vector>

class GEntityPlayer;
class CSConvertIDContainer;

class GPlayerBuffConverter : MTestMemPool<GPlayerBuffConverter>
{
public:
	GPlayerBuffConverter(GEntityPlayer* pOwner);
	~GPlayerBuffConverter();

	void Add(int nFromBuffID, int nToBuffID, int nRank = 0);
	void Delete(int nDelBuffID, int nRank = 0);
	void Clear();

	int Convert(int nFromBuffID);

private:
	GEntityPlayer*			m_pOwner;

	struct BUFFCONVENTRY
	{
		BUFFCONVENTRY(int nFromBuffID, int nToBuffID, int nRank)
			: m_nFromBuffID(nFromBuffID), m_nToBuffID(nToBuffID), m_nRank(nRank) { }

		int m_nFromBuffID;
		int m_nToBuffID;
		int m_nRank;
	};
	typedef std::vector<BUFFCONVENTRY> VEC_BUFFCONVENTRY;

	VEC_BUFFCONVENTRY		m_vecBuffConvEntry;
};
