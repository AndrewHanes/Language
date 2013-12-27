CC = gcc

CCFLAGS = -ggdb

C_FILES = SymbolTable.c
H_FILES = SymbolTable.h
LEX_FILES = Language.lex

SOURCE = $(C_FILES) $(H_FILES) $(LEX_FILES)

INTERMEDIATE = scanner.yy.c SymbolTable.o

EXECS = Language

all:	Language

Language:	Language.yy.c SYMTAB
	$(CC) $(CCFLAGS) -o Language Language.yy.c SymbolTable.o

SYMTAB:
	$(CC) $(CCFLAGS) -c $(C_FILES) $(H_FILES)

Language.yy.c:
	flex -oLanguage.yy.c Language.lex

clean:
	rm $(INTERMEDIATE)
