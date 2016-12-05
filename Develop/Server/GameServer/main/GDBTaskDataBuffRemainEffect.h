#pragma once

class GDBT_BUFF_REMAIN_EFFECT_UPDATE_ALL
{
public:
	GDBT_BUFF_REMAIN_EFFECT_UPDATE_ALL(const AID nAID, const MUID& uidPlayer, const CID nCID, const int nCharPtm
		, vector<REMAIN_BUFF_TIME>& vecBuffRemainTime)
		: m_nAID(nAID), m_uidPlayer(uidPlayer), m_nCID(nCID), m_nCharPtm(nCharPtm)
	{
		m_vecBuffRemainTime.swap(vecBuffRemainTime);
	}

	AID							m_nAID;
	MUID						m_uidPlayer;
	CID							m_nCID;
	int							m_nCharPtm;
	vector<REMAIN_BUFF_TIME>	m_vecBuffRemainTime;
};
