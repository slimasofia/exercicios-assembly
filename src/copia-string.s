.code16
.text
.globl _start

_start:
    movw $source_string, %si  # carrega o endereço da string fonte em SI
    movw $dest_string, %di    # carrega o endereço da string destino em DI

copy_loop:
    movb (%si), %al           # lê um byte da string 
    movb %al, (%di)           # copia o byte para a string destino
    inc %si                   # avança para o próximo byte na string original
    inc %di                   # avança para o próximo byte no destino
    cmpb $0, %al              # verifica se o byte copiado é o terminador nulo '\0'
    jne copy_loop             # continua copiando enquanto não encontrar '\0'

end_program:
    hlt                   


source_string:
    .ascii "Hello, World!\0" 
dest_string:
    .space 50                 # espaço reservado para a cópia da string

. = _start + 510
.byte 0x55
.byte 0xaa

