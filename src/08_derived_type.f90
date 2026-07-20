program derived_type
  implicit none

  type :: point
    real :: x, y
  end type point

  type(point) :: p

  p%x = 1.0
  p%y = 2.0

  print *, p%x, p%y

end program derived_type
