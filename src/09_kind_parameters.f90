program kind_parameters
  implicit none
  integer, parameter :: long = selected_int_kind(9)
  integer, parameter :: dp = selected_real_kind(9, 307)

  integer(kind=long) :: a
  real(kind=dp) :: b

  a = 10_long
  b = 3.14159265358979_dp

  print *, a, b

end program kind_parameters
