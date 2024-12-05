.code16 			    
.text 				    

.globl _start

_start:
	movb $0x00, %ah		# configurando o registrador ah com o número da função (AH = 0 lê um caractere do teclado)
	int $0x16		# chamando a interrupção (o código ASCII do caractere lido é retornado em AL) *com a int 21h não estava funcionando

	movb $0x0E, %ah		# a função 02 espera o caractere a ser mostrado em DL
	int $0x10		# chama a interrupção 10h para exibir o caractere que está em AL 

	hlt

. = _start + 510

.byte 0x55		        
.byte 0xaa		   
