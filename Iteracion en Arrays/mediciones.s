#Este programa recorre un Array de mediciones
#Si 
.data

    mediciones: .half 0x1100 0x00F0 0xA200 0X1000
    largo: .byte 4

.text

    la t0, mediciones
    lb t1, largo
    li t2, 0x00000F00
    li t3, 0
    li t4, 0

    while:

        beq t3, t1, Comparacion
        lh t5, o(t0)
        slli t5, t5, 16
        srli t5, t5, 16
        bge t5, t2, sumo
        j continue

        sumo:

            addi t4, t4, 1

        continue:

            addi t0, t0, 2
            addi t3, t3, 1
            j while

        Comparacion:

            li a1, 2
            div t1, t1, a1
            bge t4, t1, devuelveUno
            li a0, 0
            j fin

        devuelveUno:

            li a0, 1
            j fin

        fin:

            li a7, 10
            ecall