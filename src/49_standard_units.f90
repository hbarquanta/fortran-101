program standard_units
  use iso_fortran_env, only: output_unit, error_unit, input_unit
  implicit none
  integer :: n

  write(output_unit, *) 'to standard output'
  write(error_unit, *) 'to standard error'

  write(output_unit, *) 'enter a number:'
  read(input_unit, *) n
  print *, 'you entered', n

end program standard_units
