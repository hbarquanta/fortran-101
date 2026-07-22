program array_bounds
  implicit none
  real :: arr(-2:2, 3)   ! custom lower bound -2 in the first dimension

  print *, size(arr, 1), size(arr, 2)     ! extent along each dimension
  print *, lbound(arr, 1), ubound(arr, 1) ! lower/upper bound of dimension 1
  print *, lbound(arr, 2), ubound(arr, 2) ! lower/upper bound of dimension 2

end program array_bounds
