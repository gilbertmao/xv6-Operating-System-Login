# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.22

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /xv6

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /xv6/build

# Include any dependencies generated for this target.
include user/CMakeFiles/_test_aes256.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include user/CMakeFiles/_test_aes256.dir/compiler_depend.make

# Include the progress variables for this target.
include user/CMakeFiles/_test_aes256.dir/progress.make

# Include the compile flags for this target's objects.
include user/CMakeFiles/_test_aes256.dir/flags.make

user/CMakeFiles/_test_aes256.dir/src/crypto/test/test_aes256.c.o: user/CMakeFiles/_test_aes256.dir/flags.make
user/CMakeFiles/_test_aes256.dir/src/crypto/test/test_aes256.c.o: ../user/src/crypto/test/test_aes256.c
user/CMakeFiles/_test_aes256.dir/src/crypto/test/test_aes256.c.o: user/CMakeFiles/_test_aes256.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/xv6/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object user/CMakeFiles/_test_aes256.dir/src/crypto/test/test_aes256.c.o"
	cd /xv6/build/user && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT user/CMakeFiles/_test_aes256.dir/src/crypto/test/test_aes256.c.o -MF CMakeFiles/_test_aes256.dir/src/crypto/test/test_aes256.c.o.d -o CMakeFiles/_test_aes256.dir/src/crypto/test/test_aes256.c.o -c /xv6/user/src/crypto/test/test_aes256.c

user/CMakeFiles/_test_aes256.dir/src/crypto/test/test_aes256.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/_test_aes256.dir/src/crypto/test/test_aes256.c.i"
	cd /xv6/build/user && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /xv6/user/src/crypto/test/test_aes256.c > CMakeFiles/_test_aes256.dir/src/crypto/test/test_aes256.c.i

user/CMakeFiles/_test_aes256.dir/src/crypto/test/test_aes256.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/_test_aes256.dir/src/crypto/test/test_aes256.c.s"
	cd /xv6/build/user && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /xv6/user/src/crypto/test/test_aes256.c -o CMakeFiles/_test_aes256.dir/src/crypto/test/test_aes256.c.s

# Object files for target _test_aes256
_test_aes256_OBJECTS = \
"CMakeFiles/_test_aes256.dir/src/crypto/test/test_aes256.c.o"

# External object files for target _test_aes256
_test_aes256_EXTERNAL_OBJECTS = \
"/xv6/build/user/CMakeFiles/ulib.dir/asm/usys.S.o" \
"/xv6/build/user/CMakeFiles/ulib.dir/src/ulib.c.o" \
"/xv6/build/user/CMakeFiles/ulib.dir/src/umalloc.c.o" \
"/xv6/build/user/CMakeFiles/ulib.dir/src/printf.c.o" \
"/xv6/build/user/CMakeFiles/ulib.dir/src/crypto/aes256.c.o" \
"/xv6/build/user/CMakeFiles/ulib.dir/src/crypto/sha256.c.o" \
"/xv6/build/user/CMakeFiles/ulib.dir/src/login/login_lib.c.o"

user/_test_aes256: user/CMakeFiles/_test_aes256.dir/src/crypto/test/test_aes256.c.o
user/_test_aes256: user/CMakeFiles/ulib.dir/asm/usys.S.o
user/_test_aes256: user/CMakeFiles/ulib.dir/src/ulib.c.o
user/_test_aes256: user/CMakeFiles/ulib.dir/src/umalloc.c.o
user/_test_aes256: user/CMakeFiles/ulib.dir/src/printf.c.o
user/_test_aes256: user/CMakeFiles/ulib.dir/src/crypto/aes256.c.o
user/_test_aes256: user/CMakeFiles/ulib.dir/src/crypto/sha256.c.o
user/_test_aes256: user/CMakeFiles/ulib.dir/src/login/login_lib.c.o
user/_test_aes256: user/CMakeFiles/_test_aes256.dir/build.make
user/_test_aes256: user/CMakeFiles/_test_aes256.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/xv6/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable _test_aes256"
	cd /xv6/build/user && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/_test_aes256.dir/link.txt --verbose=$(VERBOSE)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold "Disassembling _test_aes256 > /xv6/build/user/_test_aes256.asm"
	cd /xv6/build/user && objdump -S _test_aes256 > _test_aes256.asm

# Rule to build all files generated by this target.
user/CMakeFiles/_test_aes256.dir/build: user/_test_aes256
.PHONY : user/CMakeFiles/_test_aes256.dir/build

user/CMakeFiles/_test_aes256.dir/clean:
	cd /xv6/build/user && $(CMAKE_COMMAND) -P CMakeFiles/_test_aes256.dir/cmake_clean.cmake
.PHONY : user/CMakeFiles/_test_aes256.dir/clean

user/CMakeFiles/_test_aes256.dir/depend:
	cd /xv6/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /xv6 /xv6/user /xv6/build /xv6/build/user /xv6/build/user/CMakeFiles/_test_aes256.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : user/CMakeFiles/_test_aes256.dir/depend

