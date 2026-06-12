;messaggio iniziale
lea dx, msg
mov ah, 09h
int 21h

;riga nuova e da capo        
mov ah, 02h
mov dl, 10
int 21h
mov dl, 13
int 21h

mov dx, 0
mov ax, 0

;indirizzo della testa del vettore in bx
lea bx, v

;imposta le prime 2 celle a 1
mov [bx], 1
mov [bx + 1], 1

mov si, 2 
mov cx, 8

riempi_v:     
    mov al, 0       
    
    ;aggiungi quello precedente  
    add al, [bx + si - 1]
    
    ;aggiungi quello ancora precedente
    add al, [bx + si - 2] 
    
    mov [bx + si], al 
    
    ;prossima cella 
    inc si   
loop riempi_v 

mov si, 0
mov cx, 10
mov ax, 0

stampa_v:
    ;pulisci ah
    mov ah, 0
    lea bx, v
    mov al, [bx + si] 
    
    ;prendi 10 per dividere
    mov bl, 10
    
    ;useremmo di per calcolare la lunghezza del 
    ;numero
    mov di, 0
    
    scomponimento:  
        ;pulisci ah         
        mov ah, 0 
        
        ;dividi ax per bl e conta  
        div bl
        inc di
        
        ;salva ax nello stack
        ;il resto e' in ah
        push ax
        
        ;se il quoziente e' 0, esci,
        ;altrimenti rifai tutto
        cmp al, 0
    jne scomponimento
    
    ricomponimento:
        ;metti la cifra in dx                            
        pop dx
        
        ;porta il resto a dl e pulisci dh
        mov dl, dh
        mov dh, 0
        
        ;trasforma il codice ascii in numero        
        add dl, 48 
        
        ;stampa
        mov ah, 02h
        int 21h
        
        dec di
        cmp di, 0        
    jne ricomponimento
    
    ;stampa spazio
    mov dl, 32 
    mov ah, 02h
    int 21h       
    
    ;prossima cella   
    inc si    
loop stampa_v

msg db "Primi 10 numeri della sequenza Fibonacci: $"
v db 10 dup(0)