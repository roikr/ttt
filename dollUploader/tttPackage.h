/*
 *  package.h
 *  dollUploader
 *
 *  Created by Roee Kremer on 1/19/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#include <string>
#include <fstream>

using namespace std;

class tttPackage {
	
public:
	
	bool loadFile(string filename,bool bWithData);
	void display();
	void exit();
	
	char * memblock;
	ifstream::pos_type size;
	int numSentences;
	unsigned int * offsets;
	
	int dataOffset;
	int dataLength;
	
};
