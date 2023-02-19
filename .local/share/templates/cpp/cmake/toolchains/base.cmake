string(
  JOIN " " CMAKE_CXX_FLAGS
  "${CMAKE_CXX_FLAGS}"
  -Wall
  -Wextra
  -Wshadow
  -Wnon-virtual-dtor
  -pedantic
)

string(
  JOIN " " CMAKE_CXX_FLAGS_DEBUG
  "${CMAKE_CXX_FLAGS_DEBUG}"
  -fsanitize=address,undefined
  -fstack-protector-strong
)

string(
  JOIN " " CMAKE_EXE_LINKER_FLAGS
  "${CMAKE_EXE_LINKER_FLAGS}"
  -fuse-ld=lld
)
