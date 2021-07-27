#include <stdio.h>
#include <fstream>

#define gmEx extern "C" __declspec (dllexport)

gmEx double file_size(const char* file)
{
	std::ifstream   bFile(file, std::ios::binary | std::ios::ate);

	double size = (double)(bFile.tellg());
	bFile.close();

	return size;
}

gmEx double buffer_load_nosandbox(void* buffer, double size, const char* file)
{
	std::ifstream   bFile(file, std::ios::binary | std::ios::ate);
	std::streamsize bSize = (unsigned int)size;

	bFile.seekg(0, std::ios::beg);

	char* bData = (char*)buffer;

	bFile.read(bData, bSize);
	bFile.close();

	return 1;
}