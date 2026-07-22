program random_numbers
  implicit none
  integer, allocatable :: seed(:)
  real :: r(2)
  integer :: is, i, p

  is = 13
  call random_seed(size=p)         ! p: how many integers this compiler's seed needs
  allocate(seed(p))
  seed = 17 * [(i - is, i = 1, p)]  ! build a reproducible seed, instead of a random one
  call random_seed(put=seed)        ! fix the seed: same seed always gives the same numbers
  deallocate(seed)

  call random_number(r)             ! fills r with reals in [0, 1)
  print *, r

end program random_numbers
