# CCP5 Summer School — Fortran Exercises

Hands-on exercises from the CCP5 Summer School "Introduction to Modern
Fortran" course, worked through alongside the numbered concept examples
in [`../src/`](../src/) and [`../docs/README.md`](../docs/README.md).

## Shared module

[`shared/types.f90`](shared/types.f90) defines `kpr`, a portable
double-precision kind (`real64` from `iso_fortran_env`), reused across
several exercises. Any exercise that does `use myTypes` needs it
compiled alongside it, module first:

```sh
gfortran -o myprogram shared/types.f90 <exercise-folder>/exercise.f90
```

## Exercises

- **00_ex_from_lecture** — warm-up practice: a recursive sequence
  (`x_{n+1} = 108 - x_{n-2}/... `-style formula), not one of the
  official 9.
- **01_intrinsic_functions** — `trim`, `adjustl`, `epsilon`/`huge`/`tiny`/`mod`,
  `sin`/`cos`, `real`/`aimag`, `len`.
- **02_quadratic_solver** — the quadratic formula, handling complex
  roots, using the shared `kpr` precision.
- **03_sum_computation** — Σi² over even `i`, the same computation
  written three ways (counted `do`, `do while`, and a posteriori
  `do`/`exit` loop) to compare loop constructs — see
  `exercise_type1.f90`/`type2.f90`/`type3.f90`.
- **04_functions_subroutines** — refactoring the sum computation so the
  function/subroutine live in their own module (`module_calc.f90`)
  instead of being `contains`ed in the program.
- **05_simpsons_rule** — Simpson's rule numerical integration of
  `f(x) = x² - 2x + 1`.
- **06_vector_module** — a vector norm/normalize/populate toolkit,
  refactored from `contains`ed procedures into its own module
  (`modules.f90`).
- **07_dynamic_allocation** — the vector module refactored again to use
  `allocatable` storage, with `allocate_vector`/`deallocate_vector`
  subroutines instead of a fixed size.
- **08_monte_carlo_pi** — estimating π by sampling random points in a
  unit square and checking which fall inside the inscribed circle.
- **09_game_of_life** — Conway's Game of Life (not started yet).

## Building an exercise

Most exercises are a single `exercise.f90`:

```sh
cd 01_intrinsic_functions
gfortran -o myprogram exercise.f90
./myprogram
```

Exercises with their own `modules.f90` (06, 07) need both files, module
first:

```sh
cd 07_dynamic_allocation
gfortran -o myprogram modules.f90 exercise.f90
./myprogram
```
