program cycle_demo
  implicit none
  integer :: i

  do i = 1, 10
    if (mod(i, 2) == 0) cycle   ! skip even numbers, go to next iteration
    print *, i
  end do

end program cycle_demo
