CC = gcc

CCFLAGS = -ggdb

C_FILES = SymbolTable.c
H_FILES = SymbolTable.h
LEX_FILES = Language.lex Language.y

SOURCE = $(C_FILES) $(H_FILES) $(LEX_FILES)

INTERMEDIATE = Language.yy.c SymbolTable.o Language.tab.c Language.output Language.dSYM Language-lex.dSYM SymbolTable.h.gch $(EXECS)

EXECS = Language Language-lex

all:	Language

Language:	Language.tab.c Language.yy.c SymbolTable.o
	$(CC) $(CCFLAGS) -o Language Language.tab.c SymbolTable.o

lex:	Language.yy.c SymbolTable.o
	$(CC) $(CCFLAGS) -DTestLex -o Language-lex Language.yy.c SymbolTable.o
SymbolTable.o:
	$(CC) $(CCFLAGS) -c $(C_FILES) $(H_FILES)

Language.yy.c:	Language.tab.c
	flex -oLanguage.yy.c Language.lex

Language.tab.c:	Language.y SymbolTable.o
	bison -v Language.y

clean:
	rm -r $(INTERMEDIATE) core 2> /dev/null

realclean:	clean
	rm -r $(EXECS) core 2> /dev/null
