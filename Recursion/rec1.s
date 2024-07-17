#Este programa implementa la funcion rec(n)
#Si n = 1, entonces, rec(n) = 0
#Por otro lado, si n > 1, rec(n) = 2*n + rec(n-1)

.data

    n:.word 0x00000003

.text

    lw a0, n #Cargo el argumento "n" en el registo a0
    jal ra, rec #Realizo un primer llamado a la funcion rec, con a0 = n como argumento y guardo la direccion de retorno en ra
    j fin #Cuando regrese de la llamada, termino la ejecucion el programa

    rec:

        addi sp, sp, -8 #Reservo 2 espacios en la pila
        sw ra, 0(sp) #En el primer espacio de la pila guardare la direccion cargada en ra
        sw a0, 4(sp) #En el segundo espacio de la pila guardare el valor actual de a0
        li t1, 1 #Cargo en t1, el valor inmediato 1, que usare para filtrar el caso base
        beq a0, t1, casoBase #Realizo una comparacion entre a0 y 1 (t1). Si a0 es igual a t1, estoy ante el caso base y salto a la etiqueta "caso base"
        addi a0, a0, -1 #Caso contrario, cargo en a0, el valor de n - 1. Y a0, seria igual a (n - 1)
        jal ra, rec #Realizo un segundo llamado a la funcion rec de forma recursiva, con a0 = (n - 1) como argumento
        mv t0, a0 #Muevo el valor de a0 (a0 = rec(n-1)) a t0
        lw a0, 4(sp) #Cargo en a0, el valor que habia guardado previamente en el segundo espacio de la pila, es decir restituyo en a0, su valor previo a realizar la segunda llamada a la funcion rec, a0 = n 
        slli a0, a0, 1 #Realizo un desplazamiento de 1 bit a la izquierda en a0 y lo cargo en a0, esto equivale a multiplicar por 2, el valor previo de a0, es decir, a0 = 2*n
        add a0, a0, t0 # #Realizo una suma entre a0(2*n) y t0 (rec(n-1)) y lo cargo en a0, a0 = 2*n + rec(n-1)
        j epilogo #Salto a epilogo para retornar
    
    casoBase:

        li t2, 0 #Cargo el valor inmediato 0 en t2
        mv a0, t2 #Muevo el valor en t2(0) a a0, a0 = 0 

    epilogo:

        lw ra, 0(sp) #Cargo como direccion de retorno, la direccion que habia guardado en el primer espacio de la pila 
        addi sp, sp, 8 #Restauro los 2 espacios que le habia pedido a la pila
        ret #Regreso a la direccion de retorno cargada en ra

        #Realizo este proceso por cada una de las llamadas recursivas que realice durante la ejecucion del programa

    fin:

        li a7, 10
        ecall

#Al finalizar la ejecucion del programa, el valor cargado en a0 deberia ser el resultado de rec(3) = 10 (A, en sistema hexadecimal)