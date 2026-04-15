NAME			:= app

LIB_IMGUI_DIR	:= lib/imgui


CXXFLAGS		:= -std=c++11 -Wformat -Wall -Wextra -Werror -Wall -Wformat `pkg-config --cflags glfw3` -lGL `pkg-config --static --libs glfw3`
# CXXFLAGS += -g -fsanitize=address

IFLAGS			:= -I include  -I$(LIB_IMGUI_DIR) -I$(LIB_IMGUI_DIR)/backends



IMGUI_SRC_FILES := $(LIB_IMGUI_DIR)/imgui.cpp $(LIB_IMGUI_DIR)/imgui_demo.cpp $(LIB_IMGUI_DIR)/imgui_draw.cpp $(LIB_IMGUI_DIR)/imgui_tables.cpp $(LIB_IMGUI_DIR)/imgui_widgets.cpp
IMGUI_SRC_FILES += $(LIB_IMGUI_DIR)/backends/imgui_impl_glfw.cpp $(LIB_IMGUI_DIR)/backends/imgui_impl_opengl3.cpp

HEADER_DIR 		:= include
HEADER_FILES 	:= config.hpp
HEADER_LIST		:= $(addprefix $(HEADER_DIR)/, $(HEADER_FILES))


SRC_DIR			:= src
SRC_FILES		:= main.cpp

SRC_LIST		:= $(addprefix $(SRC_DIR)/, $(SRC_FILES))
SRC_LIST		+= $(IMGUI_SRC_FILES)

OBJ_DIR			:= obj
OBJ_LIST		:= $(patsubst %.cpp, $(OBJ_DIR)/%.o, $(SRC_LIST))

all: $(NAME)

$(NAME): $(OBJ_LIST)
	$(CXX) $(OBJ_LIST) $(CXXFLAGS) $(IFLAGS) -o $(NAME)


$(OBJ_DIR)/%.o: $(LIB_IMGUI_DIR)/%.cpp
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) $(IFLAGS) -o $@ -c $<

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp $(HEADER_LIST)
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) $(IFLAGS) -o $@ -c $<


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
	$(MAKE) -Bnwk | compiledb

.PHONY: run
run: all
	./$(NAME)

