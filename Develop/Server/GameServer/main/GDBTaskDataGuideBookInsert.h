#pragma once

struct GDBT_GUIDEBOOK_INSERT_DATA
{
	GDBT_GUIDEBOOK_INSERT_DATA() : m_uidPlayer(0), m_nCID(0), m_nGuideBookID(0) {}
	GDBT_GUIDEBOOK_INSERT_DATA(const MUID& uidPlayer, const CID nCID, const int nGuideBookID)
		: m_uidPlayer(uidPlayer), m_nCID(nCID), m_nGuideBookID(nGuideBookID) {}

	MUID	m_uidPlayer;
	CID		m_nCID;
	int		m_nGuideBookID;
};
