program calc_pi
    implicit none
    integer :: n
    real :: x,y,r,estimate_pi_result

    x = 1.0 !side length x of square
    y = 1.0 !side length y of square
    r = 1.0 !radius of circle
    n = 100000000 !Number of points
    estimate_pi_result = 0.0

    call estimate_pi(x,y,r,n,estimate_pi_result)
    print *, estimate_pi_result

contains
    function is_inside_circle(x, y, r)
        real, intent(in) :: x, y, r
        logical :: is_inside_circle
        is_inside_circle = (x**2 + y**2 <= r**2)
    end function is_inside_circle

    subroutine estimate_pi(x,y,r,n,estimate_pi_result)
        real, intent(in) :: x,y,r
        integer, intent(in) :: n
        real, intent(out) :: estimate_pi_result
        integer :: i, count_indices
        real :: x_rand, y_rand, prob_counts

        count_indices = 0.0
        prob_counts = 0.0

        do i = 1,n
            call random_number(x_rand)
            call random_number(y_rand)
            
            x_rand = x_rand*x
            y_rand = y_rand*y
            
            if (is_inside_circle(x_rand,y_rand,r)) then
                count_indices = count_indices+1
            end if 
        end do

        prob_counts = count_indices/real(n)
        
        estimate_pi_result = 4*prob_counts
    end subroutine estimate_pi






end program calc_pi