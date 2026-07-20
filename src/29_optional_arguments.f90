program optional_args
  implicit none
  real :: d

  call distance(3.0, 4.0, d)
  print *, d                          ! no origin given -> defaults to (0,0)

  call distance(3.0, 4.0, d, 1.0, 1.0)
  print *, d                          ! origin given explicitly

contains

  subroutine distance(x, y, d, x0, y0)
    real, intent(in) :: x, y
    real, intent(in), optional :: x0, y0   ! caller may omit these
    real, intent(out) :: d
    real :: ox, oy

    ox = 0.0
    oy = 0.0
    if (present(x0)) ox = x0   ! present() checks if the caller passed it
    if (present(y0)) oy = y0

    d = sqrt((x - ox)**2 + (y - oy)**2)
  end subroutine distance

end program optional_args
