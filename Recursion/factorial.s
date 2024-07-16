#Este programa implementa la funcion factorial(n)
#Si n = 1, entonces, factorial(n) = 1 
#Por otro lado, si n > 1, factorial(n) = n*factorial(n-1) 

.data

    n: .word 0x00000003

.text

    lw a0, n #Cargo el argumento "n" en el registo a0
    jal ra, factorial #Realizo un primer llamado a la funcion factorial, con a0 = n como argumento y guardo la direccion de retorno en ra
    j fin #Cuando regrese de la llamada, termino la ejecucion el programa

    factorial:

        addi sp, sp, -8 #Reservo 2 espacios en la pila
        sw ra, 0(sp) #En el primer espacio de la pila guardare la direccion cargada en ra
        sw a0, 4(sp) #En el segundo espacio de la pila guardare el valor actual de a0
        li t1, 1 #Cargo en t1, el valor inmediato 1, que usare para filtrar el caso base
        beq a0, t1, epilogo #Realizo una comparacion entre a0 y 1 (t1). Si a0 es igual a t1, estoy ante el caso base y salto al epilogo para retornar
        addi a0, a0, -1 #Caso contrario, cargo en a0, el valor de n - 1. Y a0, seria igual a (n - 1)
        jal ra, factorial #Realizo un segundo llamado a la funcion factorial de forma recursiva, con a0 = (n - 1) como argumento
        lw t0, 4(sp) #Cargo el valor que habia guardado en el segundo espacio de la pila en t0, t0 = n
        mul a0, t0, a0 #Realizo una multiplicacion entre a0 (factorial(n-1)) y t0 (n). Y a0, seria igual a n*factorial(n-1)
    
    epilogo:

        lw ra, 0(sp) #Cargo como direccion de retorno, la direccion que habia guardado en el primer espacio de la pila 
        addi sp, sp, 8 #Restauro los 2 espacios que le habia pedido a la pila
        ret #Regreso a la direccion de retorno cargada en ra
       
        #Realizo este proceso por cada una de las llamadas recursivas que realice durante la ejecucion del programa
    
    fin:

        li a7, 10
        ecall

#Al finalizar la ejecucion del programa, el valor cargado en a0 deberia ser el resultado de factorial(3) = 6