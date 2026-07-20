program variable_attributes
  implicit none

  ! volatile: value may change unexpectedly, so never optimize away access
  integer, volatile :: counter

  counter = 0
  counter = counter + 1
  print *, counter

  call tick()
  call tick()
  call tick()

contains

  subroutine tick()
    ! save: keeps its value between calls instead of resetting each time
    integer, save :: n = 0
    n = n + 1
    print *, n
  end subroutine tick

end program variable_attributes
