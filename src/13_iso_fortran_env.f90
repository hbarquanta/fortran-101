program iso_kinds
  use iso_fortran_env, only: int8, int16, real32, real64
  implicit none

  integer(kind=int8) :: a
  integer(kind=int16) :: b
  real(kind=real32) :: c
  real(kind=real64) :: d

  a = 10_int8
  b = 1000_int16
  c = 3.14_real32
  d = 3.14159265358979_real64

  print *, a, b, c, d

end program iso_kinds
