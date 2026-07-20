program without_implicit_none
  ! no implicit none: type is guessed from the variable's first letter
  ! i-n = integer, everything else = real
  num = 5          ! starts with 'n' -> integer
  total = 3.5      ! starts with 't' -> real

  num = num + 1
  total = total + 1

  print *, num, total
end program without_implicit_none
