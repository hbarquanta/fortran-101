module point_assign
  implicit none

  type :: point
    real :: x, y
  end type point

  interface assignment (=)
    module procedure copy_point   ! lets = run our own code on point values
  end interface assignment (=)

contains

  subroutine copy_point(lhs, rhs)
    type(point), intent(out) :: lhs
    type(point), intent(in) :: rhs
    print *, 'copying point'
    lhs%x = rhs%x
    lhs%y = rhs%y
  end subroutine copy_point

end module point_assign

program assignment_overloading
  use point_assign
  implicit none
  type(point) :: p1, p2

  p1 = point(1.0, 2.0)   ! triggers copy_point
  p2 = p1                 ! triggers copy_point again

  print *, p2%x, p2%y

end program assignment_overloading
