#pragma once

#include "GMsgHandler.h"

class GNoviceMsgHandler : public GMsgHandler, public MTestMemPool<GNoviceMsgHandler>
{
public:
	GNoviceMsgHandler();
	virtual ~GNoviceMsgHandler();

	virtual bool OnRequest(const MCommand* pCmd);
	virtual bool OnResponse(const MCommand* pCmd);

	virtual CSMsgType GetHandlerType(void) { return MT_NOVICE; }
};
