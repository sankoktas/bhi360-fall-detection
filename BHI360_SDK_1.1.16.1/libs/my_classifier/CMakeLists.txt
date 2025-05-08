get_filename_component(LIB_KEY ${CMAKE_CURRENT_LIST_DIR} NAME)
project(${LIB_KEY} C)
FILE(GLOB SOURCES "*.c")
add_library(${LIB_KEY} STATIC ${SOURCES})
