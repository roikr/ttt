
#include <stdio.h>
#include <assert.h>
#include "tttContainer.h"
#include "tttUtils.h"
#include "tttData.h"
#include "tttParser.h"
extern "C" {
#include "tttDownloader.h"
}
using namespace std;


int main (int argc, const char * argv[]) {
	tttDownloader downloader;

/*
// read and write single test
	
	if (downloader.detectDevice() && downloader.getDeviceInfo(true)) {
		downloader.setDoll(202);
		int code;
		downloader.getDoll(code);
	}

	return 0;
*/
	tttData data;
	tttParserParse("ttt.xml", data);
//	tttDumpData(data);
	
	tttCreateHeader("TESTOUT.BIN", data);
	
	
	
	tttContainer container;
	tttBuildContainer(container, data);

	container.eval();
	//container.display();
	
	container.saveFile("TESTOUT.BIN");
//	tttDownloader downloader;
	if (downloader.detectDevice() && downloader.getDeviceInfo(true)) {

		downloader.write("TESTOUT.BIN");
	}

	
    return 0;
}

// old

    
//	tttPackage p1;
//	bool loaded = p1.loadFile("TEST3.BIN");
//	assert(loaded);
//	p1.display();
//	p1.exit();

//	container.addPackage("HARMONIC.BIN");
//	container.addPackage("DOUBLE.BIN");
//	container.addPackage("ONECLICK.BIN");
//	container.addPackage("SITUATION.BIN");
//	for (int i=0; i<10; i++) {
//		container.addPackage("WEBSITE.BIN");
//	}
//	for (int i=0; i<10; i++) {
//		container.addPackage("MEDIA.BIN");
//	}

//tttCopyFile("PREPINK.BIN", "TEST3OUT.BIN");

	
//	tttPackage p;
//	p.loadFile("TESTOUT.BIN",true);
//	p.display();