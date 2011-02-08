
#include <stdio.h>
#include <assert.h>
#include "tttContainer.h"
#include "tttUtils.h"
#include "tttData.h"
#include "tttParser.h"

using namespace std;


int main (int argc, const char * argv[]) {
    
//	tttPackage p1;
//	bool loaded = p1.loadFile("TEST3.BIN");
//	assert(loaded);
//	p1.display();
//	p1.exit();
	
	
	
	tttData data;
	tttParserParse("ttt.xml", data);
//	tttDumpData(data);
	
	tttCreateHeader("TESTOUT.BIN", data);
	
	
	
	tttContainer container;
	tttBuildContainer(container, data);
	//container.addPackage("HARMONIC.BIN");
//	container.addPackage("DOUBLE.BIN");
//	container.addPackage("ONECLICK.BIN");
//	container.addPackage("SITUATION.BIN");
//	for (int i=0; i<10; i++) {
//		container.addPackage("WEBSITE.BIN");
//	}
//	for (int i=0; i<10; i++) {
//		container.addPackage("MEDIA.BIN");
//	}
	container.eval();
	//container.display();
	//tttCopyFile("PREPINK.BIN", "TEST3OUT.BIN");
	container.saveFile("TESTOUT.BIN");
	
//	tttPackage p;
//	p.loadFile("TESTOUT.BIN",true);
//	p.display();
	
    return 0;
}
