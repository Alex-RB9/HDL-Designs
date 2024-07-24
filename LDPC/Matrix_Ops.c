#include <stdio.h>
#include "Matrix_Ops.h"

// Function to initialize the matrix rows
void initializeRegisters(Register registers[], int q) {
    for (int i = 0; i < q; i++) {
        for (int j = 0; j < L; j++) {
            registers[i].data[j] = 0; // Initialize with zero or any default value
        }
    }
}

// Function to right shift an array
void rightShift(int arr[], int alpha) {
    int temp[L];
    // Perform right shift
    for (int i = 0; i < L; i++) {
        temp[(i + alpha) % L] = arr[i];
    }
    // Copy temp array to original array
    for (int i = 0; i < L; i++) {
        arr[i] = temp[i];
    }
}

// Function to add a value from an information sequence to a row (register)
void addValue(Register registers[], int regIndex, int InfoSeq[]) {
    if (regIndex >= 0 && regIndex < Q) {
        for (int i = 0; i < L; i++) {
            // Perform modulo-2 addition
            registers[regIndex].data[i] = (registers[regIndex].data[i] + InfoSeq[i]) % 2;
        }
    } else {
        printf("Index out of bounds\n");
    }
}

// Function to compute the column-wise cumulative sum
void Accumulate(int CheckSum[]) {
    // Compute cumulative sum
    for (int i = 1; i < L; i++) {
        CheckSum[i] += CheckSum[i - 1];
        CheckSum[i] = CheckSum[i] % 2;
    }

    CheckSum[L-1] = 0;
    rightShift(CheckSum, 1); 
}

// Function to calculate parity
void ParityCalculator(Register QRAM[]) {
    for (int i = 1; i < Q; i++) {
        for (int j = 0; j < L; j++) {
            QRAM[i].data[j] = (QRAM[i-1].data[j] + QRAM[i].data[j]) % 2; 
        }
    }  
}
