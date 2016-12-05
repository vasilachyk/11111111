#include "stdafx.h"
#include "PNoviceMsgHandler.h"
#include "PGlobal.h"
#include "PServer.h"
#include "PCommandCenter.h"
#include "SProxyPlayerManager.h"
#include "SProxyPlayer.h"

PNoviceMsgHandler::PNoviceMsgHandler()
{
}

PNoviceMsgHandler::~PNoviceMsgHandler()
{
}

bool PNoviceMsgHandler::OnRequest(const minet::MCommand* pCmd)
{
	CID nCID = m_msgHelper.GetSenderID(pCmd);
	SProxyPlayerManager* pManager = gsys.pServer->GetPlayerManager();
	SProxyPlayer* pPlayer = pManager->FindPlayer(nCID);
	if (pPlayer == NULL)	return true;

	wstring strSenderName = pPlayer->GetName();
	MCommand* pNewCmd = m_msgHelper.MakeNewServerCommandNoviceRes(m_strMsg, strSenderName);
	gsys.pCommandCenter->RouteToAll(pNewCmd);

	return true;
}
