program macro_expansion
  implicit none
#define SQUARE_PLUS(x) (x*x+x)
  real :: y

  y = 10.0
  print *, SQUARE_PLUS(y)   ! expands to (y*y+y) before compiling

end program macro_expansion
