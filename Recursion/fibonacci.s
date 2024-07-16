#Este programa implementa la funcion fibonacci(n)
#Si n = 0, entonces, fibonacci(n) = 0
#Si n = 1, entonces, fibonacci(n) = 1 
#Por otro lado, si n > 1, fibonacci(n) = fibonacci(n-1) + fibonacci(n-2) 

.data   

    n: .word 0x00000003

.text

    lw a0, n #Cargo el argumento "n" en el registo a0
    jal ra, fibonacci #Realizo un primer llamado a la funcion fibonacci, con a0 = n como argumento y guardo la direccion de retorno en ra
    j fin #Cuando regrese de la llamada, termino la ejecucion el programa

    fibonacci:

        addi sp, sp,-12 #Reservo 3 espacios en la pila
        sw ra, 0(sp) #En el primer espacio de la pila guardare la direccion cargada en ra
        sw a0, 4(sp) #En el segundo espacio de la pila guardare el valor actual de a0
        li t1, 2 #Cargo en t1, el valor inmediato 2, que usare para filtrar los casos base
        blt a0, t1, epilogo #Realizo una comparacion entre a0 y 2 (t1). Si a0 es menor que t1, estoy ante un caso base y salto al epilogo para retornar
        addi a0, a0, -1 #Caso contrario, cargo en a0, el valor de n - 1. Y a0, seria igual a (n - 1)
        jal ra, fibonacci #Realizo un segundo llamado a la funcion fibonacci de forma recursiva, con a0 = (n - 1) como argumento
        sw a0, 8(sp)  #En el tercer espacio de la pila guardo el valor de a0, luego del segundo llamado a la funcion fibonacci, a0 = fibonacci(n-1)
        lw a0, 4(sp) #Cargo en a0, el valor que habia guardado previamente en el segundo espacio de la pila, es decir restituyo en a0, su valor previo a realizar la segunda llamada a la funcion fibonacci, a0 = n 
        addi a0, a0, -2 #Cargo en a0, el valor de n - 2. Y a0, seria igual a (n - 2)
        jal ra, fibonacci #Realizo un tecer llamado a la funcion fibonacci de forma recursiva, con a0 = (n - 2) como argumento
        lw t0, 8(sp) #Cargo en t0, el valor que guarde en el tercer espacio de la pila, es decit, t0 = fibonacci(n-1)
        add a0, a0, t0 #Realizo una suma entre a0(fibonacci (n-2)) y t0 (fibonacci(n-1)) y lo cargo en a0, a0 = fibonacci(n-1) + fibonacci(n-2)

    epilogo:

        lw ra, 0(sp) #Cargo como direccion de retorno, la direccion que habia guardado en el primer espacio de la pila 
        addi sp, sp, 12 #Restauro los 3 espacios que le habia pedido a la pila
        ret #Regreso a la direccion de retorno cargada en ra

        #Realizo este proceso por cada una de las llamadas recursivas que realice durante la ejecucion del programa
    
    fin:

        li a7, 10
        ecall


#Al finalizar la ejecucion del programa, el valor cargado en a0 deberia ser el resultado de fibonacci(3) = 2