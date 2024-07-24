#include "Index-Alfa.h"
#include "Matrix_Ops.h"

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main() {
    int m, a;
    int NoOfTuples;
    int Pbits = 0;
    int CheckSum[L] = {0};  // Initialize CheckSum to zeros

    initialize_table();  // Initialize the table with (m, alpha) pairs

    Register Info[T];
    Register QRAM[Q];
    initializeRegisters(Info, T);
    initializeRegisters(QRAM, Q);

    printf("The Info Sequence is:\n");
    for (int i = 0; i < T; i++) {
        for (int j = 0; j < L; j++) {
            Info[i].data[j] = (rand() % 2) ? 1 : 0;
            printf("%d", Info[i].data[j]);
        }
        printf("\n");
    }
    
    
    for (int i = 0; i < Q; i++) {
        NoOfTuples = table[i].count;
        for (int j = 0; j < NoOfTuples; j++) {
            m = table[i].pairs[j].m;
            a = table[i].pairs[j].alpha;

            // Create a local copy of Info[m].data
            int tempInfoSeq[L];
            for (int k = 0; k < L; k++) {
                tempInfoSeq[k] = Info[m].data[k];
            }

            // Perform the right shift on the copy
            rightShift(tempInfoSeq, a);

            // Use tempInfoSeq for further processing
            addValue(QRAM, i, tempInfoSeq);

            // Accumulate the CheckSum based on tempInfoSeq
            for (int k = 0; k < L; k++) {
                CheckSum[k] = (CheckSum[k] + tempInfoSeq[k]) % 2;
            }
        }
    }

    Accumulate(CheckSum);  // Accumulate the CheckSum values

    // Copy the CheckSum to the first row of PRAM
    for (int i = 0; i < L; i++) {
        QRAM[0].data[i] = CheckSum[i];
    }

    ParityCalculator(QRAM);  // Calculate parity bits

    free_table();  // Free allocated memory

    printf("The Parity Bits are:\n");
    for (int i = 0; i < NUM_ROWS; i++) {
        for (int j = 0; j < L; j++) {
            printf("%d", QRAM[i].data[j]);
            Pbits += 1;
        }
        printf("\n");    
    }
    printf("\n");
    printf("The number of parity bits: %d", Pbits);
    printf("\nThe total frame length is: %d", Pbits+(T*360));
    return 0;
}

