program intrinsic_functions
    implicit none
    real :: x, y, z
    real :: real_part, imag_part
    integer :: len1, len2
    character(len=20) :: str1, str2
    character(len=100) :: str3
    character(len=10) :: str4, str5
    character(len=100) :: str6

    

    x = 3
    y = 4
    call calc(x, y, z)
    print *,z

    str1 = "Hello"
    str2 = "World"
    call do_trim(str1, str2, str3)
    print *, str3

    str4 = "   Hello"
    str5 = "   World"
    call do_adjustl(str4, str5, str6)
    print *, str6
    
    call do_len(str1, str2, len1, len2)
    print *, "Length of str1:", len1
    print *, "Length of str2:", len2

    call do_sin_cos(0.5, y, z)
    print *, "sin(0.5):", y
    print *, "cos(0.5):", z

    call do_real_aimag(cmplx(3.7, 1.0), real_part, imag_part, len1, len2, z)
    print *, "Real part:", real_part
    print *, "Imaginary part:", imag_part
    print *, "Length of real part:", len1
    print *, "Length of imaginary part:", len2
    print *, "Sum of real and imaginary parts:", z

    call do_epsilon_huge_tiny_mod(x, y, z, real_part)
    print *, "Epsilon:", x
    print *, "Huge:", y
    print *, "Tiny:", z
    print *, "Modulus of 5.5 and 2.0:", real_part


    contains
    subroutine calc(x, y, z)
        real, intent(in) :: x, y
        real, intent(out) :: z
        z = sqrt(x**2 + y**2)
    end subroutine calc

    subroutine do_trim(str1, str2, str3)
        character(len=20), intent(in) :: str1, str2
        character(len=100), intent(out) :: str3
        str3 = trim(str1) // " " // trim(str2)
    end subroutine do_trim

    subroutine do_adjustl(str4, str5, str6)
        character(len=10), intent(in) :: str4, str5
        character(len=100), intent(out) :: str6
        str6 = adjustl(str4) // " " // adjustl(str5)
    end subroutine do_adjustl

    subroutine do_len(str1, str2, len1, len2)
        character(len=20), intent(in) :: str1, str2
        integer, intent(out) :: len1, len2
        len1 = len(trim(str1) // " ")
        len2 = len(trim(str2))
    end subroutine do_len

    subroutine do_sin_cos(x,y,z)
        real, intent(in) :: x
        real, intent(out) :: y, z
        y = sin(x)
        z = cos(x)
    end subroutine do_sin_cos

    subroutine do_real_aimag(c, real_part, imag_part, len1, len2, z)
        complex, intent(in) :: c
        integer, intent(out) :: len1, len2
        real, intent(out) :: real_part, imag_part, z
        real_part = real(c)
        len1 = int(real_part)
        imag_part = aimag(c)
        len2 = int(imag_part)
        z = real_part + imag_part
    end subroutine do_real_aimag

    subroutine do_epsilon_huge_tiny_mod(eps_out, huge_out, tiny_out, mod_out)
        real, intent(out) :: eps_out, huge_out, tiny_out, mod_out
        eps_out = epsilon(1.0)
        huge_out = huge(1.0)
        tiny_out = tiny(1.0)
        mod_out = mod(5.5, 2.0)
    end subroutine do_epsilon_huge_tiny_mod


    end program intrinsic_functions