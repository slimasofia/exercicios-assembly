.code16
.text

.globl _start

_start:

	lea string1, %si          # carrega o endereço de 'string1' em SI (string "Hello")
	lea string2, %bx          # carrega o endereço de 'string2' em BX (string " World!")

	# Carregar o endereço da área de destino (onde a concatenação será armazenada)
	lea concatenated_string, %di 

	# Copiar a primeira string
copy_string1:
	lodsb                     # carrega um byte de 'string1' em AL
	testb %al, %al            # verifica se chegou ao final da string (byte nulo 0x00)
	jz copy_string2           # se for 0x00, saltar para a cópia da segunda string

	stosb                     # armazena o byte de AL na área de destino (concatenated_string)
	jmp copy_string1          # continua copiando os caracteres da primeira string

	# copiar a segunda string
copy_string2:
	lodsb                     
    	testb %al, %al           
    	jz display_string      

	stosb                
    	jmp copy_string2    


	# exibir a string concatenada para verificar se deu certo

display_string:
	lea concatenated_string, %si  # carrega o endereço de 'concatenated_string' em SI

display_loop:
	lodsb                     # carrega o próximo byte da string concatenada em AL
	testb %al, %al            # verifica se é o final da string (0x00)
	jz end_program            # se for 0x00, termina o programa

	movb $0x0E, %ah          
	int $0x10              
	jmp display_loop          # continua para o próximo caractere

end_program:
	hlt                       

string1:
    	.asciz "Hello"           

string2:
    	.asciz " World!"          

concatenated_string:
    	.space 40                 # para armazenar a string concatenada



. = _start + 510
.byte 0x55
.byte 0xaa

