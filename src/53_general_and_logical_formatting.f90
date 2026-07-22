program general_and_logical_formatting
  implicit none
  logical :: l
  integer :: i
  real :: b

  l = .true.
  i = 10
  b = 10.043

  write(*, '(a10,l4)')    'l4 ', l     ! l: format descriptor specific to logicals
  write(*, '(a10,g16.8)') 'g16.8 ', i  ! g: works for any type...
  write(*, '(a10,g16.8)') 'g16.8 ', b  ! ...including real...
  write(*, '(a10,g16.8)') 'g16.8 ', l  ! ...and logical

end program general_and_logical_formatting
