
.code16
.text

.globl _start

_start:

    # Ler um caractere do teclado
    movb $0x00, %ah        # Configura a função 0x00 da int 16h (ler teclado)
    int $0x16              # Chama a interrupção 16h (AL contém o caractere lido)

    # Salvar o caractere lido no registrador DL (para exibição depois)
    movb %al, %dl          # Copia o caractere de AL para DL

    # Pular para a linha seguinte
    movb $0x0E, %ah        # Configura a função 0x0E da int 10h
    movb $0x0D, %al        # Carrega '\r' (retorno ao início da linha) em AL
    int $0x10              # Exibe '\r'
    movb $0x0A, %al        # Carrega '\n' (nova linha) em AL
    int $0x10              # Exibe '\n'

    # Exibir o caractere salvo
    movb $0x0E, %ah        # Configura a função 0x0E da int 10h
    movb %dl, %al          # Recupera o caractere original salvo em DL para AL
    int $0x10              # Exibe o caractere armazenado em AL

    hlt



. = _start + 510
.byte 0x55
.byte 0xaa
