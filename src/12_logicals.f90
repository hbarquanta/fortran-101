program logicals
  implicit none
  logical :: a, b

  a = .true.
  b = .false.

  print *, a .and. b, a .or. b, .not. a

end program logicals
