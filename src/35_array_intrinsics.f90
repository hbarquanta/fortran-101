program array_intrinsics
  implicit none
  real :: a(2,2), b(2,2), c(2,2)
  real :: v1(3), v2(3), d
  complex :: z(2)

  a = reshape([1.0, 2.0, 3.0, 4.0], [2,2])
  b = reshape([5.0, 6.0, 7.0, 8.0], [2,2])

  print *, transpose(a)   ! flips rows and columns

  c = matmul(a, b)        ! matrix multiplication
  print *, c

  v1 = [1.0, 2.0, 3.0]
  v2 = [4.0, 5.0, 6.0]
  d = dot_product(v1, v2) ! sum of element-wise products
  print *, d

  z = [(1.0, 2.0), (3.0, -4.0)]
  print *, conjg(z)        ! flips the sign of the imaginary part

end program array_intrinsics
