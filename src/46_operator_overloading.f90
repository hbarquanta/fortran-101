module point_ops
  implicit none

  type :: point
    real :: x, y
  end type point

  interface operator (+)
    module procedure add_points   ! lets + work between two point values
  end interface operator (+)

contains

  function add_points(a, b) result(c)
    type(point), intent(in) :: a, b
    type(point) :: c
    c%x = a%x + b%x
    c%y = a%y + b%y
  end function add_points

end module point_ops

program operator_overloading
  use point_ops
  implicit none
  type(point) :: p1, p2, p3

  p1 = point(1.0, 2.0)
  p2 = point(3.0, 4.0)
  p3 = p1 + p2   ! uses our overloaded +

  print *, p3%x, p3%y

end program operator_overloading
