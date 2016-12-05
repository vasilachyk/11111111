#pragma once



#include "LDBAsyncTask.h"
#include "MMemPool.h"
#include "LDBTaskDataAccount.h"

class LDBTaskPWEAccountInsert : public LDBAsyncTask, public MMemPool<LDBTaskPWEAccountInsert>
{
public :
	LDBTaskPWEAccountInsert(const MUID& uidPlayer);
	~LDBTaskPWEAccountInsert();

	enum
	{
		ACCOUNT_INSERT = 0
	};

	void Input(LDBT_ACC_INSERT& data);

	void					OnExecute(mdb::MDatabase& rfDB);
	mdb::MDB_THRTASK_RESULT	_OnCompleted();


protected :
	class _RESULT
	{
	public :
		AID		m_GSN;
		int64	m_CONN_SN;
	};

	class Completer
	{
	public :
		Completer(LDBT_ACC_INSERT& data, _RESULT& result) : m_Data(data), m_Result(result) {}

		void Do();
		void InitAccountInfo();		

	protected :
		LDBT_ACC_INSERT&	m_Data;
		_RESULT&			m_Result;
	};


protected :
	LDBT_ACC_INSERT m_Data;
	_RESULT			m_Result;	
};


