.code16 			    
.text 				    

.globl _start

_start:				

	# limpa a tela (função 0x06, int 10h)
	mov $0x06, %ah 		# 0x06 limpa a tela
	mov $0, %al		# em AL vai o parâmetro, nesse caso é 0 (limpa a tela inteira)
	mov $0x07, %bh		# cor de fundo e do texto (fundo preto, texto branco)
	mov $0, %cx		# posição inicial (linha, coluna)
	mov $0x184F, %dx	# última posição (linha 24, coluna 79)
	int $0x10		# chama a interrupção para limpar a tela

	# mover o cursor pra posição (5, 10) - (função 0x02, int 10h)
	mov $0x02, %ah		# 0x02 para mover o cursor
	mov $0, %bh		# página da tela (0)
	mov $5, %dh		# linha
	mov $10, %dl		# coluna
	int $0x10

	# escrever 'A' na tela (função 0x0E, int 10h)
	mov $0x0E, %ah		# 0x0E exibe um caractere
	mov $'A', %al		# movendo o caractere 'A' pra AL
	mov $0x07, %bh		# cor de fundo e do texto (fundo preto, texto branco)
	int $0x10		# chama a interrupção pra exibir o caractere

	hlt

. = _start + 510

.byte 0x55		        
.byte 0xaa		
