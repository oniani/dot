# Structure:
#
#   .                      -> root directory
#   ├── CMakeLists.txt     -> this file
#   ├── build              -> build directory
#   ├── lib                -> library
#   │   ├── CMakeLists.txt -> contains `add_library(lib STATIC code.cxx)`
#   │   ├── code.cxx       -> code for the library
#   │   └── code.hxx       -> header file for the library
#   └── main.cxx           -> main executable
#

# Minimum CMake version
cmake_minimum_required(VERSION 3.15 FATAL_ERROR)

# Enforce the standard
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Build mode and flags
set(CMAKE_BUILD_TYPE debug)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++20")

# Project name and version number
project(point VERSION 1.0)

# Add the main executable
add_executable(${PROJECT_NAME} main.cxx)

# Add a library
add_subdirectory(lib)
target_link_libraries(${PROJECT_NAME} PUBLIC lib)
