program recursive_puzzle
  implicit none
  real(kind=8) :: x(0:42)
  integer :: n

  x(0) = 4.0d0
  x(1) = 17.0d0 / 4.0d0

  do n = 1, 41
    x(n+1) = 108.0d0 - 815.0d0/x(n-1) - 1500.0d0/x(n)
  end do

  print *, x(42)

end program recursive_puzzle
