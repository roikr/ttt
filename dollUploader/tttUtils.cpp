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
#include "tttData.h"


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

void tttDumpData(tttData &data) {
	cout << "doll: " << data.doll << endl;
	for (vector<group>::iterator giter=data.groups.begin(); giter!=data.groups.end(); giter++) {
		cout << "group: ";
		for (vector<int>::iterator biter=giter->beeps.begin(); biter!=giter->beeps.end(); biter++) {
			cout << *biter << " ";
		}
		cout << endl;
	}
	
	vector<package>::iterator piter;
	
	cout << "basic: " << endl;
	for (piter=data.basic.begin(); piter!=data.basic.end(); piter++) {
		cout << "package: name: " << piter->name << ", filename: " << piter->filename << ", numSentences: " << piter->numSentences << endl;
	}
	
	cout << "website: " << endl;
	for (piter=data.website.begin(); piter!=data.website.end(); piter++) {
		cout << "package: name: " << piter->name << ", filename: " << piter->filename << ", numSentences: " << piter->numSentences << ", code: " << piter->code << endl;
	}
	
	cout << "media: " << endl;
	for (piter=data.media.begin(); piter!=data.media.end(); piter++) {
		cout << "package: name: " << piter->name << ", filename: " << piter->filename << ", numSentences: " << piter->numSentences << ", code: " << piter->code << endl;
	}
}

void tttCreateHeader(string filename,tttData &data) {
	ifstream::pos_type size = 0x400;
	
	char * memblock = new char [size];
	
	unsigned short * table = reinterpret_cast<unsigned short*> (memblock) ;
	
	memset(memblock, 0, size);
	
	for (vector<group>::iterator giter=data.groups.begin(); giter!=data.groups.end(); giter++) {
		vector<int>::iterator biter;
		for (biter=giter->beeps.begin(); biter!=giter->beeps.end(); biter++) {
			table[distance(data.groups.begin(), giter) * 10 + distance(giter->beeps.begin(), biter)] = *biter;
		}
		if (giter->beeps.size() < 10) {
			table[distance(data.groups.begin(), giter) * 10 + distance(giter->beeps.begin(), biter)] = 0xFF;
		}
			
	}	
	
	
	vector<package>::iterator piter;
	for (piter=data.website.begin(); piter!=data.website.end(); piter++) {
		table[0xC8+distance(data.website.begin(), piter)] = piter->code;
	}
	
	if (data.website.size() < 10) {
		table[0xC8+distance(data.website.begin(), piter)] = 0xFF;
	}
	
	
	for (piter=data.media.begin(); piter!=data.media.end(); piter++) {
		table[0xD2+distance(data.media.begin(), piter)] = piter->code;
	}
	
	if (data.media.size()< 10) {
		table[0xD2+distance(data.media.begin(), piter)] = 0xFF;
	}
	
	table[0x1FF] = data.doll;
	
		
	ofstream myFile (filename.c_str(),  ios::out | ios::binary);
		
	if (myFile.is_open()) {
		

		myFile.write(memblock, size);
		myFile.close();
			
	} else cout << "Unable to open header file" << endl;
	
	delete[] memblock;

}

void tttBuildContainer(tttContainer &container,tttData &data) {
	vector<package>::iterator piter;
	for (piter=data.basic.begin(); piter!=data.basic.end(); piter++) {
		cout << "package: name: " << piter->name << ", filename: " << piter->filename << ", numSentences: " << piter->numSentences << endl;
		container.addPackage(piter->filename);
	}
	for (piter=data.website.begin(); piter!=data.website.end(); piter++) {
		cout << "package: name: " << piter->name << ", filename: " << piter->filename << ", numSentences: " << piter->numSentences << ", code: " << piter->code << endl;
		container.addPackage(piter->filename);
	}
	for (piter=data.media.begin(); piter!=data.media.end(); piter++) {
		cout << "package: name: " << piter->name << ", filename: " << piter->filename << ", numSentences: " << piter->numSentences << ", code: " << piter->code << endl;
		container.addPackage(piter->filename);
	}
}