.data

    datos: .word 0x90180002

    mascara: .word 0x0000FFFF

.text

    lw s0, datos #Cargo "datos" en el registro s0
    lw t0, mascara #Cargo la mascara que usare para desempaquetar los datos (De a 2 Bytes) de s0 en t0
    li t1, 1 #Cargo en t1 el valor inmediato 1, lo usare para realizar una comparacion y obtener la paridad de cada uno de los datos (De a 2 Bytes) de s0
    li t2, 2 #Cargo en t2, el valor inmediato 2, es la cantidad de datos(De a 2 Bytes) empaquetados en s0
    li a0, 0 #Cargo en a0 el valor inmediato 0, sera el contador de datos(De a 2 Bytes) pares en s0
    
    Dato1:
        and t3, s0, t0 #Desempaqueto el Dato1 de s0 y lo cargo en t3, t3 = 0x00000002
        andi t3, t3, 1 #Me quedo con el ultimo bit de t3 y realizo un "and" con 1, cargo el resultado en t3
        beq t3, t1, Dato2 #Si t3 es igual a t1(1), significa que es impar, lo descarto y avanzo al siguiente dato de s0
        addi a0, a0, 1 #Al contrario, si t3 es distinto a t1(1), es par y sumo 1 a a0(Contador de datos(De 2 Bytes) pares en s0)
    
    Dato2:
        
        srli s0, s0, 16 #Realizo un desplazamiento de 16 bits a la derecha en s0 y lo cargo en s0,s0 = 0x00009018
        andi s0, s0, 1 #Idem que con el Dato1
        beq t4, t1, Comparacion #Idem que con el Dato1
        addi a0, a0, 1 #Idem que con el Dato1
    
    Comparacion:
        
        beq a0, t2, devuelveUno #Si la cantidad de datos (De a 2 Bytes) pares en s0 es igual a la cantidad de datos (De a 2 Bytes) en s0,significa que todo sus datos son pares y devuelvo 1
        li s1, 0 #Caso contrario, devuelvo 0 
        j fin
    
    devuelveUno:
        
        li s1, 1 #Cargo el valor inmediato 1 en s1
    
    fin:
        
        li a7, 10
        ecall

    #Al finalizar el programa si los 2 datos (De a 2 Bytes) en s0 son pares, s1 tendra cargado el valor inmediato 1, caso contrario tendra cargado el valor 0.
    #En este caso, deberia devolver 1, ya que ambos datos son pares.