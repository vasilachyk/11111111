#pragma once

#include "GMsgHandler.h"

class GLFPMsgHandler : public GMsgHandler, public MTestMemPool<GLFPMsgHandler>
{
public:
	GLFPMsgHandler();
	virtual ~GLFPMsgHandler();

	virtual bool OnRequest(const MCommand* pCmd);
	virtual bool OnResponse(const MCommand* pCmd);

	virtual CSMsgType GetHandlerType(void) { return MT_LFP; }
};
