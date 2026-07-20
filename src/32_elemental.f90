program elemental_demo
  implicit none
  integer :: nums(3)

  nums = [1, 2, 3]

  print *, square(nums)   ! elemental: applies to every element automatically

contains

  ! elemental: written for one scalar, but also works on a whole array,
  ! applying itself to each element in turn
  elemental function square(x) result(y)
    integer, intent(in) :: x
    integer :: y

    y = x * x
  end function square

end program elemental_demo
