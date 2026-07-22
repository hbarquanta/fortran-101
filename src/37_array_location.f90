program array_location
  implicit none
  integer :: arr(5)
  integer :: packed(4)
  integer :: restored(5)

  arr = [3, -1, 4, 1, 5]

  print *, maxloc(arr)   ! index of the largest element
  print *, minloc(arr)   ! index of the smallest element

  print *, merge(1, 0, arr > 0)   ! elementwise: 1 where true, 0 where false

  packed = pack(arr, arr > 0)     ! keep only elements where the mask is true
  print *, packed

  restored = unpack(packed, arr > 0, 0)   ! scatter back, filling gaps with 0
  print *, restored

end program array_location
