#!/usr/bin/env bash
set -e

# Change to project root directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "${SCRIPT_DIR}"

PREFIX="${PREFIX:-/usr/local}"
BINDIR="${PREFIX}/bin"

echo "========================================="
echo " Installing tCube - a terminal 3D engine "
echo "========================================="

echo "Building release binary..."
make release --no-print-directory

echo "Installing binary to ${BINDIR}..."

if [ -w "${BINDIR}" ] || [ ! -e "${BINDIR}" -a -w "$(dirname "${BINDIR}")" ]; then
    make install PREFIX="${PREFIX}" --no-print-directory
else
    echo "Notice: Permission required to write to ${BINDIR}."
    echo "Running with sudo..."
    sudo make install PREFIX="${PREFIX}" --no-print-directory
fi

echo "-----------------------------------------"
echo "Successfully installed tCube to ${BINDIR}/tCube!"
echo "Run 'tCube' in your terminal to start."
echo "========================================="
