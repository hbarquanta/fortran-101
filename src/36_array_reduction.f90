program array_reduction
  implicit none
  integer :: arr(5)
  logical :: mask(5)

  arr = [3, -1, 4, 1, 5]
  mask = arr > 0

  print *, sum(arr)      ! total of all elements
  print *, product(arr)  ! product of all elements
  print *, maxval(arr)   ! largest element
  print *, minval(arr)   ! smallest element
  print *, count(mask)   ! how many elements satisfy the mask
  print *, all(mask)     ! true only if every element satisfies the mask
  print *, any(mask)     ! true if at least one element satisfies the mask

end program array_reduction
