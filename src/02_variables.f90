program variables
  implicit none

  integer :: age
  real :: height
  character(len=20) :: name
  logical :: is_student

  age = 30
  height = 1.75
  name = 'Ada'
  is_student = .true.

  print *, 'Name: ', name
  print *, 'Age: ', age
  print *, 'Height: ', height
  print *, 'Is student: ', is_student

end program variables
