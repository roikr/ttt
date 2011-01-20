/*
 *  tttContainer.cpp
 *  dollUploader
 *
 *  Created by Roee Kremer on 1/19/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#include "tttContainer.h"
#include <assert.h>
#include <stdio.h>
#include <iostream>

void tttContainer::addPackage(string filename) {
	tttPackage p;
	bool loaded = p.loadFile(filename);
	assert(loaded);
	p.display();
	packages.push_back(p);
	
}

void tttContainer::eval() {
	
	
	sentences.clear();
	
	int numSentences = 0;
	size = 0;
	vector<tttPackage>::iterator iter;
	
	for (iter=packages.begin(); iter!=packages.end(); iter++) {
		numSentences+=iter->numSentences;
		size+=(int)(iter->size) - 4*(1+iter->numSentences);
	}
	
	
	int offset = 2*(1+numSentences);
	size+=2*offset;
	cout << "size:" << size  << ",numSentences: " << numSentences << endl;
	
	int j=0;
	int packageOffset = 0;
	
	for (iter=packages.begin(); iter!=packages.end(); iter++) {
		int start = iter->offsets[0] & 0xEFFFFFF ;
		
		for (int i=0; i < iter->numSentences ; i++) { // (*numSentences)-1
			sentence s;
			
			s.packageNum = distance(packages.begin(), iter);
			s.srcOffset = iter->offsets[i] & 0xEFFFFFF;
			s.offset = (iter->offsets[i] & 0xEFFFFFF) - start +packageOffset+offset;
			//int offset1 = ((i+1 < iter->numSentences) ?  iter->offsets[i+1] & 0xEFFFFFF  : (iter->size /2)-1;
			//cout << i+1 << ": " << offset0 << "-" << offset1 << " (" << offset0*2 << "-" << offset1*2 << ")" << endl;
			//cout << j+1 << ": " << offset0 << " (" << offset0*2 << ")" << endl;
			
			sentences.push_back(s);
			 
			j++;
		}
		packageOffset+= (int)(iter->size)/2 - 2* (1 + iter->numSentences);
		
		
		
		
	}
	
}

void tttContainer::display() {
	for (vector<sentence>::iterator iter = sentences.begin(); iter!=sentences.end(); iter++) {
		cout << "sentence: " << distance(sentences.begin(), iter) << ", package: " << iter->packageNum << ", offset: " << iter->offset  << " (" << iter->offset*2 << ")" << endl;
	}
}

void tttContainer::saveFile(string filename) {
	ofstream myFile (filename.c_str(),  ios::out | ios::binary);
	
	unsigned short space = 0;
	
	if (myFile.is_open()) {
		short numSentences = sentences.size();
		myFile.write ((char*)&numSentences, 2);
		myFile.write ((char*)&space, 2); // undefined
		
		for (vector<sentence>::iterator siter = sentences.begin(); siter!=sentences.end(); siter++) {
			signed int offset = siter->offset | 0x1000000;
			myFile.write ((char*)&offset, sizeof (unsigned int));
		}
		
		for (vector<tttPackage>::iterator piter = packages.begin(); piter!=packages.end(); piter++) {
			myFile.write ((char*)(piter->memblock+piter->dataOffset), piter->dataLength);
		}
	}
	
		
}