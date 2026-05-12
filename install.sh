#!/bin/bash
req_cmake=$(command -v cmake)
if [ -z "$req_cmake" ]; then
    echo "cmake not found. Installing it"
    sudo dnf install cmake
else
    echo "cmake found"
fi

req_ninja_build=$(command -v ninja-build)
if [ -z "$req_ninja_build" ]; then
    echo "ninja build not found"
    sudo dnf install ninja-build
else
    echo "ninja build found"
fi

req_gcc=$(command -v arm-linux-gnu-gcc)
if [ -z "$req_gcc" ]; then
    echo "gcc for arm cross compiling not found. Installing it"
    sudo dnf install arm-linux-gnu-gcc
    sudo dnf install arm-none-eabi-gcc-cs
    sudo dnf install arm-none-eabi-gcc-cs-c++
else
    echo "gcc for arm found"
fi

if [ -f SDK_25_06_00_LPC845BREAKOUT.zip ]; then
    if [ ! -d SDK_25_06_00_LPC845BREAKOUT ]; then
        unzip SDK_25_06_00_LPC845BREAKOUT.zip
    fi
    mv SDK_25_06_00_LPC845BREAKOUT ~

    if [ -z "$ARMGCC_DIR" ]; then
        echo "setting ARMGCC_DIR env var"
        if [ "$SHELL" == "/bin/zsh" ]; then
            echo 'export ARMGCC_DIR="/usr"' >> ~/.zshrc
            echo "Done"
        else
            echo 'export ARMGCC_DIR="/usr"' >> ~/.bashrc
            echo 'Done. Make a "source ~/.zshrc" to apply env variable'
        fi
    else
        echo "env variable already set"
        echo "Done"
    fi
else
    echo "No sdk file found. Download it from the git repository"
    exit
fi
