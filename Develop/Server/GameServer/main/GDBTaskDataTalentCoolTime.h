#pragma once

class GDBT_TALENT_COOL_TIME_UPDATE_ALL
{
public:
	GDBT_TALENT_COOL_TIME_UPDATE_ALL(const AID nAID, const MUID& uidPlayer, const CID nCID, const int nCharPtm, vector<pair<int, float>>& vecTalentCoolTime)
		: m_nAID(nAID), m_uidPlayer(uidPlayer), m_nCID(nCID), m_nCharPtm(nCharPtm)
	{
		m_vecTalentCoolTime.swap(vecTalentCoolTime);
	}

	AID							m_nAID;
	MUID						m_uidPlayer;
	CID							m_nCID;
	int							m_nCharPtm;
	vector<pair<int, float>>	m_vecTalentCoolTime;
};
