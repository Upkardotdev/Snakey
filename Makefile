# === Project Settings ===
PROJECT_NAME = snakey
SRC_DIR = src
SRC = $(SRC_DIR)/main.cpp
BUILD_DIR = build
BIN = $(BUILD_DIR)/$(PROJECT_NAME)

# === Raylib ===
RAYLIB_DIR = libs/raylib
RAYLIB_SRC = $(RAYLIB_DIR)/src

CXX = g++
CXXFLAGS = -std=c++17 -Wall -I$(RAYLIB_SRC)
LDFLAGS = -L$(RAYLIB_SRC) -lraylib -lm -ldl -lpthread -lGL -lX11

# === Default Target ===
all: setup raylib $(BIN)

# --- Setup: Clone Raylib if missing ---
setup:
	@if [ ! -d "$(RAYLIB_DIR)" ]; then \
		echo "==> Cloning Raylib..."; \
		git clone --depth=1 https://github.com/raysan5/raylib.git $(RAYLIB_DIR); \
	fi

# --- Build Raylib from source ---
raylib:
	@echo "==> Building Raylib from source..."
	@cd $(RAYLIB_SRC) && make PLATFORM=PLATFORM_DESKTOP

# --- Build your game ---
$(BIN): $(SRC)
	@mkdir -p $(BUILD_DIR)
	@echo "==> Compiling $(PROJECT_NAME)..."
	$(CXX) $(SRC) -o $(BIN) $(CXXFLAGS) $(LDFLAGS)

# --- Run the game ---
run: all
	@echo "==> Running $(PROJECT_NAME)..."
	./$(BIN)

# --- Clean ---
clean:
	rm -rf $(BUILD_DIR)
	@cd $(RAYLIB_SRC) && make clean

# --- Full reset (deletes Raylib too) ---
dist-clean: clean
	rm -rf $(RAYLIB_DIR)

.PHONY: all setup raylib run clean dist-clean
