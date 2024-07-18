#Este programa itera sobre los elementos del array "numeros"
#Al final de la ejecucion del programa, carga en a0 al valor maximo entre ellos.

.data 

    numeros: .word 3, 1, 4, 1, 5, 5, 2, 6
    longitud: .byte 8

.text

    la s0, numeros #Cargo la direccion de memoria, donde empieza el array "numeros" en s0
    lb s1, longitud #Cargo la longitud del array "numeros" en s1
    li t0, 0 #Cargo el valor inmediato 0 en t0, t0 sera el contador del ciclo while
    li t1, 0 #Cargo el valor inmediato 0 en t1, t1 sera el maximo elemento, hasta el momento

    while:

        beq t0, s1, AsignacionFinal #Si t0(contador de mi ciclo while) = s2(longitud del array "numeros"),significa que recorrio todo el arreglo y salta a la etiqueta "AsignacionFinal"
        lw t2, 0(s0) #Cargo el elemento de una posicion dada del array "numeros"(s0) en t2
        blt t1, t2, cambioMaximo #Realizo una comparacion entre t1(Maximo, hasta el momento) y t2. Si el elemento en t2 es mayor a t1, salto a la etiqueta "cambioMaximo"
        j continue #Si no, salto a la etiqueta "continue"

        cambioMaximo:

            mv t1, t2 #Muevo el valor de t2 a t1, es decir, actualizo el maximo hasta el momento, ya que encontre un elemento mayor

        continue:

            addi t0, t0, 1 #Sumo 1 al valor previo de t0(contador del ciclo while)
            addi s0, s0, 4 #Sumo 4 Bytes a la direccion de memoria cargada en s0, es decir, me desplazo al siguiente elemento del array "numeros"
            j while #Regreso al ciclo while para seguir iterando

    AsignacionFinal: 

        mv a0, t1 #Finalmente, muevo el valor de t1(Maximo valor en el array "numeros") a a0

    fin:

        li a7, 10
        ecall

#Al finalizar la ejecucion del programa, el valor cargado en a0 deberia ser 6 porque es el maximo valor presente en el array "numeros"