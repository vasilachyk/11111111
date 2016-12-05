#include "stdafx.h"
#include "GDBTaskItemSort.h"
#include "GDBManager.h"
#include "GGlobal.h"
#include "GItemSystem.h"
#include "GItemSorter.h"

GDBTaskItemSort::GDBTaskItemSort( const MUID& uidReqPlayer )
: GDBAsyncTask(uidReqPlayer, SDBT_DBTYPE_GAMEDB, SDBTID_ITEM_SORT)
{

}

GDBTaskItemSort::~GDBTaskItemSort()
{

}

void GDBTaskItemSort::Input( const GDBT_ITEM_SORT& data )
{
	m_Data = data;
}

void GDBTaskItemSort::OnExecute( mdb::MDatabase& rfDB )
{
	mdb::MDatabaseQuery q(&rfDB);
	if (!ExecuteW(q, GetSQLW(ITEM_SORT)))
		return;
}

mdb::MDB_THRTASK_RESULT GDBTaskItemSort::_OnCompleted()
{
	Completer completer(m_Data);
	completer.Do();

	return mdb::MDBTR_SUCESS;
}

mdb::MDB_THRTASK_RESULT	GDBTaskItemSort::_OnFailed()
{
	return mdb::MDBTR_SUCESS;
}

void GDBTaskItemSort::Completer::Do()
{
	gsys.pDBManager->ItemSortLog(m_Data);

	gsys.pItemSystem->GetSorter().SortForDBTask(m_Data);
}
