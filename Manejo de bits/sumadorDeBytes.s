.data

    w: .word 0x901A0002

    mascara: .byte 0xFF

.text

    lw s0, w #Cargo w en el registro s0
    lb s1, mascara #Cargo la mascara que usare para desempaquetar cada uno de los bytes de w (s0)

    PrimerByte:
    
        and t0, s0, s1 #Desempaqueto el PrimerByte de w(s0) y lo cargo en t0, t0 = 0x00000002

    SegundoByte:
    
        srli t1, s0, 8 #Realizo un desplazamiento hacia la derecha de 8 bits en (s0) y lo cargo en t1, t1 = 0x00901A00
        and t1, t1, s1 #Desempaqueto el SegundoByte de w(s0) y lo cargo en t1, t1 = 0x00000000

    TercerByte:

        srli t2, s0, 16 #Realizo un desplazamiento hacia la derecha de 16 bits en (s0) y lo cargo en t2, t2 = 0x0000901A
        and t2, t2 , s1 #Desempaqueto el TercerByte de w(s0) y lo cargo en t2, t2 = 0x0000001A


    CuartoByte:

        srli t3, s0, 24 #Realizo un desplazamiento hacia la derecha de 24 bits en (s0) y lo cargo en t3, t3 = 0x00000090 
        #No hace falta desempaquetarlo porque el desplazamiento lo desempaqueto       


    SumaDeBytes:

        add a0, t0, t1 #Sumo t0 y t1 (PrimerByte y SegundoByte) y lo cargo en a0
        add a0, a0, t2 #Sumo t2 (TercerByte) al resultado de la suma anterior y lo vuelvo a cargar en a0
        add a0, a0, t3 #Sumo t3 (CuartoByte) al resultado de la suma anterior y lo vuelvo a cargar en a0
        #Al final de todo el programa la suma de los 4 bytes que forman a w(s0), estaria cargada en a0