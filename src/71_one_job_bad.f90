program one_job_bad
  implicit none
  real :: x

  x = 5.0
  call answer_to_all(x, 1)
  print *, x

  x = 5.0
  call answer_to_all(x, 2)
  print *, x

contains

  ! bad: one routine doing several unrelated things, picked by a flag
  subroutine answer_to_all(x, stage)
    real, intent(inout) :: x
    integer, intent(in) :: stage

    x = x + 1.0            ! block 1
    if (stage == 1) then
      x = x * 2.0           ! block 2
    else
      x = x - 3.0           ! block 3
    end if
  end subroutine answer_to_all

end program one_job_bad
