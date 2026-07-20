program syntax_demo
  implicit none
  integer :: a, b, total

  a = 2; b = 3          ! ; separates two statements on one line

  total = a + &         ! & continues this statement onto the next line
          b

  print *, 'Total:', total

end program syntax_demo
