#include "stdafx.h"
#include "GBuffRemainEffectSqlBuilder.h"
#include "MDBUtil.h"

void GBuffRemainEffectSqlBuilder::Push(
	const int nBuffID,
	const int nStackCount,
	const float fCritPercent,
	const float fCritApplyRate,
	const int nMinDamage,
	const int nMaxDamage,
	const int nMinHeal,
	const int nMaxHeal,
	const int nMinAttrDamage,
	const int nMaxAttrDamage,
	const float fRemainSec,
	const bool bFixedDuration)
{
	m_vecBuffRemainEffect.push_back(
		BUFF_REMAIN_EFFECT(
			nBuffID,
			nStackCount,
			fCritPercent,
			fCritApplyRate,
			nMinDamage,
			nMaxDamage,
			nMinHeal,
			nMaxHeal,
			nMinAttrDamage,
			nMaxAttrDamage,
			fRemainSec,
			bFixedDuration)
		);
}

CString& GBuffRemainEffectSqlBuilder::BuildSQL(const int64 CHAR_SN)
{
	std::string strInput = BuildJSONInput();

	m_strSQL.ReleaseBuffer();
	m_strSQL.Format(L"{CALL RZ_BUFF_REMAIN_EFFECT_UPDATE_ALL (%I64d, '%S')}",
		CHAR_SN, mdb::MDBStringEscaper::Escape(strInput).c_str());

	return m_strSQL;
}

std::string GBuffRemainEffectSqlBuilder::BuildJSONInput()
{
	nlohmann::json js_array = nlohmann::json::array();

	for (const BUFF_REMAIN_EFFECT& re : m_vecBuffRemainEffect)
	{
		nlohmann::json js_element =
		{
			{ "BUFF_ID",			re.m_nBuffID },
			{ "STACK_COUNT",		re.m_nStackCount },
			{ "CRIT_PERCENT",		re.m_fCritPercent },
			{ "CRIT_APPLY_RATE",	re.m_fCritApplyRate },
			{ "MIN_DAMAGE",			re.m_nMinDamage },
			{ "MAX_DAMAGE",			re.m_nMaxDamage },
			{ "MIN_HEAL_AMT",		re.m_nMinHeal },
			{ "MAX_HEAL_AMT",		re.m_nMaxHeal },
			{ "MIN_ATTR_DAMAGE",	re.m_nMinAttrDamage },
			{ "MAX_ATTR_DAMAGE",	re.m_nMaxAttrDamage },
			{ "REMAIN_TIME",		re.m_fRemainSec },
			{ "FIXED_DURATION",		re.m_bFixedDuration }
		};

		js_array.push_back(js_element);
	}

	return js_array.dump();
}

void GBuffRemainEffectSqlBuilder::Reset()
{
	m_vecBuffRemainEffect.clear();
}
