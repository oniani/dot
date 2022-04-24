include("${CMAKE_CURRENT_LIST_DIR}/base.cmake")

set(PROJECT_TEMPLATE_CXX_COMPILER_MINIMUM_VERSION 14)

set(CMAKE_C_COMPILER "clang")
set(CMAKE_CXX_COMPILER "clang++")

set(CMAKE_AR "llvm-ar")
set(CMAKE_RANLIB "llvm-ranlib")

string(
  JOIN " " CMAKE_CXX_FLAGS_RELEASE
  "${CMAKE_CXX_FLAGS_RELEASE}"
  -fno-sanitize=cfi-unrelated-cast # Catch2 does not properly support cfi
)
