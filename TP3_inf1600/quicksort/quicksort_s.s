.text
.globl quicksort_s
quicksort_s:
pushl %ebp
movl %esp, %ebp
pushl %ebx

quicksort:
pushl %ebp
movl %esp, %ebp, 
subl %esp, 0x10 # espace pour 2 variables locales
movl %eax, 8(%ebp) # gauche
movl %edx, 12(%ebp) # droite
subl %edx, %eax # différence droite-gauche
cmpl %edx, 1 # si la taille est <= 1, retour
jle retour

# choisir un pivot
pushl %eax # gauche
pushl %edx # droite
call medianOfThree
addl %esp, 0x8 # nettoyer la pile

# réordonner les éléments du tableau
movl %ebx, %eax # pivot
movl %ecx, %eax # i = gauche
movl %esi, %edx # k = droite - 1

debut_partition:
shll $2, %ecx
addl 8(%ebp), %ecx
movl %edx, %ecx # %edx = T[i]
cmpl %edx, %ebx # %edx - pivot
jge test_k
addl %ecx, 1 # i++
jmp debut_partition
test_k:
shll $2, %esi
addl 8(%ebp), %esi
movl %edx, %esi # %edx = T[k]
cmpl %edx, %ebx # %edx - pivot
jle echanger
subl $1, %esi  # k--
jmp debut_partition
echanger:
shll $2, %ecx
addl 8(%ebp), %ecx
movl %eax, %ecx # %eax = T[i]
shll $2, %esi
addl 8(%ebp), %esi
movl %edx, %esi # %edx = T[k]
shll $2, %ecx
addl 8(%ebp), %ecx
movl %ecx, %edx # T[i] = T[k]
shll $2, %esi
addl 8(%ebp), %esi
movl %esi, %eax # T[k] = %eax
addl $1, %ecx  # i++
subl $1, %esi  # k--
cmpl %ecx, %esi # si i < k, continuer partitionnement
jl debut_partition

# placer le pivot à sa position finale
shll $2, %ecx
addl 8(%ebp), %ecx
movl %eax, %ecx # %eax = T[i]
shll $2, %esi
addl 8(%ebp), %esi
movl %esi, %eax # T[k] = T[i]
shll $2, %ecx
addl 8(%ebp), %ecx
movl %ecx, %ebx # T[i] = pivot

# appel récursif sur les deux partitions
movl %eax, %ecx # pivot_position
subl %eax, 8(%ebp) # pivot_position - gauche
pushl %edx # droite
pushl %eax # droite_partition_size
pushl 8(%ebp) # gauche
call quicksort
addl $12, %esp # nettoyer la pile
movl %eax, %edx # droite
subl %eax, %ecx # droite_partition_size = droite - pivot_position
decl %eax # ne pas trier le pivot deux fois
pushl %eax # gauche_partition_size
pushl 12(%ebp) # droite
pushl %ecx # gauche
call quicksort
addl $12, %esp # nettoyer la pile


retour:   
popl %ebx
leave
ret
