program scope_demo
  implicit none
  integer :: x

  x = 1

  block
    ! this x shadows the outer one; it's a separate variable
    integer :: x
    x = 2
    print *, x
  end block

  print *, x
end program scope_demo
