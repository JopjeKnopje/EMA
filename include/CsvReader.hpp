#pragma once

#include <iostream>
#include <filesystem>
#include <sstream>
#include <string>
#include <vector>

using DataContainer = std::vector<int>;

class CsvReader {
public:
	CsvReader(std::string const &path);
	CsvReader(CsvReader &&) = delete;
	CsvReader(const CsvReader &) = delete;
	CsvReader &operator=(CsvReader &&) = delete;
	CsvReader &operator=(const CsvReader &) = delete;
	~CsvReader();


	DataContainer getData() const;

private:
	void _parseFile();

	DataContainer _samples;
	const std::string &_filepath;
};

