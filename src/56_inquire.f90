program inquire_demo
  implicit none
  logical :: file_exists, file_open
  integer :: unit_number

  inquire(file='scratch.dat', exist=file_exists, opened=file_open, number=unit_number)
  print *, file_exists, file_open, unit_number   ! not created yet: F F -1

  open(101, file='scratch.dat', status='unknown', action='write')

  inquire(file='scratch.dat', exist=file_exists, opened=file_open, number=unit_number)
  print *, file_exists, file_open, unit_number   ! now it exists and is open on unit 101

  close(101, status='delete')   ! clean up: delete the file we just created

end program inquire_demo
