program vector_stuff
    use vector_stuff_module
    implicit none
    real(kind=8) :: a(100)
    real(kind=8) :: normalized_a(100)
    real(kind=8) :: norm_result

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


end program vector_stuff