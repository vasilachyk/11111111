#pragma once

#include "MUID.h"

class GEntitySync;
class GEntityActor;
class GBuffInfo;
struct REMAIN_BUFF_TIME;

class GBuffUser : public MTestMemPool<GBuffUser>
{
public:
	GBuffUser(const MUID& uidUser = MUID::Invalid(), float fCriticalPercent = 0.f, float fCriticalApplyRate = 0.f, int nMinDamage = 0, int nMaxDamage = 0, int nMinHeal = 0, int nMaxHeal = 0, int nMinAttrDamage = 0, int nMaxAttrDamage = 0);
	GBuffUser(const REMAIN_BUFF_TIME& remainBuffTime);
	GBuffUser(GEntitySync* pUser, GEntityActor* pTarget, GBuffInfo* pBuffInfo);
	~GBuffUser();

	void SetFrom(GEntitySync* pUser, GEntityActor* pTarget, GBuffInfo* pBuffInfo);
	void SetFrom(const REMAIN_BUFF_TIME& remainBuffTime);
	void ExtractInto(REMAIN_BUFF_TIME& remainBuffTime) const;

	const MUID& GetUserUID() const;
	bool CheckCritical() const;
	int CalcDamage(bool bCritical) const;
	int CalcHeal(bool bCritical) const;
	int CalcAttrDamage(bool bCritical) const;

	void SetUserUID(const MUID& uidUser);
	void SetCriticalPercent(float fCriticalPercent);
	void SetCriticalApplyRate(float fCriticalApplyRate);
	void SetDamage(int nMinDamage, int nMaxDamage);
	void SetHeal(int nMinHeal, int nMaxHeal);
	void SetAttrDamage(int nMinAttrDamage, int nMaxAttrDamage);

private:
	MUID m_uidUser;

	float m_fCriticalPercent;
	float m_fCriticalApplyRate;

	int m_nMinDamage;
	int m_nMaxDamage;

	int m_nMinHeal;
	int m_nMaxHeal;

	int m_nMinAttrDamage;
	int m_nMaxAttrDamage;
};
