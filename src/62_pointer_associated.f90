program pointer_associated
  implicit none
  integer, pointer :: a
  integer, target :: i, k

  i = 100
  k = 300

  a => i
  print *, associated(a)      ! true: a points to something
  print *, associated(a, i)   ! true: specifically to i
  print *, associated(a, k)   ! false: not pointing to k

  a => null()
  print *, associated(a)      ! false: a points to nothing now

end program pointer_associated
