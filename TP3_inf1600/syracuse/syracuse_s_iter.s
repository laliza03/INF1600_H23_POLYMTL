.data
val_init: 15

.text
.globl syracuse_s_iter
.globl afficher
syracuse_s_iter:

pushl   %ebp
movl    %esp, %ebp
pushl   %ebx


movl , %esi            ; initiliser l'itterateur à 1
movl $0, %ebx      ; Mettre la valeur à vérifier dans le registre EAX

verif:
and %ebx, 0x01          ; Effectuer l'opération AND avec la valeur 1
jz pair                 ; Sauter à l'étiquette "pair" si le résultat est zéro (nombre pair)

impair:
imul %ebx, 3 

cmp $1, %ebx
je retour 
jump verif                ; Sinon, le nombre est impair :     

pair:


cmp $1, %ebx
je retour 
jmp verif


# FIN COMPLETION
# NE RIEN MODIFIER APRES CETTE LIGNE
retour:   
popl %ebx
leave
ret
