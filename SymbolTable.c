#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "SymbolTable.h"

SymTab* mkSymTab() {
	SymTab* l =  (SymTab*) malloc(sizeof(SymTab));
	l->head = 0;
	l->length = 0;
	l->last = 0;
	l->scopeLevel = 0;
	return l;
}

Variable* mkVariable(int type, void* ptr, char* name, int scopeLevel) {
	Variable* v = (Variable*) malloc(sizeof(Variable));
	v->type = type;
	v->ptr = ptr;
	v->name = name;
	v->scopeLevel = scopeLevel;
	return v;
}

Node* mkNode(Node* prev, Variable* data, Node* next) {
	Node* n = (Node*) malloc(sizeof(Node));
	n->prev = prev;
	n->data = data;
	n->next = next;
	return n;
}

void storeVar(SymTab* l, Variable* data) {
	Node* n = mkNode(0, data, 0);
	if(l->length == 0) {
		l->head = n;
		l->last = n;
	}
	else {
		Node* tmp = l->last;
		tmp->next = n;
		l->last = n;
		n->prev = tmp;
	}
	l->length++;
}

Variable* lookupVariable(SymTab* l, char* varName) {
	Node* n = l->last;
	Node* target = 0;
	while(n != 0) {
		if(strcmp(n->data->name, varName) == 0) {
			return n->data;
		}
		n = n->prev;
	}
	return 0;
}

void enterScope(SymTab* s) {
	s->scopeLevel+=1;
}

void leaveScope(SymTab* s) {
	Node* n = s->head;
	while(n != 0 && n->data->scopeLevel < s->scopeLevel) {
		n = n->next;
	}
	n->prev->next = 0;
	s->last = n->prev;
	while(n != 0) {
		Node* tmp = n;
		n = n->next;
		free(tmp);
	}
	s->scopeLevel--;
}
/*
int main() {
	printf("Testing Symbol Table....\n");
	int n = 5;
	int a = 6;
	int x = 20;
	SymTab* s = mkSymTab();
	storeVar(s, mkVariable(1, &n, "test", s->scopeLevel));
	enterScope(s);
	storeVar(s, mkVariable(1, &a, "test", s->scopeLevel));
	storeVar(s, mkVariable(1, &x, "test2", s->scopeLevel));
	printf("%d\n", *((int *) (lookupVariable(s, "test")->ptr)));
	printf("%d\n", *((int *) (lookupVariable(s, "test2")->ptr)));
	leaveScope(s);
}*/
