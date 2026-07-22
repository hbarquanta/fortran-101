! this is "the library": compiled once, archived, then linked against
! by anyone who wants add_one, without ever seeing this source again
function add_one(x) result(y)
  implicit none
  real, intent(in) :: x
  real :: y
  y = x + 1.0
end function add_one
