program pointer_arrays
  implicit none
  integer, pointer :: p(:)
  integer, target :: arr(6)

  arr = [1, 2, 3, 4, 5, 6]

  p => arr(2:5)   ! points at a slice of arr, not the whole thing
  print *, p       ! 2 3 4 5

  p(1) = 99        ! modifies arr(2), since p is an alias for that slice
  print *, arr

end program pointer_arrays
