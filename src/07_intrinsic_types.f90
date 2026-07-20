program intrinsic_types
  implicit none

  integer :: i
  real :: r
  real(kind=8) :: r_precise
  complex :: c

  i = 42
  r = 3.14
  r_precise = 3.14159265358979_8
  c = (1.0, 2.0)

  print *, i, r, r_precise, c

end program intrinsic_types
