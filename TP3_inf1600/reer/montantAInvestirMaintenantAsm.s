.data
.text
.globl _ZN4Reer29montantAInvestirMaintenantAsmEv

_ZN4Reer29montantAInvestirMaintenantAsmEv:
pushl %ebp
movl %esp, %ebp

# DEBUT COMPLETION
pushl %eax
movl 24(%ebp), %eax # eax = le taux interets
movl 12(%ebp), %ebx # ebx = annees avant retraite
movl $100, %ecx
idivl %ecx # eax = taux interets / 100

xorl %edx, %edx # edx = 0
cmp $0, %ebx
je end_exposant # si ebx = 0, on retourne
exposant:
imull %eax, %edx
decl %ebx # decremente ebx
jne exposant
end_exposant:
call _ZN4Reer34montantAmasseFinalAvantRetraiteAsmEv # eax = montant accumule
imul %edx, %eax # eax = le montant investi
# FIN COMPLETION

# NE RIEN MODIFIER APRES CETTE LIGNE
retour:
leave
ret
