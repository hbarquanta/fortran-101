program bitwise_reductions
  implicit none
  integer :: nums(3)

  nums = [7, 3, 5]         ! 0111, 0011, 0101

  print *, iall(nums)      ! bitwise AND of all elements: 0111&0011&0101 = 1
  print *, iany(nums)      ! bitwise OR of all elements:  0111|0011|0101 = 7
  print *, iparity(nums)   ! bitwise XOR of all elements: 0111^0011^0101 = 1
end program bitwise_reductions
