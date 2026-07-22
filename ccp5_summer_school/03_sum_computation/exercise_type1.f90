program compute_sum_1
    ! This is a standard loop
    implicit none
    integer :: i, n
    real :: result
    
    n = 5

    call compute_sum(n, result)
    print *, "The sum of squares from 1 to", n, "is", result

    contains
    subroutine compute_sum(n, result)
        integer, intent(in) :: n
        real, intent(out) :: result
        result = 0.0
        
        do i = 1, n
            if (mod(i, 2) == 1) cycle   ! skip odd numbers, go to next iteration
            result = result + i**2
        end do
    end subroutine compute_sum

end program compute_sum_1