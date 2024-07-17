.data:

    s: .word 2, 6, 4, 8
    q: .word 0, 0, 0, 0

.text:

    la a0, s
    la a1, q
    lb a2, largo
    li t3, 0
    li t4, 0

    while:

    bgw t3, a2, fin
    lw t0, 0(a0)
    mv t2, t0
    andi t0, t0, 1
    beq t0, zero, copio
    sw t4, 0(a1)
    j continue

    copio:

     sw t2, 0(a1)
     j continue

    loop:

        addi t3, t3, 1
        addi a0, a0, 4
        addi a1, a1, 4
        j while

    fin:
    
        li a7, 10
        ecall