program write_to_file
  implicit none

  open(101, file='myfile.dat', status='unknown', action='write')
  write(101, *) 'my first line in a file'
  close(101)

end program write_to_file
