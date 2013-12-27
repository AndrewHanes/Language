CC = gcc

CCFLAGS = -ggdb

C_FILES = SymbolTable.c
H_FILES = SymbolTable.h
LEX_FILES = Language.lex

SOURCE = $(C_FILES) $(H_FILES) $(LEX_FILES)

INTERMEDIATE = Language.yy.c SymbolTable.o Language.tab.c

EXECS = Language

all:	Language

Language:	Language.tab.c Language.yy.c SymbolTable.o
	$(CC) $(CCFLAGS) -o Language Language.tab.c Language.yy.c SymbolTable.o

SymbolTable.o:
	$(CC) $(CCFLAGS) -c $(C_FILES) $(H_FILES)

Language.yy.c:
	flex -oLanguage.yy.c Language.lex

Language.tab.c:	Language.y SymbolTable.h
	bison -v  Language.y

clean:
	rm $(INTERMEDIATE) $(EXECS)
	rm -r Language.dSYM
	rm SymbolTable.h.gch
