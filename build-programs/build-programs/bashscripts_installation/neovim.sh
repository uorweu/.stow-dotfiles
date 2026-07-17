#!/usr/bin/env bash

# Exit immediately if any command fails
set -e

echo "============================================="
echo "Starting Automated Neovim v0.11.6 Native Build"
echo "============================================="

# 1. Install all necessary build prerequisites
echo "--> Installing build tools and libraries..."
sudo apt update
sudo apt install -y cmake gettext lua5.1 liblua5.1-0-dev build-essential ninja-build unzip curl git
# 2. Wipe the old directory and clone the fresh v0.11.6 tag
echo "--> Wiping old source directory (if it exists)..."
rm -rf $HOME/build-programs/programs/neovim

# 3. Clone the exact v0.11.6 tag from GitHub
echo "--> Fetching Neovim v0.11.6 source code..."
git clone -b v0.11.6 https://github.com/neovim/neovim.git $HOME/build-programs/programs/neovim

# 4. Move into the repository directory
cd $HOME/build-programs/programs/neovim

# 5. Compile the source code using Ninja (if installed)
echo "--> Compiling Neovim..."
make CMAKE_BUILD_TYPE=RelWithDebInfo

# 6. Move into the build folder, package it, and install natively
echo "--> Generating and installing Debian package..."
cd build
cpack -G DEB

# The wildcard (*) ensures it grabs 'nvim-linux-x86_64.deb' perfectly!
sudo dpkg -i nvim-linux*.deb

echo "============================================="
echo " Neovim v0.11.6 installed successfully! "
echo "============================================="
echo "nvim --version"
nvim --version
