#include "CsvReader.hpp"
#include <cstdlib>
#include <string>
#include <iostream>




int main (int argc, char *argv[])
{
	// 1. generate or read csv file
	if (argc < 2)
	{
		// TODO: Log error
		return EXIT_FAILURE;
	}
	CsvReader reader = CsvReader(argv[1]);
	auto samples = reader.getData();

	// 2. run through algo


	for (auto s : samples)
	{
		std::cout << s << std::endl;
	}
	
	return 0;
}
