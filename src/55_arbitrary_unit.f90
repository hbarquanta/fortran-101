program arbitrary_unit
  implicit none
  integer :: i

  i = 42
  write(777, *) i   ! unit 777 isn't open yet, so gfortran creates a file: fort.777

end program arbitrary_unit
