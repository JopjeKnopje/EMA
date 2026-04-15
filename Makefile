#CXX = g++
#CXX = clang++

# LIB_IMGUI_DIR			:= lib/imgui
#
# EXE = app
# IMGUI_DIR = $(LIB_IMGUI_DIR)
# SOURCES = main.cpp
# SOURCES += $(IMGUI_DIR)/imgui.cpp $(IMGUI_DIR)/imgui_demo.cpp $(IMGUI_DIR)/imgui_draw.cpp $(IMGUI_DIR)/imgui_tables.cpp $(IMGUI_DIR)/imgui_widgets.cpp
# SOURCES += $(IMGUI_DIR)/backends/imgui_impl_glfw.cpp $(IMGUI_DIR)/backends/imgui_impl_opengl3.cpp
# OBJS = $(addsuffix .o, $(basename $(notdir $(SOURCES))))
# UNAME_S := $(shell uname -s)
# LINUX_GL_LIBS = -lGL
#
# CXXFLAGS = -std=c++11 -I$(IMGUI_DIR) -I$(IMGUI_DIR)/backends
# CXXFLAGS += -g -Wall -Wformat
#
#
# LIBS += $(LINUX_GL_LIBS) `pkg-config --static --libs glfw3`
#
# CXXFLAGS += `pkg-config --cflags glfw3`
# CFLAGS = $(CXXFLAGS)
#
#
# %.o:%.cpp
# 	$(CXX) $(CXXFLAGS) -c -o $@ $<
#
# %.o:$(IMGUI_DIR)/%.cpp
# 	$(CXX) $(CXXFLAGS) -c -o $@ $<
#
# %.o:$(IMGUI_DIR)/backends/%.cpp
# 	$(CXX) $(CXXFLAGS) -c -o $@ $<
#
# all: $(EXE)
#
#
# $(EXE): $(OBJS)
# 	$(CXX) -o $@ $^ $(CXXFLAGS) $(LIBS)
#
# clean:
# 	rm -f $(EXE) $(OBJS)


NAME		:= app

LIB_IMGUI_DIR			:= lib/imgui
IMGUI_DIR := $(LIB_IMGUI_DIR)



CFLAGS		:= -std=c++11 -Wformat -Wall -Wextra -Werror -g -Wall -Wformat `pkg-config --cflags glfw3` -lGL `pkg-config --static --libs glfw3`
# CFLAGS += -g -fsanitize=address

IFLAGS		:= -I include  -I$(LIB_IMGUI_DIR) -I$(LIB_IMGUI_DIR)/backends


# SOURCES += $(IMGUI_DIR)/imgui.cpp $(IMGUI_DIR)/imgui_demo.cpp $(IMGUI_DIR)/imgui_draw.cpp $(IMGUI_DIR)/imgui_tables.cpp $(IMGUI_DIR)/imgui_widgets.cpp
# SOURCES += $(IMGUI_DIR)/backends/imgui_impl_glfw.cpp $(IMGUI_DIR)/backends/imgui_impl_opengl3.cpp
# OBJS = $(addsuffix .o, $(basename $(notdir $(SOURCES))))


IMGUI_SRC_FILES := $(IMGUI_DIR)/imgui.cpp $(IMGUI_DIR)/imgui_demo.cpp $(IMGUI_DIR)/imgui_draw.cpp $(IMGUI_DIR)/imgui_tables.cpp $(IMGUI_DIR)/imgui_widgets.cpp
IMGUI_SRC_FILES += $(IMGUI_DIR)/backends/imgui_impl_glfw.cpp $(IMGUI_DIR)/backends/imgui_impl_opengl3.cpp


SRC_DIR			:= src
SRC_FILES		:= main.cpp

SRC_LIST		:= $(addprefix $(SRC_DIR)/, $(SRC_FILES))
SRC_LIST		+= $(IMGUI_SRC_FILES)

OBJ_DIR			:= obj
OBJ_LIST		:= $(patsubst %.cpp, $(OBJ_DIR)/%.o, $(SRC_LIST))


# TODO: Look at libft to create dirs for subdirs

test:
	@echo $(SRC_LIST)

all: $(NAME)


$(NAME): $(OBJ_LIST)
	$(CXX) $(OBJ_LIST) $(CFLAGS) $(IFLAGS) -o $(NAME)

$(OBJ_DIR)/%.o: %.cpp | $(OBJ_DIR)
	@mkdir -p $(@D)
	$(CXX) $(CFLAGS) $(IFLAGS) -o $@ -c $<
	@echo $<

# $(OBJ_DIR)/%.o: $(LIB_IMGUI_SRC_FILES) 
# 	@mkdir -p $(@D)
# 	$(CXX) $(CFLAGS) $(IFLAGS) -o $@ -c $<

$(OBJ_DIR):
	mkdir $(OBJ_DIR)



.PHONY: clean
clean:
	rm -rf $(OBJ_DIR)

.PHONY: fclean
fclean: clean
	rm -f $(NAME)

.PHONY: re
re: fclean 
	$(MAKE) 

.PHONY: compile_commands
compile_commands:
	$(MAKE) | compiledb

compile_commands_test:
	$(MAKE) test | compiledb

.PHONY: run
run: all
	./$(NAME)


# TEST_DIR  		:= unit_tests
# TEST_SRC_FILES	:= test_ft_write.c \
# 				   test_neg_pos.c
# TEST_SRC_LIST	:= $(addprefix $(TEST_DIR)/, $(TEST_SRC_FILES))
# TEST_BIN_DIR 	:= $(TEST_DIR)/bin
# TEST_RUNNER_DIR := $(TEST_DIR)/runners
# TEST_BIN_LIST	:= $(patsubst $(TEST_DIR)/%.c, $(TEST_BIN_DIR)/%, $(TEST_SRC_LIST))
#
# TEST_UNITY_ROOT	:= lib/Unity
# TEST_UNITY_SRC	:= $(TEST_UNITY_ROOT)/src/unity.c
# TEST_IFLAGS		:= -I $(TEST_UNITY_ROOT)/src 
# TEST_UNITY_OPTIONS := \
# 					-DUNITY_INCLUDE_PRINT_FORMATTED \
# 					-DUNITY_OUTPUT_COLOR
#
# $(TEST_BIN_DIR):
# 	mkdir $@
#
# $(TEST_RUNNER_DIR):
# 	mkdir -p $@
#
# # Save all the generated runners for debugging.
# PRECIOUS: $(patsubst %.c, $(TEST_RUNNER_DIR)/%_runner.c, $(TEST_SRC_FILES))
# $(TEST_RUNNER_DIR)/%_runner.c: $(TEST_DIR)/%.c | $(TEST_RUNNER_DIR)
# 	ruby $(TEST_UNITY_ROOT)/auto/generate_test_runner.rb $< $@
#
# $(TEST_BIN_DIR)/%: $(TEST_RUNNER_DIR)/%_runner.c $(LIB_ASM) | $(TEST_BIN_DIR)
# 	$(CXX) $(CFLAGS) $(IFLAGS) $(TEST_IFLAGS) $(TEST_UNITY_OPTIONS) $(TEST_UNITY_SRC) $(TEST_DIR)/$*.c $< -o $@ $(LIB_ASM) 
#
#
# test_%: $(TEST_BIN_DIR)/test_% | lib_asm
# 	./$<
#
# .PHONY: test
# test: lib_asm $(TEST_BIN_LIST)
#
# .PHONY: test_run
# test_run: test
# 	./$(TEST_DIR)/run_tests.sh $(TEST_BIN_DIR)
