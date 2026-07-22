program automatic_array_demo
  implicit none

  call show(5)

contains

  subroutine show(n)
    integer, intent(in) :: n
    real :: a(n)   ! automatic array: sized by n, exists only while show() runs
    a = 1.0
    print *, sum(a)
  end subroutine show

end program automatic_array_demo
