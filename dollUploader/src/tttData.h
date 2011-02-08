/*
 *  tttData.h
 *  dollUploader
 *
 *  Created by Roee Kremer on 2/3/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#pragma once

#include <string>
#include <vector>

using namespace std;

struct group {
	vector<int> beeps;
};

struct package {
	string name;
	string filename;
	int numSentences;
	int code;
};

struct tttData {
	vector<group> groups;
	int doll;
	vector<package> basic;
	vector<package> website;
	vector<package> media;
};

