program adjustable_size_demo
  implicit none
  real :: x(5)

  x = [1.0, 2.0, 3.0, 4.0, 5.0]
  call pass3(x, 5)
  print *, x

contains

  subroutine pass3(x, n)
    integer, intent(in) :: n
    real, intent(inout) :: x(n)   ! adjustable size: explicit shape, computed from n
    x = 10.0                       ! shape is fully known, so whole-array ops work
  end subroutine pass3

end program adjustable_size_demo
