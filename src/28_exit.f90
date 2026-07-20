program exit_demo
  implicit none
  integer :: i

  do i = 1, 10
    if (i == 5) exit   ! stop the loop entirely once i reaches 5
    print *, i
  end do

end program exit_demo
