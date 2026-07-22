module compute_sum_module
    implicit none
    private
    public :: compute_sum_subroutine, compute_sum_function

    
    contains
    subroutine compute_sum_subroutine(n, result)
        integer, intent(in) :: n
        real, intent(out) :: result
        integer :: i
        result = 0.0

        do i = 1, n
            if (mod(i, 2) == 1) cycle   ! skip odd numbers, go to next iteration
            result = result + i**2
        end do
    end subroutine compute_sum_subroutine

    function compute_sum_function(n)
        integer, intent(in) :: n
        real :: compute_sum_function
        integer :: i

        compute_sum_function = 0.0

        do i = 1, n
            if (mod(i, 2) == 1) cycle   ! skip odd numbers, go to next iteration
            compute_sum_function = compute_sum_function + i**2
        end do
    end function compute_sum_function

end module compute_sum_module