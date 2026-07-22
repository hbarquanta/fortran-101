module vector_stuff_module
    implicit none
    private
    public :: populate_vector, calc_norm, normalize_vector, replace_neg_by_abs
    public :: allocate_vector, deallocate_vector


contains

    subroutine allocate_vector(a, n)
        real(kind=8), allocatable, intent(out) :: a(:)
        integer, intent(in) :: n
        integer :: info

        allocate(a(n), stat=info)
    end subroutine allocate_vector

    subroutine deallocate_vector(a)
        real(kind=8), allocatable, intent(inout) :: a(:)
        integer :: info

        if (allocated(a)) then
            deallocate(a, stat=info)
        end if
    end subroutine deallocate_vector


    subroutine populate_vector(a)
        real(kind=8), intent(inout) :: a(:)
        integer :: i


        do i = 1, size(a)
            a(i) = real(i, kind=8)- size(a)/2.0
        end do
    end subroutine populate_vector

    function calc_norm(a)
        real(kind=8), intent(in) :: a(:)   
        integer :: i
        real(kind=8) :: calc_norm

        calc_norm = 0.0
        do i = 1, size(a)
            calc_norm = calc_norm + a(i)**2
        end do
        calc_norm = sqrt(calc_norm)
    end function calc_norm

    subroutine normalize_vector(a, normalized_a)
        real(kind=8), intent(in) :: a(:)
        real(kind=8), intent(out) :: normalized_a(size(a))
        integer :: i
        real(kind=8) :: norm

        norm = calc_norm(a)
        if (norm == 0.0) then
            print *, "Error: zero vector."
            stop
        end if

        do i = 1, size(a)
            normalized_a(i) = a(i) / norm
        end do
    end subroutine normalize_vector

    subroutine replace_neg_by_abs(a,a_pos_only)
        real(kind=8), intent(in) :: a(:)
        real(kind=8), intent(out) :: a_pos_only(size(a))
        integer :: i

        do i = 1, size(a)
            if (a(i) < 0.0) then
                a_pos_only(i) = abs(a(i))
            else
                a_pos_only(i) = a(i)
            end if
        end do
    end subroutine replace_neg_by_abs

end module vector_stuff_module