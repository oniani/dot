find_package(Catch2 REQUIRED)

add_library(catch_main OBJECT catch_main.cpp)
target_link_libraries(catch_main PUBLIC Catch2::Catch2)

add_executable(tests tests.cpp)
target_link_libraries(tests PRIVATE catch_main)
