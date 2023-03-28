.data
.text
.globl	_ZN4Reer15salaireFinalAsmEv
_ZN4Reer15salaireFinalAsmEv:
pushl %ebp
movl %esp, %ebp

pushl %eax              # Sauvegarder la valeur de EAX sur la pile      

#fetch les paramètres
movl 16(%ebp), %ebx     # ebx prend le 2e paramètre de la classe : salaire de départ
movl 20(%ebp), %edx     # ecx prend le 3e paramètre de la classe : augmentation salariale
movl 28(%ebp), %ecx     # edx prend le dernier paramètre de la classe : anneesAvantRetraite

movl $100, %esi         # esi ==> 100 (pour utiliser le pourcentage)
movl %edx, %eax         # eax prend la valeur augmentation salariale

idivl %esi              # eax ==> le taux d'augmentation salarial (%) / 100 = 0.09
addl $1, %eax           # eax ==> 1 + le taux d'augmentation salariale = 1.09
subl $1, %ecx           # ecx ==> valeur de l'exposant : anneesAavantRetraite - 1 = 29
 

boucle_calcul_exposant:
imul %eax, %eax                 # eax ==> parentheses exposant annees avant retraite-1      
loop boucle_calcul_exposant     # loop (ecx) 29 fois et décrémente à chaque fois 
imul %ebx, %eax                 # eax ==> salaire final = eax * salaire de début
pop %eax                        #récupérer  %eax sauvegardé au début de fonction 


retour:
leave
ret
