#include "stdafx.h"
#include "GBuffUser.h"
#include "GEntitySync.h"
#include "GEntityActor.h"
#include "GBuffEntity.h"
#include "GBuffInfo.h"
#include "GMath.h"
#include "GGlobal.h"
#include "GAttackDamageCalculator.h"
#include "GCombatCalculator.h"

GBuffUser::GBuffUser(const MUID& uidUser, float fCriticalPercent, float fCriticalApplyRate, int nMinDamage, int nMaxDamage, int nMinHeal, int nMaxHeal, int nMinAttrDamage, int nMaxAttrDamage)
	: m_uidUser(uidUser)
	, m_fCriticalPercent(fCriticalPercent)
	, m_fCriticalApplyRate(fCriticalApplyRate)
	, m_nMinDamage(nMinDamage)
	, m_nMaxDamage(nMaxDamage)
	, m_nMinHeal(nMinHeal)
	, m_nMaxHeal(nMaxHeal)
	, m_nMinAttrDamage(nMinAttrDamage)
	, m_nMaxAttrDamage(nMaxAttrDamage)
{
}

GBuffUser::GBuffUser(const REMAIN_BUFF_TIME& remainBuffTime)
{
	SetFrom(remainBuffTime);
}

GBuffUser::GBuffUser(GEntitySync* pUser, GEntityActor* pTarget, GBuffInfo* pBuffInfo)
	: m_uidUser(MUID::Invalid())
	, m_fCriticalPercent(0.f)
	, m_fCriticalApplyRate(0.f)
	, m_nMinDamage(0)
	, m_nMaxDamage(0)
	, m_nMinHeal(0)
	, m_nMaxHeal(0)
	, m_nMinAttrDamage(0)
	, m_nMaxAttrDamage(0)
{
	SetFrom(pUser, pTarget, pBuffInfo);
}

GBuffUser::~GBuffUser()
{
}

void GBuffUser::SetFrom(GEntitySync* pUser, GEntityActor* pTarget, GBuffInfo* pBuffInfo)
{
	if (!pUser) return;
	VALID(pTarget);
	VALID(pBuffInfo);

	GEntityActor* pUserActor = NULL;
	if (pUser->IsBuffEntity())
	{
		GBuffEntity* pBuffEntity = static_cast<GBuffEntity*>(pUser);
		pUserActor = pBuffEntity->GetOwner();
	}
	else if (pUser->IsActor())
	{
		pUserActor = ToEntityActor(pUser);
	}
	else
	{
		_ASSERT(0);
		return;
	}

	SetUserUID(pUser->GetUID());

	float fCriticalPercent = gsys.pCombatCalculator->GetBuffCriticalPercent(pUserActor, pTarget, pBuffInfo);
	SetCriticalPercent(fCriticalPercent);

	float fCriticalFactor;
	GDamageRangedInfo damageInfo;
	GHealRangedInfo healInfo;
	if (gsys.pAttackDamageCalculator->CalcBuffRangedDamage(pUserActor, pTarget, pBuffInfo, &damageInfo, &healInfo, &fCriticalFactor))
	{
		SetCriticalApplyRate(fCriticalFactor);
		SetDamage(damageInfo.nMinDamage, damageInfo.nMaxDamage);
		SetHeal(healInfo.nMin, healInfo.nMax);
	}
}

void GBuffUser::SetFrom(const REMAIN_BUFF_TIME& remainBuffTime)
{
	m_fCriticalPercent		= remainBuffTime.fCriticalPercent;
	m_fCriticalApplyRate	= remainBuffTime.fCriticalApplyRate;
	m_nMinDamage			= remainBuffTime.nMinDamage;
	m_nMaxDamage			= remainBuffTime.nMaxDamage;
	m_nMinHeal				= remainBuffTime.nMinHeal;
	m_nMaxHeal				= remainBuffTime.nMaxHeal;
	m_nMinAttrDamage		= remainBuffTime.nMinAttrDamage;
	m_nMaxAttrDamage		= remainBuffTime.nMaxAttrDamage;
}

void GBuffUser::ExtractInto(REMAIN_BUFF_TIME& remainBuffTime) const
{
	remainBuffTime.fCriticalPercent		= m_fCriticalPercent;
	remainBuffTime.fCriticalApplyRate	= m_fCriticalApplyRate;
	remainBuffTime.nMinDamage			= m_nMinDamage;
	remainBuffTime.nMaxDamage			= m_nMaxDamage;
	remainBuffTime.nMinHeal				= m_nMinHeal;
	remainBuffTime.nMaxHeal				= m_nMaxHeal;
	remainBuffTime.nMinAttrDamage		= m_nMinAttrDamage;
	remainBuffTime.nMaxAttrDamage		= m_nMaxAttrDamage;
}

const MUID& GBuffUser::GetUserUID() const
{
	return m_uidUser;
}

bool GBuffUser::CheckCritical() const
{
	GPercentDice dice;
	return dice.Dice(m_fCriticalPercent);
}

int GBuffUser::CalcDamage(bool bCritical) const
{
	int nDamage = GMath::RandomNumber(m_nMinDamage, m_nMaxDamage);

	if (bCritical)
		nDamage = GMath::TruncateToInt(nDamage * m_fCriticalApplyRate);

	return nDamage;
}

int GBuffUser::CalcHeal(bool bCritical) const
{
	int nHeal = GMath::RandomNumber(m_nMinHeal, m_nMaxHeal);

	if (bCritical)
		nHeal = GMath::TruncateToInt(nHeal * m_fCriticalApplyRate);

	return nHeal;
}

int GBuffUser::CalcAttrDamage(bool bCritical) const
{
	int nAttrDamage = GMath::RandomNumber(m_nMinAttrDamage, m_nMaxAttrDamage);

	if (bCritical)
		nAttrDamage = GMath::TruncateToInt(nAttrDamage * m_fCriticalApplyRate);

	return nAttrDamage;
}

void GBuffUser::SetUserUID(const MUID& uidUser)
{
	m_uidUser = uidUser;
}

void GBuffUser::SetCriticalPercent(float fCriticalPercent)
{
	m_fCriticalPercent = fCriticalPercent;
}

void GBuffUser::SetCriticalApplyRate(float fCriticalApplyRate)
{
	m_fCriticalApplyRate = fCriticalApplyRate;
}

void GBuffUser::SetDamage(int nMinDamage, int nMaxDamage)
{
	m_nMinDamage = nMinDamage;
	m_nMaxDamage = nMaxDamage;
}

void GBuffUser::SetHeal(int nMinHeal, int nMaxHeal)
{
	m_nMinHeal = nMinHeal;
	m_nMaxHeal = nMaxHeal;
}

void GBuffUser::SetAttrDamage(int nMinAttrDamage, int nMaxAttrDamage)
{
	m_nMinAttrDamage = nMinAttrDamage;
	m_nMaxAttrDamage = nMaxAttrDamage;
}
