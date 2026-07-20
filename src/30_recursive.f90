program recursive_demo
  implicit none

  print *, fibonacci(10)

contains

  recursive function fibonacci(n) result(f)
    integer, intent(in) :: n
    integer :: f

    if (n <= 1) then
      f = n
    else
      f = fibonacci(n - 1) + fibonacci(n - 2)   ! calls itself twice
    end if
  end function fibonacci

end program recursive_demo
