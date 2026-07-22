program newunit_demo
  implicit none
  integer :: my_unit

  open(newunit=my_unit, file='myfile.dat', status='unknown', action='write')
  write(my_unit, *) 'written via newunit'
  close(my_unit)

  print *, 'unit was:', my_unit   ! compiler-assigned, not a number we chose

end program newunit_demo
