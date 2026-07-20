program person_example
  implicit none

  type :: personType
    character(len=100) :: name
    logical :: is_married
    integer :: age
    real :: weight
  end type personType

  type(personType) :: john

  john%name = "John Smith"
  john%is_married = .true.
  john%age = 34
  john%weight = 82.5

  print *, john%name, john%is_married, john%age, john%weight

end program person_example
