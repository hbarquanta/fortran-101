program solve_sequence

    use myTypes

    implicit none
    integer :: n, i
    real(kpr) :: x(42)  ! Array to hold the sequence terms
    
    n = 42 ! Number of terms in the sequence
    i = 0

    call solve_sequence_subroutine(n, x)
    print *, x(n)

contains
    subroutine solve_sequence_subroutine(n, x)
        integer, intent(in) :: n
        real(kpr), intent(out) :: x(n)
        integer :: i

        x(1) = 4.0
        x(2) = 17.0/4.0
        
        do i = 3, n
            x(i) = 108.0 - (815.0-(1500.0/x(i-2)))/x(i-1)
        end do
    end subroutine solve_sequence_subroutine



end program solve_sequence