#include "CsvReader.hpp"
#include <cstddef>
#include <fstream>
#include <iostream>
#include <ostream>
#include <sstream>
#include <string>


CsvReader::CsvReader(std::string const &path) : _filepath(path)
{
	std::cout << path << std::endl;
	_parseFile();
}

CsvReader::~CsvReader()
{

}

DataContainer CsvReader::getData() const
{
	return _samples;
}

std::size_t _parseGetSplits(const std::string &line)
{
	std::stringstream ss{line};
	int a;
	std::size_t i = 0;
	while (ss >> a)
		i++;
	return i;
}

void CsvReader::_parseFile()
{
    std::ifstream ifs(_filepath);

	// TODO: logger
	std::cout << "reading: " << _filepath << std::endl;

	std::string line;
	size_t line_nr = 0;
	while (std::getline(ifs, line))
	{
		std::istringstream iss(line);

		const std::size_t splits = _parseGetSplits(line);
		std::cerr << splits << std::endl;

		if (splits != 1)
		{
			// TODO: Use logger
			std::cerr << "CSV: Format invalid" << std::endl;
			continue;
		}

		int a;
		if (iss >> a)
		{
			std::cout << line;
			_samples.push_back(a);
		}
		else
			std::cerr << "CSV: Failed extracting line: " << line_nr << std::endl;

		line_nr++;
	}
}








