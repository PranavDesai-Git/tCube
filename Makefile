# ==============================================================================
# tCube Makefile - Production Grade Build System
# ==============================================================================

CC       ?= gcc
CFLAGS   ?= -std=c99 -Wall -Wextra -pedantic -O2
CPPFLAGS := -Iinclude -MMD -MP
LDFLAGS  := 
LDLIBS   := -lm

# Directory layout
SRC_DIR   := src
INC_DIR   := include
BUILD_DIR := build
OBJ_DIR   := $(BUILD_DIR)/obj
BIN_DIR   := $(BUILD_DIR)/bin

TARGET    := $(BIN_DIR)/tCube

# Auto-discover all source files in src/
SRCS      := $(wildcard $(SRC_DIR)/*.c)
OBJS      := $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SRCS))
DEPS      := $(OBJS:.o=.d)

# Installation defaults
PREFIX    ?= /usr/local
BINDIR    ?= $(PREFIX)/bin

.PHONY: all debug release clean install uninstall run help compile_commands.json

all: $(TARGET) compile_commands.json

# Debug build configuration
debug: CFLAGS := -std=c99 -Wall -Wextra -pedantic -g -DDEBUG -O0
debug: $(TARGET) compile_commands.json

# Release build configuration
release: CFLAGS := -std=c99 -Wall -Wextra -Werror -pedantic -O3 -DNDEBUG
release: $(TARGET) compile_commands.json

# Generate compile_commands.json for LSP / clangd support
compile_commands.json: $(SRCS)
	@echo "  GEN     $@"
	@echo "[" > $@
	@first=1; \
	for src in $(SRCS); do \
		if [ $$first -eq 0 ]; then echo "," >> $@; fi; \
		first=0; \
		printf '  {\n    "directory": "%s",\n    "command": "%s %s %s -c %s",\n    "file": "%s"\n  }' \
			"$(CURDIR)" "$(CC)" "$(CFLAGS)" "$(CPPFLAGS)" "$$src" "$$src" >> $@; \
	done; \
	echo "" >> $@; \
	echo "]" >> $@

# Link the final executable binary
$(TARGET): $(OBJS) | $(BIN_DIR)
	@echo "  LD      $@"
	@$(CC) $(LDFLAGS) $^ $(LDLIBS) -o $@

# Compile source files to object files in build/obj/
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	@echo "  CC      $<"
	@$(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $@

# Create directories as needed
$(OBJ_DIR) $(BIN_DIR):
	@mkdir -p $@

# Automatically include header dependency files
-include $(DEPS)

# Clean all build artifacts
clean:
	@echo "  CLEAN   $(BUILD_DIR) compile_commands.json"
	@rm -rf $(BUILD_DIR) compile_commands.json

# Build and run the binary
run: $(TARGET)
	@./$(TARGET)

# Install binary to system
install: release
	@echo "  INSTALL $(TARGET) -> $(DESTDIR)$(BINDIR)/tCube"
	@install -d $(DESTDIR)$(BINDIR)
	@install -m 755 $(TARGET) $(DESTDIR)$(BINDIR)/tCube

# Uninstall binary from system
uninstall:
	@echo "  UNINSTALL $(DESTDIR)$(BINDIR)/tCube"
	@rm -f $(DESTDIR)$(BINDIR)/tCube

# Help target
help:
	@echo "tCube Build System"
	@echo "Available targets:"
	@echo "  all       : Build default binary ($(TARGET))"
	@echo "  debug     : Build with debug symbols (-g -O0)"
	@echo "  release   : Build optimized release binary (-O3)"
	@echo "  run       : Build and execute tCube"
	@echo "  clean     : Remove all build outputs"
	@echo "  install   : Install binary to $(BINDIR)"
	@echo "  uninstall : Uninstall binary from $(BINDIR)"
