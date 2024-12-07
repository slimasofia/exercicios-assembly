.code16
.text
.globl _start

_start:
	movw $array, %si      # carrega o endereço do início do array em SI
	movb array_size, %cl  # carrega o tamanho do array em CL

	call sort_array      

	movw $array, %si      # carrega o endereço do array ordenado em SI
	call print_array     

	hlt                  

# ordenar o array em ordem crescente
sort_array:
    	movb array_size, %cl  # número de elementos no array (contador externo)
outer_loop:
    	dec %cl               # decrementa o loop externo
    	movb %cl, %ch         # prepara CH para o contador interno
    	movw $array, %si      # reinicia SI no início do array
    	jz end_sort           # se CL for zero, encerra a ordenação
inner_loop:
    	mov (%si), %al        # carrega o elemento atual em AL
    	mov 1(%si), %bl       # carrega o próximo elemento (SI +1) em BL
    	cmp %bl, %al          # compara os dois elementos
    	jbe no_swap           # se já estiverem em ordem, pula a troca
    	mov %bl, (%si)        # troca os dois elementos
    	mov %al, 1(%si)
no_swap:
    	inc %si               # avança para o próximo par de elementos
    	dec %ch               # reduz o contador interno
    	jnz inner_loop        # repete o loop interno até CH chegar a zero
    	jmp outer_loop        # repete o loop externo
end_sort:
    	ret                  

# para exibir o array na tela e verificar se deu certo:
print_array:
    	movb array_size, %cl  # carrega o tamanho do array
print_loop:
    	mov (%si), %al        # carrega o próximo elemento do array
    	add $'0', %al         # converte o número para caractere ASCII
    	mov $0xe, %ah         # para escrever na tela (int 0x10, função 0xe)
    	int $0x10            
    	inc %si               # vai pro próximo elemento
    	dec %cl               # decrementa o contador
    	jnz print_loop        # repete até exibir todos os elementos
    	ret                 

array:
    .byte 2, 9, 7	      # (só funciona pra números de 1 dígito)    
array_size:
    .byte 3              

. = _start + 510
.byte 0x55
.byte 0xaa

