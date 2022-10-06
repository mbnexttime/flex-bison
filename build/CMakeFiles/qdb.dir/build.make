# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.16

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
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
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/kgavrilov/flex/hw_2

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/kgavrilov/flex/hw_2/build

# Include any dependencies generated for this target.
include CMakeFiles/qdb.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/qdb.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/qdb.dir/flags.make

parser.cc: ../src/parser.y
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/kgavrilov/flex/hw_2/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "[BISON][PARSER] Building parser with bison 3.5.1"
	/usr/bin/bison --defines=/home/kgavrilov/flex/hw_2/build/parser.h -o /home/kgavrilov/flex/hw_2/build/parser.cc /home/kgavrilov/flex/hw_2/src/parser.y

parser.h: parser.cc
	@$(CMAKE_COMMAND) -E touch_nocreate parser.h

lexer.cc: ../src/lexer.l
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/kgavrilov/flex/hw_2/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "[FLEX][LEXER] Building scanner with flex 2.6.4"
	cd /home/kgavrilov/flex/hw_2 && /usr/bin/flex --header-file=/home/kgavrilov/flex/hw_2/build/lexer.h -o/home/kgavrilov/flex/hw_2/build/lexer.cc src/lexer.l

lexer.h: lexer.cc
	@$(CMAKE_COMMAND) -E touch_nocreate lexer.h

CMakeFiles/qdb.dir/src/main.cc.o: CMakeFiles/qdb.dir/flags.make
CMakeFiles/qdb.dir/src/main.cc.o: ../src/main.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/kgavrilov/flex/hw_2/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object CMakeFiles/qdb.dir/src/main.cc.o"
	/usr/bin/g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/qdb.dir/src/main.cc.o -c /home/kgavrilov/flex/hw_2/src/main.cc

CMakeFiles/qdb.dir/src/main.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/qdb.dir/src/main.cc.i"
	/usr/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/kgavrilov/flex/hw_2/src/main.cc > CMakeFiles/qdb.dir/src/main.cc.i

CMakeFiles/qdb.dir/src/main.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/qdb.dir/src/main.cc.s"
	/usr/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/kgavrilov/flex/hw_2/src/main.cc -o CMakeFiles/qdb.dir/src/main.cc.s

CMakeFiles/qdb.dir/lexer.cc.o: CMakeFiles/qdb.dir/flags.make
CMakeFiles/qdb.dir/lexer.cc.o: lexer.cc
CMakeFiles/qdb.dir/lexer.cc.o: parser.h
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/kgavrilov/flex/hw_2/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building CXX object CMakeFiles/qdb.dir/lexer.cc.o"
	/usr/bin/g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/qdb.dir/lexer.cc.o -c /home/kgavrilov/flex/hw_2/build/lexer.cc

CMakeFiles/qdb.dir/lexer.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/qdb.dir/lexer.cc.i"
	/usr/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/kgavrilov/flex/hw_2/build/lexer.cc > CMakeFiles/qdb.dir/lexer.cc.i

CMakeFiles/qdb.dir/lexer.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/qdb.dir/lexer.cc.s"
	/usr/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/kgavrilov/flex/hw_2/build/lexer.cc -o CMakeFiles/qdb.dir/lexer.cc.s

CMakeFiles/qdb.dir/parser.cc.o: CMakeFiles/qdb.dir/flags.make
CMakeFiles/qdb.dir/parser.cc.o: parser.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/kgavrilov/flex/hw_2/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Building CXX object CMakeFiles/qdb.dir/parser.cc.o"
	/usr/bin/g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/qdb.dir/parser.cc.o -c /home/kgavrilov/flex/hw_2/build/parser.cc

CMakeFiles/qdb.dir/parser.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/qdb.dir/parser.cc.i"
	/usr/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/kgavrilov/flex/hw_2/build/parser.cc > CMakeFiles/qdb.dir/parser.cc.i

CMakeFiles/qdb.dir/parser.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/qdb.dir/parser.cc.s"
	/usr/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/kgavrilov/flex/hw_2/build/parser.cc -o CMakeFiles/qdb.dir/parser.cc.s

# Object files for target qdb
qdb_OBJECTS = \
"CMakeFiles/qdb.dir/src/main.cc.o" \
"CMakeFiles/qdb.dir/lexer.cc.o" \
"CMakeFiles/qdb.dir/parser.cc.o"

# External object files for target qdb
qdb_EXTERNAL_OBJECTS =

qdb: CMakeFiles/qdb.dir/src/main.cc.o
qdb: CMakeFiles/qdb.dir/lexer.cc.o
qdb: CMakeFiles/qdb.dir/parser.cc.o
qdb: CMakeFiles/qdb.dir/build.make
qdb: common/libcommon.a
qdb: CMakeFiles/qdb.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/kgavrilov/flex/hw_2/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_6) "Linking CXX executable qdb"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/qdb.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/qdb.dir/build: qdb

.PHONY : CMakeFiles/qdb.dir/build

CMakeFiles/qdb.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/qdb.dir/cmake_clean.cmake
.PHONY : CMakeFiles/qdb.dir/clean

CMakeFiles/qdb.dir/depend: parser.cc
CMakeFiles/qdb.dir/depend: parser.h
CMakeFiles/qdb.dir/depend: lexer.cc
CMakeFiles/qdb.dir/depend: lexer.h
	cd /home/kgavrilov/flex/hw_2/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/kgavrilov/flex/hw_2 /home/kgavrilov/flex/hw_2 /home/kgavrilov/flex/hw_2/build /home/kgavrilov/flex/hw_2/build /home/kgavrilov/flex/hw_2/build/CMakeFiles/qdb.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/qdb.dir/depend

