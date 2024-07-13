.data

     w: .word 0x37A2F011

     mascara: .word 0x000000FF

.text

    lw s0,w #Cargo a w en el registro s0
    lw s1, mascara #Cargo la mascara que usare para desempaquetar los Bytes de w(s0) en s1
    li s2, 1 #Cargo el valor inmediato 1 en s2, lo usare para realizar una comparacion y obtener la paridad de cada uno de los Bytes de w(s0)
    li s3, 0 #Cargo el valor inmediato 0 en s3, sera el contador de Bytes impares en w(s0)

    PrimerByte:

        and t0, s0, s1 #Desempaqueto el PrimerByte de w(s0) y lo cargo en t0, t0 = 0x00000011
        andi t0, t0, 1 #Me quedo con el ultimo bit de t0 y realizo un "and" con 1, cargo el resultado en t0
        bne t0, s2, Byte1 #Si t0 es distinto a s2(1), significa que es par, lo descarto y avanzo al siguiente Byte de w(s0)
        addi s3, s3, 1 #Al contrario, si t0 es igual a s2(1), es impar y sumo 1 a s3(Contador de Bytes impares en w(s0))
    
    SegundoByte:
        
        srli t1, s0, 8 #Realizo un desplazamiento de 8 bits a la derecha en w(s0) y lo cargo en t1, t1 = 0x0037A2F0 
        and t1, t1, s1 #Desempaqueto el SegundoByte de w(s0) y lo cargo en t1, t1 = 0x000000F0
        andi t1, t1, 1 #Idem que con el PrimerByte
        bne t1, s2, Byte2 #Idem que con el PrimerByte
        addi s3, s3, 1 #Idem que con el PrimerByte
   
    TercerByte:
       
        srli t2, s0, 16 #Realizo un desplazamiento de 16 bits a la derecha em w(s0) y lo cargo en t2, t2 = 0x000037A2 
        and t2, t2, s1 #Desempaqueto el TercerByte de w(s0) y lo cargo en t2, t2 = 0x000000A2
        andi t2, t2, 1 #Idem que con el PrimerByte
        bne t2, s2, Byte3 #Idem que con el PrimerByte
        addi s3, s3, 1 #Idem que con el PrimerByte

    UltimoByte:

        srli t3, s0, 24 #Realizo un desplazamiento de 24 bits a la derecha em w(s0) y lo cargo en t3, t3 = 0x00000037 
        andi t3, t3, 1 #Idem que con el PrimerByte
        bne t3, s2, fin #Idem que con el PrimerByte
        addi s3, s3, 1 #Idem que con el PrimerByte

    fin:

        mv a0, s3 #Muevo el valor de s3(Contador de Bytes impares en w(s0)) a a0

        #En este caso el valor de a0, al final del programa deberia ser 2, ya que 0x37(UltimoByte) y 0x11(PrimerByte) son impares
