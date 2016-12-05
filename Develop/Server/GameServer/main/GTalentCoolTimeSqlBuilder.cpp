#include "stdafx.h"
#include "GTalentCoolTimeSqlBuilder.h"
#include "MDBUtil.h"

void GTalentCoolTimeSqlBuilder::Push(const int nTalentID, const float fRemainSec)
{
	m_vecTalentCoolTime.push_back(TALENT_COOL_TIME(nTalentID, fRemainSec));
}

CString& GTalentCoolTimeSqlBuilder::BuildSQL(const int64 CHAR_SN)
{
	std::string strInput = BuildJSONInput();

	m_strSQL.ReleaseBuffer();
	m_strSQL.Format(L"{CALL RZ_TALENT_COOLTIME_UPDATE_ALL (%I64d, '%S')}",
		CHAR_SN, mdb::MDBStringEscaper::Escape(strInput).c_str());

	return m_strSQL;
}

std::string GTalentCoolTimeSqlBuilder::BuildJSONInput()
{
	nlohmann::json js_array = nlohmann::json::array();

	for (const TALENT_COOL_TIME& ct : m_vecTalentCoolTime)
	{
		nlohmann::json js_element =
		{
			{ "TALENT_ID",		ct.m_nTalentID },
			{ "REMAIN_TIME",	ct.m_fRemainSec }
		};

		js_array.push_back(js_element);
	}

	return js_array.dump();
}

void GTalentCoolTimeSqlBuilder::Reset()
{
	m_vecTalentCoolTime.clear();
}
