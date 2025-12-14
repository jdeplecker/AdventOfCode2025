cmake_minimum_required(VERSION 3.13)
project(day09)
set(CMAKE_CXX_STANDARD 23)

set(SOURCE_FILES part1.cpp
        part2.cpp
)

# Add executable target with source files listed in SOURCE_FILES variable
add_executable(day09 ${SOURCE_FILES})