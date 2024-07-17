.data 

    numeros: .word 3, 1, 4, 1, 5, 5, 2, 6
    largo: .byte 8

.text

    la t0, numeros
    lb t1, largo
    li t3, 0
    li t4, 0

    while:

        beq t3, t1, AsignacionFinal
        lw t5, 0(t0)
        blt t4, t5, cambioMaximo
        j continue

        cambioMaximo:

            mv t4, t5

        continue:

            addi t3, t3, 1
            addi t0, t0, 4
            j while

    AsignacionFinal: 

        mv a0, t4

    fin:

    li a7, 10
    ecall