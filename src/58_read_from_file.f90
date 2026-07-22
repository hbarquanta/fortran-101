program read_from_file
  implicit none
  integer :: a, b, info

  a = 10

  open(101, file='myfile.dat', status='unknown', action='write')
  write(101, *) a
  close(101)

  open(101, file='myfile.dat', status='old', action='read')
  read(101, *, iostat=info) b
  close(101)

  print *, b, b + 1

end program read_from_file
