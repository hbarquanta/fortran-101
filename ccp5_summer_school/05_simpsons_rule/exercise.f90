program simpsons_rule
    implicit none
    integer :: n
    real :: a, b, result
    

    ! Interval [a, b], number of subintervals n
    a = 0.0
    b = 1.0
    n = 10  ! n must be even for Simpson's rule


    call simpsons_rule_subroutine(a, b, n, result)
    print *, "The integral of f(x) from", a, "to", b, "is approximately", result

contains
    subroutine simpsons_rule_subroutine(a, b, n, result)
        real, intent(in) :: a, b
        integer, intent(in) :: n
        real, intent(out) :: result
        real :: h, x0, x1, x2
        integer :: i

        result = 0.0
        h = (b - a) / n

        do i = 0, n/2 -1
            x0 = a + (2*i)*h
            x1 = a + (2*i+1)*h
            x2 = a + (2*i+2)*h
            result = result + (f(x0) + 4*f(x1) + f(x2))
        end do
        result = result * h / 3.0
        end subroutine simpsons_rule_subroutine

        function f(x)
            real, intent(in) :: x
            real :: f
            f = x**2-2*x+1
        end function f

end program simpsons_rule