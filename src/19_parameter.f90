program parameter_demo
  implicit none
  ! parameter: a named constant, fixed at compile time, can't be reassigned
  real, parameter :: pi = 3.14159

  print *, pi
end program parameter_demo
