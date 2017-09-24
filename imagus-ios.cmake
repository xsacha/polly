# Copyright (c) 2016, Ruslan Baratov
# All rights reserved.

if(DEFINED IMAGUS_IOS_CMAKE_)
  return()
else()
  set(IMAGUS_IOS_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/../polly/utilities/polly_clear_environment_variables.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/../polly/utilities/polly_init.cmake")

set(IOS_SDK_VERSION 11.0)
set(IOS_DEPLOYMENT_SDK_VERSION 10.0)
set(POLLY_XCODE_COMPILER "clang")
polly_init(
    "iOS ${IOS_SDK_VERSION} Universal (iphoneos) / \
${POLLY_XCODE_COMPILER} / \
c++11 support"
    "Xcode"
)

include("${CMAKE_CURRENT_LIST_DIR}/../polly/utilities/polly_common.cmake")

include(polly_fatal_error)

# Fix try_compile
set(MACOSX_BUNDLE_GUI_IDENTIFIER au.com.imagus.ifacerec)
set(CMAKE_MACOSX_BUNDLE YES)

#set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "iPhone Developer")

# Verify XCODE_XCCONFIG_FILE
set(
    _polly_xcode_xcconfig_file_path
    "${CMAKE_CURRENT_LIST_DIR}/../polly/scripts/NoCodeSign.xcconfig"
)
if(NOT EXISTS "$ENV{XCODE_XCCONFIG_FILE}")
  polly_fatal_error(
      "Path specified by XCODE_XCCONFIG_FILE environment variable not found"
      "($ENV{XCODE_XCCONFIG_FILE})"
      "Use this command to set: "
      "    export XCODE_XCCONFIG_FILE=${_polly_xcode_xcconfig_file_path}"
  )
else()
  string(
      COMPARE
      NOTEQUAL
      "$ENV{XCODE_XCCONFIG_FILE}"
      "${_polly_xcode_xcconfig_file_path}"
      _polly_wrong_xcconfig_path
  )
  if(_polly_wrong_xcconfig_path)
    polly_fatal_error(
        "Unexpected XCODE_XCCONFIG_FILE value: "
        "    $ENV{XCODE_XCCONFIG_FILE}"
        "expected: "
        "    ${_polly_xcode_xcconfig_file_path}"
    )
  endif()
endif()

set(IPHONEOS_ARCHS armv7;arm64)
set(CMAKE_XCODE_ATTRIBUTE_ONLY_ACTIVE_ARCH NO)
set(CMAKE_IOS_SDK_ROOT /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer)

include("${CMAKE_CURRENT_LIST_DIR}/../polly/compiler/xcode.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/../polly/os/iphone.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/../polly/flags/cxx11.cmake")

# Adds LLVM IR to binary, that allows Apple to produce binaries for any arch
# Since Apple recompiles your app, it gets a new UUID and makes debugging more difficult
# May be required by those who use the library
#include("${CMAKE_CURRENT_LIST_DIR}/../polly/flags/bitcode.cmake")

#include("${CMAKE_CURRENT_LIST_DIR}/../polly/utilities/polly_ios_development_team.cmake")
