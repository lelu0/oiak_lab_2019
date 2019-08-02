.data
texts: .long 5

.text
.global main
main:

movl texts, %edi #in 32 args are on stack
pushl %edi
call powerfunc

#w przypadku wielu argumentow dodajemy je w odwrotnej kolejnosci niz wystepuja w deklaracji funkcji
movl $4, %edi
pushl %edi
movl $6, %edi
pushl %edi
call printfunc

movl $0, %eax
call exit
