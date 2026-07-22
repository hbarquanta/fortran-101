program assumed_rank_demo
  implicit none
  real :: a0
  real :: a1(2)
  real :: a2(3,3)
  real :: a3(4,4)

  call sub(a0)
  call sub(a1)
  call sub(a2)
  call sub(a3)

contains

  subroutine sub(a)
    real, intent(inout) :: a(..)   ! assumed rank: accepts scalar or array of any rank
    print *, rank(a)                ! rank() reports how many dimensions a has
  end subroutine sub

end program assumed_rank_demo
