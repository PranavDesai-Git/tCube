#!/usr/bin/env bash
set -e

# Change to project root directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "${SCRIPT_DIR}"

echo "Building tCube..."
make --no-print-directory

echo "Starting tCube..."
exec ./build/bin/tCube "$@"
