# make test - create the test executables
# make release - create the release executables
# make clean - clean the build directory

# toolchain
CC := g++
AR := ar

# path
SRC := src
OBJ := obj
LIB := lib
INC := inc
SRC_TEST := $(SRC)/test
OBJ_TEST := $(OBJ)/test
LIB_TEST := $(LIB)/test

# options
OPTS_TEST := -pthread

# includes
INCLUDE_GTEST := -isystem ${GTEST_DIR}/include -I${GTEST_DIR} 
INCLUDE_PROJ := -I$(INC)

# obj files
MAIN_OBJ := $(OBJ)/main.o
DEP_OBJ := $(OBJ)/code_to_be_tested.o
TEST_OBJ := $(OBJ_TEST)/unit_test_case.o $(OBJ_TEST)/Gtest_main.o
GTEST_OBJ := $(OBJ_TEST)/gtest-all.o

# lib files
GTEST_LIB := $(LIB_TEST)/libgtest.a

# executables
TEST_EXE := avg_test
MAIN_EXE := avg
ALL_EXE := $(TEST_EXE) $(MAIN_EXE)

### Build release
release: $(DEP_OBJ) $(MAIN_OBJ)
	$(CC) $(DEP_OBJ) $(MAIN_OBJ) -o $(MAIN_EXE)

### Build test
test: $(GTEST_LIB) $(DEP_OBJ) $(TEST_OBJ)
	$(CC) $(OPTS_TEST) $(DEP_OBJ) $(TEST_OBJ) $(GTEST_LIB) -o $(TEST_EXE)

### Gtest objects and library
$(GTEST_OBJ):
	$(CC) $(INCLUDE_GTEST) -c ${GTEST_DIR}/src/gtest-all.cc -o $(GTEST_OBJ)

$(GTEST_LIB): $(GTEST_OBJ)
	$(AR) -rv $(GTEST_LIB) $(GTEST_OBJ)

### Test objects
$(OBJ_TEST)/%.o: $(SRC_TEST)/%.c
	$(CC) $(INCLUDE_PROJ) $(INCLUDE_GTEST) -c $< -o $@

### Default objects
$(OBJ)/%.o: $(SRC)/%.c
	$(CC) $(INCLUDE_PROJ) -c $< -o $@

### Clean
clean:
	rm $(OBJ)/*.o ||:
	rm $(OBJ_TEST)/*.o ||:
	rm $(LIB)/*.a ||:
	rm $(LIB_TEST)/*.a ||:
	rm $(ALL_EXE) ||:
