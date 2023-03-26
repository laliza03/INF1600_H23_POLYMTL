.text
.globl syracuse_s_iter
.globl afficher
syracuse_s_iter:

pushl   %ebp
movl    %esp, %ebp
pushl   %ebx

initialisateur_registres:
movl 8(%ebp), %eax  #chercher le premier paramètre stocké dans la pile Un = 15
xor %ebx, %ebx      #inialisation du registre ebx à 0
xor %ecx, %ecx      #initialiser l'iterration à  i = 0
xor %edx, %edx      #inialisation du registre edx à 0


affichage_avec_call: 
pushl %eax          #sauvegarde eax dans la pile
pushl %ecx          #sauvegarde ecx dans la pile
call afficher       #appel de la fonction "afficher" qui se trouve dans le main
popl %ecx
popl %eax


boucle_verification: 
cmp $1, %eax        #vérifier si Un qu'on vient de load = 1 (donc fin du programme)
je retour
movl $1, %edx
and %eax, %edx      #AND avec la valeur 1 equivalent à faire division par 2 et voir si le reste est 0
incl %ecx           #incrémenter i++ 
pushl %eax          #affichage de Un dans la pile ==> stocker valeur
cmpl $0, %edx       #compare si le reste est 0 dans edx
jne impair          #jmp à impair si le résultat est != zéro ==> le nombre est impair
jmp pair            #jmp à paire si le résultat est zéro ==> le nombre est pair


impair: 
imull $3, %eax     #3*Un
addl $1, %eax      #(3*UN) + 1
jmp affichage_avec_call
                 

pair: 
popl %eax
shrl $1, %eax      #shift right une fois est équivalent à faire division par 2
jmp affichage_avec_call


retour:   
popl %ebx
leave
ret
