# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_SANITIZE_THREAD_CMAKE_)
  return()
else()
  set(POLLY_SANITIZE_THREAD_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "Clang thread sanitizer / c++11 support"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/compiler/clang.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/sanitize_thread.cmake")
