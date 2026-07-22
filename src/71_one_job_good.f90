program one_job_good
  implicit none
  real :: x

  x = 5.0
  call block_1(x)
  call block_2(x)
  print *, x

  x = 5.0
  call block_1(x)
  call block_3(x)
  print *, x

contains

  ! good: each routine does exactly one thing, callers combine them as needed
  subroutine block_1(x)
    real, intent(inout) :: x
    x = x + 1.0
  end subroutine block_1

  subroutine block_2(x)
    real, intent(inout) :: x
    x = x * 2.0
  end subroutine block_2

  subroutine block_3(x)
    real, intent(inout) :: x
    x = x - 3.0
  end subroutine block_3

end program one_job_good
