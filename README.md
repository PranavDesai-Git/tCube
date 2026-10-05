# tCube

> A terminal 3D engine project scaffold.

## Project Layout

```text
termCube/
├── include/         # Public header files (*.h)
├── src/             # Source code files (*.c)
│   └── main.c
├── build/           # Build artifacts (ignored by git)
│   ├── bin/         # Executable binary target
│   └── obj/         # Compiled object files (*.o) and dependencies (*.d)
├── Makefile         # Production build system
├── run.sh           # Build & run script
├── install.sh       # Linux installation script
├── .gitignore       # Git ignore rules
└── README.md        # Documentation
```

## Quick Start

### Build & Run

```bash
./run.sh
```

Or using `make`:

```bash
make
./build/bin/tCube
```

### Installation (Linux)

```bash
./install.sh
```
