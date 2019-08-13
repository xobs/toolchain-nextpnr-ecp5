# Install dependencies script

BOOST="libboost-dev libboost-filesystem-dev libboost-thread-dev libboost-program-options-dev libboost-python-dev libboost-iostreams-dev libboost-system-dev libboost-chrono-dev libboost-date-time-dev libboost-atomic-dev libboost-regex-dev"
BOOST_ARM64="libboost-dev:arm64 libboost-filesystem-dev:arm64 libboost-thread-dev:arm64 libboost-program-options-dev:arm64 libboost-python-dev:arm64 libboost-iostreams-dev:arm64 libboost-system-dev:arm64 libboost-chrono-dev:arm64 libboost-date-time-dev:arm64 libboost-atomic-dev:arm64 libboost-regex-dev:arm64"
BOOST_ARMHF="libboost-dev:armhf libboost-filesystem-dev:armhf libboost-thread-dev:armhf libboost-program-options-dev:armhf libboost-python-dev:armhf libboost-iostreams-dev:armhf libboost-system-dev:armhf libboost-chrono-dev:armhf libboost-date-time-dev:armhf libboost-atomic-dev:armhf libboost-regex-dev:armhf"

if [ $ARCH == "linux_x86_64" ]; then
  sudo apt-get install -y build-essential bison flex libreadline-dev \
                          gawk tcl-dev libffi-dev git mercurial graphviz \
                          xdot pkg-config python3.5-dev qt5-default libqt5opengl5-dev $BOOST \
                          gcc-5 g++-5 libeigen3-dev qtbase5-dev libpython3.5-dev
  sudo apt-get autoremove -y
  sudo update-alternatives \
    --install /usr/bin/gcc gcc /usr/bin/gcc-5 60 \
    --slave /usr/bin/g++ g++ /usr/bin/g++-5
  gcc --version
  g++ --version
fi

if [ $ARCH == "linux_i686" ]; then
  sudo apt-get install -y build-essential bison flex libreadline-dev \
                          gawk tcl-dev libffi-dev git mercurial graphviz \
                          xdot pkg-config python3.5-dev qt5-default libqt5opengl5-dev $BOOST \
                          gcc-5-multilib g++-5-multilib libeigen3-dev qtbase5-dev libpython3.5-dev
  sudo ln -s /usr/include/asm-generic /usr/include/asm
  ln -s /usr/include/x86_64-linux-gnu/zconf.h /usr/include
  sudo apt-get autoremove -y
  sudo update-alternatives \
    --install /usr/bin/gcc gcc /usr/bin/gcc-5 60 \
    --slave /usr/bin/g++ g++ /usr/bin/g++-5
  gcc --version
  g++ --version
fi

if [ $ARCH == "linux_armv7l" ]; then
  sudo apt-get install -y build-essential bison flex libreadline-dev \
                          gawk tcl-dev libffi-dev git mercurial graphviz \
                          xdot pkg-config python3.5-dev:armhf qt5-default:armhf libqt5opengl5-dev:armhf $BOOST_ARMHF \
                          gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf \
                          binfmt-support qemu-user-static libeigen3-dev:armhf qtbase5-dev:armhf libpython3.5-dev:armhf
  sudo apt-get autoremove -y
  ln -s /usr/include/x86_64-linux-gnu/zconf.h /usr/include
  arm-linux-gnueabihf-gcc --version
  arm-linux-gnueabihf-g++ --version
fi

if [ $ARCH == "linux_aarch64" ]; then
  sudo apt-get install -y build-essential bison flex libreadline-dev \
                          gawk tcl-dev libffi-dev git mercurial graphviz \
                          xdot pkg-config python3.5-dev:arm64 qt5-default:arm64 libqt5opengl5-dev:arm64 $BOOST_ARM64 \
                          gcc-aarch64-linux-gnu g++-aarch64-linux-gnu \
                          binfmt-support qemu-user-static libeigen3-dev:arm64 qtbase5-dev:arm64 libpython3.5-dev:arm64
  sudo apt-get autoremove -y
  ln -s /usr/include/x86_64-linux-gnu/zconf.h /usr/include
  aarch64-linux-gnu-gcc --version
  aarch64-linux-gnu-g++ --version
fi

if [ $ARCH == "windows_x86" ]; then
  sudo apt-get install -y build-essential bison flex libreadline-dev \
                          gawk tcl-dev libffi-dev git mercurial graphviz \
                          xdot pkg-config python3.5-dev qt5-default libqt5opengl5-dev $BOOST \
                          gcc-5-mingw-w64 gc++-5-mingw-w64 wine libeigen3-dev qtbase5-dev libpython3.5-dev
                          #mingw-w64 mingw-w64-tools
  sudo apt-get autoremove -y
  ln -s /usr/include/x86_64-linux-gnu/zconf.h /usr/include
  sudo update-alternatives \
    --install /usr/bin/i686-w64-mingw32-gcc i686-w64-mingw32-gcc /usr/bin/i686-w64-mingw32-gcc-5 60 \
    --slave /usr/bin/i686-w64-mingw32-g++ i686-w64-mingw32-g++ /usr/bin/i686-w64-mingw32-g++-5
  i686-w64-mingw32-gcc --version
  i686-w64-mingw32-g++ --version
fi

if [ $ARCH == "windows_amd64" ]; then
  sudo apt-get install -y build-essential bison flex libreadline-dev \
                          gawk tcl-dev libffi-dev git mercurial graphviz \
                          xdot pkg-config python3.5-dev qt5-default libqt5opengl5-dev $BOOST \
                          gcc-5-mingw-w64 gc++-5-mingw-w64 wine libeigen3-dev qtbase5-dev libpython3.5-dev
                          #mingw-w64 mingw-w64-tools
  sudo apt-get autoremove -y
  ln -s /usr/include/x86_64-linux-gnu/zconf.h /usr/include
  sudo update-alternatives \
    --install /usr/bin/x86_64-w64-mingw32-gcc x86_64-w64-mingw32-gcc /usr/bin/x86_64-w64-mingw32-gcc-5 60 \
    --slave /usr/bin/x86_64-w64-mingw32-g++ x86_64-w64-mingw32-g++ /usr/bin/x86_64-w64-mingw32-g++-5
  x86_64-w64-mingw32-gcc --version
  x86_64-w64-mingw32-g++ --version
fi

if [ $ARCH == "darwin" ]; then
  # which -s brew
  # if [[ $? != 0 ]] ; then
  #   # Install Homebrew
  #   ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  # else
  #   brew update
  # fi
  DEPS="bison flex gawk libffi git mercurial \
        pkg-config python3 libusb gnu-sed wget \
        boost boost-python3 eigen"
  # brew install --force $DEPS
  # brew upgrade python
  brew unlink $DEPS && brew link --force $DEPS
fi
