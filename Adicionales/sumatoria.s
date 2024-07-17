.data
    n: .word 3
.text
    lw a0, notas
    li t0, 0
    li t1, 0
    ciclo:
    blt a0, t0, fin
    add t1, t1, t0
    addi t0, t0, 1
    j ciclo
    fin:
    mv a0, t1
    li a7, 10
    ecall