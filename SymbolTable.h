#ifndef __SYMVOLTABLE_H_
#define __SYMVOLTABLE_H_

typedef struct Variable_s {
	int type;
	void* ptr;
	char* name;
	int scopeLevel;
} Variable;

typedef struct TokenInformation {
	char* name;
	double val;
} TokenInfo;

typedef struct Node_s {
	struct Node_s* next;
	struct Node_s* prev;
	Variable* data;
} Node;

typedef struct SymTab_s {
	Node* head;
	long length;
	Node* last;
	long scopeLevel;
} SymTab;

SymTab* mkSymTab();

Variable* mkVariable(int type, void* ptr, char* name, int scopeLevel);

void storeVar(SymTab* l, Variable* data);

Variable* lookupVariable(SymTab* l, char* varName);

void enterScope(SymTab* s);

void leaveScope(SymTab* s);

Node* mkNode(Node* prev, Variable* data, Node* next);

#endif
