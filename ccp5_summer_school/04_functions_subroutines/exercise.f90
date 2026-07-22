program compute_sum
    use compute_sum_module
    implicit none
    integer :: n
    real :: result

    n = 5
    result = 0.0

    call compute_sum_subroutine(n, result)
    print *, "The sum of squares from 1 to", n, "is", result

    result = compute_sum_function(n)
    print *, "The sum of squares from 1 to", n, "is", result

end program compute_sum