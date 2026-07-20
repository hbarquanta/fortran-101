program bitwise_operators
  implicit none
  integer :: a, b

  a = 12   ! 1100
  b = 10   ! 1010

  print *, bge(a, b)      ! a >= b, comparing bits as unsigned -> true
  print *, bgt(a, b)      ! a > b, comparing bits as unsigned -> true
  print *, ble(a, b)      ! a <= b, comparing bits as unsigned -> false
  print *, blt(a, b)      ! a < b, comparing bits as unsigned -> false

  print *, iand(a, b)     ! bitwise AND: 1100 & 1010 = 1000 = 8
  print *, ior(a, b)      ! bitwise OR:  1100 | 1010 = 1110 = 14
  print *, ieor(a, b)     ! bitwise XOR: 1100 ^ 1010 = 0110 = 6

  print *, ishft(a, 2)    ! shift left 2 bits:  1100 -> 110000 = 48
  print *, ishft(a, -2)   ! shift right 2 bits: 1100 -> 0011 = 3
end program bitwise_operators
