#include "stdafx.h"
#include "GLFPMsgHandler.h"
#include "GGlobal.h"
#include "GPlayerObjectManager.h"
#include "GEntityPlayer.h"
#include "GCommandCenter.h"
#include "GAppServerFacade.h"

GLFPMsgHandler::GLFPMsgHandler()
{
}

GLFPMsgHandler::~GLFPMsgHandler()
{
}

bool GLFPMsgHandler::OnRequest(const MCommand* pCmd)
{
	if (m_strMsg.empty())	return false;

	GEntityPlayer* pPlayer = gmgr.pPlayerObjectManager->GetEntity(m_uidCommandSender);
	VALID_RET(pPlayer, false);

	CID nCID = pPlayer->GetCID();
	MCommand* pNewCmd = m_msgHelper.MakeNewServerCommandLFPReq(m_strMsg, nCID);
	gsys.pAppServerFacade->Route(pNewCmd);

	return true;
}

bool GLFPMsgHandler::OnResponse(const MCommand* pCmd)
{
	wstring strSenderName = m_msgHelper.GetSenderName(pCmd);
	MCommand* pNewCmd = m_msgHelper.MakeNewClientCommandLFPRes(m_strMsg, strSenderName);
	gsys.pCommandCenter->RouteToAll(pNewCmd);

	return true;
}
