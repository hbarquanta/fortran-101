module counter_mod
  implicit none

  type :: counter
    integer :: value
  contains
    procedure :: increment
    final :: cleanup
  end type counter

contains

  subroutine increment(this)
    class(counter), intent(inout) :: this
    this%value = this%value + 1
  end subroutine increment

  subroutine cleanup(this)
    type(counter), intent(inout) :: this
    print *, 'cleanup', this%value
  end subroutine cleanup

end module counter_mod

program type_bound
  use counter_mod
  implicit none

  call run()

contains

  subroutine run()
    type(counter) :: a
    a%value = 0
    call a%increment()
    print *, a%value
  end subroutine run

end program type_bound
