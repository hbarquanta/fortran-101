program pointers_basic
  implicit none
  integer, pointer :: a
  integer, target :: i

  i = 100
  a => i        ! a now points to i: they refer to the same memory

  a = a + 50    ! modifies i, since a is just an alias for it
  print *, i, a ! both show 150

end program pointers_basic
