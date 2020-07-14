#include <stddef.h>
#include "ll_cycle.h"

int ll_has_cycle(node *head) {
	if (head == NULL)
		return 0;
    node *hare = head;
    node *tortoise = head;
    for (int i = 0; ; i++) {
    	if (hare->next == NULL || hare->next->next == NULL) 
    		return 0;
    	else {
    		hare = hare->next->next;
    		tortoise = tortoise->next;
    		if (hare == tortoise)
    			return -1; 
    	}
    }
}