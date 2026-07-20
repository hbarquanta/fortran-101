program select_case_demo
  implicit none
  integer :: day

  day = 3

  select case (day)   ! runs the one branch matching day's value
    case (1)
      print *, 'Monday'
    case (2)
      print *, 'Tuesday'
    case (3)
      print *, 'Wednesday'
    case default        ! runs if no case above matched
      print *, 'Unknown day'
  end select

end program select_case_demo
