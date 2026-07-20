program character_literals
  implicit none
  character(len=42) :: a, b = "12", &
                        c = "john's", d = "h"

  a = "hello"

  print *, a, b, c, d

end program character_literals
