program vector_stuff
    use vector_stuff_module
    implicit none
    real(kind=8),allocatable :: a(:)
    real(kind=8),allocatable :: normalized_a(:)
    real(kind=8) :: norm_result

    call allocate_vector(a, 10)
    call allocate_vector(normalized_a, 10)


    a = 2.0
    normalized_a = 0.0

    call populate_vector(a)
    print *, "Vector a:", a
    
    norm_result = calc_norm(a)
    print *, "Norm a:", norm_result

    call normalize_vector(a, normalized_a)
    print *, "Normalized a:", normalized_a

    call replace_neg_by_abs(a, normalized_a)
    print *, "Vector a with negative values replaced by absolute values:", normalized_a

    call deallocate_vector(normalized_a)
    call deallocate_vector(a)


end program vector_stuff