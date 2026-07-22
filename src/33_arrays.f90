program arrays
  implicit none
  integer :: arr(5)   ! a fixed-size array of 5 integers

  arr = [1, 2, 3, 4, 5]   ! array constructor: builds an array from a list

  print *, arr        ! prints every element
  print *, arr(3)      ! indexing starts at 1, not 0

end program arrays
