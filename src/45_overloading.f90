module overload_demo
  implicit none

  interface show
    module procedure show_int, show_real   ! same name, two different implementations
  end interface show

contains

  subroutine show_int(x)
    integer, intent(in) :: x
    print *, 'integer:', x
  end subroutine show_int

  subroutine show_real(x)
    real, intent(in) :: x
    print *, 'real:', x
  end subroutine show_real

end module overload_demo

program overloading
  use overload_demo
  implicit none

  call show(5)      ! compiler picks show_int, based on the argument's type
  call show(3.14)   ! compiler picks show_real

end program overloading
