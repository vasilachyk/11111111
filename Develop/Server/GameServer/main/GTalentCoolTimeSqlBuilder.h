#pragma once

#include <json.hpp>

class GTalentCoolTimeSqlBuilder
{
public:
	void		Push(const int nTalentID, const float fRemainSec);
	CString&	BuildSQL(const int64 CHAR_SN);
	void		Reset();

private:
	struct TALENT_COOL_TIME
	{
		TALENT_COOL_TIME(const int nTalentID, const float fRemainSec) : m_nTalentID(nTalentID), m_fRemainSec(fRemainSec) {}

		int		m_nTalentID;
		float	m_fRemainSec;
	};
	
	std::string BuildJSONInput();

protected:
	std::vector<TALENT_COOL_TIME>	m_vecTalentCoolTime;
	CString							m_strSQL;
};
