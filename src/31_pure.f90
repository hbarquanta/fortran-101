program pure_demo
  implicit none

  print *, square(5)

contains

  ! pure: this function may only compute a result from its arguments.
  ! it can't print, can't change any variable outside itself, and always
  ! returns the same output for the same input.
  pure function square(x) result(y)
    integer, intent(in) :: x
    integer :: y

    y = x * x
  end function square

end program pure_demo
