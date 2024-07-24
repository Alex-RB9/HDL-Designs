#include "Index-Alfa.h"
#include<stdio.h>

Row table[NUM_ROWS];

void initialize_table() {
    // Allocate memory for tuples and populate the table
    table[0].count = 3;
    table[0].pairs = (Tuple*)malloc(table[0].count * sizeof(Tuple));
    table[0].pairs[0] = (Tuple){5, 0};
    table[0].pairs[1] = (Tuple){9, 26};
    table[0].pairs[2] = (Tuple){19, 222};

    table[1].count = 4;
    table[1].pairs = (Tuple*)malloc(table[1].count * sizeof(Tuple));
    table[1].pairs[0] = (Tuple){1, 125};
    table[1].pairs[1] = (Tuple){2, 132};
    table[1].pairs[2] = (Tuple){2, 323};
    table[1].pairs[3] = (Tuple){6, 0};

    table[2].count = 4;
    table[2].pairs = (Tuple*)malloc(table[2].count * sizeof(Tuple));
    table[2].pairs[0] = (Tuple){3, 217};
    table[2].pairs[1] = (Tuple){3, 248};
    table[2].pairs[2] = (Tuple){4, 112};
    table[2].pairs[3] = (Tuple){7, 0};

    table[3].count = 4;
    table[3].pairs = (Tuple*)malloc(table[3].count * sizeof(Tuple));
    table[3].pairs[0] = (Tuple){1, 107};
    table[3].pairs[1] = (Tuple){4, 280};
    table[3].pairs[2] = (Tuple){8, 17};
    table[3].pairs[3] = (Tuple){7, 239};

    table[4].count = 2;
    table[4].pairs = (Tuple*)malloc(table[4].count * sizeof(Tuple));
    table[4].pairs[0] = (Tuple){0, 106};
    table[4].pairs[1] = (Tuple){9, 0};

    table[5].count = 1;
    table[5].pairs = (Tuple*)malloc(table[5].count * sizeof(Tuple));
    table[5].pairs[0] = (Tuple){6, 246};

    table[6].count = 2;
    table[6].pairs = (Tuple*)malloc(table[6].count * sizeof(Tuple));
    table[6].pairs[0] = (Tuple){11, 0};
    table[6].pairs[1] = (Tuple){13, 176};

    table[7].count = 2;
    table[7].pairs = (Tuple*)malloc(table[7].count * sizeof(Tuple));
    table[7].pairs[0] = (Tuple){2, 220};
    table[7].pairs[1] = (Tuple){18, 318};

    table[8].count = 2;
    table[8].pairs = (Tuple*)malloc(table[8].count * sizeof(Tuple));
    table[8].pairs[0] = (Tuple){2, 154};
    table[8].pairs[1] = (Tuple){14, 314};

    table[9].count = 2;
    table[9].pairs = (Tuple*)malloc(table[9].count * sizeof(Tuple));
    table[9].pairs[0] = (Tuple){5, 83};
    table[9].pairs[1] = (Tuple){15, 205};

    table[10].count = 2;
    table[10].pairs = (Tuple*)malloc(table[10].count * sizeof(Tuple));
    table[10].pairs[0] = (Tuple){4, 313};
    table[10].pairs[1] = (Tuple){10, 215};

    table[11].count = 3;
    table[11].pairs = (Tuple*)malloc(table[11].count * sizeof(Tuple));
    table[11].pairs[0] = (Tuple){1, 198};
    table[11].pairs[1] = (Tuple){16, 265};
    table[11].pairs[2] = (Tuple){19, 64};

    table[12].count = 2;
    table[12].pairs = (Tuple*)malloc(table[12].count * sizeof(Tuple));
    table[12].pairs[0] = (Tuple){0, 318};
    table[12].pairs[1] = (Tuple){16, 352};

    table[13].count = 3;
    table[13].pairs = (Tuple*)malloc(table[13].count * sizeof(Tuple));
    table[13].pairs[0] = (Tuple){2, 263};
    table[13].pairs[1] = (Tuple){17, 310};
    table[13].pairs[2] = (Tuple){18, 21};

    table[14].count = 2;
    table[14].pairs = (Tuple*)malloc(table[14].count * sizeof(Tuple));
    table[14].pairs[0] = (Tuple){1, 237};
    table[14].pairs[1] = (Tuple){18, 223};

    table[15].count = 2;
    table[15].pairs = (Tuple*)malloc(table[15].count * sizeof(Tuple));
    table[15].pairs[0] = (Tuple){1, 233};
    table[15].pairs[1] = (Tuple){18, 45};

    table[16].count = 2;
    table[16].pairs = (Tuple*)malloc(table[16].count * sizeof(Tuple));
    table[16].pairs[0] = (Tuple){3, 317};
    table[16].pairs[1] = (Tuple){16, 358};

    table[17].count = 2;
    table[17].pairs = (Tuple*)malloc(table[17].count * sizeof(Tuple));
    table[17].pairs[0] = (Tuple){3, 174};
    table[17].pairs[1] = (Tuple){15, 171};

    table[18].count = 2;
    table[18].pairs = (Tuple*)malloc(table[18].count * sizeof(Tuple));
    table[18].pairs[0] = (Tuple){1, 259};
    table[18].pairs[1] = (Tuple){2, 213};

    table[19].count = 2;
    table[19].pairs = (Tuple*)malloc(table[19].count * sizeof(Tuple));
    table[19].pairs[0] = (Tuple){2, 350};
    table[19].pairs[1] = (Tuple){15, 93};

    table[20].count = 1;
    table[20].pairs = (Tuple*)malloc(table[20].count * sizeof(Tuple));
    table[20].pairs[0] = (Tuple){4, 180};

    table[21].count = 2;
    table[21].pairs = (Tuple*)malloc(table[21].count * sizeof(Tuple));
    table[21].pairs[0] = (Tuple){1, 168};
    table[21].pairs[1] = (Tuple){9, 184};

    table[22].count = 1;
    table[22].pairs = (Tuple*)malloc(table[22].count * sizeof(Tuple));
    table[22].pairs[0] = (Tuple){1, 131};

    table[23].count = 5;
    table[23].pairs = (Tuple*)malloc(table[23].count * sizeof(Tuple));
    table[23].pairs[0] = (Tuple){3, 148};
    table[23].pairs[1] = (Tuple){3, 183};
    table[23].pairs[2] = (Tuple){4, 0};
    table[23].pairs[3] = (Tuple){10, 124};
    table[23].pairs[4] = (Tuple){11, 199};
}

void print_table() {
    for (int i = 0; i < NUM_ROWS; i++) {
        for (int j = 0; j < table[i].count; j++) {
            printf("%d\t%d\t", table[i].pairs[j].m, table[i].pairs[j].alpha);
        }
        printf("\n");
    }
}

void free_table() {
    // Free allocated memory for each row
    for (int i = 0; i < NUM_ROWS; i++) {
        free(table[i].pairs);
    }
}
