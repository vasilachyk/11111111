#include "stdafx.h"
#include "GGuideBookSystem.h"
#include "GEntityPlayer.h"
#include "GPlayerObjectManager.h"
#include "GPlayerGuideBook.h"
#include "GGuideBook.h"
#include "GGuideBookMgr.h"
#include "GDBManager.h"
#include "GDBTaskDataGuideBookInsert.h"
#include "GGlobal.h"
#include "CCommandTable.h"
#include "GCommand.h"

void GGuideBookSystem::AddGuideBook_OnLevelUp(GEntityPlayer* pPlayer, int nLevel)
{
	VALID(pPlayer);
	GPlayerGuideBook& playerGuideBook = pPlayer->GetPlayerGuideBook();

	vector<GGuideBook*> vecGuideBooks = gmgr.pGuideBookMgr->FindByLevelEqualOrGreaterThan(nLevel);
	for (GGuideBook* pGuideBook : vecGuideBooks)
	{
		if (!playerGuideBook.IsExist(pGuideBook->m_nID))
		{
			gsys.pDBManager->GuideBookInsert(GDBT_GUIDEBOOK_INSERT_DATA(pPlayer->GetUID(), pPlayer->GetCID(), pGuideBook->m_nID));
		}
	}
}

void GGuideBookSystem::AddGuideBook_OnFieldEntered(GEntityPlayer* pPlayer, int nFieldID)
{
	VALID(pPlayer);
	GPlayerGuideBook& playerGuideBook = pPlayer->GetPlayerGuideBook();

	GGuideBook* pGuideBook = gmgr.pGuideBookMgr->FindByFieldID(nFieldID);
	if (pGuideBook && !playerGuideBook.IsExist(pGuideBook->m_nID))
	{
		gsys.pDBManager->GuideBookInsert(GDBT_GUIDEBOOK_INSERT_DATA(pPlayer->GetUID(), pPlayer->GetCID(), pGuideBook->m_nID));
	}
}

void GGuideBookSystem::AddGuideBookForDBTask(const MUID & uidPlayer, int nGuideBookID)
{
	GEntityPlayer* pPlayer = gmgr.pPlayerObjectManager->GetEntity(uidPlayer);
	VALID(pPlayer);

	pPlayer->GetPlayerGuideBook().Insert(nGuideBookID);

	MCommand* pCmd = MakeNewCommand(MC_SC_GUIDEBOOK_GAIN, 1, NEW_INT(nGuideBookID));
	pPlayer->RouteToMe(pCmd);
}
