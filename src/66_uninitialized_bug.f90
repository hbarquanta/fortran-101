program uninitialized_bug
  implicit none
  integer :: a(5)
  real :: c   ! never assigned a value

  a = 10
  call square(a)
  print *, a
  print *, a(5) * c   ! uses c before it's ever set

contains

  subroutine square(b)
    integer, intent(inout) :: b(:)
    b = b * b
  end subroutine square

end program uninitialized_bug
