.text
.globl quicksort_s
quicksort_s:
pushl %ebp
movl %esp, %ebp
pushl %ebx

quicksort:
pushl %ebp
movl %ebp, %esp
subl %esp, 0x10 ; espace pour 2 variabl%es local%es
movl %eax, [%ebp+8] ; gauche
movl %edx, [%ebp+12] ; droite
subl %edx, %eax ; différence droite-gauche
cmpl %edx, 1 ; si la taille est <= 1, retour
jl%e fin_quicksort

; choisir un pivot
pushl %eax ; gauche
pushl %edx ; droite
call medianOfThree
addl %esp, 0x8 ; nettoyer la pile

; réordonner les éléments du tableau
movl %ebx, %eax ; pivot
movl %ecx, %eax ; i = gauche
movl %esi, %edx ; k = droite - 1
debut_partition:
movl %edx, [%ebp+8+%ecx4] ; %edx = T[i]
cmpl %edx, %ebx ; %edx - pivot
jg%e t%est_k
addl %ecx, 1 ; i++
jmp d%ebut_partition
test_k:
movl %edx, [%ebp+8+%esi4] ; %edx = T[k]
cmpl %edx, %ebx ; %edx - pivot
jle echanger
subl %esi, 1 ; k--
jmp debut_partition
echanger:
movl %eax, [%ebp+8+%ecx4] ; %eax = T[i]
movl %edx, [%ebp+8+%esi4] ; %edx = T[k]
movl [%ebp+8+%ecx4], %edx ; T[i] = T[k]
movl [%ebp+8+%esi4], %eax ; T[k] = %eax
addl %ecx, 1 ; i++
subl %esi, 1 ; k--
cmpl %ecx, %esi ; si i < k, continuer partitionnement
jl debut_partition

; placer le pivot à sa position finale
movl %eax, [%ebp+8+%ecx4] ; %eax = T[i]
movl [%ebp+8+%esi4], %eax ; T[k] = T[i]
movl [%ebp+8+%ecx*4], %ebx ; T[i] = pivot

; appel récursif sur les deux partitions
movl %eax, %ecx ; pivot_position
subl %eax, [%ebp+8] ; pivot_position - gauche
pushl %edx ; droite
pushl %eax ; droite_partition_size
pushl [%ebp+8] ; gauche
call quicksort
addl %esp, 0xc ; nettoyer la pile
movl %eax, %edx ; droite
subl %eax, %ecx ; droite_partition_size = droite - pivot_position
d%ecl %eax ; n%e pas trier le pivot deux fois
pushl %eax ; gauche_partition_size
pushl [%ebp+12] ; droite
pushl %ecx ; gauche
call quicksort
addl %esp, 0xc ; nettoyer la pile


retour:   
popl %ebx
leave
ret
