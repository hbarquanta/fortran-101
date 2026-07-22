program array_shapes
  implicit none
  integer :: flat(6)
  integer :: matrix(2, 3)   ! a 2-row, 3-column array

  flat = [1, 2, 3, 4, 5, 6]
  matrix = reshape(flat, [2, 3])   ! reshape the flat array into 2 rows, 3 columns

  print *, matrix
  print *, shape(matrix)           ! shape() reports an array's dimensions

end program array_shapes
