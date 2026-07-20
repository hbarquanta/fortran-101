program relational_operators
  implicit none
  integer :: a, b
  logical :: p, q

  a = 5
  b = 3
  p = .true.
  q = .false.

  print *, a == b, a /= b, a < b, a <= b, a > b, a >= b
  print *, p .and. q, p .or. q, p .eqv. q, p .neqv. q
end program relational_operators
