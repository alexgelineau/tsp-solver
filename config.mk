VERSION = 1

# paths
PREFIX = /usr/local
MANPREFIX = ${PREFIX}/share/man

# flags
CPPFLAGS = -std=c++17 -O3 -Wall -Wpedantic -Wextra -march=native -fdiagnostics-color=always

UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
LDFLAGS =
else
LDFLAGS = -Wl,-O1 -Wl,--as-needed
endif

# compiler
CC = g++
