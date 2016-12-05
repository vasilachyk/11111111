#pragma once

#include "PMsgHandler.h"

class PLFPMsgHandler : public PMsgHandler
{
public:
	PLFPMsgHandler();
	virtual ~PLFPMsgHandler();

	virtual bool OnRequest(const minet::MCommand* pCmd);
	virtual CSMsgType GetHandlerType(void) { return MT_LFP; }
};
