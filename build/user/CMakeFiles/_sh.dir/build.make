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
include user/CMakeFiles/_sh.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include user/CMakeFiles/_sh.dir/compiler_depend.make

# Include the progress variables for this target.
include user/CMakeFiles/_sh.dir/progress.make

# Include the compile flags for this target's objects.
include user/CMakeFiles/_sh.dir/flags.make

user/CMakeFiles/_sh.dir/src/sh.c.o: user/CMakeFiles/_sh.dir/flags.make
user/CMakeFiles/_sh.dir/src/sh.c.o: ../user/src/sh.c
user/CMakeFiles/_sh.dir/src/sh.c.o: user/CMakeFiles/_sh.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/xv6/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object user/CMakeFiles/_sh.dir/src/sh.c.o"
	cd /xv6/build/user && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT user/CMakeFiles/_sh.dir/src/sh.c.o -MF CMakeFiles/_sh.dir/src/sh.c.o.d -o CMakeFiles/_sh.dir/src/sh.c.o -c /xv6/user/src/sh.c

user/CMakeFiles/_sh.dir/src/sh.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/_sh.dir/src/sh.c.i"
	cd /xv6/build/user && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /xv6/user/src/sh.c > CMakeFiles/_sh.dir/src/sh.c.i

user/CMakeFiles/_sh.dir/src/sh.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/_sh.dir/src/sh.c.s"
	cd /xv6/build/user && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /xv6/user/src/sh.c -o CMakeFiles/_sh.dir/src/sh.c.s

# Object files for target _sh
_sh_OBJECTS = \
"CMakeFiles/_sh.dir/src/sh.c.o"

# External object files for target _sh
_sh_EXTERNAL_OBJECTS = \
"/xv6/build/user/CMakeFiles/ulib.dir/asm/usys.S.o" \
"/xv6/build/user/CMakeFiles/ulib.dir/src/ulib.c.o" \
"/xv6/build/user/CMakeFiles/ulib.dir/src/umalloc.c.o" \
"/xv6/build/user/CMakeFiles/ulib.dir/src/printf.c.o" \
"/xv6/build/user/CMakeFiles/ulib.dir/src/crypto/aes256.c.o" \
"/xv6/build/user/CMakeFiles/ulib.dir/src/crypto/sha256.c.o" \
"/xv6/build/user/CMakeFiles/ulib.dir/src/login/login_lib.c.o"

user/_sh: user/CMakeFiles/_sh.dir/src/sh.c.o
user/_sh: user/CMakeFiles/ulib.dir/asm/usys.S.o
user/_sh: user/CMakeFiles/ulib.dir/src/ulib.c.o
user/_sh: user/CMakeFiles/ulib.dir/src/umalloc.c.o
user/_sh: user/CMakeFiles/ulib.dir/src/printf.c.o
user/_sh: user/CMakeFiles/ulib.dir/src/crypto/aes256.c.o
user/_sh: user/CMakeFiles/ulib.dir/src/crypto/sha256.c.o
user/_sh: user/CMakeFiles/ulib.dir/src/login/login_lib.c.o
user/_sh: user/CMakeFiles/_sh.dir/build.make
user/_sh: user/CMakeFiles/_sh.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/xv6/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable _sh"
	cd /xv6/build/user && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/_sh.dir/link.txt --verbose=$(VERBOSE)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold "Disassembling _sh > /xv6/build/user/_sh.asm"
	cd /xv6/build/user && objdump -S _sh > _sh.asm

# Rule to build all files generated by this target.
user/CMakeFiles/_sh.dir/build: user/_sh
.PHONY : user/CMakeFiles/_sh.dir/build

user/CMakeFiles/_sh.dir/clean:
	cd /xv6/build/user && $(CMAKE_COMMAND) -P CMakeFiles/_sh.dir/cmake_clean.cmake
.PHONY : user/CMakeFiles/_sh.dir/clean

user/CMakeFiles/_sh.dir/depend:
	cd /xv6/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /xv6 /xv6/user /xv6/build /xv6/build/user /xv6/build/user/CMakeFiles/_sh.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : user/CMakeFiles/_sh.dir/depend

