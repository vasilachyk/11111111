#include "StdAfx.h"
#include "ZGuildLogic.h"
#include "ZPlayer.h"
#include "ZPlayerManager.h"
#include "ZCommandCenter.h"
#include "CCommandTable_Master.h"
#include "STransData_M2G.h"
#include "ZField.h"

void ZGuildLogic::MemberOnlineInfo(MUID uidSender, MUID uidPlayer, const vector<CID>& vecMemberCID )
{
	vector<TD_GUILD_ONLINE_MEMBER_INFO> vecOnlineMemberInfo;
	for each (CID nMemberCID in vecMemberCID)
	{
		ZPlayer* pPlayer = gmgr.pPlayerManager->FindByCID(nMemberCID);
		if (NULL == pPlayer)
			continue;
		if (false == pPlayer->IsInWorld())
			continue;

		vecOnlineMemberInfo.push_back(TD_GUILD_ONLINE_MEMBER_INFO(pPlayer->GetCID(), pPlayer->GetFieldID(), pPlayer->GetChannelID()));		
	}

	MCommand* pNewCmd = gsys.pCommandCenter->MakeNewCommand(MMC_GUILD_MEMBER_ONLINEINFO,
		uidSender,
		2,
		NEW_UID(uidPlayer),
		NEW_BLOB(vecOnlineMemberInfo));

	gsys.pCommandCenter->PostCommand(pNewCmd);
}

void ZGuildLogic::Destroy( int nGID )
{
	MCommand* pNewCmd = gsys.pCommandCenter->MakeNewCommand(MMC_GUILD_DESTROY_SYNC,
		1,
		NEW_INT(nGID));

	gsys.pCommandCenter->RouteToGameServer(pNewCmd);
}

void ZGuildLogic::Join(CID nCID, AID nAID, int nGID, const wstring& strName, int nLevel, int nFieldID, int nChannelID)
{
	MCommand* pNewCmd = gsys.pCommandCenter->MakeNewCommand(MMC_GUILD_JOIN_SYNC,
		7,
		NEW_INT64(nCID),
		NEW_INT64(nAID),
		NEW_INT(nGID),
		NEW_WSTR(strName.c_str()),
		NEW_INT(nLevel),
		NEW_INT(nFieldID),
		NEW_INT(nChannelID));
	
	gsys.pCommandCenter->RouteToGameServer(pNewCmd);
}

void ZGuildLogic::Leave( CID nCID, int nGID )
{
	MCommand* pNewCmd = gsys.pCommandCenter->MakeNewCommand(MMC_GUILD_LEAVE_SYNC,
		2,
		NEW_INT64(nCID),
		NEW_INT(nGID));

	gsys.pCommandCenter->RouteToGameServer(pNewCmd);
}

void ZGuildLogic::Kick( CID nCID, int nGID )
{
	MCommand* pNewCmd = gsys.pCommandCenter->MakeNewCommand(MMC_GUILD_KICK_SYNC,
		2,
		NEW_INT64(nCID),
		NEW_INT(nGID));

	gsys.pCommandCenter->RouteToGameServer(pNewCmd);
}

void ZGuildLogic::OnLine( CID nCID, int nGID, int nFieldID, int nChannelID )
{
	MCommand* pNewCmd = gsys.pCommandCenter->MakeNewCommand(MMC_GUILD_ONLINE_SYNC,
		4,
		NEW_INT64(nCID),
		NEW_INT(nGID),
		NEW_INT(nFieldID), 
		NEW_INT(nChannelID));

	gsys.pCommandCenter->RouteToGameServer(pNewCmd);
}

void ZGuildLogic::OffLine( CID nCID, int nGID )
{
	MCommand* pNewCmd = gsys.pCommandCenter->MakeNewCommand(MMC_GUILD_OFFLINE_SYNC,
		2,
		NEW_INT64(nCID),
		NEW_INT(nGID));

	gsys.pCommandCenter->RouteToGameServer(pNewCmd);
}

void ZGuildLogic::MoveField( CID nCID, int nGID, int nFieldID, int nChannelID )
{
	MCommand* pNewCmd = gsys.pCommandCenter->MakeNewCommand(MMC_GUILD_MOVEFIELD_SYNC,
		4,
		NEW_INT64(nCID),
		NEW_INT(nGID),
		NEW_INT(nFieldID), 
		NEW_INT(nChannelID));

	gsys.pCommandCenter->RouteToGameServer(pNewCmd);
}

void ZGuildLogic::ChangeMaster( CID nOldCID, CID nNewCID, int nGID )
{
	MCommand* pNewCmd = gsys.pCommandCenter->MakeNewCommand(MMC_GUILD_CHANGE_MASTER_SYNC,
		3,
		NEW_INT64(nOldCID),
		NEW_INT64(nNewCID),
		NEW_INT(nGID));

	gsys.pCommandCenter->RouteToGameServer(pNewCmd);
}

void ZGuildLogic::DepositStorageMoney(MUID uidReqServer, CID nCID, int nGID, int nDepoistMoney, int nStorageMoney )
{
	MCommand* pNewCmd = gsys.pCommandCenter->MakeNewCommand(MMC_GUILD_DEPOSIT_STORAGEMONEY_SYNC,
		4,
		NEW_INT64(nCID),
		NEW_INT(nGID),
		NEW_INT(nDepoistMoney), 
		NEW_INT(nStorageMoney));

	gsys.pCommandCenter->RouteToGameServer(pNewCmd, uidReqServer);
}

void ZGuildLogic::WithdrawStorageMoney(MUID uidReqServer, CID nCID, int nGID, int nWithdrawMoney, int nStorageMoney )
{
	MCommand* pNewCmd = gsys.pCommandCenter->MakeNewCommand(MMC_GUILD_WITHDRAW_STORAGEMONEY_SYNC,
		4,
		NEW_INT64(nCID),
		NEW_INT(nGID),
		NEW_INT(nWithdrawMoney), 
		NEW_INT(nStorageMoney));

	gsys.pCommandCenter->RouteToGameServer(pNewCmd, uidReqServer);
}

void ZGuildLogic::MoveStorageItem(MUID uidReqServer, CID nCID, int nGID, vector<TD_PLAYER_GAME_DATA_ITEM_INSTANCE>& vecTDItem)
{
	MCommand* pNewCmd = gsys.pCommandCenter->MakeNewCommand(MMC_GUILD_MOVE_STORAGEITEM_SYNC,
		3,
		NEW_INT64(nCID),
		NEW_INT(nGID),
		NEW_BLOB(vecTDItem));

	gsys.pCommandCenter->RouteToGameServer(pNewCmd, uidReqServer);
}