program assumed_shape_demo
  implicit none
  real :: x(5)

  x = [1.0, 2.0, 3.0, 4.0, 5.0]
  call pass1(x)
  print *, x

contains

  subroutine pass1(x)
    real, intent(inout) :: x(:)   ! assumed shape: size is known automatically
    x = 10.0                       ! whole-array assignment works
  end subroutine pass1

end program assumed_shape_demo
