#include "stdafx.h"
#include "GNoviceMsgHandler.h"
#include "GGlobal.h"
#include "GPlayerObjectManager.h"
#include "GEntityPlayer.h"
#include "GCommandCenter.h"
#include "GAppServerFacade.h"

GNoviceMsgHandler::GNoviceMsgHandler()
{
}

GNoviceMsgHandler::~GNoviceMsgHandler()
{
}

bool GNoviceMsgHandler::OnRequest(const MCommand* pCmd)
{
	if (m_strMsg.empty())	return false;

	GEntityPlayer* pPlayer = gmgr.pPlayerObjectManager->GetEntity(m_uidCommandSender);
	VALID_RET(pPlayer, false);

	CID nCID = pPlayer->GetCID();
	MCommand* pNewCmd = m_msgHelper.MakeNewServerCommandNoviceReq(m_strMsg, nCID);
	gsys.pAppServerFacade->Route(pNewCmd);

	return true;
}

bool GNoviceMsgHandler::OnResponse(const MCommand* pCmd)
{
	wstring strSenderName = m_msgHelper.GetSenderName(pCmd);
	MCommand* pNewCmd = m_msgHelper.MakeNewClientCommandNoviceRes(m_strMsg, strSenderName);
	gsys.pCommandCenter->RouteToAll(pNewCmd);

	return true;
}
