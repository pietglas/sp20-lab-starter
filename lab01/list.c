#include "list.h"
#include <stdio.h>

/* Add a node to the end of the linked list. Assume head_ptr is non-null. */
void append_node (node** head_ptr, int new_data) {
	struct node *new_tail = malloc(sizeof *new_tail);
	new_tail->val = new_data;
	new_tail->next = NULL;

	/* If the list is empty, set the new node to be the head and return */
	if (*head_ptr == NULL) {
		/* YOUR CODE HERE */
		return;
	}
	node* curr = *head_ptr;
	while (curr->next != NULL) {
		curr = curr->next;
	}
	curr->next = new_tail;
}

/* Reverse a linked list in place (in other words, without creating a new list).
   Assume that head_ptr is non-null. */
void reverse_list (node** head_ptr) {
	node* prev = NULL;
	node* curr = *head_ptr;
	node* next = NULL;
	while (curr != NULL) {
		next = curr->next;
		curr->next = prev;
		prev = curr;
		curr = next;
	}
	/* Set the new head to be what originally was the last node in the list */
	*head_ptr = prev;
}

/* Deletes the list with front **head_ptr */
void delete_list(node** head_ptr) {
	node *next;
	while (*head_ptr != NULL) {
		next = (*head_ptr)->next;
		free(*head_ptr);
		*head_ptr = next;
	}
}

void print_list(node** head_ptr) {
	node *curr = *head_ptr;
	while (curr != NULL) {
		printf("%d, ", curr->val);
		curr = curr->next;
	}
	printf("\n");
}

int main() {
	struct node *node0 = malloc(sizeof *node0);
	node0->val = 0;
	node0->next = NULL;

	for (int i = 1; i < 6; i++) {
		append_node(&node0, i);
	}
	print_list(&node0);
	reverse_list(&node0);
	print_list(&node0);
	delete_list(&node0);
}



