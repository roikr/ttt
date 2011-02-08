/*
 *  tttParser.cpp
 *  dollUploader
 *
 *  Created by Roee Kremer on 2/3/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#include "tttParser.h"
#include "ofxXmlSettings.h"

void parsePackage(ofxXmlSettings &xml,vector<package> &packages) {
	
	for (int j=0; j<xml.getNumTags("package"); j++) {
		package p;
		p.name = xml.getAttribute("package","name","",j);
		p.filename = xml.getAttribute("package","filename","",j);
		p.numSentences = xml.getAttribute("package","numSentences",0,j);
		p.code = xml.getAttribute("package","code",0,j);
		packages.push_back(p);
		
	}
	
}

void tttParserParse(string filename,tttData &data) {
	ofxXmlSettings xml;
	
	
	bool bLoaded = xml.loadFile(filename);
	assert(bLoaded);
	
	xml.pushTag("ttt");
	
	data.doll = xml.getValue("doll",0);
	
	xml.pushTag("groups");
	
	for (int i=0; i<xml.getNumTags("group"); i++) {
		xml.pushTag("group",i);
		group g;
		for (int j=0; j<xml.getNumTags("beep"); j++) {
			g.beeps.push_back(xml.getValue("beep",0,j));
		}
		data.groups.push_back(g);
		xml.popTag();
	}
	
	xml.popTag();
	
	xml.pushTag("basic");
	parsePackage(xml, data.basic);
	xml.popTag();
	xml.pushTag("website");
	parsePackage(xml, data.website);
	xml.popTag();
	xml.pushTag("media");
	parsePackage(xml, data.media);
	xml.popTag();
	
	xml.popTag();
	
	
}
