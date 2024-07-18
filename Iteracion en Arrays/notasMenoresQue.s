#Este programa itera sobre los elementos del array "notas"
#Si la cantidad de elementos menores a 0xA0 es mayor a la mitad de la longitud del array "notas", entonces se carga el valor inmediato 1 en a0
#Caso contrario, se carga el valor inmediato 0 en a0

.data

    notas: .byte 0xA1 0xB0 0xF1 0x07
    longitud: .byte 4

.text

    la s0, notas #Cargo la direccion de memoria, donde empieza el array "notas" en s0
    lb s1, longitud #Cargo la longitud del array "notas" en s1
    li s2, 0xA0 #Cargo el valor inmediato 0xA0 que usare para comparar cada uno de los elementos del array "notas" en s2
    li t0, 0 #Cargo el valor inmediato 0 en t0, t0 sera el contador del ciclo while
    li t1, 0 #Cargo el valor inmediato 0 en t1, t1 sera la cantidad de elementos menores a 0xA0(s2) en el array "notas"
 
    while:

        beq t0, s1, Comparacion #Si t0(contador de mi ciclo while) = s2(longitud del array "notas"),significa que recorrio todo el arreglo y salta a la etiqueta "Comparacion"
        lbu t2, 0(s0) #Cargo el elemento de una posicion dada del array "notas"(s0) en t2
        blt t2, s2, sumo #Realizo una comparacion entre t2 y s2(0xA0). Si el elemento en t2 es menor a s2(0xA0), salto a la etiqueta "sumo"
        j continue #Si no, salto a la etiqueta "continue"

        sumo:

            addi t1, t1, 1 #Sumo 1 al valor previo de t1(cantidad de elementos menores a 0xA0(s2) en el array "notas")

        continue:

            addi t0, t0, 1 #Sumo 1 al valor previo de t0(contador del ciclo while)
            addi s0, s0, 1 #Sumo 1 Byte a la direccion de memoria cargada en s0, es decir, me desplazo al siguiente elemento del array "notas"
            j while #Regreso al ciclo while para seguir iterando

    Comparacion:

        srli s1, s1, 1 #Realizo un desplazamiento de 1 bit a la derecha en s1, esto es equivalente a dividir por 2 al valor cargado en s1(longitud del array "notas")
        blt s1, t1, devuelvoUno #Si s1(longitud del array "notas"/2) es menor a t1(cantidad de elementos menores a 0xA0(s2) en el array "notas"), salta a la etiqueta "devuelvoUno"
        li a0, 0 #Si no, cargo el valor inmediato 0 en a0 
        j fin #Finalizo la ejecucion del programa

    devuelvoUno:

        li a0, 1 #Cargo el valor inmediato 1 en a0

    fin: 

        li a7, 10
        ecall

#Al finalizar la ejecucion del programa, el valor cargado en a0 deberia ser 0 porque menos de la mitad de los valores valen menos que 0xA0