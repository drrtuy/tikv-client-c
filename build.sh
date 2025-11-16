#!/bin/bash

set -o pipefail

SCRIPT_LOCATION=$(dirname "$0")
SRC_LOCATION=$(realpath "$SCRIPT_LOCATION")
BUILD_PATH=$(realpath "$SCRIPT_LOCATION"/build)
CPUS=$(getconf _NPROCESSORS_ONLN)
INSTALL_PREFIX="/usr/"

set_cmake_flags() {
  MDB_CMAKE_FLAGS=(
      -DCMAKE_EXPORT_COMPILE_COMMANDS=1
      -DCMAKE_INSTALL_PREFIX:PATH=$INSTALL_PREFIX
      -DENABLE_TESTS=ON
      -DCMAKE_BUILD_TYPE=Debug
      -DgRPC_VERSION=1.30.2
  )
}

build_binary() {
  cd "$SRC_LOCATION"
  cmake "${MDB_CMAKE_FLAGS[@]}" -S"$SRC_LOCATION" -B"$BUILD_PATH"
  cmake --build "$BUILD_PATH" -j "$CPUS"
}

install_binary() {
  cmake --install "$BUILD_PATH"
}

set_cmake_flags

build_binary
