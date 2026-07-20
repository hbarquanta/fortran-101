program function_example
  implicit none
  real :: d

  d = distance(0.0, 0.0, 3.0, 4.0)
  print *, 'Distance:', d

contains

  function distance(x1, y1, x2, y2)
    real :: distance
    real, intent(in) :: x1, y1, x2, y2
    distance = sqrt((x2 - x1)**2 + (y2 - y1)**2)
  end function distance

end program function_example
