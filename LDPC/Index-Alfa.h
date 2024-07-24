#ifndef INDEX_ALFA_H
#define INDEX_ALFA_H

#include <stdlib.h> 


typedef struct {
    int m;
    int alpha;
} Tuple;

// Define a row in the table, consisting of a count and a dynamic array of Tuples
typedef struct {
    int count;  // Number of valid (m, alpha) pairs
    Tuple* pairs;
} Row;

// Number of rows in the table
#define NUM_ROWS 24

// Declare the global table array
extern Row table[NUM_ROWS];

// Function prototypes for table operations
void initialize_table();
void print_table();
void free_table();

#endif // INDEX_ALFA_H
