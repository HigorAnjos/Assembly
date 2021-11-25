section .data ; Segmento de dados
barraN equ 10 ;
 
chave db " ZENITzenit-POLARpolar", barraN
tamanho_da_chave equ $-chave    ;Calcula o tamanho da string
 
chave2 db "-POLARpolar ZENITzenit", barraN
tamanho_da_chave2 equ $-chave2    ;Calcula o tamanho da string
 
section .bss ; Segmento de dados não inicializados
 
mensagem_lida resb 100 ; Reservando espaco na memoria
tamanho_da_mensagem_lida resb 2 

 
section .text ; Segmento de código
global _start ; O ligador ld
_start: ; Ponto de entrada
 
; Lendo da STDIN
    mov eax,3 ; READ
    mov ebx,0 ; FD do teclado (STDIN)
    mov ecx, mensagem_lida ; Ponteiro de destino da string
    mov edx,100 ; Máximo
    int 80h
 
; em eax retorna a quantidade de bytes
    mov [tamanho_da_mensagem_lida],eax ; Movendo para dentro espaco que foi alocado [Endereco]
;
;For pra andar ate o fim da string
 
xor esi,esi 
 
for_inicio:
 
    mov eax, [tamanho_da_mensagem_lida]
    dec eax
    cmp esi,eax
    je Imprimi
    
xor edi, edi
 
busca_:
    
    mov eax, tamanho_da_chave
    dec eax
    cmp edi,eax
    je end_for
    
    mov al, [chave+edi]
    cmp [mensagem_lida+esi], al
    jne end_busca
    
troca:
    mov al, [chave2+edi]
    mov [mensagem_lida+esi], al
    jmp end_for
    
end_busca:
    inc edi
    jmp busca_
    
end_for: 
    inc esi
    jmp for_inicio
 
Imprimi:
    mov ecx, mensagem_lida
    mov edx, [tamanho_da_mensagem_lida]
    mov eax, 4
    mov ebx, 1
    int 80h
Sai:
; Encerrando
    mov eax,1 ; EXIT
    int 0x80 ; Chamada ao sistema
