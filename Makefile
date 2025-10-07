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

# === Targets ===
all: setup raylib $(BIN)

setup:
	@if [ ! -d "$(RAYLIB_DIR)" ]; then \
		echo "==> Cloning Raylib..."; \
		git clone https://github.com/raysan5/raylib.git $(RAYLIB_DIR); \
	fi

raylib:
	@echo "==> Building Raylib from source..."
	@cd $(RAYLIB_DIR) && make PLATFORM=PLATFORM_DESKTOP >/dev/null

$(BIN): $(SRC)
	@mkdir -p $(BUILD_DIR)
	@echo "==> Building $(PROJECT_NAME)..."
	$(CXX) $(SRC) -o $(BIN) $(CXXFLAGS) $(LDFLAGS)

run: all
	@echo "==> Running game..."
	./$(BIN)

clean:
	rm -rf $(BUILD_DIR)
	@cd $(RAYLIB_DIR) && make clean >/dev/null

dist-clean: clean
	rm -rf $(RAYLIB_DIR)

.PHONY: all setup raylib run clean dist-clean
