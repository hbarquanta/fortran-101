program command_line_arguments
  implicit none
  integer :: count, i
  character(len=255) :: cmd
  character(len=25) :: argum

  call get_command(cmd)
  print *, trim(cmd)          ! the full command line used to invoke this program

  count = command_argument_count()
  print *, 'No of arguments: ', count

  do i = 1, count
    call get_command_argument(i, argum)
    print *, 'argument no ', i, ' is: ', trim(argum)
  end do

end program command_line_arguments
