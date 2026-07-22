program read_from_string
  implicit none
  character(len=20) :: h
  real :: f
  integer :: a

  h = '12.5 10'
  read(h, *) f, a   ! reads from the string h, instead of from the keyboard

  print *, f, a

end program read_from_string
