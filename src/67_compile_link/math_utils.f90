module math_utils
  implicit none
contains

  function double_it(x) result(y)
    real, intent(in) :: x
    real :: y
    y = x * 2.0
  end function double_it

end module math_utils
