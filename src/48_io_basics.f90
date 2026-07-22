program io_basics
  implicit none
  integer :: i, j

  i = 5
  j = 7

  print *, 'Hello world'     ! print is shorthand for write(*,*)
  write(*,*) 'Hello world'   ! identical output to the line above

  write(*, '(2(i0,1x))') i, j   ! inline format string
  write(*, 101) i, j             ! same format, given via a label instead
  101 format(2(i0,1x))

end program io_basics
