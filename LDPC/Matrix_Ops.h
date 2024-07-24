#ifndef MATRIX_OPS_H
#define MATRIX_OPS_H

#define T 20
#define Q 24  // Number of rows (registers)
#define L 360  // Number of columns per row


typedef struct {
    int data[L]; // Array to hold values in a row
} Register;

// Function prototypes
void initializeRegisters(Register registers[], int q);
void rightShift(int arr[], int alpha);
void addValue(Register registers[], int regIndex, int InfoSeq[]);
void Accumulate(int CheckSum[]);
void ParityCalculator(Register QRAM[]);

#endif

