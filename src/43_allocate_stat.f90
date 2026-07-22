program allocate_stat_demo
  implicit none
  integer, allocatable :: a(:)
  integer :: info

  allocate(a(5), stat=info)
  print *, info   ! 0: success

  allocate(a(10), stat=info)   ! a is already allocated: this would crash without stat=
  print *, info                 ! nonzero: caught as an error instead

  deallocate(a)   ! a is still holding the first allocation; free it before exiting

end program allocate_stat_demo
