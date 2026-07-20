program arithmetic_operators
  implicit none
  integer :: a, b
  character(len=6) :: s

  a = 5
  b = 3

  print *, a + b          ! binary: two operands
  print *, +a              ! unary: one operand
  print *, (a + b) * 2     ! parentheses group the expression

  s = 'foo' // 'bar'       ! // concatenates strings
  print *, s
end program arithmetic_operators
