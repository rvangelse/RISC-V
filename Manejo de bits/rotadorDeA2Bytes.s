.data

    w: .word 0x1A900200

    mascara: .word 0x0000FFFF

.text

    lw s0, w #Cargo w en el regstro s0
    lw s1, mascara #Cargo la mascara que usare para desempaquetar de a 2 Bytes en s1

    Primeros2Bytes:

        and t0, s0, s1 #Desempaqueto los Primeros2Bytes de w(s0) y los cargo en t0, t0 = 0x00000200
        slli t0, t0, 16 #Desplazo a t0, 16 bits a la izquierda(2 Bytes), t0 = 0x02000000

    BytesSiguientes:

        slli s1, s1, 16 #Desplazo a la mascara(s1), 16 bits a la izquierda(2 Bytes), s1 = 0xFFFF0000
        and t1, s0, s1 #Desempaqueto los 2 Bytes que me quedaban de w(s0) y lo cargo en t1, t1 = 0x1A900000
        srli t1, t1, 16 #Desplazo a t1, 16 bits a la derecha(2 Bytes), t1 = 0x00001A90
    
    Rotacion:

        or a0, t0, t1 #Junto a t0 con t1 y cargo el valor resultante en a0, a0 = 0x02001A90