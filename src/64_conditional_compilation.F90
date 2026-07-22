program conditional_compilation
  implicit none

  print *, 'Hello World!!!'
#ifdef MORE
  ! only compiled in if MORE was defined at compile time (gfortran -DMORE)
  print *, 'From Alin'
#endif

end program conditional_compilation
