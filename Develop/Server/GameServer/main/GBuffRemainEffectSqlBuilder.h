#pragma once

#include <json.hpp>

class GBuffRemainEffectSqlBuilder
{
public:
	void Push(
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
		const bool bFixedDuration);

	CString&	BuildSQL(const int64 CHAR_SN);
	void		Reset();

private:
	struct BUFF_REMAIN_EFFECT
	{
		BUFF_REMAIN_EFFECT(
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
			: m_nBuffID(nBuffID),
			m_nStackCount(nStackCount),
			m_fCritPercent(fCritPercent),
			m_fCritApplyRate(fCritApplyRate),
			m_nMinDamage(nMinDamage),
			m_nMaxDamage(nMaxDamage),
			m_nMinHeal(nMinHeal),
			m_nMaxHeal(nMaxHeal),
			m_nMinAttrDamage(nMinAttrDamage),
			m_nMaxAttrDamage(nMaxAttrDamage),
			m_fRemainSec(fRemainSec),
			m_bFixedDuration(bFixedDuration) {}

		int		m_nBuffID;
		int		m_nStackCount;
		float	m_fCritPercent;
		float	m_fCritApplyRate;
		int		m_nMinDamage;
		int		m_nMaxDamage;
		int		m_nMinHeal;
		int		m_nMaxHeal;
		int		m_nMinAttrDamage;
		int		m_nMaxAttrDamage;
		float	m_fRemainSec;
		bool	m_bFixedDuration;
	};

	std::string BuildJSONInput();

protected:
	std::vector<BUFF_REMAIN_EFFECT>	m_vecBuffRemainEffect;
	CString							m_strSQL;
};
