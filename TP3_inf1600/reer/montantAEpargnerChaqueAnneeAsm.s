.data
.text
.globl _ZN4Reer30montantAEpargnerChaqueAnneeAsmEv

_ZN4Reer30montantAEpargnerChaqueAnneeAsmEv:
pushl %ebp
movl %esp, %ebp

# DEBUT COMPLETION 
pushl %eax
movl 12(%ebp), %edx # edx = nombre d'années avant la retraite
movl 24(%ebp), %eax # eax = taux d'intérêt
movl $100, %ebx
idivl %ebx # eax = taux d'intérêt en pourcentage
exposant:
movl %eax, %ecx # ecx = taux d'intérêt en pourcentage
incl %ecx # ecx = taux d'intérêt en pourcentage + 1
decl %edx # edx = nombre d'années avant la retraite - 1
imul %ecx, %edx
loop exposant
idivl %edx
movl %eax, %ecx
call _ZN4Reer34montantAmasseFinalAvantRetraiteAsmEv
imul %ecx, %eax # eax = épargne
# FIN COMPLETION

# NE RIEN MODIFIER APRES CETTE LIGNE
retour:
leave
ret
