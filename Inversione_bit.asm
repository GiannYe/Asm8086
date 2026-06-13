;stampa messaggio iniziale
lea dx, msg
mov ah, 09h
int 21h              

;prendi input
input:
    mov ah, 01h
    int 21h
    
    cmp al, 13
    je esciInput 
    
    sub al, 48
    mov ah, 0
    
    push ax
    mov ax, 10
    mul bx
    pop bx
    add bx, ax
    
    jmp input
    
esciInput:

;da capo e nuova riga
mov ah, 02h
mov dl, 10
int 21h
mov dl, 13
int 21h 

;negazione
not bx
 
;stampa il risultato 
mov cx, 16 

;stampa messaggio
lea dx, msgA
mov ah, 09h
int 21h

stampaBin:
    ;formatazione del testo
    inc si
    
    cmp si, 5
    je spazio
    cmp si, 9
    je spazio
    cmp si, 13
    je spazio
    
    jmp saltaSpazio
    
    spazio:
        mov ah, 02h
        mov dl, 32
        int 21h
    
    saltaSpazio:
    
    rol bx, 1
    jc bit1  
    
    ;bit0
    mov dl, 48
    mov ah, 02h
    int 21h
    
    jmp salta1
    
    bit1: 
    
    mov dl, 49
    mov ah, 02h
    int 21h
    
    salta1:

loop stampaBin

;123 =     0000 0000 0111 1011
;not 123 = 1111 1111 1000 0100 

;da capo e nuova riga
mov ah, 02h
mov dl, 10
int 21h
mov dl, 13
int 21h 

;stampa messaggio
lea dx, msgB
mov ah, 09h
int 21h

mov ax, bx
mov bx, 16
mov cx, 4

stampaHex1:
    mov dx, 0
    div bx
    
    ;formattazione in HEX
    cmp dx, 10
    je X
    cmp dx, 11
    je XI
    cmp dx, 12
    je XII 
    cmp dx, 13
    je XII
    cmp dx, 14
    je XIV     
    cmp dx, 15
    je XV  
    
    jmp saltaHex
    
    X: mov dl, 17   
    XI: mov dl, 18
    XII: mov dl, 19
    XIII: mov dl, 20
    XIV: mov dl, 21
    XV: mov dl, 22 
    
    saltaHex:   
    
    ;metti nello stack
    add dx, 48
    push dx
       
loop stampaHex1
    
mov cx, 4
mov ah, 02h

stampaHex2:
    ;prendi dallo stack
    pop dx    
    int 21h
loop stampaHex2    

msg db "Inserisci il messaggio: $"
msgA db "Binario: $"
msgB db "Esadecimale: $"