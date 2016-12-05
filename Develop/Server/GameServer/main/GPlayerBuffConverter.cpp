#include "stdafx.h"
#include "GPlayerBuffConverter.h"
#include "GEntityPlayer.h"
#include "CSConvertIDContainer.h"

GPlayerBuffConverter::GPlayerBuffConverter(GEntityPlayer* pOwner)
	: m_pOwner(pOwner)
{
}

GPlayerBuffConverter::~GPlayerBuffConverter()
{
}

void GPlayerBuffConverter::Add(int nFromBuffID, int nToBuffID, int nRank)
{
	Delete(nFromBuffID, nRank);
	m_vecBuffConvEntry.push_back(BUFFCONVENTRY(nFromBuffID, nToBuffID, nRank));
}

void GPlayerBuffConverter::Delete(int nDelBuffID, int nRank)
{
	for (VEC_BUFFCONVENTRY::iterator iter = m_vecBuffConvEntry.begin(); iter != m_vecBuffConvEntry.end(); )
	{
		const BUFFCONVENTRY& entry = *iter;

		if (entry.m_nFromBuffID == nDelBuffID && entry.m_nRank == nRank)
		{
			iter = m_vecBuffConvEntry.erase(iter);
		}
		else
		{
			iter++;
		}
	}
}

void GPlayerBuffConverter::Clear()
{
	m_vecBuffConvEntry.clear();
}

int GPlayerBuffConverter::Convert(int nFromBuffID)
{
	int nToBuffID = nFromBuffID, nMostHighRank = -1;

	for (const BUFFCONVENTRY& entry : m_vecBuffConvEntry)
	{
		if (entry.m_nFromBuffID == nFromBuffID && entry.m_nRank > nMostHighRank)
		{
			nToBuffID = entry.m_nToBuffID;
			nMostHighRank = entry.m_nRank;
		}
	}

	return nToBuffID;
}
