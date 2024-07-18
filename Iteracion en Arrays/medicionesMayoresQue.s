#Este programa itera sobre los elementos del array "mediciones"
#Si la cantidad de elementos mayores a 0x00000F00 es mayor a la mitad de la longitud del array "mediciones", entonces se carga el valor inmediato 1 en a0
#Caso contrario, se carga el valor inmediato 0 en a0

.data

    mediciones: .half 0x1100 0x00F0 0xA200 0X1000
    longitud: .byte 4

.text

    la s0, mediciones #Cargo la direccion de memoria, donde empieza el array "mediciones" en s0
    lb s1, longitud #Cargo la longitud del array "mediciones" en s1
    li s2, 0x00000F00 #Cargo el valor inmediato 0x00000F00 que usare para comparar cada uno de los elementos del array "mediciones" en s2
    li t0, 0 #Cargo el valor inmediato 0 en t0, t0 sera el contador del ciclo while
    li t1, 0 #Cargo el valor inmediato 0 en t1, t1 sera la cantidad de elementos mayores a 0x00000F00(s2) en el array "mediciones"

    while:

        beq t0, s1, Comparacion #Si t0(contador de mi ciclo while) = s2(longitud del array "mediciones"),significa que recorrio todo el arreglo y salta a la etiqueta "Comparacion"
        lhu t2, 0(s0) #Cargo el elemento de una posicion dada del array "mediciones"(s0) en t2
        bge t2, s2, sumo #Realizo una comparacion entre t2 y s2(0x00000F00). Si el elemento en t2 es mayor a s2(0x00000F00), salto a la etiqueta "sumo"
        j continue #Si no, salto a la etiqueta "continue"

        sumo:

            addi t1, t1, 1 #Sumo 1 al valor previo de t1(cantidad de elementos mayores a 0x00000F00(s2) en el array "mediciones")

        continue:

            addi s0, s0, 2 #Realizo un desplazamiento de 1 bit a la derecha en s1, esto es equivalente a dividir por 2 al valor cargado en s1(longitud del array "mediciones")
            addi t0, t0, 1 #Sumo 1 Byte a la direccion de memoria cargada en s0, es decir, me desplazo al siguiente elemento del array "mediciones"
            j while #Regreso al ciclo while para seguir iterando

        Comparacion:

            srli s1, s1, 1 #Realizo un desplazamiento de 1 bit a la derecha en s1, esto es equivalente a dividir por 2 al valor cargado en s1(longitud del array "mediciones")
            bgt t1, s1, devuelveUno #Si t1(cantidad de elementos mayores a 0x00000F00(s2) en el array "mediciones") es mayor a s1(longitud del array "mediciones"/2), salta a la etiqueta "devuelvoUno"
            li a0, 0 #Si no, cargo el valor inmediato 0 en a0 
            j fin #Finalizo la ejecucion del programa

        devuelveUno:

            li a0, 1 #Cargo el valor inmediato 1 en a0

        fin:

            li a7, 10
            ecall

#Al finalizar la ejecucion del programa, el valor cargado en a0 deberia ser 1 porque mas de la mitad de los valores valen mas que 0x00000F00