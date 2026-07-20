program string_comparison
  implicit none
  character(len=3) :: s1 = "abc", s2 = "abd"

  print *, lge(s1, s2), lgt(s1, s2), lle(s1, s2), llt(s1, s2)

end program string_comparison
