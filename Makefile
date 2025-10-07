# Compiler
CXX = g++
CXXFLAGS = -std=c++17 -Wall -Iinclude
LDFLAGS = -Llib -lraylib -lm -ldl -lpthread -lGL -lX11

# Files
SRC = src/main.cpp
OUT = snake-game

# Default rule
all:
	@$(CXX) $(SRC) -o $(OUT) $(CXXFLAGS) $(LDFLAGS)

run: all
	@./$(OUT)

clean:
	rm -f $(OUT)
