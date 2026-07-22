program assumed_size_demo
  implicit none
  real :: x(5)

  x = [1.0, 2.0, 3.0, 4.0, 5.0]
  call pass2(x, 5)
  print *, x

contains

  subroutine pass2(x, n)
    integer, intent(in) :: n
    real, intent(inout) :: x(*)   ! assumed size: extent is unknown, n must be passed separately
    integer :: i

    do i = 1, n
      x(i) = 10.0                 ! no shape info, so no whole-array ops: must loop by hand
    end do
  end subroutine pass2

end program assumed_size_demo
