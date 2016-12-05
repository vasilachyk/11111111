#pragma once

#include <map>
#include <set>

class CSConvertIDContainer
{
public:
	void Add(int nFromID, int nToID) {
		m_mapConvertID.insert(CONVERTID_MAP::value_type(nFromID, nToID));
	}
	int Convert(int nFromID) const {
		CONVERTID_MAP::const_iterator iter = m_mapConvertID.find(nFromID);
		return iter == m_mapConvertID.end() ? nFromID : iter->second;
	}
	void EnumConvToIDs_Into(std::set<int>& outset) const {
		for (CONVERTID_MAP::const_iterator iter = m_mapConvertID.begin(); iter != m_mapConvertID.end(); iter++)
			outset.insert(iter->second);
	}
	std::set<int> EnumConvToIDs() const {
		std::set<int> ConvToIDs;
		EnumConvToIDs_Into(ConvToIDs);
		return ConvToIDs;
	}
	void Delete(int nDelFromID) {
		m_mapConvertID.erase(nDelFromID);
	}
	void Clear() {
		m_mapConvertID.clear();
	}
private:
	typedef std::map<int, int> CONVERTID_MAP;
	CONVERTID_MAP m_mapConvertID;
};
