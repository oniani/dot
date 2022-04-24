cmake_minimum_required(VERSION 3.16)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

project(
  project
  VERSION 0.0.1
  DESCRIPTION "Description"
  HOMEPAGE_URL "https://github.com/oniani"
  LANGUAGES C CXX
)

if(NOT DEFINED COMPILER)
  set(COMPILER "clang")
endif()
string(TOLOWER ${COMPILER} COMPILER)

if(${COMPILER} STREQUAL "clang")
  message(STATUS "Compiler: clang libstdc++")
  include("cmake/toolchains/clang.cmake")
elseif(${COMPILER} STREQUAL "gcc")
  message(STATUS "Compiler: gcc libstdc++")
  include("cmake/toolchains/gcc.cmake")
else()
  message(FATAL_ERROR "Compiler: unknown")
endif()

include("cmake/tooling.cmake")

option(BUILD_EXECUTABLE "Enable building an executable" ON)
if(BUILD_EXECUTABLE)
  message(STATUS "Building an executable")
  add_executable(${PROJECT_NAME} main.cpp)
endif()

option(ENABLE_TESTING "Enable testing" ON)
if(ENABLE_TESTING)
  enable_testing()
  message(STATUS "Building tests")
  add_subdirectory(test)
endif()
