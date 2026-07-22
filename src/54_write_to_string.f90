program write_to_string
  implicit none
  character(len=50) :: s
  integer :: a
  real :: b

  a = 11
  b = 39.5

  write(s, '(a2,i0,1x,a2,f16.8)') 'a=', a, 'b=', b   ! writes into the string s, not the screen

  write(*, '(a50)', advance='no') trim(s)   ! advance='no': don't start a new line after this
  write(*,*) 'this goes on the prev line'

end program write_to_string
