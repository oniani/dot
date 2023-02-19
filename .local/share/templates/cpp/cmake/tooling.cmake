file(GLOB_RECURSE CXX_FILES ${PROJECT_SOURCE_DIR}/include/*.hpp)

find_program(CLANG_FORMAT clang-format)
if(CLANG_FORMAT)
  message(STATUS "Tooling: clang-format has been found")
  add_custom_target(format COMMAND ${CLANG_FORMAT} -i -style=file:../.clang-format ${CXX_FILES})
endif()

find_program(CLANG_TIDY clang-tidy)
if(CLANG_TIDY)
  message(STATUS "Tooling: clang-tidy has been found")
  add_custom_target(tidy COMMAND ${CLANG_TIDY} --config-file=../.clang-tidy ${CXX_FILES})
endif()

find_program(CPP_CHECK cppcheck)
if(CPP_CHECK)
  message(STATUS "Tooling: cppcheck has been found")
  add_custom_target(check COMMAND ${CPP_CHECK} ${CXX_FILES})
endif()
