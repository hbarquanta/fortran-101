program named_constants
  implicit none
  integer, parameter :: POT_LJ = 0, POT_MORSE = 1, POT_BUCK = 2
  integer, parameter :: ENER_KINETIC = 1, ENER_POTENTIAL = 3
  integer :: vdw
  real :: energies(3), energy

  vdw = POT_MORSE
  energies = [10.0, 20.0, 30.0]

  if (vdw == POT_LJ) then
    print *, 'Lennard-Jones'
  else if (vdw == POT_MORSE) then
    print *, 'Morse'
  else if (vdw == POT_BUCK) then
    print *, 'Buckingham'
  end if

  energy = energies(ENER_KINETIC) + energies(ENER_POTENTIAL)   ! self-explanatory now
  print *, energy

end program named_constants
