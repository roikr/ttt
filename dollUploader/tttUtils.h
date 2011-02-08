/*
 *  tttUtils.h
 *  dollUploader
 *
 *  Created by Roee Kremer on 1/25/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#pragma once

#include <string>
#include "tttData.h"
#include "tttContainer.h"

using namespace std;

void tttCopyFile(string src,string dest);
void tttCreateHeader(string filename,tttData &data);
void tttDumpData(tttData &data);
void tttBuildContainer(tttContainer &container,tttData &data);