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
	tttDumpData(data);
	
	tttCreateHeader("TESTOUT.BIN", data);
	
	tttContainer container;
	container.addPackage("TEST1.BIN");
	container.addPackage("TEST2.BIN");
	container.eval();
	container.display();
	//tttCopyFile("PREPINK.BIN", "TEST3OUT.BIN");
	container.saveFile("TESTOUT.BIN");
	
	tttPackage p;
	p.loadFile("TESTOUT.BIN",true);
	p.display();
	
    return 0;
}
