.data
.text
.globl _ZN4Reer34montantAmasseFinalAvantRetraiteAsmEv

_ZN4Reer34montantAmasseFinalAvantRetraiteAsmEv:
pushl %ebp
movl %esp, %ebp

pushl %esi
movl 24(%ebp), %ebx                 # ebx prend le paramètre : taux d'intérêts
movl 28(%ebp), %ecx                 # ecx prend le paramètre : année de retraite 
movl 32(%ebp), %eax                 # eax prend le paramètre : salaire voulu
movl $100, %esi                     # esi ==> 100 (pour utiliser le pourcentage)
idivl %esi
movl %eax, %edx                     # edx contient la valeur du salaire voulu en pourcentage

#calcul du salaire de Retraite
call _ZN4Reer15salaireFinalAsmEv
imul %edx, %eax       
idivl %esi 
movl %eax, %edx                     # edx contient maintenant le salaire de retraite

#calcul du taux intérets et de l'exposant
movl %ebx, %eax
idivl %esi                          # eax : taux d'intérêts 
addl $1, %eax                       # eax : taux d'intérêts + 1
subl $1, %ecx                       # ecx : année de retraite - 1 (exposant_numérateur)

exposant_numérateur:
imul %eax, %eax                     # loop avec nbr de valeur de ecx iterrations
loop exposant_numérateur
movl %eax, %ebx                     # ebx : valeur numérateur
decl %eax                           
movl %eax, %esi                     # esi : taux d'intérêts
incl %eax                           


exposant_dénominateur:
imul %eax, %eax                     # loop avec nbr annees de retraite iterrations  
loop exposant_dénominateur
imul %esi, %eax                     # eax : valeur dénominateur
movl %ebx, %ecx                     # sauvegarde numérateur dans ecx
movl %eax, %ebx                     # ebx : valeur dénominater
movl %ecx, %eax                     # eax : valeur numérateur
idivl %ebx                          # eax / ebx

# calcul final du montant accumulé
imul %edx, %eax                     # eax contient le montant total accumulé

retour:
leave
ret
