#pragma once

#include <vector>
#include "MUID.h"
#include "MTime.h"

class GEntityPlayer;

class GPlayerPosSynchor : MTestMemPool<GPlayerPosSynchor>
{
public:
	GPlayerPosSynchor(GEntityPlayer* pPlayer);
	~GPlayerPosSynchor();

	void Update(float fDelta);

private:
	void				UpdateParty(float fDelta);
	std::vector<MUID>	CollectDistancedPartyMemberUIDs();

	GEntityPlayer*		m_pPlayer;
	MRegulator			m_rgrPartyTick;
};
