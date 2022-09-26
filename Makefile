# Le .PHONY est la pour dire au Makefile que ces mots sont des noms de règles et non pas des noms de fichier
.PHONY: all clean fclean re test sanitize

# ########################################################################### #
#                                 VARIABLES                                   #
# ########################################################################### #
# Le path du fichier envoyé en paramètre au bsq pour la règle test
TEST_FILE = ./maps/map_1_1_5.txt

# Les noms des binaires que l'on va être amenés a compiler
NAME = bsq
SANITIZE = $(NAME)_sanitized

# Les paths du projet
PATH_SRC = ./src/
PATH_OBJ = ./obj/
PATH_INC = ./inc/

# Le compileur et les différents flags utilisés pour la compilation
COMPILE = gcc
FLAGS = -Wall -Wextra -Werror
SANITIZE_FLAGS = $(FLAGS) -fsanitize=address -g3

# Les noms de fichier !!!!! NE PAS OUBLIER DE LES RENSEIGNER ICI QUAND VOUS EN RAJOUTEZ UN !!!!!!
FILES = \
	main
	ft_atoi
INCLUDE_FILES = bsq.h
INCLUDES = $(addprefix $(PATH_INC), $(INCLUDE_FILES))
OBJS = $(addsuffix .o, $(addprefix $(PATH_OBJ), $(FILES)))

# ########################################################################### #
#                                   REGLES                                    #
# ########################################################################### #

# Appelée quand on fait un simple "make". La dépendance dit qu'il faut compiler bsq
all: $(NAME)

# Compile les objets en binaire.
# Les dépendances disent qu'il faut compiler les objets, puis vérifier si les objets et les includes ont changé depuis la derniere compilation du binaire bsq.
# Si c'est le cas, ou si bsq n'existe pas, on rentre dans la regle. Sinon, on ne rentre pas.
$(NAME): $(OBJS) $(INCLUDES)
	@$(COMPILE) $(FLAGS) $(OBJS) -c $(NAME) -I $(PATH_INC)

# Compile les objets en binaire avec les flags de sanitize.
# Les dépendances disent qu'il faut compiler les objets, puis vérifier si les objets et les includes ont changé depuis la derniere compilation du binaire bsq_sanitize.
# Si c'est le cas, ou si bsq_sanitize n'existe pas, on rentre dans la regle. Sinon, on ne rentre pas.
$(SANITIZE): $(OBJS) $(INCLUDES)
	@$(COMPILE) $(SANITIZE_FLAGS) $(OBJS) -c $(NAME) -I $(PATH_INC)

# Compile les objets.
# Cette regle sera appellée tour a tour par les dépendances OBJS de la regle name:
# Par exemple: ./objs/main.o <=> $(PATH_OBJS)main.o matche cette règle avec % = main.
# Ensuite Makefile va checker si $(PATH_SRC)%.c <=> ./src/main.c existe.
# Si la dépendance existe, Makefile cherche si il a été modifié depuis la dernière compilation du .o
# Si c'est le cas ou si le .o n'existe pas, Makefile rentre dans la règle. Le cas échéant, rien ne se passe.
$(PATH_OBJ)%.o: $(PATH_SRC)%.c
	@$(COMPILE) $(FLAGS) -o $< -c $@

# Supprime les objets.
clean:
	@rm -rf $(PATH_OBJ)

# Supprime objets et binaires
# Ici, premier cas où l'on appelle une autre règle en dépendance. Elle sera appelée en tant que règle.
# D'ailleurs, au contraire des règles de compilation ci dessus, il n'y a pas de check d'existence/de dates de modification avec ces règles;
# Si la règle est bien dans le .PHONY ce check ne se fera pas et cela évite une erreur comme si on avait un fichier qui a le meme nom qu'une règle Makefile.
# Une fois appelée, on rentre forcément dans une règle, pas comme les règles de compilation
fclean: clean
	@rm -rf $(NAME)

# Supprime tout et recompile. (Fait d'abord un fclean puis un all)
re: fclean all

# Compile et lance le binaire
test: all
	@./$(NAME) $(TEST_FILE)

# Compile et lance le binaire avec fsanitize (pour trouver les segfault)
sanitize: $(SANITIZE)
	@./$(SANITIZE) $(TEST_FILE)
