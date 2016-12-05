#include "stdafx.h"
#include "GDBTaskGuideBookInsert.h"
#include "GGuideBookSystem.h"
#include "GGlobal.h"

GDBTaskGuideBookInsert::GDBTaskGuideBookInsert(const MUID& uidPlayer)
	: GDBAsyncTask(uidPlayer, SDBT_DBTYPE_GAMEDB, SDBTID_GUIDEBOOK_INSERT)
{
}

GDBTaskGuideBookInsert::~GDBTaskGuideBookInsert()
{
}

void GDBTaskGuideBookInsert::Input(const GDBT_GUIDEBOOK_INSERT_DATA& data)
{
	m_Data = data;
}

void GDBTaskGuideBookInsert::OnExecute(mdb::MDatabase & rfDB)
{
	mdb::MDatabaseQuery q(&rfDB);
	if (!ExecuteW(q, GetSQLW(GUIDEBOOK_INSERT)))
		return;
}

mdb::MDB_THRTASK_RESULT GDBTaskGuideBookInsert::_OnCompleted()
{
	Completer completer(m_Data);
	completer.Do();

	return mdb::MDBTR_SUCESS;
}

void GDBTaskGuideBookInsert::Completer::Do()
{
	gsys.pGuideBookSystem->AddGuideBookForDBTask(m_Data.m_uidPlayer, m_Data.m_nGuideBookID);
}
