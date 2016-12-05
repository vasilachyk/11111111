#include "stdafx.h"
#include "PLFPMsgHandler.h"
#include "PGlobal.h"
#include "PServer.h"
#include "PCommandCenter.h"
#include "SProxyPlayerManager.h"
#include "SProxyPlayer.h"

PLFPMsgHandler::PLFPMsgHandler()
{
}

PLFPMsgHandler::~PLFPMsgHandler()
{
}

bool PLFPMsgHandler::OnRequest(const minet::MCommand* pCmd)
{
	CID nCID = m_msgHelper.GetSenderID(pCmd);
	SProxyPlayerManager* pManager = gsys.pServer->GetPlayerManager();
	SProxyPlayer* pPlayer = pManager->FindPlayer(nCID);
	if (pPlayer == NULL)	return true;

	wstring strSenderName = pPlayer->GetName();
	MCommand* pNewCmd = m_msgHelper.MakeNewServerCommandLFPRes(m_strMsg, strSenderName);
	gsys.pCommandCenter->RouteToAll(pNewCmd);

	return true;
}
