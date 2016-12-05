#include "stdafx.h"
#include "LDBTaskPWEAccountInsert.h"
#include "MDBRecordSet.h"
#include "SCmdRouter_Login.h"
#include "LGlobal.h"
#include "LCommandCenter.h"
#include "LDBManager.h"
#include "LCmdRouter_Player.h"
#include "LPlayerObject.h"
#include "LPlayerObjectManager.h"
#include "MLocale.h"

LDBTaskPWEAccountInsert::LDBTaskPWEAccountInsert(const MUID& uidPlayer) 
: LDBAsyncTask(SDBT_DBTYPE_ACCOUNTDB, SDBTID_ACCOUNTINSERT)
{
	
}

LDBTaskPWEAccountInsert::~LDBTaskPWEAccountInsert()
{

}

void LDBTaskPWEAccountInsert::Input( LDBT_ACC_INSERT& data )
{
	m_Data = data;
}

void LDBTaskPWEAccountInsert::OnExecute( mdb::MDatabase& rfDB )
{
	mdb::MDBRecordSet rs(&rfDB);
	if (!ExecuteW(rs, GetSQLW(ACCOUNT_INSERT)))
		return;

	if (0 == rs.GetFetchedRowCount())
	{
		SetTaskFail();
		return;
	}

	m_Result.m_GSN		= rs.FieldW(L"ACCN_SN").AsInt64();
	m_Result.m_CONN_SN	= rs.FieldW(L"CONN_SN").AsInt64();

	if (0 == m_Result.m_GSN)
	{
		SetTaskFail();
		return;
	}
}

mdb::MDB_THRTASK_RESULT LDBTaskPWEAccountInsert::_OnCompleted()
{
	Completer completer(m_Data, m_Result);
	completer.Do();

	return mdb::MDBTR_SUCESS;
}

void LDBTaskPWEAccountInsert::Completer::Do()
{
	if (0 < m_Result.m_GSN)
	{
		InitAccountInfo();
		LCmdRouter_Player::PostPWEAddPlayerReq(m_Data.m_uidPlayer, m_Result.m_GSN, m_Data.m_strUSER_ID);
	}
	else
	{
		SCmdRouter_Login cmdRouter(gsys.pCommandCenter);
		cmdRouter.ResponsePWELogin(m_Data.m_uidPlayer, CR_FAIL_LOGIN_NOT_EXIST_USER);
	}
}

void LDBTaskPWEAccountInsert::Completer::InitAccountInfo()
{
	LPlayerObject* pPlayerObject = gmgr.pPlayerObjectManager->GetPlayer(m_Data.m_uidPlayer);
	if (NULL == pPlayerObject)
	{
		pPlayerObject = (LPlayerObject*)gmgr.pPlayerObjectManager->NewObject(m_Data.m_uidPlayer);
		gmgr.pPlayerObjectManager->AddObject(pPlayerObject);
	}

	// 계정 정보 설정
	ACCOUNT_INFO AccInfo;

	AccInfo.nAID	= m_Result.m_GSN;

	_tcsncpy_s(AccInfo.szUserID, MLocale::ConvUTF16ToTCHAR(m_Data.m_strUSER_ID.c_str()).c_str(), m_Data.m_strUSER_ID.length());
	AccInfo.szUserID[m_Data.m_strUSER_ID.length()] = 0;

	pPlayerObject->InitAccountInfo(AccInfo);
}
