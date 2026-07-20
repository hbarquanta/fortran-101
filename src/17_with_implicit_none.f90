program with_implicit_none
  implicit none
  ! types are explicit now, instead of guessed from the name
  integer :: num
  real :: total

  num = 5
  total = 3.5

  num = num + 1
  total = total + 1

  print *, num, total
end program with_implicit_none
