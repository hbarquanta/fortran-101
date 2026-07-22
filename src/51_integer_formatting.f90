program integer_formatting
  implicit none
  integer :: i

  i = 10

  write(*, '(a10,i0)')   'i0 ', i     ! minimum digits needed
  write(*, '(a10,i5)')   'i5 ', i     ! right-justified in a 5-character field
  write(*, '(a10,i5.3)') 'i5.3 ', i   ! 5-char field, at least 3 digits (zero-padded)
  write(*, '(a10,i1)')   'i1 ', i     ! field too narrow: prints '*' instead

end program integer_formatting
