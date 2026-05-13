#!/bin/bash
os=""
pkgs=() # Array with packages to install
if command -v dnf > /dev/null 2>&1; then os="fedora"; fi
if command -v apt > /dev/null 2>&1; then os="debian"; fi

req_cmake=$(command -v cmake)
if [ -z "$req_cmake" ]; then
    echo "cmake not found. Installing it"
    pkgs+=("cmake")
else
    echo "cmake found"
fi

req_ninja_build=$(command -v ninja-build)
if [ -z "$req_ninja_build" ]; then
    echo "ninja build not found"
    pkgs+=("ninja")
else
    echo "ninja build found"
fi

req_gcc=$(command -v arm-linux-gnu-gcc)
if [ -z "$req_gcc" ]; then
    pkgs+=("gcc-arm")
    echo "gcc for arm cross compiling not found. Installing it"
else
    echo "gcc for arm found"
fi

req_openocd=$(command -v openocd)
if [ -z "$req_openocd" ]; then
    pkgs+=("openocd")
    echo "openocd not found. Installing it"
else
    echo "openocd found"
fi

case "$os" in
    fedora)
        for pkg in "${pkgs[@]}"; do
            if [ "$pkg" == "gcc-arm" ]; then
                sudo dnf install -y arm-linux-gnu-gcc
                sudo dnf install -y arm-none-eabi-gcc-cs
                sudo dnf install -y arm-none-eabi-gcc-cs-c++
                sudo dnf copr enable rleh/arm-none-eabi-gdb
                sudo dnf install arm-none-eabi-gdb
                continue
            fi
            if [ "$pkg" == "ninja" ]; then
                sudo dnf install -y ninja-build
                sudo dnf install -y ninja
                continue
            fi
            sudo dnf install -y $pkg
        done
        ;;
    debian)
        sudo apt update
        for pkg in "${pkgs[@]}"; do
            if [ "$pkg" == "gcc-arm" ]; then
                sudo apt install -y gcc-arm-none-eabi
                continue
            fi
            if [ "$pkg" == "ninja" ]; then
                sudo apt install -y ninja-build
                sudo apt install -y ninja
                continue
            fi
            sudo apt install -y $pkg
        done
        ;;
esac

if [ -d "/home/${USER}/SDK_25_06_00_LPC845BREAKOUT" ]; then
    rm -rf /home/${USER}/SDK_25_06_00_LPC845BREAKOUT 
fi

if [ -f SDK_25_06_00_LPC845BREAKOUT.zip ]; then
    if [ ! -d SDK_25_06_00_LPC845BREAKOUT ]; then
        unzip SDK_25_06_00_LPC845BREAKOUT.zip > /dev/null
    fi
    mv SDK_25_06_00_LPC845BREAKOUT ~

    if [ -z "$ARMGCC_DIR" ]; then
        echo "setting ARMGCC_DIR env var"
        if [ "$SHELL" == "/bin/zsh" ]; then
            echo 'export ARMGCC_DIR="/usr"' >> ~/.zshrc
            echo "Done"
        else
            echo 'export ARMGCC_DIR="/usr"' >> ~/.bashrc
            echo 'Done. "source ~/.zshrc" to apply env variable'
        fi
    else
        echo "env variable already set"
        echo "Done"
    fi
else
    echo "No sdk file found. Download it from the git repository"
    exit
fi
