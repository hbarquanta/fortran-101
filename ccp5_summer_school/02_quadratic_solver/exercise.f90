program test_quadratic
  use myTypes

  implicit none
  complex(kpr) :: root1, root2
  real(kpr) :: a, b, c
  a = 10.0_kpr
  b = -2.0_kpr
  c = 2.0_kpr
  call quadratic_solver(a, b, c, root1, root2)
  print *, root1, root2

contains
subroutine quadratic_solver(a, b, c, root1, root2)
  implicit none
  real(kpr), intent(in) :: a, b, c
  complex(kpr), intent(out) :: root1, root2
  complex(kpr) :: discriminant

  discriminant = cmplx(b**2 - 4.0_kpr*a*c, 0.0_kpr)

  if (discriminant == (0.0_kpr, 0.0_kpr)) then
    root1 = -b / (2.0_kpr*a)
    root2 = root1
  else
    root1 = (-b + sqrt(discriminant)) / (2.0_kpr*a)
    root2 = (-b - sqrt(discriminant)) / (2.0_kpr*a)
  end if

end subroutine quadratic_solver

end program test_quadratic
