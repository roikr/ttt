#include <stdlib.h>
#include <stdio.h>

#include "tttDownloader.h"

#define VENDOR_ID  0x1e34
#define PRODUCT_ID  0xff01

// if the following is defined, we need nlphid.dll.
// otherwise, we statically link with nlphid.lib
//#define USE_DLL
#ifdef  USE_DLL
#  define IMPORT __declspec( dllimport )
#else
# define IMPORT
#endif



// the feature buffer size is determined by the largest report size
#define FEAT_BUFFER_BYTES   (FEAT_LARGE_REPORT_SIZE)
#define FEAT_BUFFER_WORDS  ((FEAT_BUFFER_BYTES+1)/2)

#define HANDSHAKE_FLAGS 0xf000
#define PENDING_FLAG 0x8000
#define BUSY_FLAG    0x4000
#define ACK_FLAG     0x2000
#define NAK_FLAG     0x1000

#define HIGHBYTE(x)  ((x >> 8)&0xff)
#define LOWBYTE(x)   (x & 0xff)

#define HIGHWORD(x)  ((u16)(x >> 16))
#define LOWWORD(x)   ((u16)x)

//********* Command Id's for the Downloader Function **************

// the GET_INFO command currently just returns the number of flash devices supported
// by the downloader (NUM_DEVICES).  The demo version supports 2 devices (1 serial, 1 parallel)

#define USBCMD_GET_INFO          0  

// the GET_DEVICE_INFO fills in information about the specified device into 16 bytes (8 words):
// word 0: echoes the command+device+handshake flags
// word 1: type bits, TYPE_SERIAL_FLASH or TYPE_PARALLEL_FLASH, plus number of sectors in low byte
// word 2: product id of flash
// word 3: manufacturer id of flash
// word 4,5: low/high words of starting *word address* of write-able memory. typically 0 if the
//           entire flash is write-able.
// word 6,7: low/high words of last+1 *word address* of write-able memory. typically equal to
//           the number of words in the flash if the entire flash is write-able.

#define USBCMD_GET_DEVICE_INFO   1  

// the READ command reads the specified number of words into the buffer that can be read
// back by the host.  The first 8 bytes (4 words) are the read request.  Data is appended
// to the buffer starting at word offset 4.
// word 0: echoes the command+device+handshake flags
// word 1: number of words to read
// word 2/3: *word address* to start reading
// word 4..  data filled in from flash (little endian)

#define USBCMD_READ              2

// the WRITE command writes the specified number of words into flash. 
// the WRITE_WITH_ERASE command acts the same for serial flash, but for parallel flash the 
// start address will be compared against a list of sector start addresses.  If there is an
// exact match, the sector is erased before data is written.
//
// Both commands will do a verify pass after programming all of the data.  
//
// The first 8 bytes (4 words) are the write request.  Data starts at word offset 4.
// word 0: echoes the command+device+handshake flags
// word 1: number of words to write
// word 2/3: *word address* to start reading
// word 4..  data to program (little-endian)


#define USBCMD_WRITE             3
#define USBCMD_WRITE_WITH_ERASE  4

// ERASE_SECTOR command
// word 0: echoes the command+device+handshake flags
// word 1: not used
// word2/3: *word address* of the sector to be erased. (note, some devices do not require
//          this to be the starting address of the sector, but rather, any address in the sector)

#define USBCMD_ERASE_SECTOR      5

// GET_SECTOR_TABLE command
// word 0: echoes the command+device+handshake flags
// word 1: returns the number of sectors, may be zero 
// word 2/3: not used
// word 4...  sector table with 4-bytes (little-endian) per sector with the start address of the
//            sector.

#define USBCMD_GET_SECTOR_TABLE  6


// this demo version supports 2 devices:
//   0:  serial flash
//   1:  parallel flash

#define NUM_DEVICES              2


// the following type bits are used in the GET_DEVICE_INFO results

#define TYPE_SERIAL_FLASH        0x8000
#define TYPE_PARALLEL_FLASH      0x4000
#define TYPE_FLAGS_MASK          0xff00
#define TYPE_NUM_SECTORS_MASK    0x00ff


// returns 0 if device exists:
//    if able to open device and read out vendor, product and version info,
//    these values will be returned.  Otherwise they will be zero.
// returns 1 if out of devices
// returns 2 if error

extern "C" {

IMPORT LONG APIENTRY NHGetHIDDeviceInfo(DWORD dwIndex, 
   USHORT *vendorId, USHORT *productId, USHORT *versionNumber, 
   char * pathName, DWORD pathNameMaxLen);


IMPORT HANDLE APIENTRY NHOpenDevice(char * pathName);
IMPORT LONG APIENTRY NHCloseDevice(HANDLE h);

IMPORT LONG APIENTRY NHSendReport(DWORD count, UCHAR *outData, HANDLE h);
IMPORT LONG APIENTRY NHGetReport(DWORD count, UCHAR *inData, HANDLE h);

}

#define MAX_HID_DEVICE_PATHNAME_LEN 1024   // just a guess!
#define SHORT_REPORT 0
#define LONG_REPORT  1


long GetHex(char *p)
{
    long acc=0;;
    if (strlen(p)==0) return -1;
    while (*p) {
        int c;
        if ((*p >= '0') && (*p <= '9'))
            c = *p-'0';
        else if ((*p >= 'a') && (*p <= 'f'))
            c = *p-'a'+10;
        else if ((*p >= 'A') && (*p <= 'F'))
            c = *p-'A'+10;
        else return -1;

        acc = (acc << 4) + c;
        p++;
        }
    return acc;  
}

int tttDownloader::Command(int cmd, int device, int sendLongReportFlag, int getLongReportFlag, HANDLE h)
{
    long result;

    reportBuffer[0] = sendLongReportFlag ? 2 : 1;
    rdata[0] = cmd + (device << 8);

    result = NHSendReport(FEAT_LARGE_REPORT_SIZE+1, reportBuffer, h);

    if (result) return result;


    reportBuffer[0] = getLongReportFlag ? 2 : 1;
    while (1) {
        result = NHGetReport(FEAT_LARGE_REPORT_SIZE+1, reportBuffer, h);
        if (result) return result;
        if (rdata[0] & ACK_FLAG) break;
        if (!(rdata[0] & (PENDING_FLAG+BUSY_FLAG))) return -1;
        }

    return 0;
}




bool tttDownloader::detectDevice() {

	s32 dwIndex;
	s32 result;

	pathName = (unsigned char *)malloc(MAX_HID_DEVICE_PATHNAME_LEN);

    dwIndex = 0;
    while (1) {
        result = NHGetHIDDeviceInfo(
            dwIndex, &vendorId, &productId, &versionNumber, reinterpret_cast<char*>(pathName), MAX_HID_DEVICE_PATHNAME_LEN);

        if (result != 0) break;
            
        //if (vendorId && productId) {
        //   printf("%-5d %04x %04x %04x %s\n", dwIndex, vendorId, productId, versionNumber, pathName);
        //  }

        if ((vendorId == VENDOR_ID) && (productId == PRODUCT_ID)) 
            // break w/result = 0
            break;

        dwIndex++;
        }

    if (result) {
        printf("\nError: unable to find expect device, vendor = %04x, product = %04x\n", VENDOR_ID, PRODUCT_ID);
        //exit(1);
		return 0;
        }

    printf("\nUSB HID Device found, version = %d\n", versionNumber);
	bDetected = true;
	return 1;
}


bool tttDownloader::getDeviceInfo(bool info) {
	HANDLE h = INVALID_HANDLE_VALUE;
	u16 iflag= info ? 1 : 0;
	u16 nmem;
	u16 i;

	if ((h = NHOpenDevice(reinterpret_cast<char*>(pathName)))==INVALID_HANDLE_VALUE) {
        printf("\nError opening HID device\n");
		return 0;
    }

	 //***** step 2 -- get the number of memory devices *****

    if (Command(USBCMD_GET_INFO,0,SHORT_REPORT,SHORT_REPORT,h)) {
		printf("\nError: communication failed or interrupted\n");
		NHCloseDevice(h);
		return 0;	
	}

    nmem = rdata[1];

    if (nmem == 0) {
        printf("\nError: device reports no flash memories\n");
        NHCloseDevice(h);
		return 0;
    }

    if (memoryDevice >= nmem) {
        printf("\nspecified memory device index %d is too large, there are %d devices\n", memoryDevice,nmem);
        NHCloseDevice(h);
		return 0;
        }

    //***** step 3 -- for each memory, read the default start address and end address of write-able range *****
    // for -i option, print all device information

    for (i=0; i < nmem; i++) {  
        if (Command(USBCMD_GET_DEVICE_INFO,i,SHORT_REPORT,SHORT_REPORT,h)) {
			printf("\nError: communication failed or interrupted\n");
			NHCloseDevice(h);
			return 0;
		}

        devStartAddress[i] = rdata[4] + (((u32)rdata[5])<<16);
        devEndAddress[i] = rdata[6] + (((u32)rdata[7])<<16);
        if (iflag) {
            printf("memory %d\n",i);
            printf("  type_flags = 0x%04x  num_sectors = %d\n", rdata[1] & TYPE_FLAGS_MASK, rdata[1] & TYPE_NUM_SECTORS_MASK);
            printf("  mfct_id =    0x%04x  prod_id =     0x%04x\n", rdata[3], rdata[2]);
            printf("  start_adrs = 0x%08lx end_adrs = 0x%08lx\n", devStartAddress[i], devEndAddress[i]);
            printf("  size = %ld words\n", (s32)devEndAddress[i] - (s32)devStartAddress[i]);
		}
	}
	NHCloseDevice(h);
	return 1;
}

bool tttDownloader::write(string filename) {
	HANDLE h = INVALID_HANDLE_VALUE;   
    
    u32 bSize,wSize,wIndex;

	if ((h = NHOpenDevice(reinterpret_cast<char*>(pathName)))==INVALID_HANDLE_VALUE) {
        printf("\nError opening HID device\n");
		return 0;
   }
    
   
	
	u32 startAddress = devStartAddress[memoryDevice];

    // verify that start address is < end address

    if (startAddress >= devEndAddress[memoryDevice]) {
        printf("\nError: start address (0x%08lx) exceeds or equals end address (0x%08lx)\n", startAddress, devEndAddress[memoryDevice]);
		NHCloseDevice(h);
		return 0;
    }
   

    //****** step 4 -- Writing *****
    //  a) open the input file
    //  b) get it's size in bytes
    //  c) make sure there is enough room in flash for the data
    //  d) write the data 512 words at a time


    FILE *fin = fopen(filename.c_str(), "rb"); // argv[argc-1]

    if (!fin) {
		printf("\nError: unable to open input file %s\n", filename.c_str());
        NHCloseDevice(h);
		return 0;
    }

    fseek(fin,0,SEEK_END);
    bSize = ftell(fin);
    rewind(fin);

    if (bSize == 0) {
        printf("\nError: null file\n");
        NHCloseDevice(h);
		return 0;
    }

    // convert file size to words and allocate buffer

    wSize = (bSize+1)/2;

    // see if enough room in flash

    if ((devEndAddress[memoryDevice]-startAddress) < wSize) {
        printf("\nError: insufficient flash memory for file.\n");
        printf("File size is %ld words, available room in flash is %ld words\n", wSize,devEndAddress[memoryDevice]-startAddress);
        printf("Flash programming start address = 0x%08lx\n", startAddress);
        printf("Flash programming end address = 0x%08lx\n", devEndAddress[memoryDevice]);
        fclose(fin);
        NHCloseDevice(h);
		return 0;
        }

    printf("\nWriting %ld (0x%08lx) words to memory device %d...\n", wSize, wSize, memoryDevice);

    wIndex = 0;
    while (wIndex < wSize) {
        u32 wcnt = wSize - wIndex;
        if (wcnt > MAX_BLOCK_WORDS) wcnt = MAX_BLOCK_WORDS;
        rdata[1] = (u16)wcnt;
        rdata[2] = LOWWORD(startAddress);
        rdata[3] = HIGHWORD(startAddress);
        rdata[4+wcnt-1] = 0;  // in case last thing read from file is only a single byte
        fread(&rdata[4], sizeof(u16), wcnt, fin);
        if (Command(USBCMD_WRITE_WITH_ERASE,memoryDevice,LONG_REPORT,SHORT_REPORT,h)) {
            fclose(fin);
            printf("\nError: communication failed or interrupted\n");
			NHCloseDevice(h);
			return 0;
            }
        wIndex += wcnt;
        startAddress += wcnt;

        printf("\r%c",'%');
        printf("%3d", (int)((100*wIndex+wSize/2)/wSize));
        }

    fclose(fin);
    printf("\ndone\n");
     

	NHCloseDevice(h);
	return 1;
}

bool tttDownloader::setDoll(int code) {
	HANDLE h = INVALID_HANDLE_VALUE;  

	if ((h = NHOpenDevice(reinterpret_cast<char*>(pathName)))==INVALID_HANDLE_VALUE) {
        printf("\nError opening HID device\n");
		return 0;
   }

	u32 startAddress = devStartAddress[memoryDevice]+0x1FF;
   
    rdata[1] = (u16)1;
    rdata[2] = LOWWORD(startAddress);
    rdata[3] = HIGHWORD(startAddress);
    rdata[4] = (u16)code;

	if (Command(USBCMD_WRITE_WITH_ERASE,memoryDevice,LONG_REPORT,SHORT_REPORT,h)) {
        printf("\nError: communication failed or interrupted\n");
		NHCloseDevice(h);
		return 0;
    }

   
 
	NHCloseDevice(h);
	return 1;
}


bool tttDownloader::getDoll(int &code) {
	HANDLE h = INVALID_HANDLE_VALUE;  

	if ((h = NHOpenDevice(reinterpret_cast<char*>(pathName)))==INVALID_HANDLE_VALUE) {
        printf("\nError opening HID device\n");
		return 0;
   }

	u32 startAddress = devStartAddress[memoryDevice]+0x1FF;
   
    rdata[1] = (u16)1;
    rdata[2] = LOWWORD(startAddress);
    rdata[3] = HIGHWORD(startAddress);
    rdata[4] = 0xabcd;
    if (Command(USBCMD_READ,memoryDevice,SHORT_REPORT,LONG_REPORT,h)) {
        printf("\nError: communication failed or interrupted\n");
		NHCloseDevice(h);
		return 0;
    }
       
	code = rdata[4];
	printf("\ndoll: %i\n",code);
	
	NHCloseDevice(h);
	return 1;
}

int tttDownloader::nlpdltest(char * filename) 
{
    int argc = 2;
	char **argv;
	//argv = filename.c_str();

	HANDLE h = INVALID_HANDLE_VALUE;   
    
    
    
    u16 iflag=0;
    u16 memoryDevice=0;
    u32 startAddress = (u32)-1;
    u32 readCount = (u32)-1;
    u16 i;
    u16 nmem;
    u32 bSize,wSize,wIndex,rSize,rIndex;


	/*
    if (argc < 2) {
        printf("nlpdltest -i\n");
        printf("  or\n");
        printf("nlpdltest [-m#] [-a#] [-r#] <file.bin>\n\n");
        printf("-i  print information about available flash memories\n");
        printf("-m# specify memory device index, 0-3, default is 0\n");
        printf("-a# specify start word address in hex, default is start\n");
        printf("    address reported by the device for the specified memory\n");
        printf("-r[#] read specfied number of words, default is write\n");
        printf("    if no hex number is included with -r switch, or if it is 0,\n");
        printf("    then the entire flash is read starting from the specified \n");
        printf("    (or default) start address.\n");
        printf("    the specified memory\n");
        exit(1);
        }

    if (argc == 2) {
        if (strcmp(argv[1],"-i")==0) {
            iflag=1;
            }
        }

    if (!iflag) {
        for (i=1; i < argc-1; i++) {
            if (strncmp(argv[i],"-m",2)==0) {
                if ((argv[i][2] < '0') || (argv[i][2] > '3')) {
                    printf("\nError: expected digit 0-3 after -m switch\n");
                    exit(1);    
                    }
                memoryDevice = argv[i][2]-'0';
                printf("memory device %d\n", memoryDevice);
                }
            else if (strncmp(argv[i],"-a",2)==0) {
                if ((startAddress = GetHex(argv[i]+2))==-1) {
                    printf("\nError: expected hex number after -a switch\n");
                    exit(1);
                    }
                printf("start address = 0x%08lx\n", startAddress);
                }
            else if (strncmp(argv[i],"-r",2)==0) {
                if (argv[i][2]==0) 
                    readCount = 0;  // read entire flash
                else {
                    if ((readCount = GetHex(argv[i]+2))==-1) {
                        printf("\nError: expected hex number after -r switch\n");
                        exit(1);
                        }
                    }
                }
            }
        }

	*/

    detectDevice();

    //***** step 1 -- open the device *****

    if ((h = NHOpenDevice(reinterpret_cast<char*>(pathName)))==INVALID_HANDLE_VALUE) {
        printf("\nError opening HID device\n");
        //exit(1);
		return 0;
        }
    
    //***** step 2 -- get the number of memory devices *****

    if (Command(USBCMD_GET_INFO,0,SHORT_REPORT,SHORT_REPORT,h)) goto ErrorExit1;
    nmem = rdata[1];

    if (nmem == 0) {
        printf("\nError: device reports no flash memories\n");
        goto ErrorExit2;
        }

    if (memoryDevice >= nmem) {
        printf("\nspecified memory device index %d is too large, there are %d devices\n", memoryDevice,nmem);
        goto ErrorExit2;
        }

    //***** step 3 -- for each memory, read the default start address and end address of write-able range *****
    // for -i option, print all device information

    for (i=0; i < nmem; i++) {  
        if (Command(USBCMD_GET_DEVICE_INFO,i,SHORT_REPORT,SHORT_REPORT,h)) goto ErrorExit1; 
        devStartAddress[i] = rdata[4] + (((u32)rdata[5])<<16);
        devEndAddress[i] = rdata[6] + (((u32)rdata[7])<<16);
        if (iflag) {
            printf("memory %d\n",i);
            printf("  type_flags = 0x%04x  num_sectors = %d\n", rdata[1] & TYPE_FLAGS_MASK, rdata[1] & TYPE_NUM_SECTORS_MASK);
            printf("  mfct_id =    0x%04x  prod_id =     0x%04x\n", rdata[3], rdata[2]);
            printf("  start_adrs = 0x%08lx end_adrs = 0x%08lx\n", devStartAddress[i], devEndAddress[i]);
            printf("  size = %ld words\n", (s32)devEndAddress[i] - (s32)devStartAddress[i]);
            }
        }
    if (iflag) goto Exit;  // -i: done

    // if start address not specified on command line, set it to default start address

    if (startAddress == (u32)-1) startAddress = devStartAddress[memoryDevice];

    // verify that start address is < end address

    if (startAddress >= devEndAddress[memoryDevice]) {
        printf("\nError: start address (0x%08lx) exceeds or equals end address (0x%08lx)\n",
            startAddress, devEndAddress[memoryDevice]);
        goto ErrorExit2;
        }

    if (readCount == (u32)-1) {

        //****** step 4 -- Writing *****
        //  a) open the input file
        //  b) get it's size in bytes
        //  c) make sure there is enough room in flash for the data
        //  d) write the data 512 words at a time


        FILE *fin = fopen(filename, "rb"); // argv[argc-1]

        if (!fin) {
            printf("\nError: unable to open input file %s\n", argv[argc-1]);
            goto ErrorExit2;
            }

        fseek(fin,0,SEEK_END);
        bSize = ftell(fin);
        rewind(fin);

        if (bSize == 0) {
            printf("\nError: null file\n");
            goto ErrorExit2;
            }

        // convert file size to words and allocate buffer

        wSize = (bSize+1)/2;

        // see if enough room in flash

        if ((devEndAddress[memoryDevice]-startAddress) < wSize) {
            printf("\nError: insufficient flash memory for file.\n");
            printf("File size is %ld words, available room in flash is %ld words\n", wSize,devEndAddress[memoryDevice]-startAddress);
            printf("Flash programming start address = 0x%08lx\n", startAddress);
            printf("Flash programming end address = 0x%08lx\n", devEndAddress[memoryDevice]);
            fclose(fin);
            goto ErrorExit2;
            }

        printf("\nWriting %ld (0x%08lx) words to memory device %d...\n", wSize, wSize, memoryDevice);

        wIndex = 0;
        while (wIndex < wSize) {
            u32 wcnt = wSize - wIndex;
            if (wcnt > MAX_BLOCK_WORDS) wcnt = MAX_BLOCK_WORDS;
            rdata[1] = (u16)wcnt;
            rdata[2] = LOWWORD(startAddress);
            rdata[3] = HIGHWORD(startAddress);
            rdata[4+wcnt-1] = 0;  // in case last thing read from file is only a single byte
            fread(&rdata[4], sizeof(u16), wcnt, fin);
            if (Command(USBCMD_WRITE_WITH_ERASE,memoryDevice,LONG_REPORT,SHORT_REPORT,h)) {
                fclose(fin);
                goto ErrorExit1;
                }
            wIndex += wcnt;
            startAddress += wcnt;

            printf("\r%c",'%');
            printf("%3d", (int)((100*wIndex+wSize/2)/wSize));
            }

        fclose(fin);
        printf("\ndone\n");
        }

    else {
        //****** step 4 -- Reading *****
       
        FILE *fout = fopen(argv[argc-1], "wb");
        rSize = devEndAddress[memoryDevice]-startAddress;

        if (!fout) {
            printf("\nError: unable to open output file %s\n", argv[argc-1]);
            goto ErrorExit2;
            }

        if (readCount != 0) {
            if (readCount <= rSize) 
                rSize = readCount;
            else 
                printf("\nWarning: specified read count exceeds available flash address range, reading %d words\n", rSize);
            }

        printf("\nReading %ld (0x%08lx) words from memory device %d...\n", rSize, rSize, memoryDevice);
       
        
        rIndex = 0;
        while (rIndex < rSize) {
            u32 rcnt = rSize - rIndex;
            if (rcnt > MAX_BLOCK_WORDS) rcnt =  MAX_BLOCK_WORDS;
            rdata[1] = (u16)rcnt;
            rdata[2] = LOWWORD(startAddress);
            rdata[3] = HIGHWORD(startAddress);
            rdata[4] = 0xabcd;
            if (Command(USBCMD_READ,memoryDevice,SHORT_REPORT,LONG_REPORT,h)) {
                fclose(fout);
                goto ErrorExit1;
                }
            fwrite(&rdata[4], sizeof(u16), rcnt, fout);
            rIndex += rcnt;
            startAddress += rcnt;
            printf("\r%c",'%');
            printf("%3d", (int)((100*rIndex+rSize/2)/rSize));

            }
        
        fclose(fout);   
        printf("\ndone\n");
        }
     

Exit:
    NHCloseDevice(h);
    //return 0;
	return 1;
    
ErrorExit1:
    printf("\nError: communication failed or interrupted\n");
ErrorExit2:
    NHCloseDevice(h);
   // exit(1);
	return 0;

}


