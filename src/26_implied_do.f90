program implied_do
  implicit none
  integer :: i

  print *, (i, i = 1, 10)       ! begin=1, end=10, default step 1
  print *, (i, i = 1, 10, 2)    ! begin=1, end=10, step 2

end program implied_do
