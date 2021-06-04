# Structure:
#
#  .                      -> root directory
#  ├── CMakeLists.txt     -> this file
#  ├── build              -> build directory
#  ├── main.cxx           -> main executable
#  ├── src                -> source code
#  │   ├── CMakeLists.txt -> empty file
#  │   ├── code.cxx       -> code for the library
#  │   └── code.hxx       -> header file for the library
#  └── third_party        -> third party libraries
#

# Minimum CMake version
cmake_minimum_required(VERSION 3.15 FATAL_ERROR)

# Enforce the standard
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Build mode and flags
set(CMAKE_BUILD_TYPE debug)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++20")

# Generate `compile_commands.json`
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Project name and version number
project(project VERSION 1.0)

# Add the source directory
add_subdirectory(src)

# Include the third party libraries
include_directories(third_party)

# Add the main executable
add_executable(${PROJECT_NAME} main.cxx)

# Recursively collect all source and header files
file(GLOB_RECURSE FILES *.cxx *.hxx)

# `clang-format` integration
find_program(CLANG_FORMAT "clang-format")
if(CLANG_FORMAT)
  add_custom_target(
    clang-format
    COMMAND ${CLANG_FORMAT} -i -style=google ${FILES}
  )
endif()

# `clang-tidy` integration
find_program(CLANG_TIDY "clang-tidy")
if(CLANG_TIDY)
  set(CMAKE_CXX_CLANG_TIDY clang-tidy -checks=-*,readability-*)
endif()

# `cppcheck` integration
find_program(CPP_CHECK "cppcheck")
if(CPP_CHECK)
  add_custom_target(
    cppcheck
    COMMAND ${CPP_CHECK}
    --enable=information,missingInclude,performance,portability,warning
    --std=c++20
    --template="[{severity}][{id}] {message} {callstack} \(at {file}:{line}\)"
    --verbose
    ${FILES}
  )
endif()
