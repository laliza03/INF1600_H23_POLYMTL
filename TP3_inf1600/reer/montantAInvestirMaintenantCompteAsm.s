.data
.text
COMPTE:
.double 1.0550000000000000044
ENCAISSE:
.int 123570
.globl _ZN6Compte29montantAInvestirMaintenantAsmEv

_ZN6Compte29montantAInvestirMaintenantAsmEv:
pushl %ebp
movl %esp, %ebp

# DEBUT COMPLETION
pushl %eax
movl 12(%ebp), %eax
movl 8(%ebp), %ebx   # ebx = parametre anneeAvantRetraite
pushl %eax
call _ZN4Reer15salaireFinalEv # appel de la methode
addl $4, %esp
negl %ebx # calcul du montant a investir
fldl COMPTE
fyl2x
fildl %ebx
fld1
fyl2x
fmulp
fmulp
fldl ENCAISSE
fsubp
# FIN COMPLETION

# NE RIEN MODIFIER APRES CETTE LIGNE
retour:
leave
ret
