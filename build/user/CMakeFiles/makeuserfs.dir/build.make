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

# Utility rule file for makeuserfs.

# Include any custom commands dependencies for this target.
include user/CMakeFiles/makeuserfs.dir/compiler_depend.make

# Include the progress variables for this target.
include user/CMakeFiles/makeuserfs.dir/progress.make

user/CMakeFiles/makeuserfs: user/fs.img
user/CMakeFiles/makeuserfs: user/login_fs.img

user/fs.img: tools/mkfs
user/fs.img: ../README
user/fs.img: user/_sh
user/fs.img: user/_ls
user/fs.img: user/_cat
user/fs.img: user/_test_sha256
user/fs.img: user/_test_aes256
user/fs.img: user/_init
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/xv6/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Generating fs.img"
	cd /xv6/build/user && ../tools/mkfs fs.img _init README _sh _ls _cat _test_sha256 _test_aes256

user/login_fs.img: tools/mkfs
user/login_fs.img: ../README
user/login_fs.img: user/_sh
user/login_fs.img: user/_ls
user/login_fs.img: user/_cat
user/login_fs.img: user/_test_sha256
user/login_fs.img: user/_test_aes256
user/login_fs.img: user/_login_init
user/login_fs.img: user/_login
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/xv6/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Generating login_fs.img"
	cd /xv6/build/user && ../tools/mkfs login_fs.img _login_init _login README _sh _ls _cat _test_sha256 _test_aes256

makeuserfs: user/CMakeFiles/makeuserfs
makeuserfs: user/fs.img
makeuserfs: user/login_fs.img
makeuserfs: user/CMakeFiles/makeuserfs.dir/build.make
.PHONY : makeuserfs

# Rule to build all files generated by this target.
user/CMakeFiles/makeuserfs.dir/build: makeuserfs
.PHONY : user/CMakeFiles/makeuserfs.dir/build

user/CMakeFiles/makeuserfs.dir/clean:
	cd /xv6/build/user && $(CMAKE_COMMAND) -P CMakeFiles/makeuserfs.dir/cmake_clean.cmake
.PHONY : user/CMakeFiles/makeuserfs.dir/clean

user/CMakeFiles/makeuserfs.dir/depend:
	cd /xv6/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /xv6 /xv6/user /xv6/build /xv6/build/user /xv6/build/user/CMakeFiles/makeuserfs.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : user/CMakeFiles/makeuserfs.dir/depend

