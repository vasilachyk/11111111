#pragma once

#include <string>

namespace mdb
{
	/*
	std::string MDBEscapeString(std::string);
	std::wstring MDBEscapeString(std::wstring);

	std::string MDBEscapeString(const char* v) {
		return MDBEscapeString(std::string(v));
	}

	std::wstring MDBEscapeString(const wchar_t* v) {
		return MDBEscapeString(std::wstring(v));
	}
	*/

	/* Anti SQL-injection: Make sure you have escaped SQL string parameter with this function. */
	class MDBStringEscaper
	{
	public:
		static std::string Escape(const std::string& str) {
			return FindAndReplace(str, '\'');
		}
		static std::string Escape(const char* str) {
			return Escape(std::string(str));
		}

		static std::wstring Escape(const std::wstring& str) {
			return FindAndReplace(str, L'\'');
		}
		static std::wstring Escape(const wchar_t* str) {
			return Escape(std::wstring(str));
		}

	private:
		template <typename _Str, typename _Chr>
		static _Str FindAndReplace(_Str s, _Chr c)
		{
			std::vector<size_t> vecEscapes;

			for (int i = int(s.length()); i >= 0; i--)
			{
				if (s[i] == c)
					vecEscapes.push_back(i);
			}

			for (size_t i = 0; i < vecEscapes.size(); i++)
				s.insert(vecEscapes[i], 1, c);

			return s;
		}
	};

	// convert bool type to "TRUE" or "FALSE".
	class MDBBoolUtil
	{
	public:
		static const char* ToString(bool v) {
			return v ? "TRUE" : "FALSE";
		}
		static const wchar_t* ToWString(bool v) {
			return v ? L"TRUE" : L"FALSE";
		}
	};
}
