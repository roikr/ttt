/*
 *  tttUtils.cpp
 *  dollUploader
 *
 *  Created by Roee Kremer on 1/25/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#include "tttUtils.h"

#include <iostream>
#include <fstream>

void tttCopyFile(string src,string dest) {
	
	ifstream::pos_type size;
	char * memblock;

	ifstream file (src.c_str(), ios::in|ios::binary|ios::ate);
	if (file.is_open())
	{
		size = file.tellg();
		memblock = new char [size];
		file.seekg (0, ios::beg);
		file.read (memblock, size);
		file.close();
		
		cout << "the complete file content is in memory" << endl;
		
		ofstream myFile (dest.c_str(),  ios::out | ios::binary);
		
		if (myFile.is_open()) {
			myFile.write(memblock, size);
			myFile.close();
			
		}
		
		
		delete[] memblock;
	}
	else cout << "Unable to open src file" << endl;
	
}