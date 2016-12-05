#pragma once

#include "PMsgHandler.h"

class PNoviceMsgHandler : public PMsgHandler
{
public:
	PNoviceMsgHandler();
	virtual ~PNoviceMsgHandler();

	virtual bool OnRequest(const minet::MCommand* pCmd);
	virtual CSMsgType GetHandlerType(void) { return MT_NOVICE; }
};
