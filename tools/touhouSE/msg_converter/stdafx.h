
#pragma once

#include <iostream>
#include <vector>
#include <string>
#include <fstream>

#include <boost/utility.hpp>
#include <boost/shared_ptr.hpp>
#include <boost/enable_shared_from_this.hpp>
#include <boost/assign.hpp>
#include <boost/foreach.hpp>
#include <boost/iostreams/stream.hpp>
#include <boost/filesystem.hpp>
#include <boost/filesystem/fstream.hpp>
#include <boost/format.hpp>

#define NOMINMAX
#include <Windows.h>
#include <Shlwapi.h>
#pragma comment(lib, "Shlwapi.lib")

#define PRINT_MSG_ERROR 1

typedef struct data_list{
  char fn[100];
  unsigned int size;
  unsigned int comp_size;
  unsigned int addr;
}LIST;

#include "../touhouSE_src/utility.h"
#include "../touhouSE_src/container_sink.h"
#include "../touhouSE_src/msg.h"
#include "../touhouSE_src/th11_utility.h"
