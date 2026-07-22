program real_formatting
  implicit none
  real :: b

  b = 10.043

  write(*, '(a10,f16.8)')  'f16.8 ', b    ! fixed-point notation
  write(*, '(a10,e16.8)')  'e16.8 ', b    ! scientific notation
  write(*, '(a10,d16.8)')  'd16.8 ', b    ! same as E, but with a D exponent marker
  write(*, '(a10,en16.8)') 'en16.8 ', b   ! engineering notation: exponent is a multiple of 3
  write(*, '(a10,es16.8)') 'es16.8 ', b   ! scientific notation with exactly one leading digit

end program real_formatting
