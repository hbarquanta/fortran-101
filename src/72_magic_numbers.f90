program magic_numbers
  implicit none
  integer :: vdw
  real :: energies(3), energy

  vdw = 1
  energies = [10.0, 20.0, 30.0]

  if (vdw == 0) then
    print *, 'Lennard-Jones'
  else if (vdw == 1) then
    print *, 'Morse'
  else if (vdw == 2) then
    print *, 'Buckingham'
  end if

  energy = energies(1) + energies(3)   ! what do 1 and 3 even mean here?
  print *, energy

end program magic_numbers
