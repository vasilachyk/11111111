#include "stdafx.h"
#include "GPlayerPosSynchor.h"
#include "GConst.h"
#include "GGlobal.h"
#include "GEntityPlayer.h"
#include "GPlayerObjectManager.h"
#include "GParty.h"
#include "GPartySystem.h"
#include "MCommand.h"
#include "GCommand.h"
#include "GCommandCenter.h"
#include "CCommandTable.h"

GPlayerPosSynchor::GPlayerPosSynchor(GEntityPlayer* pPlayer)
{
	m_pPlayer = pPlayer;

	m_rgrPartyTick.SetTickTime(GConst::PARTY_MEMBER_POSITION_TICK);
	m_rgrPartyTick.Start();
}

GPlayerPosSynchor::~GPlayerPosSynchor()
{
}

void GPlayerPosSynchor::Update(float fDelta)
{
	PFC_THISFUNC;
	UpdateParty(fDelta);
}

void GPlayerPosSynchor::UpdateParty(float fDelta)
{
	if (!m_rgrPartyTick.IsReady(fDelta))
		return;

	if (!m_pPlayer->HasParty())
		return;

	if (m_pPlayer->IsNowInvisibility())
		return;

	std::vector<MUID> vecMemberUIDs = CollectDistancedPartyMemberUIDs();

	if (vecMemberUIDs.empty())
		return;

	MCommand* pCmd = MakeNewCommand(MC_PARTY_REFRESH_MEMBER_POSITION, 
		2, 
		NEW_UID(m_pPlayer->GetUID()), 
		NEW_VEC(m_pPlayer->GetPos()));

	pCmd->AddReceiver(vecMemberUIDs);
	gsys.pCommandCenter->PostCommand(pCmd);
}

std::vector<MUID> GPlayerPosSynchor::CollectDistancedPartyMemberUIDs()
{
	GParty* pParty = gsys.pPartySystem->FindParty(m_pPlayer->GetPartyUID());
	VALID_RET(pParty, std::vector<MUID>());

	std::vector<MUID> vecMemberUIDs;
	for (partymember_iterator iter = pParty->GetMemberBegin(); iter != pParty->GetMemberEnd(); iter++)
	{
		GEntityPlayer* pMember = gmgr.pPlayerObjectManager->GetEntity(iter->first);
		if (!pMember) continue;

		if (m_pPlayer == pMember) continue;
		if (m_pPlayer->GetField() != pMember->GetField()) continue;	// different field: no need to collect.
		if (m_pPlayer->DistanceTo(pMember) <= SECTOR_SIZE) continue;

		vecMemberUIDs.push_back(pMember->GetUID());
	}

	return vecMemberUIDs;
}
