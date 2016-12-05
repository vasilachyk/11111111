#pragma once

#include "GDBAsyncTask.h"
#include "GDBTaskDataItemSort.h"
#include "MMemPool.h"

class GDBTaskItemSort : public GDBAsyncTask, public MMemPool<GDBTaskItemSort>
{
public:
	GDBTaskItemSort(const MUID& uidReqPlayer);
	~GDBTaskItemSort();

	enum
	{
		ITEM_SORT = 0
	};

	void Input(const GDBT_ITEM_SORT& data);

	void					OnExecute(mdb::MDatabase& rfDB) override;
	mdb::MDB_THRTASK_RESULT	_OnCompleted() override;
	mdb::MDB_THRTASK_RESULT	_OnFailed() override;


protected:
	class Completer
	{
	public:
		Completer(GDBT_ITEM_SORT& data) : m_Data(data) {}
		~Completer() {}

		void Do();

	private:
		GDBT_ITEM_SORT&	m_Data;
	};


protected:
	GDBT_ITEM_SORT	m_Data;
};
