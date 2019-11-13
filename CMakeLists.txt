cmake_minimum_required (VERSION 2.8)
project (CMakeFunctionPointers)

#version number
set (CMakeFunctionPointers_VERSION_MAJOR 1)
set (CMakeFunctionPointers_VERSION_MINOR 0)

#indicate the entry point for the executable
add_executable (CMakeFunctionPointers  main.cpp)

install (TARGETS CMakeFunctionPointers DESTINATION bin)
