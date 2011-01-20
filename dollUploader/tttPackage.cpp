/*
 *  package.cpp
 *  dollUploader
 *
 *  Created by Roee Kremer on 1/19/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#include "tttPackage.h"

#include <stdio.h>
#include <iostream>


void dump_word(short word) {
	cout << "dec: " << dec << word <<  ", hex: " << hex << word << "\n";
}


void dump_memory(short *start,int start16B,int end16B) {
	
	cout << hex << start16B << ": ";
	
	for (int i=start16B; i<end16B; i++) {
		if (!( i % 16)) {
			cout << endl << i << ": ";
		}
		cout << *(start+i) << " ";
	}
	cout <<endl;
}



bool tttPackage::loadFile(string filename) {
	
	
	ifstream myfile(filename.c_str(),ios::in|ios::binary|ios::ate);
	
	if (myfile.is_open()) {
		size = myfile.tellg();
		
		
		memblock = new char [size];
		myfile.seekg (0, ios::beg);
		myfile.read (memblock, size);
		myfile.close();
		
		numSentences = *reinterpret_cast<short*> (memblock) ;
		

		
		offsets = reinterpret_cast< signed int*> (memblock+4) ;
		
		dataOffset = (offsets[0] & 0xEFFFFFF)*2;
		dataLength = (int)(size) - 4*(1+numSentences);
		
		cout << "name: " << filename << ", size:" << size  << ", numSentences: " << numSentences << ", dataStart: " << dataOffset << ", dataLength: " << dataLength << endl;
		
		return true;
	} else 
		cout << "Unable to open file";
	
	return false;
		
}


void tttPackage::display() {
			
	for (int i=0; i < numSentences ; i++) { // (*numSentences)-1
		int offset0 = offsets[i] & 0xEFFFFFF;
		int offset1 = ((i+1 < numSentences) ?  offsets[i+1] & 0xEFFFFFF  : size/2)-1;
		cout << i+1 << ": " << offset0 << "-" << offset1 << " (" << offset0*2 << "-" << offset1*2 << ")" << endl;
		//cout << dec << i+1 << ": " << (offset0 & 0xEFFFFFF) << " " << hex << (offsets[i] & 0xEFFFFFF) << endl;
	}
	
}

void tttPackage::exit() {
	delete[] memblock;
}
