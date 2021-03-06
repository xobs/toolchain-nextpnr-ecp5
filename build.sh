#!/bin/bash
##################################
#   Icestorm toolchain builder   #
##################################
set -e
# Set english language for propper pattern matching
export LC_ALL=C

# Generate toolchain-icestorm-arch-ver.tar.gz from source code
# sources: http://www.clifford.at/icestorm/

export VERSION="${TRAVIS_TAG}"

# -- Target architectures
export ARCH=$1
TARGET_ARCHS="linux_x86_64 linux_i686 linux_armv7l linux_aarch64 darwin"

# -- Toolchain name
export NAME=nextpnr-ecp5

# -- Debug flags
INSTALL_DEPS=1
COMPILE_NEXTPNR_ECP5=1
CREATE_PACKAGE=1

# -- Store current dir
export WORK_DIR=$PWD
# -- Folder for building the source code
export BUILDS_DIR=$WORK_DIR/_builds
# -- Folder for storing the generated packages
export PACKAGES_DIR=$WORK_DIR/_packages
# --  Folder for storing the source code from github
export UPSTREAM_DIR=$WORK_DIR/_upstream

# -- Create the build directory
mkdir -p $BUILDS_DIR
# -- Create the packages directory
mkdir -p $PACKAGES_DIR
# -- Create the upstream directory and enter into it
mkdir -p $UPSTREAM_DIR

# -- Fix broken Homebrew on Darwin
# https://github.com/Homebrew/legacy-homebrew/issues/29938#issuecomment-54896169
# export PATH=/usr/local/opt/qt5/bin:$PATH

# -- Test script function
function test_bin {
  . $WORK_DIR/test/test_bin.sh $1
  if [ $? != "0" ]; then
    exit 1
  fi
}

# -- Print function
function print {
  echo ""
  echo $1
  echo ""
}

# -- Check ARCH
if [[ $# > 1 ]]; then
  echo ""
  echo "Error: too many arguments"
  exit 1
fi

if [[ $# < 1 ]]; then
  echo ""
  echo "Usage: bash build.sh TARGET"
  echo ""
  echo "Targets: $TARGET_ARCHS"
  exit 1
fi

if [[ $ARCH =~ [[:space:]] || ! $TARGET_ARCHS =~ (^|[[:space:]])$ARCH([[:space:]]|$) ]]; then
  echo ""
  echo ">>> WRONG ARCHITECTURE \"$ARCH\""
  exit 1
fi

echo ""
echo ">>> ARCHITECTURE \"$ARCH\""

# -- Directory for compiling the tools
export BUILD_DIR=$BUILDS_DIR/build_$ARCH

# -- Directory for installation the target files
export PACKAGE_DIR=$PACKAGES_DIR/build_$ARCH

# --------- Instal dependencies ------------------------------------
if [ $INSTALL_DEPS == "1" ]; then

  print ">> Install dependencies"
  . $WORK_DIR/scripts/install_dependencies.sh

fi

# -- Create the build dir
mkdir -p $BUILD_DIR

# -- Create the package folders
mkdir -p $PACKAGE_DIR/$NAME/bin
mkdir -p $PACKAGE_DIR/$NAME/share

# --------- Compile nextpnr ------------------------------------
if [ $COMPILE_NEXTPNR_ECP5 == "1" ]; then

  print ">> Compile nextpnr-ecp5"
  $WORK_DIR/scripts/compile-nextpnr-ecp5.sh

fi

# --------- Create the package -------------------------------------
if [ $CREATE_PACKAGE == "1" ]; then

  print ">> Create package"
  . $WORK_DIR/scripts/create_package.sh

fi
