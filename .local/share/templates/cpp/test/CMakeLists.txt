find_package(Catch2 REQUIRED)

add_library(catch_main OBJECT catch_main.cpp)
target_link_libraries(catch_main PUBLIC Catch2::Catch2)

add_executable(foo foo.cpp)
target_link_libraries(foo PRIVATE catch_main)

add_executable(bar bar.cpp)
target_link_libraries(bar PRIVATE catch_main)

add_executable(baz baz.cpp)
target_link_libraries(baz PRIVATE catch_main)
