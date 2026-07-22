program use_library
  implicit none
  ! add_one lives in a library we'll link against, not in this file:
  ! declaring it "external" tells the compiler to trust us on its
  ! signature instead of needing a module/interface for it
  real :: add_one
  external :: add_one

  print *, add_one(41.0)   ! resolved at link time, from libmylib.a

end program use_library
