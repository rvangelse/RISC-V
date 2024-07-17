.data

    notas: .byte 0xA1 0x00 0xA1 0x07
    largo: .byte 4

.text

    la t0, notas
    lb t1, largo
    li t2, 0xA0
    li t3, 0
    li t4, 0

    while:

        beq t3, t1, Comparacion
        lbu t6, 0(t0)
        blt t2, t6, sumo
        j continue

        sumo:

            addi t4, t4, 1

        continue:

        addi t3, t3, 1
        addi t0, t0, 1
        j while

    Comparacion:

    slli t1, t1, 1
    blt t1, t4, devuelveUno
    li a0, 0
    j fin

    devuelveUno:

    li a0, 1

    fin:
    
    li a7, 10
    ecall