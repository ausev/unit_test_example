# --- Inputs ----#
ifndef SILENCE
	SILENCE = @
endif

COMPONENT_NAME = example_test
CPPUTEST_USE_EXTENSIONS = Y
# CPPUTEST_USE_GCOV = Y
CPP_PLATFORM = Gcc
BITNESS_FLAG = -m32
# TEST_DEFINES = -DUNIT_TEST
TEST_DEFINES = 
CPPUTEST_CPPFLAGS = $(BITNESS_FLAG) $(TEST_DEFINES)
CPPUTEST_CFLAGS = $(BITNESS_FLAG) $(TEST_DEFINES)
CPPUTEST_LDFLAGS= $(BITNESS_FLAG) $(TEST_DEFINES)
CPPUTEST_WARNINGFLAGS = -Wall -Werror
CPPUTEST_WARNINGFLAGS += -Wno-write-strings -Wno-unused-variable -Wno-maybe-uninitialized

SRC_FILES = example.c

TEST_SRC_FILES = AllTests.cpp example_test.cpp

INCLUDE_DIRS = $(CPPUTEST_HOME)/include .

include $(CPPUTEST_HOME)/build/MakefileWorker.mk

executable:
	$(SILENCE) gcc main.c example.c -I. -o out
	$(SILENCE) ./out