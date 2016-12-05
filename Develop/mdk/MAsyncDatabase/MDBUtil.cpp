#include "stdafx.h"
#include "MDBUtil.h"
#include <string>
#include <vector>

namespace mdb
{
	/*
	std::string MDBEscapeString(std::string v)
	{
		std::vector<size_t> vecEscapes;

		for (int i = int(v.length()); i >= 0; i--)
		{
			if (v[i] == '\'')
				vecEscapes.push_back(i);
		}

		for (size_t i = 0; i < vecEscapes.size(); i++)
			v.insert(vecEscapes[i], "'");

		return v;
	}

	std::wstring MDBEscapeString(std::wstring v)
	{
		std::vector<size_t> vecEscapes;

		for (int i = int(v.length()); i >= 0; i--)
		{
			if (v[i] == L'\'')
				vecEscapes.push_back(i);
		}

		for (size_t i = 0; i < vecEscapes.size(); i++)
			v.insert(vecEscapes[i], L"'");

		return v;
	}
	*/
}
