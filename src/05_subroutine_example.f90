program subroutine_example
  implicit none
  real :: d

  call distance(0.0, 0.0, 3.0, 4.0, d)
  print *, 'Distance:', d

contains

  subroutine distance(x1, y1, x2, y2, d)
    real, intent(in) :: x1, y1, x2, y2
    real, intent(out) :: d
    d = sqrt((x2 - x1)**2 + (y2 - y1)**2)
  end subroutine distance

end program subroutine_example
