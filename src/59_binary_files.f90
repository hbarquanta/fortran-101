program binary_files
  implicit none
  integer :: a, b, info

  a = 10

  open(101, file='myfile.dat', status='unknown', action='write', form='unformatted')
  write(101) a          ! unformatted: no format specifier allowed
  close(101)

  open(101, file='myfile.dat', status='old', action='read', form='unformatted')
  read(101, iostat=info) b
  close(101)

  print *, b, b + 1

end program binary_files
