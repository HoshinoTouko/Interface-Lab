data segment
    msg     db 'PLEASE INPUT A STRING', 0AH, 0DH, 0AH, 0DH, '$'
    buff    db 255         ; Buffer
    db ?
    db 255 dup (?)
    crlf    db 0ah, 0dh, "$"    ; Next line
data    ends

 

code segment
    assume ds:data, cs:code

start:
    mov     ax, data    ; Save data to ds.
    mov     ds, ax

    lea     dx, msg
    mov     ah, 09h
    int     21h

    lea     dx, buff    ; Input string
    mov     ah, 0ah
    int     21h

    lea     si, buff + 2h    ; Load the address of string to si
    mov     cl, buff + 1h    ; Load the number of character to cl

next:
    lea     dx, crlf    ; Newline
    mov     ah, 9h
    int     21h

    cmp     cl, 0h
    je      finish

    mov     dl, byte ptr [si]   ;   Output a character.
    mov     ah, 2h
    int     21h

    ; Save character.
    mov     bl, dl 

    mov     dl, 20h
    mov     ah, 2h
    int     21h

    ; The first digit of character's ascii.
    mov     dl, bl ; Load character from temp register.
    shr     dl, 1
    shr     dl, 1
    shr     dl, 1
    shr     dl, 1

    cmp     dl, 20h
    je      skip_all_one
    cmp     dl, 0ah
    jb      skip_add_one

    add     dl, 49
skip_add_one:
    add     dl, 48
skip_all_one:
    mov     ah, 2h
    int     21h

    ; The first digit of character's ascii.
    mov     dl, bl ; Load character from temp register.
    shl     dl, 1
    shl     dl, 1
    shl     dl, 1
    shl     dl, 1
    shr     dl, 1
    shr     dl, 1
    shr     dl, 1
    shr     dl, 1

    cmp     dl, 20h
    je      skip_all_two
    cmp     dl, 0ah
    jb      skip_add_two

    add     dl, 49
skip_add_two:
    add     dl, 48
skip_all_two:
    mov     ah, 2h
    int     21h

    dec     cl    ; Counter decrement
    inc     si
    jmp     next

finish:
    mov     ah, 4ch
    int     21h

code ends
    end     start
