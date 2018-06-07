;A2.asm
;显示程序实验

STACK1  SEGMENT STACK USE16
        DW 128 DUP(?)
STACK1    ENDS

DATA    SEGMENT
        MSG     DB    'PLEASE INPUT A STRING', 0AH, 0DH, '$'
        N       EQU   20
        BUF     DB    N + 1
        SPACE   DB    20
        EXITMSG DB    'EXIT', 0AH, 0DH, '$'
DATA    ENDS

CODE    SEGMENT USE16
        ASSUME  CS: CODE, DS: DATA 

START:  
        MOV     AX, DATA
        MOV     DS, AX
        
        LEA     DX, MSG
        MOV     AH, 09H
        INT     21H
        
        LEA     DX, BUF
        MOV     AH, 0AH
        INT     21H
        
EXITMSGBLOCK:
        LEA     DX, EXITMSG
        MOV     AH, 09H
        INT     21H
        
EXIT:    
        MOV     AX, 4C00H
        INT     21H
        
CODE    ENDS
        END     START
