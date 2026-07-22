program where_construct
  implicit none
  integer :: arr(5)

  arr = [3, -1, 4, 1, -5]

  where (arr > 0)
    arr = arr * 2
  elsewhere
    arr = 0
  end where

  print *, arr

end program where_construct
