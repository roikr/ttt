#include <stdio.h>
#include <assert.h>
#include "tttContainer.h"

using namespace std;


int main (int argc, const char * argv[]) {
    
//	tttPackage p1;
//	bool loaded = p1.loadFile("TEST3.BIN");
//	assert(loaded);
//	p1.display();
//	p1.exit();
	
	tttContainer container;
	container.addPackage("TEST3.BIN");
	container.addPackage("TEST3.BIN");
	container.eval();
	container.display();
	container.saveFile("MYTEST.BIN");
	
	tttPackage p;
	p.loadFile("MYTEST.BIN");
	p.display();
    return 0;
}
