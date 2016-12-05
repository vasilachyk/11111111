#pragma once

#include "GDBAsyncTask.h"
#include "GDBTaskDataGuideBookInsert.h"
#include "MMemPool.h"

class GDBTaskGuideBookInsert : public GDBAsyncTask, public MMemPool<GDBTaskGuideBookInsert>
{
public:
	GDBTaskGuideBookInsert(const MUID& uidPlayer);
	~GDBTaskGuideBookInsert();

	enum
	{
		GUIDEBOOK_INSERT = 0,
	};

	void Input(const GDBT_GUIDEBOOK_INSERT_DATA& data);

	void					OnExecute(mdb::MDatabase& rfDB) override;
	mdb::MDB_THRTASK_RESULT	_OnCompleted() override;

protected:
	class Completer
	{
	public:
		Completer(const GDBT_GUIDEBOOK_INSERT_DATA& data) : m_Data(data) {}
		~Completer() {}

		void Do();

	private:
		const GDBT_GUIDEBOOK_INSERT_DATA& m_Data;
	};

protected:
	GDBT_GUIDEBOOK_INSERT_DATA m_Data;
};
