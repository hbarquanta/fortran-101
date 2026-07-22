program allocatable_demo
  implicit none
  integer, allocatable :: a(:)

  print *, allocated(a)   ! not allocated yet -> false

  allocate(a(5))
  a = 10
  print *, allocated(a), a

  deallocate(a)
  print *, allocated(a)   ! false again

end program allocatable_demo
