#pragma once


#include <string>
#include <windows.h>
using namespace std;

#define MAX_BLOCK_WORDS    512 
#define FEAT1_REPORT_SIZE 16
#define FEAT2_REPORT_SIZE (MAX_BLOCK_WORDS*2+8)
#define FEAT_SMALL_REPORT_SIZE  16
#define FEAT_LARGE_REPORT_SIZE  (MAX_BLOCK_WORDS*2+8)

#define u08 unsigned char
#define u16 unsigned short
#define u32 unsigned long
#define s16 short
#define s32 long

class tttDownloader {
public:
	tttDownloader() : bDetected(false),rdata((u16*)&reportBuffer[1]),memoryDevice(0) {};
	bool detectDevice();
	bool getDeviceInfo(bool info);
	bool write(string filename);
	bool setDoll(int code);
	bool getDoll(int &code);

private: 
	bool bDetected;
	u16 vendorId, productId, versionNumber;
    u08 *pathName;

	// buffer for sending/receiving feature reports
	// it should be 1 byte more than the actual report payload because the HID API wants the 
	// report ID included as the first byte.  
	// most of the payload is handled as u16's 
	u08 reportBuffer[FEAT_LARGE_REPORT_SIZE+1];
	u16 *rdata;

	// default start/end addresses reported by device for up-to-4 flash memories
	u32 devStartAddress[4];
	u32 devEndAddress[4];

	u16 memoryDevice;

	int Command(int cmd, int device, int sendLongReportFlag, int getLongReportFlag, HANDLE h);

	int nlpdltest(char * filename);
};

