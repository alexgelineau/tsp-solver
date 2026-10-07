# Makefile du voyageur de commerce

include config.mk

BUILD_DIR ?= build

SRC = import.cpp export.cpp data.cpp heuristics.cpp
OBJ = $(patsubst %.cpp,$(BUILD_DIR)/%.o,$(SRC))

TEST_OBJ = $(OBJ) $(BUILD_DIR)/tests.o
MAIN_OBJ = $(OBJ) $(BUILD_DIR)/tsp-solver.o

.PHONY: all clean

all: $(BUILD_DIR)/tsp-solver

$(BUILD_DIR)/tests.o: tests.cpp $(SRC:.cpp=.h) | $(BUILD_DIR)

$(BUILD_DIR)/tests: $(TEST_OBJ) | $(BUILD_DIR)
	$(CC) -o $@ $(TEST_OBJ) $(LDFLAGS)
	./$@

$(BUILD_DIR)/tsp-solver.o: tsp-solver.cpp $(SRC:.cpp=.h) | $(BUILD_DIR)

$(BUILD_DIR)/%.o: %.cpp $(SRC:.cpp=.h) | $(BUILD_DIR)
	$(CC) $(CPPFLAGS) -c -o $@ $<

$(BUILD_DIR)/tsp-solver: $(BUILD_DIR)/tests $(MAIN_OBJ) | $(BUILD_DIR)
	$(CC) -o $@ $(MAIN_OBJ) $(LDFLAGS)

$(BUILD_DIR):
	mkdir -p $@

clean:
	rm -rf $(BUILD_DIR)
