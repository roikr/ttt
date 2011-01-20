/*
 *  tttContainer.h
 *  dollUploader
 *
 *  Created by Roee Kremer on 1/19/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#include "tttPackage.h"
#include <string>
#include <vector>

using namespace std;

struct sentence {
	int packageNum;
	int offset;
	int srcOffset;
};

class tttContainer  {
public:
	void addPackage(string filename);
	void eval();
	void display();
	void saveFile(string filename);
	
private:
	vector<tttPackage> packages;
	vector<sentence> sentences;
	int size;
};
