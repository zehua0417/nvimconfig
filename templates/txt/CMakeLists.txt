# 设置CMake的最低版本要求
cmake_minimum_required(VERSION 3.10)

# 设置项目名称
project(YourProjectName)

# 设置可执行文件的输出路径
set(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/bin)

# 设置源文件的目录
aux_source_directory(src SRC_LIST)

# 设置头文件的目录
include_directories(include)

# 设置目标可执行文件
add_executable(main.bin ${SRC_LIST})
target_compile_options(main.bin PUBLIC -g)

# 设置目标对象文件的输出路径
set_target_properties(main.bin PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/bin
    LIBRARY_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/bin
    #ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/obj
)
