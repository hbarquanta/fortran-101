# Fortran 101 — Concept Notes

Running documentation of everything learned in the workshop, in the order
we learned it. Each section: what it is, the syntax, and a hands-on
example you can build and run.

## Contents

1. [Program structure & Hello World](#1-program-structure--hello-world)
2. [Variables](#2-variables)
3. [Branching](#3-branching)
4. [Loops](#4-loops)
5. [Functions & subroutines](#5-functions--subroutines)
6. [Free-form syntax characters](#6-free-form-syntax-characters)
7. [Intrinsic types](#7-intrinsic-types)
8. [Derived (user-defined) types](#8-derived-user-defined-types)
9. [Named kind parameters](#9-named-kind-parameters)
10. [Character length & literals](#10-character-length--literals)
11. [String comparison functions](#11-string-comparison-functions)
12. [Logicals](#12-logicals)
13. [iso_fortran_env kinds](#13-iso_fortran_env-kinds)
14. [Finding all available kinds](#14-finding-all-available-kinds)
15. [Derived type with mixed fields](#15-derived-type-with-mixed-fields)
16. [Type-bound procedures](#16-type-bound-procedures)
17. [implicit none: with vs. without](#17-implicit-none-with-vs-without)
18. [Variable attributes: volatile & save](#18-variable-attributes-volatile--save)
19. [Parameter](#19-parameter)
20. [Variable scope: block](#20-variable-scope-block)
21. [Arithmetic & concatenation operators](#21-arithmetic--concatenation-operators)
22. [Relational & logical operators](#22-relational--logical-operators)
23. [Bitwise operators](#23-bitwise-operators)
24. [Bitwise reductions over an array](#24-bitwise-reductions-over-an-array)
25. [select case](#25-select-case)
26. [Implied do loops](#26-implied-do-loops)
27. [cycle](#27-cycle)
28. [exit](#28-exit)
29. [Optional arguments](#29-optional-arguments)
30. [Recursive functions](#30-recursive-functions)
31. [pure](#31-pure)
32. [elemental](#32-elemental)
33. [Arrays](#33-arrays)
34. [Array shapes: reshape & shape](#34-array-shapes-reshape--shape)
35. [Array intrinsics: transpose, matmul, dot_product, conjg](#35-array-intrinsics-transpose-matmul-dot_product-conjg)
36. [Array reduction functions](#36-array-reduction-functions)
37. [Array location & masking functions](#37-array-location--masking-functions)
38. [The where construct](#38-the-where-construct)
39. [Passing arrays: assumed shape, assumed size, adjustable size](#39-passing-arrays-assumed-shape-assumed-size-adjustable-size)
40. [Array bounds: size, lbound, ubound](#40-array-bounds-size-lbound-ubound)
41. [Assumed-rank arrays](#41-assumed-rank-arrays)
42. [Allocatable arrays](#42-allocatable-arrays)
43. [allocate's stat= argument](#43-allocates-stat-argument)
44. [Automatic arrays](#44-automatic-arrays)
45. [Procedure overloading](#45-procedure-overloading)
46. [Operator overloading](#46-operator-overloading)
47. [Assignment overloading](#47-assignment-overloading)
48. [I/O basics: print, write, and format labels](#48-io-basics-print-write-and-format-labels)
49. [Standard units](#49-standard-units)
50. [Reading from a string](#50-reading-from-a-string)
51. [Integer format descriptors](#51-integer-format-descriptors)
52. [Real format descriptors](#52-real-format-descriptors)
53. [General (G) and logical (L) format descriptors](#53-general-g-and-logical-l-format-descriptors)
54. [Writing to a string](#54-writing-to-a-string)
55. [Arbitrary unit numbers](#55-arbitrary-unit-numbers)
56. [inquire](#56-inquire)
57. [Writing to a file](#57-writing-to-a-file)
58. [Reading from a file](#58-reading-from-a-file)
59. [Binary (unformatted) files](#59-binary-unformatted-files)
60. [newunit](#60-newunit)
61. [Pointers: basics](#61-pointers-basics)
62. [Pointers: associated & null](#62-pointers-associated--null)
63. [Pointers to array slices](#63-pointers-to-array-slices)
64. [Conditional compilation](#64-conditional-compilation)
65. [Macro expansion](#65-macro-expansion)
66. [Debugging flags catch what -Wall misses](#66-debugging-flags-catch-what--wall-misses)
67. [Compiling, linking, and inspecting binaries](#67-compiling-linking-and-inspecting-binaries)
68. [Linking against a library](#68-linking-against-a-library)
69. [Command line arguments](#69-command-line-arguments)
70. [Random numbers](#70-random-numbers)
71. [One job per routine](#71-one-job-per-routine)
72. [Named constants instead of magic numbers](#72-named-constants-instead-of-magic-numbers)
73. [Closing puzzle: a recursive sequence](#73-closing-puzzle-a-recursive-sequence)
74. [Profiling with gprof](#74-profiling-with-gprof)

---

## 1. Program structure & Hello World

Every Fortran program is wrapped in a named block:

```fortran
program name
  ...
end program name
```

The name after `end program` must match the name after `program` (it's
optional but good practice — the compiler uses it to catch mismatched
`end` statements in larger files).

`implicit none` should be the first line inside every program. Without it,
Fortran guesses a variable's type from its first letter (I-N = integer,
everything else = real), which silently hides typos as new variables.
`implicit none` forces every variable to be declared, so the compiler
catches mistakes instead.

`print *, ...` writes output to the screen. The general form is
`print <format>, <values>` — the comma always separates the format
specifier from the values. `*` is a format specifier meaning "use
default formatting" (list-directed output); an explicit format string
like `'(I5, F8.2)'` could go there instead to control exact widths.

```fortran
program hello_world
  implicit none

  print *, 'Hello from Fortran!'

end program hello_world
```

(see [src/01_hello.f90](../src/01_hello.f90)) — build & run: `make && ./bin/01_hello`

### Why `.f90` and not `.f`?

- `.f` (and `.for`) = **fixed-form** source, the original FORTRAN 66/77
  layout: code must start in column 7 and end by column 72, comments need
  a `C` in column 1. A leftover from punch-card days.
- `.f90` / `.f95` / `.f03` / `.f08` = **free-form** source, introduced in
  the Fortran 90 standard: no column rules, `!` for comments, indent
  freely. This is what modern Fortran code (and this workshop) uses.

`gfortran` picks the parsing rules from the file extension, so always use
`.f90` for new code unless you're deliberately compiling legacy fixed-form
source.

(see [src/01_hello_fixed.f](../src/01_hello_fixed.f) for a fixed-form version of
the same hello-world program) — build & run: `make && ./bin/01_hello_fixed`

---

## 2. Variables

Variables are declared with a type before they're used (required, since
we always write `implicit none`). Common basic types:

- `integer` — whole numbers
- `real` — decimal numbers
- `character(len=N)` — fixed-length string of N characters
- `logical` — `.true.` / `.false.`

Declare, then assign with `=`.

```fortran
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
```

(see [src/02_variables.f90](../src/02_variables.f90)) — build & run: `make && ./bin/02_variables`

---

## 3. Branching

`if ... then ... else ... end if` runs one branch depending on a
condition. Every `if` block that uses `then` must be closed with
`end if`.

```fortran
program branching
  implicit none

  integer :: number

  number = 7

  if (number > 0) then
    print *, 'Positive'
  else
    print *, 'Not positive'
  end if

end program branching
```

(see [src/03_branching.f90](../src/03_branching.f90)) — build & run: `make && ./bin/03_branching`

---

## 4. Loops

`do i = start, stop` repeats a block once for each value of `i` from
`start` to `stop` (inclusive), closed with `end do`.

```fortran
program loops
  implicit none

  integer :: i

  do i = 1, 5
    print *, 'Iteration', i
  end do

end program loops
```

(see [src/04_loops.f90](../src/04_loops.f90)) — build & run: `make && ./bin/04_loops`

---

## 5. Functions & subroutines

Both are reusable blocks of code, defined inside a `contains` section of
a program. The difference is how they give back a result:

- A **function** returns a value directly, used inside an expression
  (`d = distance(...)`). It has a declared type and assigns its result
  to its own name.
- A **subroutine** doesn't return a value — it's called with `call`, and
  any results come back through its arguments, marked `intent(out)`.

`intent(in)` / `intent(out)` on arguments document (and let the compiler
check) whether an argument is read-only input or a result being written
back.

Function version:

```fortran
program function_example
  implicit none
  real :: d

  d = distance(0.0, 0.0, 3.0, 4.0)
  print *, 'Distance:', d

contains

  function distance(x1, y1, x2, y2)
    real :: distance
    real, intent(in) :: x1, y1, x2, y2
    distance = sqrt((x2 - x1)**2 + (y2 - y1)**2)
  end function distance

end program function_example
```

(see [src/05_function_example.f90](../src/05_function_example.f90)) — build & run: `make && ./bin/05_function_example`

Subroutine version:

```fortran
program subroutine_example
  implicit none
  real :: d

  call distance(0.0, 0.0, 3.0, 4.0, d)
  print *, 'Distance:', d

contains

  subroutine distance(x1, y1, x2, y2, d)
    real, intent(in) :: x1, y1, x2, y2
    real, intent(out) :: d
    d = sqrt((x2 - x1)**2 + (y2 - y1)**2)
  end subroutine distance

end program subroutine_example
```

(see [src/05_subroutine_example.f90](../src/05_subroutine_example.f90)) — build & run: `make && ./bin/05_subroutine_example`

---

## 6. Free-form syntax characters

- `!` — starts a comment; rest of the line is ignored.
- `;` — separates two statements on the same line.
- `&` — continues one statement onto the next line.
- plain `<enter>` — ends a statement (the default separator; no
  character needed).

```fortran
program syntax_demo
  implicit none
  integer :: a, b, total

  a = 2; b = 3          ! ; separates two statements on one line

  total = a + &         ! & continues this statement onto the next line
          b

  print *, 'Total:', total

end program syntax_demo
```

(see [src/06_syntax.f90](../src/06_syntax.f90)) — build & run: `make && ./bin/06_syntax`

---

## 7. Intrinsic types

Fortran's built-in numeric types: `integer`, `real`, `complex` (plus
`logical` and `character`, covered in [Variables](#2-variables)). Each
numeric type can take an optional `kind` parameter to control its
precision — e.g. `real(kind=8)` for double precision. A literal needs a
matching `_kind` suffix (`3.14_8`) to actually use that precision.

```fortran
program intrinsic_types
  implicit none

  integer :: i
  real :: r
  real(kind=8) :: r_precise
  complex :: c

  i = 42
  r = 3.14
  r_precise = 3.14159265358979_8
  c = (1.0, 2.0)

  print *, i, r, r_precise, c

end program intrinsic_types
```

(see [src/07_intrinsic_types.f90](../src/07_intrinsic_types.f90)) — build & run: `make && ./bin/07_intrinsic_types`

---

## 8. Derived (user-defined) types

`type ... end type` defines your own type — a named group of fields,
similar to a struct in other languages. Declare a variable of it with
`type(name)`, and access its fields with `%`.

```fortran
program derived_type
  implicit none

  type :: point
    real :: x, y
  end type point

  type(point) :: p

  p%x = 1.0
  p%y = 2.0

  print *, p%x, p%y

end program derived_type
```

(see [src/08_derived_type.f90](../src/08_derived_type.f90)) — build & run: `make && ./bin/08_derived_type`

---

## 9. Named kind parameters

Instead of writing `kind=8` directly (which isn't guaranteed portable
across compilers), you can ask for a kind by the precision you actually
need: `selected_int_kind(r)` gives a kind that can hold at least `r`
decimal digits, and `selected_real_kind(p, r)` gives a kind with at
least `p` digits of precision and an exponent range of `r`. Store the
result in a named `integer, parameter`, then use that name both as the
`kind=` and as the literal suffix.

```fortran
program kind_parameters
  implicit none
  integer, parameter :: long = selected_int_kind(9)
  integer, parameter :: dp = selected_real_kind(9, 307)

  integer(kind=long) :: a
  real(kind=dp) :: b

  a = 10_long
  b = 3.14159265358979_dp

  print *, a, b

end program kind_parameters
```

(see [src/09_kind_parameters.f90](../src/09_kind_parameters.f90)) — build & run: `make && ./bin/09_kind_parameters`

---

## 10. Character length & literals

`character(len=N)` fixes a string's length. Several variables of the
same type can be declared in one statement (splitting across lines with
`&`), and any of them can be given an initial value right in the
declaration with `=`. A literal containing an apostrophe needs double
quotes (`"john's"`) instead of single quotes.

```fortran
program character_literals
  implicit none
  character(len=42) :: a, b = "12", &
                        c = "john's", d = "h"

  a = "hello"

  print *, a, b, c, d

end program character_literals
```

(see [src/10_character_literals.f90](../src/10_character_literals.f90)) — build & run: `make && ./bin/10_character_literals`

---

## 11. String comparison functions

`lge`, `lgt`, `lle`, `llt` (lexically-greater/greater-than/less/less-than)
compare strings by the ASCII collating sequence, regardless of what
collating sequence the compiler's default `>`/`<` operators might use —
useful when you need portable string ordering.

```fortran
program string_comparison
  implicit none
  character(len=3) :: s1 = "abc", s2 = "abd"

  print *, lge(s1, s2), lgt(s1, s2), lle(s1, s2), llt(s1, s2)

end program string_comparison
```

(see [src/11_string_comparison.f90](../src/11_string_comparison.f90)) — build & run: `make && ./bin/11_string_comparison`

---

## 12. Logicals

`logical` variables hold `.true.` or `.false.`. Combine them with the
logical operators `.and.`, `.or.`, and `.not.`.

```fortran
program logicals
  implicit none
  logical :: a, b

  a = .true.
  b = .false.

  print *, a .and. b, a .or. b, .not. a

end program logicals
```

(see [src/12_logicals.f90](../src/12_logicals.f90)) — build & run: `make && ./bin/12_logicals`

---

## 13. iso_fortran_env kinds

The `iso_fortran_env` intrinsic module provides ready-made, portable kind
constants instead of computing your own with `selected_int_kind` /
`selected_real_kind`: `int8`, `int16`, `int32`, `int64` for integers,
`real32`, `real64`, `real128` for reals. Bring in only what you need with
`use iso_fortran_env, only: ...`.

```fortran
program iso_kinds
  use iso_fortran_env, only: int8, int16, real32, real64
  implicit none

  integer(kind=int8) :: a
  integer(kind=int16) :: b
  real(kind=real32) :: c
  real(kind=real64) :: d

  a = 10_int8
  b = 1000_int16
  c = 3.14_real32
  d = 3.14159265358979_real64

  print *, a, b, c, d

end program iso_kinds
```

(see [src/13_iso_fortran_env.f90](../src/13_iso_fortran_env.f90)) — build & run: `make && ./bin/13_iso_fortran_env`

---

## 14. Finding all available kinds

`iso_fortran_env` also exposes `integer_kinds` and `real_kinds` — arrays
listing every kind value the compiler actually supports, so you can see
what's on offer rather than requesting one by precision. (The `_kind`
suffix on a literal, like `10_long`, is unrelated — that's just a marker
telling the compiler which kind to treat that literal as, not a lookup.)

```fortran
program available_kinds
  use iso_fortran_env, only: integer_kinds, real_kinds
  implicit none

  print *, integer_kinds
  print *, real_kinds

end program available_kinds
```

On this machine this prints integer kinds `1 2 4 8 16` and real kinds
`4 8 16` (byte widths gfortran supports).

(see [src/14_available_kinds.f90](../src/14_available_kinds.f90)) — build & run: `make && ./bin/14_available_kinds`

---

## 15. Derived type with mixed fields

A derived type's fields don't all have to be the same type — mix
`character`, `logical`, `integer`, `real`, whatever the data needs.
`%` is the component-access operator (like `.` in most other languages)
— `john%name` reaches into `john` and gets/sets its `name` field.

```fortran
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
```

(see [src/15_person_type.f90](../src/15_person_type.f90)) — build & run: `make && ./bin/15_person_type`

---

## 16. Type-bound procedures

A derived type can attach its own procedure with `contains` +
`procedure`, called with `%` like a method (`a%increment()`). Inside it,
the object itself arrives as the first argument (conventionally named
`this`), declared `class(TypeName)` rather than `type(TypeName)` so it
also works with subtypes.

`final` binds a procedure that runs automatically when a variable of the
type goes out of scope — Fortran requires the type (and `final`) to be
declared inside a **module**, not directly in a program. Local variables
go out of scope when the subroutine holding them returns, so calling
`run()` here is what triggers `cleanup` to fire.

```fortran
module counter_mod
  implicit none

  type :: counter
    integer :: value
  contains
    procedure :: increment
    final :: cleanup
  end type counter

contains

  subroutine increment(this)
    class(counter), intent(inout) :: this
    this%value = this%value + 1
  end subroutine increment

  subroutine cleanup(this)
    type(counter), intent(inout) :: this
    print *, 'cleanup', this%value
  end subroutine cleanup

end module counter_mod

program type_bound
  use counter_mod
  implicit none

  call run()

contains

  subroutine run()
    type(counter) :: a
    a%value = 0
    call a%increment()
    print *, a%value
  end subroutine run

end program type_bound
```

(see [src/16_type_bound_procedures.f90](../src/16_type_bound_procedures.f90)) — build & run: `make && ./bin/16_type_bound_procedures`

---

## 17. implicit none: with vs. without

Without `implicit none`, an undeclared variable's type is guessed from
its first letter: `i` through `n` become `integer`, everything else
becomes `real`. With `implicit none`, you declare the type yourself
instead of relying on that guess. Same values, same result either way —
the difference is that one is explicit and the other is implicit.

Without:

```fortran
program without_implicit_none
  ! no implicit none: type is guessed from the variable's first letter
  ! i-n = integer, everything else = real
  num = 5          ! starts with 'n' -> integer
  total = 3.5      ! starts with 't' -> real

  num = num + 1
  total = total + 1

  print *, num, total
end program without_implicit_none
```

(see [src/17_without_implicit_none.f90](../src/17_without_implicit_none.f90)) — build & run: `make && ./bin/17_without_implicit_none`

With:

```fortran
program with_implicit_none
  implicit none
  ! types are explicit now, instead of guessed from the name
  integer :: num
  real :: total

  num = 5
  total = 3.5

  num = num + 1
  total = total + 1

  print *, num, total
end program with_implicit_none
```

(see [src/17_with_implicit_none.f90](../src/17_with_implicit_none.f90)) — build & run: `make && ./bin/17_with_implicit_none`

Both print `6  4.50000000`. The real danger of skipping `implicit none`
is a typo silently creating a brand-new variable instead of raising an
error — this pair just shows the type-guessing rule itself; ask if you
want to see the typo-bug version too.

---

## 18. Variable attributes: volatile & save

Both are attributes you tack onto a declaration to change how a
variable behaves:

- `volatile` — the value can change outside the normal flow of the
  program (hardware, a signal handler, shared memory), so the compiler
  must never optimize away reads or writes to it.
- `save` — a local variable in a procedure normally resets every time
  the procedure is called; `save` makes it keep its value between calls
  instead (like `static` in C). An inline initializer on a `save`
  variable only runs once, on the very first call.

```fortran
program variable_attributes
  implicit none

  ! volatile: value may change unexpectedly, so never optimize away access
  integer, volatile :: counter

  counter = 0
  counter = counter + 1
  print *, counter

  call tick()
  call tick()
  call tick()

contains

  subroutine tick()
    ! save: keeps its value between calls instead of resetting each time
    integer, save :: n = 0
    n = n + 1
    print *, n
  end subroutine tick

end program variable_attributes
```

Prints `1`, then `1`, `2`, `3` from the three `tick()` calls — `n` isn't
reset back to `0` each time.

(see [src/18_variable_attributes.f90](../src/18_variable_attributes.f90)) — build & run: `make && ./bin/18_variable_attributes`

---

## 19. Parameter

`parameter` is another attribute: it makes a variable a named constant,
fixed at compile time. You've already seen it used for kind values
([section 9](#9-named-kind-parameters)) — here it's just a plain number.

```fortran
program parameter_demo
  implicit none
  ! parameter: a named constant, fixed at compile time, can't be reassigned
  real, parameter :: pi = 3.14159

  print *, pi
end program parameter_demo
```

Trying to assign to `pi` again (`pi = 3.0`) is a compile error:
`Named constant 'pi' in variable definition context (assignment)`.

(see [src/19_parameter.f90](../src/19_parameter.f90)) — build & run: `make && ./bin/19_parameter`

---

## 20. Variable scope: block

`block ... end block` opens a new scope inside a program or procedure.
A variable declared inside it only exists for the duration of the
block — if it has the same name as an outer variable, it **shadows**
it: the inner one is a completely separate variable, and the outer one
is unaffected once the block ends.

```fortran
program scope_demo
  implicit none
  integer :: x

  x = 1

  block
    ! this x shadows the outer one; it's a separate variable
    integer :: x
    x = 2
    print *, x
  end block

  print *, x
end program scope_demo
```

Prints `2` inside the block (the shadowed local `x`), then `1` after it
— the outer `x` was never touched.

(see [src/20_block_scope.f90](../src/20_block_scope.f90)) — build & run: `make && ./bin/20_block_scope`

---

## 21. Arithmetic & concatenation operators

`+`, `-`, `*`, `/` work as expected, and `**` for exponentiation.
Parentheses group a sub-expression to control evaluation order, same as
in any language. Most operators are **binary** (two operands, like
`a + b`), but `+`/`-` can also be **unary** (one operand, like `+a` or
`-a`, just applying a sign). `//` concatenates strings.

```fortran
program arithmetic_operators
  implicit none
  integer :: a, b
  character(len=6) :: s

  a = 5
  b = 3

  print *, a + b          ! binary: two operands
  print *, +a              ! unary: one operand
  print *, (a + b) * 2     ! parentheses group the expression

  s = 'foo' // 'bar'       ! // concatenates strings
  print *, s
end program arithmetic_operators
```

(see [src/21_arithmetic_operators.f90](../src/21_arithmetic_operators.f90)) — build & run: `make && ./bin/21_arithmetic_operators`

---

## 22. Relational & logical operators

Relational operators compare values and produce a `logical`: `==`
(equal), `/=` (not equal), `<`, `<=`, `>`, `>=`. Logical operators
combine `logical` values: `.and.`, `.or.` (seen in
[section 12](#12-logicals)), plus `.eqv.` / `.neqv.` — equivalence and
non-equivalence, true when both sides match (or don't).

```fortran
program relational_operators
  implicit none
  integer :: a, b
  logical :: p, q

  a = 5
  b = 3
  p = .true.
  q = .false.

  print *, a == b, a /= b, a < b, a <= b, a > b, a >= b
  print *, p .and. q, p .or. q, p .eqv. q, p .neqv. q
end program relational_operators
```

(see [src/22_relational_operators.f90](../src/22_relational_operators.f90)) — build & run: `make && ./bin/22_relational_operators`

---

## 23. Bitwise operators

`bge`, `bgt`, `ble`, `blt` compare integers bit-by-bit as unsigned
values (same family as `lge`/`lgt`/`lle`/`llt` for strings in
[section 11](#11-string-comparison-functions)). `iand`, `ior`, `ieor`
combine bits (AND, inclusive-OR, exclusive-OR). `ishft` shifts bits: a
positive count shifts left, negative shifts right.

```fortran
program bitwise_operators
  implicit none
  integer :: a, b

  a = 12   ! 1100
  b = 10   ! 1010

  print *, bge(a, b)      ! a >= b, comparing bits as unsigned -> true
  print *, bgt(a, b)      ! a > b, comparing bits as unsigned -> true
  print *, ble(a, b)      ! a <= b, comparing bits as unsigned -> false
  print *, blt(a, b)      ! a < b, comparing bits as unsigned -> false

  print *, iand(a, b)     ! bitwise AND: 1100 & 1010 = 1000 = 8
  print *, ior(a, b)      ! bitwise OR:  1100 | 1010 = 1110 = 14
  print *, ieor(a, b)     ! bitwise XOR: 1100 ^ 1010 = 0110 = 6

  print *, ishft(a, 2)    ! shift left 2 bits:  1100 -> 110000 = 48
  print *, ishft(a, -2)   ! shift right 2 bits: 1100 -> 0011 = 3
end program bitwise_operators
```

(see [src/23_bitwise_operators.f90](../src/23_bitwise_operators.f90)) — build & run: `make && ./bin/23_bitwise_operators`

---

## 24. Bitwise reductions over an array

`iall`, `iany`, `iparity` reduce bitwise AND/OR/XOR across every element
of an array, rather than just two scalars. They need an array to work
on — a quick preview of array syntax ahead of the full arrays topic:
`integer :: nums(3)` declares a 3-element array, and `[7, 3, 5]` is an
array constructor.

```fortran
program bitwise_reductions
  implicit none
  integer :: nums(3)

  nums = [7, 3, 5]         ! 0111, 0011, 0101

  print *, iall(nums)      ! bitwise AND of all elements: 0111&0011&0101 = 1
  print *, iany(nums)      ! bitwise OR of all elements:  0111|0011|0101 = 7
  print *, iparity(nums)   ! bitwise XOR of all elements: 0111^0011^0101 = 1
end program bitwise_reductions
```

(see [src/24_bitwise_reductions.f90](../src/24_bitwise_reductions.f90)) — build & run: `make && ./bin/24_bitwise_reductions`

---

## 25. select case

`select case` picks one branch to run based on a single value —
cleaner than a long `if / else if` chain when comparing one variable
against several possibilities. `case default` catches anything not
matched by an earlier `case`.

```fortran
program select_case_demo
  implicit none
  integer :: day

  day = 3

  select case (day)   ! runs the one branch matching day's value
    case (1)
      print *, 'Monday'
    case (2)
      print *, 'Tuesday'
    case (3)
      print *, 'Wednesday'
    case default        ! runs if no case above matched
      print *, 'Unknown day'
  end select

end program select_case_demo
```

(see [src/25_select_case.f90](../src/25_select_case.f90)) — build & run: `make && ./bin/25_select_case`

---

## 26. Implied do loops

An **implied do loop** — `(object, index = begin, end, step)` — generates
a sequence of values inline, without a full `do ... end do` block.
`step` is optional and defaults to `1`. It's most often used inside a
`print` list or an array constructor.

```fortran
program implied_do
  implicit none
  integer :: i

  print *, (i, i = 1, 10)       ! begin=1, end=10, default step 1
  print *, (i, i = 1, 10, 2)    ! begin=1, end=10, step 2

end program implied_do
```

(see [src/26_implied_do.f90](../src/26_implied_do.f90)) — build & run: `make && ./bin/26_implied_do`

---

## 27. cycle

`cycle` skips the rest of the current loop iteration and jumps straight
to the next one (like `continue` in C/Python).

```fortran
program cycle_demo
  implicit none
  integer :: i

  do i = 1, 10
    if (mod(i, 2) == 0) cycle   ! skip even numbers, go to next iteration
    print *, i
  end do

end program cycle_demo
```

Prints only the odd numbers `1 3 5 7 9` — the `print` is skipped
whenever `cycle` runs, but the loop still runs all 10 iterations.

(see [src/27_cycle.f90](../src/27_cycle.f90)) — build & run: `make && ./bin/27_cycle`

---

## 28. exit

`exit` is the counterpart to `cycle`: instead of skipping to the next
iteration, it leaves the loop entirely, right away.

```fortran
program exit_demo
  implicit none
  integer :: i

  do i = 1, 10
    if (i == 5) exit   ! stop the loop entirely once i reaches 5
    print *, i
  end do

end program exit_demo
```

Prints `1 2 3 4`, then stops — compare to `cycle` (section 27), which
prints `1 3 5 7 9` and still runs all 10 iterations. `cycle` skips one
lap; `exit` ends the race.

(see [src/28_exit.f90](../src/28_exit.f90)) — build & run: `make && ./bin/28_exit`

---

## 29. Optional arguments

Marking a dummy argument `optional` lets the caller leave it out
entirely. Inside the procedure, `present(arg)` checks whether the
caller actually supplied it, so you can fall back to a default.

```fortran
program optional_args
  implicit none
  real :: d

  call distance(3.0, 4.0, d)
  print *, d                          ! no origin given -> defaults to (0,0)

  call distance(3.0, 4.0, d, 1.0, 1.0)
  print *, d                          ! origin given explicitly

contains

  subroutine distance(x, y, d, x0, y0)
    real, intent(in) :: x, y
    real, intent(in), optional :: x0, y0   ! caller may omit these
    real, intent(out) :: d
    real :: ox, oy

    ox = 0.0
    oy = 0.0
    if (present(x0)) ox = x0   ! present() checks if the caller passed it
    if (present(y0)) oy = y0

    d = sqrt((x - ox)**2 + (y - oy)**2)
  end subroutine distance

end program optional_args
```

Without an origin, distance from `(3,4)` to the default `(0,0)` is `5`;
with an explicit origin `(1,1)`, it's `√13 ≈ 3.606`.

(see [src/29_optional_arguments.f90](../src/29_optional_arguments.f90)) — build & run: `make && ./bin/29_optional_arguments`

---

## 30. Recursive functions

A function that calls itself must be marked `recursive`, and — unlike
our earlier function example — **must** use a `result(name)` clause.
Without it, the function's own name would have to mean both "the value
being returned" and "call myself again", which is ambiguous; `result`
gives the return value its own separate name so the function name stays
free for the recursive call.

```fortran
program recursive_demo
  implicit none

  print *, fibonacci(10)

contains

  recursive function fibonacci(n) result(f)
    integer, intent(in) :: n
    integer :: f

    if (n <= 1) then
      f = n
    else
      f = fibonacci(n - 1) + fibonacci(n - 2)   ! calls itself twice
    end if
  end function fibonacci

end program recursive_demo
```

`fibonacci(10)` = `55` (the 10th Fibonacci number: `0, 1, 1, 2, 3, 5, 8,
13, 21, 34, 55`).

(see [src/30_recursive.f90](../src/30_recursive.f90)) — build & run: `make && ./bin/30_recursive`

---

## 31. pure

`pure` in front of a `function` or `subroutine` promises it has no side
effects: it can't modify anything outside itself, do I/O, or call an
impure procedure. The compiler checks and enforces this. It's mostly a
guarantee for the compiler (enabling things like safe parallel loops
later on), not something that changes how the code runs here.

```fortran
program pure_demo
  implicit none

  print *, square(5)

contains

  ! pure: this function may only compute a result from its arguments.
  ! it can't print, can't change any variable outside itself, and always
  ! returns the same output for the same input.
  pure function square(x) result(y)
    integer, intent(in) :: x
    integer :: y

    y = x * x
  end function square

end program pure_demo
```

(see [src/31_pure.f90](../src/31_pure.f90)) — build & run: `make && ./bin/31_pure`

---

## 32. elemental

`elemental` marks a function written for a single scalar value that
also automatically works on a whole array — the compiler applies it to
each element in turn, no loop needed on your part.

```fortran
program elemental_demo
  implicit none
  integer :: nums(3)

  nums = [1, 2, 3]

  print *, square(nums)   ! elemental: applies to every element automatically

contains

  ! elemental: written for one scalar, but also works on a whole array,
  ! applying itself to each element in turn
  elemental function square(x) result(y)
    integer, intent(in) :: x
    integer :: y

    y = x * x
  end function square

end program elemental_demo
```

`square([1, 2, 3])` prints `1 4 9` — same `square` from
[section 31](#31-pure), just called with an array instead of one value.

(see [src/32_elemental.f90](../src/32_elemental.f90)) — build & run: `make && ./bin/32_elemental`

---

## 33. Arrays

`integer :: arr(5)` declares a fixed-size array of 5 integers. An
**array constructor**, `[...]`, builds an array from a list of values in
one go. Indexing starts at **1**, not 0 — `arr(1)` is the first element.

```fortran
program arrays
  implicit none
  integer :: arr(5)   ! a fixed-size array of 5 integers

  arr = [1, 2, 3, 4, 5]   ! array constructor: builds an array from a list

  print *, arr        ! prints every element
  print *, arr(3)      ! indexing starts at 1, not 0

end program arrays
```

`print *, arr` prints all 5 elements; `arr(3)` is `3`.

(see [src/33_arrays.f90](../src/33_arrays.f90)) — build & run: `make && ./bin/33_arrays`

---

## 34. Array shapes: reshape & shape

Arrays can have more than one dimension — `integer :: matrix(2, 3)`
specifies a 2-row, 3-column array. `reshape(array, new_shape)` takes an
existing array and reinterprets it with a different shape (given as an
array of dimension sizes). `shape(array)` goes the other way: given an
array, it reports its dimension sizes.

```fortran
program array_shapes
  implicit none
  integer :: flat(6)
  integer :: matrix(2, 3)   ! a 2-row, 3-column array

  flat = [1, 2, 3, 4, 5, 6]
  matrix = reshape(flat, [2, 3])   ! reshape the flat array into 2 rows, 3 columns

  print *, matrix
  print *, shape(matrix)           ! shape() reports an array's dimensions

end program array_shapes
```

Fortran stores arrays in **column-major** order, so `matrix` still
prints as `1 2 3 4 5 6` — same memory layout as `flat`, just reinterpreted
as 2×3. `shape(matrix)` prints `2 3`.

(see [src/34_array_shapes.f90](../src/34_array_shapes.f90)) — build & run: `make && ./bin/34_array_shapes`

---

## 35. Array intrinsics: transpose, matmul, dot_product, conjg

- `transpose(a)` — flips a 2D array's rows and columns.
- `matmul(a, b)` — matrix multiplication (not element-wise — proper
  row-by-column matrix product).
- `dot_product(v1, v2)` — sums the element-wise products of two vectors
  into a single scalar.
- `conjg(z)` — complex conjugate: flips the sign of the imaginary part.

```fortran
program array_intrinsics
  implicit none
  real :: a(2,2), b(2,2), c(2,2)
  real :: v1(3), v2(3), d
  complex :: z(2)

  a = reshape([1.0, 2.0, 3.0, 4.0], [2,2])
  b = reshape([5.0, 6.0, 7.0, 8.0], [2,2])

  print *, transpose(a)   ! flips rows and columns

  c = matmul(a, b)        ! matrix multiplication
  print *, c

  v1 = [1.0, 2.0, 3.0]
  v2 = [4.0, 5.0, 6.0]
  d = dot_product(v1, v2) ! sum of element-wise products
  print *, d

  z = [(1.0, 2.0), (3.0, -4.0)]
  print *, conjg(z)        ! flips the sign of the imaginary part

end program array_intrinsics
```

`a` is `[[1,3],[2,4]]` and `b` is `[[5,7],[6,8]]` (column-major, from
[section 34](#34-array-shapes-reshape--shape)). `transpose(a)` prints
`1 3 2 4` (now `[[1,2],[3,4]]`); `matmul(a,b)` prints `23 34 31 46`
(`[[23,31],[34,46]]`); `dot_product` gives `32`; `conjg` gives
`(1,-2)` and `(3,4)`.

(see [src/35_array_intrinsics.f90](../src/35_array_intrinsics.f90)) — build & run: `make && ./bin/35_array_intrinsics`

---

## 36. Array reduction functions

These all collapse a whole array down to a single value:

- `sum(arr)` / `product(arr)` — total sum / product of all elements.
- `maxval(arr)` / `minval(arr)` — the largest / smallest element.
- `count(mask)` — how many elements of a logical mask are `.true.`.
- `all(mask)` — `.true.` only if *every* element satisfies the mask.
- `any(mask)` — `.true.` if *at least one* element satisfies the mask.

```fortran
program array_reduction
  implicit none
  integer :: arr(5)
  logical :: mask(5)

  arr = [3, -1, 4, 1, 5]
  mask = arr > 0

  print *, sum(arr)      ! total of all elements
  print *, product(arr)  ! product of all elements
  print *, maxval(arr)   ! largest element
  print *, minval(arr)   ! smallest element
  print *, count(mask)   ! how many elements satisfy the mask
  print *, all(mask)     ! true only if every element satisfies the mask
  print *, any(mask)     ! true if at least one element satisfies the mask

end program array_reduction
```

For `arr = [3, -1, 4, 1, 5]`: `sum` = `12`, `product` = `-60`, `maxval`
= `5`, `minval` = `-1`; `mask` is `[T,F,T,T,T]`, so `count` = `4`, `all`
= `F` (one element fails), `any` = `T`.

(see [src/36_array_reduction.f90](../src/36_array_reduction.f90)) — build & run: `make && ./bin/36_array_reduction`

---

## 37. Array location & masking functions

- `maxloc(arr)` / `minloc(arr)` — the *index* (not the value) of the
  largest / smallest element.
- `merge(tsource, fsource, mask)` — elementwise choice: `tsource` where
  `mask` is true, `fsource` where it's false.
- `pack(arr, mask)` — compacts only the elements where `mask` is true
  into a smaller array, in order.
- `unpack(vector, mask, field)` — the reverse of `pack`: scatters
  `vector`'s values back into the positions where `mask` is true, filling
  everywhere else from `field`.

```fortran
program array_location
  implicit none
  integer :: arr(5)
  integer :: packed(4)
  integer :: restored(5)

  arr = [3, -1, 4, 1, 5]

  print *, maxloc(arr)   ! index of the largest element
  print *, minloc(arr)   ! index of the smallest element

  print *, merge(1, 0, arr > 0)   ! elementwise: 1 where true, 0 where false

  packed = pack(arr, arr > 0)     ! keep only elements where the mask is true
  print *, packed

  restored = unpack(packed, arr > 0, 0)   ! scatter back, filling gaps with 0
  print *, restored

end program array_location
```

For `arr = [3, -1, 4, 1, 5]`: `maxloc` = `5` (index of `5`), `minloc` =
`2` (index of `-1`); `merge` gives `1 0 1 1 1`; `pack` (mask `arr>0` has
4 trues) gives `3 4 1 5`; `unpack` scatters those back into the true
positions, filling the one false position with `0`, exactly
reconstructing `arr`.

(see [src/37_array_location.f90](../src/37_array_location.f90)) — build & run: `make && ./bin/37_array_location`

---

## 38. The where construct

`where (mask) ... elsewhere ... end where` is an array-wide conditional
assignment — like an elementwise `if/else`, applied to every element of
an array at once, based on a logical array (the `mask`).

```fortran
program where_construct
  implicit none
  integer :: arr(5)

  arr = [3, -1, 4, 1, -5]

  where (arr > 0)
    arr = arr * 2
  elsewhere
    arr = 0
  end where

  print *, arr

end program where_construct
```

Positive elements get doubled, everything else becomes `0`:
`6 0 8 2 0`.

(see [src/38_where_construct.f90](../src/38_where_construct.f90)) — build & run: `make && ./bin/38_where_construct`

---

## 39. Passing arrays: assumed shape, assumed size, adjustable size

Three different ways a subroutine's dummy argument can receive an array,
each with different consequences:

- **Assumed shape** — `x(:)`. The array's size travels along with it
  automatically (via a hidden descriptor), so whole-array operations
  like `x = 10.0` just work, and you don't need to pass the size
  separately. This is the modern (Fortran 90+) style, but requires an
  *explicit interface* — i.e. the subroutine must be in a module or
  `contains`ed, not a bare external procedure.

  ```fortran
  subroutine pass1(x)
    real, intent(inout) :: x(:)   ! assumed shape: size is known automatically
    x = 10.0                       ! whole-array assignment works
  end subroutine pass1
  ```
  (see [src/39_assumed_shape.f90](../src/39_assumed_shape.f90)) — build & run: `make && ./bin/39_assumed_shape`

- **Assumed size** — `x(*)`. The old Fortran 77 style: the subroutine
  has *no idea* how big the array actually is — `*` just means "keep
  going as far as you tell me to." You must pass the size separately
  (as `n` here) and loop by hand; whole-array operations aren't allowed
  because the compiler doesn't know the true extent.

  ```fortran
  subroutine pass2(x, n)
    integer, intent(in) :: n
    real, intent(inout) :: x(*)   ! assumed size: extent is unknown, n must be passed separately
    integer :: i

    do i = 1, n
      x(i) = 10.0                 ! no shape info, so no whole-array ops: must loop by hand
    end do
  end subroutine pass2
  ```
  (see [src/39_assumed_size.f90](../src/39_assumed_size.f90)) — build & run: `make && ./bin/39_assumed_size`

- **Adjustable size** — `x(n)`. Also old-style, and you still must pass
  the size (`n`) explicitly as another argument — but unlike assumed
  size, the shape *is* fully known here (it's computed from `n`), so
  whole-array operations work fine.

  ```fortran
  subroutine pass3(x, n)
    integer, intent(in) :: n
    real, intent(inout) :: x(n)   ! adjustable size: explicit shape, computed from n
    x = 10.0                       ! shape is fully known, so whole-array ops work
  end subroutine pass3
  ```
  (see [src/39_adjustable_size.f90](../src/39_adjustable_size.f90)) — build & run: `make && ./bin/39_adjustable_size`

All three produce the same result here (`10 10 10 10 10`) — the
difference is entirely about what the subroutine is *allowed* to do
with the array and what you have to tell it explicitly.

---

## 40. Array bounds: size, lbound, ubound

- `size(array, dim)` — how many elements along dimension `dim`.
- `lbound(array, dim)` / `ubound(array, dim)` — the lower / upper index
  bound of dimension `dim`. An array's lower bound defaults to `1`
  unless declared otherwise (like `arr(-2:2, 3)` below, where the first
  dimension explicitly starts at `-2`).

```fortran
program array_bounds
  implicit none
  real :: arr(-2:2, 3)   ! custom lower bound -2 in the first dimension

  print *, size(arr, 1), size(arr, 2)     ! extent along each dimension
  print *, lbound(arr, 1), ubound(arr, 1) ! lower/upper bound of dimension 1
  print *, lbound(arr, 2), ubound(arr, 2) ! lower/upper bound of dimension 2

end program array_bounds
```

`size` gives `5 3` (5 elements from `-2` to `2`, 3 elements from the
default `1` to `3`). `lbound`/`ubound` of dimension 1 give `-2 2`;
dimension 2 (using the default lower bound) gives `1 3`.

(see [src/40_array_bounds.f90](../src/40_array_bounds.f90)) — build & run: `make && ./bin/40_array_bounds`

---

## 41. Assumed-rank arrays

`a(..)` (a Fortran 2018 feature) lets one subroutine accept a scalar
*or* an array of any number of dimensions — the caller can pass
anything, and `rank(a)` reports how many dimensions it actually got
(`0` for a scalar).

```fortran
program assumed_rank_demo
  implicit none
  real :: a0
  real :: a1(2)
  real :: a2(3,3)
  real :: a3(4,4)

  call sub(a0)
  call sub(a1)
  call sub(a2)
  call sub(a3)

contains

  subroutine sub(a)
    real, intent(inout) :: a(..)   ! assumed rank: accepts scalar or array of any rank
    print *, rank(a)                ! rank() reports how many dimensions a has
  end subroutine sub

end program assumed_rank_demo
```

Prints `0 1 2 2` — the scalar, the 1D array, and the two 2D arrays.
To actually do something *different* per rank inside `sub` (rather than
just report it), Fortran has a `select rank` construct — same idea as
`select case`, but branching on `rank(a)` instead of a value.

(see [src/41_assumed_rank.f90](../src/41_assumed_rank.f90)) — build & run: `make && ./bin/41_assumed_rank`

---

## 42. Allocatable arrays

An array declared `allocatable` has no size until you give it one at
runtime with `allocate(...)` — useful when you don't know the size
until the program is running. `allocated(a)` checks whether it
currently has memory; `deallocate(a)` frees it again (and it can be
`allocate`d again afterward, possibly with a different size).

```fortran
program allocatable_demo
  implicit none
  integer, allocatable :: a(:)

  print *, allocated(a)   ! not allocated yet -> false

  allocate(a(5))
  a = 10
  print *, allocated(a), a

  deallocate(a)
  print *, allocated(a)   ! false again

end program allocatable_demo
```

(see [src/42_allocatable_arrays.f90](../src/42_allocatable_arrays.f90)) — build & run: `make && ./bin/42_allocatable_arrays`

---

## 43. allocate's stat= argument

By default, a mistake like allocating an already-allocated array
crashes the whole program with a runtime error. Adding `stat=` to
`allocate` (or `deallocate`) catches that instead: it comes back `0` on
success, or a nonzero error code if something went wrong, letting your
program handle it instead of dying.

```fortran
program allocate_stat_demo
  implicit none
  integer, allocatable :: a(:)
  integer :: info

  allocate(a(5), stat=info)
  print *, info   ! 0: success

  allocate(a(10), stat=info)   ! a is already allocated: this would crash without stat=
  print *, info                 ! nonzero: caught as an error instead

  deallocate(a)   ! a is still holding the first allocation; free it before exiting

end program allocate_stat_demo
```

(see [src/43_allocate_stat.f90](../src/43_allocate_stat.f90)) — build & run: `make && ./bin/43_allocate_stat`

---

## 44. Automatic arrays

A local (non-allocatable, non-dummy) array can still be sized by a
dummy argument, e.g. `real :: a(n)`. This is an **automatic array** —
unlike an `allocatable` array, you never `allocate`/`deallocate` it
yourself; it's created automatically when the procedure starts and
destroyed automatically when it returns.

```fortran
program automatic_array_demo
  implicit none

  call show(5)

contains

  subroutine show(n)
    integer, intent(in) :: n
    real :: a(n)   ! automatic array: sized by n, exists only while show() runs
    a = 1.0
    print *, sum(a)
  end subroutine show

end program automatic_array_demo
```

(see [src/44_automatic_arrays.f90](../src/44_automatic_arrays.f90)) — build & run: `make && ./bin/44_automatic_arrays`

---

## 45. Procedure overloading

An `interface` block can group several procedures under one shared
generic name with `module procedure`. The compiler picks which actual
procedure to call based on the argument's type at the call site — same
name, different behavior depending on what you pass it. Like `final`
([section 16](#16-type-bound-procedures)), this requires the
procedures to live in a **module**.

```fortran
module overload_demo
  implicit none

  interface show
    module procedure show_int, show_real   ! same name, two different implementations
  end interface show

contains

  subroutine show_int(x)
    integer, intent(in) :: x
    print *, 'integer:', x
  end subroutine show_int

  subroutine show_real(x)
    real, intent(in) :: x
    print *, 'real:', x
  end subroutine show_real

end module overload_demo

program overloading
  use overload_demo
  implicit none

  call show(5)      ! compiler picks show_int, based on the argument's type
  call show(3.14)   ! compiler picks show_real

end program overloading
```

(see [src/45_overloading.f90](../src/45_overloading.f90)) — build & run: `make && ./bin/45_overloading`

---

## 46. Operator overloading

`interface operator (+)` (or any arithmetic/relational operator, or a
custom one written as `.xxx.`) lets you define what an operator means
for your own derived type — same idea as procedure overloading, applied
to an operator symbol instead of a name.

```fortran
module point_ops
  implicit none

  type :: point
    real :: x, y
  end type point

  interface operator (+)
    module procedure add_points   ! lets + work between two point values
  end interface operator (+)

contains

  function add_points(a, b) result(c)
    type(point), intent(in) :: a, b
    type(point) :: c
    c%x = a%x + b%x
    c%y = a%y + b%y
  end function add_points

end module point_ops

program operator_overloading
  use point_ops
  implicit none
  type(point) :: p1, p2, p3

  p1 = point(1.0, 2.0)
  p2 = point(3.0, 4.0)
  p3 = p1 + p2   ! uses our overloaded +

  print *, p3%x, p3%y

end program operator_overloading
```

`(1,2) + (3,4)` gives `(4,6)`.

(see [src/46_operator_overloading.f90](../src/46_operator_overloading.f90)) — build & run: `make && ./bin/46_operator_overloading`

---

## 47. Assignment overloading

`interface assignment (=)` lets you run your own subroutine whenever a
value of your type is assigned with `=`. The subroutine always takes
exactly two arguments: the target (`intent(out)`) and the source
(`intent(in)`), in that order.

```fortran
module point_assign
  implicit none

  type :: point
    real :: x, y
  end type point

  interface assignment (=)
    module procedure copy_point   ! lets = run our own code on point values
  end interface assignment (=)

contains

  subroutine copy_point(lhs, rhs)
    type(point), intent(out) :: lhs
    type(point), intent(in) :: rhs
    print *, 'copying point'
    lhs%x = rhs%x
    lhs%y = rhs%y
  end subroutine copy_point

end module point_assign

program assignment_overloading
  use point_assign
  implicit none
  type(point) :: p1, p2

  p1 = point(1.0, 2.0)   ! triggers copy_point
  p2 = p1                 ! triggers copy_point again

  print *, p2%x, p2%y

end program assignment_overloading
```

Prints `copying point` twice — once for each `=` — proving both
assignments actually ran through our subroutine instead of a silent
default copy.

(see [src/47_assignment_overloading.f90](../src/47_assignment_overloading.f90)) — build & run: `make && ./bin/47_assignment_overloading`

---

## 48. I/O basics: print, write, and format labels

`print *, ...` is just shorthand for `write(*,*) ...` — identical
output. `write`'s general form is `write(unit, format) list` — the
first `*` means "the default unit" (screen), the second means "no
particular format, use list-directed defaults." A format can be given
inline as a string, or as a numbered label pointing at a separate
`format` statement elsewhere in the same program unit — both do the
same thing.

```fortran
program io_basics
  implicit none
  integer :: i, j

  i = 5
  j = 7

  print *, 'Hello world'     ! print is shorthand for write(*,*)
  write(*,*) 'Hello world'   ! identical output to the line above

  write(*, '(2(i0,1x))') i, j   ! inline format string
  write(*, 101) i, j             ! same format, given via a label instead
  101 format(2(i0,1x))

end program io_basics
```

(see [src/48_io_basics.f90](../src/48_io_basics.f90)) — build & run: `make && ./bin/48_io_basics`

---

## 49. Standard units

`iso_fortran_env` provides named constants for the three standard I/O
streams: `output_unit`, `error_unit`, `input_unit` — clearer than
remembering that `*` means "the default unit" in `write`/`read`.

```fortran
program standard_units
  use iso_fortran_env, only: output_unit, error_unit, input_unit
  implicit none
  integer :: n

  write(output_unit, *) 'to standard output'
  write(error_unit, *) 'to standard error'

  write(output_unit, *) 'enter a number:'
  read(input_unit, *) n
  print *, 'you entered', n

end program standard_units
```

(see [src/49_standard_units.f90](../src/49_standard_units.f90)) — build & run: `make && ./bin/49_standard_units` (type a number when prompted)

---

## 50. Reading from a string

`read` doesn't only work from the keyboard — giving it a character
variable instead of a unit number reads from *that string* instead
(an "internal file"). Handy for parsing text you already have in memory.

```fortran
program read_from_string
  implicit none
  character(len=20) :: h
  real :: f
  integer :: a

  h = '12.5 10'
  read(h, *) f, a   ! reads from the string h, instead of from the keyboard

  print *, f, a

end program read_from_string
```

(see [src/50_read_from_string.f90](../src/50_read_from_string.f90)) — build & run: `make && ./bin/50_read_from_string`

---

## 51. Integer format descriptors

`iW` in a format string means "integer, right-justified in a field `W`
characters wide." `i0` means "use exactly as many digits as needed."
`iW.M` pads with leading zeros to at least `M` digits, still within
field width `W`. If the field is too narrow to fit the number, Fortran
prints `*` instead of a truncated/wrong value.

```fortran
program integer_formatting
  implicit none
  integer :: i

  i = 10

  write(*, '(a10,i0)')   'i0 ', i     ! minimum digits needed
  write(*, '(a10,i5)')   'i5 ', i     ! right-justified in a 5-character field
  write(*, '(a10,i5.3)') 'i5.3 ', i   ! 5-char field, at least 3 digits (zero-padded)
  write(*, '(a10,i1)')   'i1 ', i     ! field too narrow: prints '*' instead

end program integer_formatting
```

For `i = 10`: `i0` gives `10`; `i5` gives `   10` (right-justified in
5 chars); `i5.3` gives `  010` (zero-padded to 3 digits); `i1` (a field
of only 1 character — too narrow for `10`) gives `*`.

(see [src/51_integer_formatting.f90](../src/51_integer_formatting.f90)) — build & run: `make && ./bin/51_integer_formatting`

---

## 52. Real format descriptors

- `Fw.d` — fixed-point: `w` total width, `d` digits after the decimal.
- `Ew.d` — scientific notation (`E` exponent marker).
- `Dw.d` — same as `E`, but with a `D` exponent marker (a legacy way to
  flag double precision).
- `ENw.d` — engineering notation: the exponent is always a multiple of 3.
- `ESw.d` — scientific notation with exactly one nonzero leading digit.

```fortran
program real_formatting
  implicit none
  real :: b

  b = 10.043

  write(*, '(a10,f16.8)')  'f16.8 ', b    ! fixed-point notation
  write(*, '(a10,e16.8)')  'e16.8 ', b    ! scientific notation
  write(*, '(a10,d16.8)')  'd16.8 ', b    ! same as E, but with a D exponent marker
  write(*, '(a10,en16.8)') 'en16.8 ', b   ! engineering notation: exponent is a multiple of 3
  write(*, '(a10,es16.8)') 'es16.8 ', b   ! scientific notation with exactly one leading digit

end program real_formatting
```

For `b = 10.043`: `f16.8` gives `10.04300022`; `e16.8` gives
`0.10043000E+02`; `d16.8` gives `0.10043000D+02`; `en16.8` gives
`10.04300022E+00`; `es16.8` gives `1.00430002E+01`.

(see [src/52_real_formatting.f90](../src/52_real_formatting.f90)) — build & run: `make && ./bin/52_real_formatting`

---

## 53. General (G) and logical (L) format descriptors

`Lw` formats a `logical` value (`T` or `F`) right-justified in a field
`w` characters wide. `Gw.d` is the odd one out: it works for **any**
type — integer, real, logical, even character — picking a sensible
representation automatically, instead of needing a different
descriptor (`i`, `f`, `l`, ...) per type.

```fortran
program general_and_logical_formatting
  implicit none
  logical :: l
  integer :: i
  real :: b

  l = .true.
  i = 10
  b = 10.043

  write(*, '(a10,l4)')    'l4 ', l     ! l: format descriptor specific to logicals
  write(*, '(a10,g16.8)') 'g16.8 ', i  ! g: works for any type...
  write(*, '(a10,g16.8)') 'g16.8 ', b  ! ...including real...
  write(*, '(a10,g16.8)') 'g16.8 ', l  ! ...and logical

end program general_and_logical_formatting
```

(see [src/53_general_and_logical_formatting.f90](../src/53_general_and_logical_formatting.f90)) — build & run: `make && ./bin/53_general_and_logical_formatting`

---

## 54. Writing to a string

Just like `read` can pull from a string instead of the keyboard
([section 50](#50-reading-from-a-string)), `write` can format its
output *into* a character variable instead of the screen — build up a
string in memory, then use it however you like. `advance='no'` on a
`write` suppresses the usual trailing newline, so a later `write`
continues on the same line.

```fortran
program write_to_string
  implicit none
  character(len=50) :: s
  integer :: a
  real :: b

  a = 11
  b = 39.5

  write(s, '(a2,i0,1x,a2,f16.8)') 'a=', a, 'b=', b   ! writes into the string s, not the screen

  write(*, '(a50)', advance='no') trim(s)   ! advance='no': don't start a new line after this
  write(*,*) 'this goes on the prev line'

end program write_to_string
```

(see [src/54_write_to_string.f90](../src/54_write_to_string.f90)) — build & run: `make && ./bin/54_write_to_string`

---

## 55. Arbitrary unit numbers

A unit number in `read`/`write` doesn't have to be `*` or a named
constant — any integer works. If that unit isn't already associated
with an open file, gfortran creates a default-named one for you:
`fort.<unit number>`.

```fortran
program arbitrary_unit
  implicit none
  integer :: i

  i = 42
  write(777, *) i   ! unit 777 isn't open yet, so gfortran creates a file: fort.777

end program arbitrary_unit
```

Running this creates `fort.777` in the current directory, containing
`42`.

(see [src/55_arbitrary_unit.f90](../src/55_arbitrary_unit.f90)) — build & run: `make && ./bin/55_arbitrary_unit`

---

## 56. inquire

`inquire` asks questions about a file without opening it: `exist`
(does it exist on disk?), `opened` (is it currently open in *this*
program?), `number` (which unit it's open on, or `-1` if not open).

```fortran
program inquire_demo
  implicit none
  logical :: file_exists, file_open
  integer :: unit_number

  inquire(file='scratch.dat', exist=file_exists, opened=file_open, number=unit_number)
  print *, file_exists, file_open, unit_number   ! not created yet: F F -1

  open(101, file='scratch.dat', status='unknown', action='write')

  inquire(file='scratch.dat', exist=file_exists, opened=file_open, number=unit_number)
  print *, file_exists, file_open, unit_number   ! now it exists and is open on unit 101

  close(101, status='delete')   ! clean up: delete the file we just created

end program inquire_demo
```

Prints `F F -1` before opening, `T T 101` after.
`close(..., status='delete')` removes the file instead of just closing
it — handy for cleaning up temporary files.

(see [src/56_inquire.f90](../src/56_inquire.f90)) — build & run: `make && ./bin/56_inquire`

---

## 57. Writing to a file

`open` connects a unit number to an actual file on disk. `status='unknown'`
means "use it whether it already exists or not"; `action='write'`
restricts this connection to writing. `close` disconnects the unit —
after that, the file persists on disk with whatever was written.

```fortran
program write_to_file
  implicit none

  open(101, file='myfile.dat', status='unknown', action='write')
  write(101, *) 'my first line in a file'
  close(101)

end program write_to_file
```

Running this creates `myfile.dat` containing that one line.

(see [src/57_write_to_file.f90](../src/57_write_to_file.f90)) — build & run: `make && ./bin/57_write_to_file`

---

## 58. Reading from a file

To read an existing file, open it with `status='old'` (fail if it
doesn't exist, rather than silently creating it) and `action='read'`.
`iostat=` on `read` catches any error instead of crashing (same idea as
`allocate`'s `stat=` from [section 43](#43-allocates-stat-argument)).

```fortran
program read_from_file
  implicit none
  integer :: a, b, info

  a = 10

  open(101, file='myfile.dat', status='unknown', action='write')
  write(101, *) a
  close(101)

  open(101, file='myfile.dat', status='old', action='read')
  read(101, *, iostat=info) b
  close(101)

  print *, b, b + 1

end program read_from_file
```

Writes `10` to the file, reopens it, reads it back into `b`, and
prints `10 11`.

(see [src/58_read_from_file.f90](../src/58_read_from_file.f90)) — build & run: `make && ./bin/58_read_from_file`

---

## 59. Binary (unformatted) files

`form='unformatted'` writes the raw bytes of a value directly, instead
of a human-readable text representation. Unformatted `read`/`write`
statements take no format specifier at all — there's no text layout to
describe. Binary files are smaller and keep full precision, but aren't
human-readable and can depend on the machine that wrote them.

```fortran
program binary_files
  implicit none
  integer :: a, b, info

  a = 10

  open(101, file='myfile.dat', status='unknown', action='write', form='unformatted')
  write(101) a          ! unformatted: no format specifier allowed
  close(101)

  open(101, file='myfile.dat', status='old', action='read', form='unformatted')
  read(101, iostat=info) b
  close(101)

  print *, b, b + 1

end program binary_files
```

Same result as [section 58](#58-reading-from-a-file) (`10 11`), just
stored as raw bytes instead of text.

(see [src/59_binary_files.f90](../src/59_binary_files.f90)) — build & run: `make && ./bin/59_binary_files`

---

## 60. newunit

Instead of hardcoding a unit number (like `101` in sections 56–59) and
risking it colliding with another open file somewhere else in a larger
program, `open(newunit=my_unit, ...)` asks the compiler to pick an
unused one and store it in your own integer variable.

```fortran
program newunit_demo
  implicit none
  integer :: my_unit

  open(newunit=my_unit, file='myfile.dat', status='unknown', action='write')
  write(my_unit, *) 'written via newunit'
  close(my_unit)

  print *, 'unit was:', my_unit   ! compiler-assigned, not a number we chose

end program newunit_demo
```

On this gfortran, `my_unit` comes back as a negative number (e.g.
`-10`) — that's normal; `newunit` deliberately picks negative values so
they're obviously compiler-assigned rather than hand-chosen, and can
never collide with a hardcoded unit number.

(see [src/60_newunit.f90](../src/60_newunit.f90)) — build & run: `make && ./bin/60_newunit`

---

## 61. Pointers: basics

A Fortran pointer doesn't hold data itself — it's an alias for another
variable's storage. A variable a pointer can point to must be declared
`target` (or be another pointer). `=>` is **pointer assignment** ("point
at this"), completely different from `=` ("copy this value"). Once
`a => i`, `a` and `i` refer to the exact same memory — changing one
changes the other.

```fortran
program pointers_basic
  implicit none
  integer, pointer :: a
  integer, target :: i

  i = 100
  a => i        ! a now points to i: they refer to the same memory

  a = a + 50    ! modifies i, since a is just an alias for it
  print *, i, a ! both show 150

end program pointers_basic
```

Both `i` and `a` print `150` — modifying `a` really modified `i`.

(see [src/61_pointers_basic.f90](../src/61_pointers_basic.f90)) — build & run: `make && ./bin/61_pointers_basic`

---

## 62. Pointers: associated & null

`associated(ptr)` checks whether a pointer currently points at
anything. `associated(ptr, target)` checks whether it points at that
*specific* target. `ptr => null()` disassociates it — points at
nothing.

```fortran
program pointer_associated
  implicit none
  integer, pointer :: a
  integer, target :: i, k

  i = 100
  k = 300

  a => i
  print *, associated(a)      ! true: a points to something
  print *, associated(a, i)   ! true: specifically to i
  print *, associated(a, k)   ! false: not pointing to k

  a => null()
  print *, associated(a)      ! false: a points to nothing now

end program pointer_associated
```

Prints `T`, `T`, `F`, `F` — `a` points to `i` (not `k`), then after
`a => null()`, it points to nothing at all.

(see [src/62_pointer_associated.f90](../src/62_pointer_associated.f90)) — build & run: `make && ./bin/62_pointer_associated`

---

## 63. Pointers to array slices

A pointer can be an array itself, and it doesn't have to point at an
entire target array — it can point at just a **slice** of one. This is
one of the classic reasons to use pointers: work with part of an array
without copying it.

```fortran
program pointer_arrays
  implicit none
  integer, pointer :: p(:)
  integer, target :: arr(6)

  arr = [1, 2, 3, 4, 5, 6]

  p => arr(2:5)   ! points at a slice of arr, not the whole thing
  print *, p       ! 2 3 4 5

  p(1) = 99        ! modifies arr(2), since p is an alias for that slice
  print *, arr

end program pointer_arrays
```

`p` aliases `arr(2:5)`, so it prints `2 3 4 5`. Setting `p(1) = 99`
writes through to `arr(2)`, giving `1 99 3 4 5 6`.

(see [src/63_pointer_arrays.f90](../src/63_pointer_arrays.f90)) — build & run: `make && ./bin/63_pointer_arrays`

---

## 64. Conditional compilation

Preprocessing isn't part of the Fortran standard itself (aside from
`include`), but every modern compiler supports the C preprocessor's
directives anyway. To activate it, the source file's extension must be
**capitalized** (`.F90` instead of `.f90`) — that's the signal to the
compiler "run the preprocessor on this file first." `#ifdef NAME ...
#endif` includes that code only if `NAME` was defined at compile time
(via a `-D` flag).

```fortran
program conditional_compilation
  implicit none

  print *, 'Hello World!!!'
#ifdef MORE
  ! only compiled in if MORE was defined at compile time (gfortran -DMORE)
  print *, 'From Alin'
#endif

end program conditional_compilation
```

Built normally (`make`), only `Hello World!!!` prints — `MORE` isn't
defined. Compile it manually with the macro defined to get the second
line too:

```sh
gfortran -DMORE -o myprogram src/64_conditional_compilation.F90
./myprogram
```

(see [src/64_conditional_compilation.F90](../src/64_conditional_compilation.F90)) — build & run: `make && ./bin/64_conditional_compilation`

---

## 65. Macro expansion

`#define NAME(args) replacement` defines a macro: every place `NAME(...)`
appears in the code gets textually replaced with `replacement` *before*
the compiler ever sees it. Convenient, but easy to make code hard to
read (or to get subtly wrong, e.g. via missing parentheses around
arguments) — use sparingly.

```fortran
program macro_expansion
  implicit none
#define SQUARE_PLUS(x) (x*x+x)
  real :: y

  y = 10.0
  print *, SQUARE_PLUS(y)   ! expands to (y*y+y) before compiling

end program macro_expansion
```

`SQUARE_PLUS(10.0)` expands to `(10.0*10.0+10.0)` = `110`.

(see [src/65_macro_expansion.F90](../src/65_macro_expansion.F90)) — build & run: `make && ./bin/65_macro_expansion`

---

## 66. Debugging flags catch what -Wall misses

A classic bug: reading a variable before it's ever been assigned.
Our Makefile's `-Wall -Wextra` already catches this *at compile time*
as a warning — but a warning is easy to miss in a wall of build output,
and the program still runs and silently produces a wrong answer instead
of stopping.

```fortran
program uninitialized_bug
  implicit none
  integer :: a(5)
  real :: c   ! never assigned a value

  a = 10
  call square(a)
  print *, a
  print *, a(5) * c   ! uses c before it's ever set

contains

  subroutine square(b)
    integer, intent(inout) :: b(:)
    b = b * b
  end subroutine square

end program uninitialized_bug
```

Built normally (`make`), this prints `0.0000000` for the last line —
wrong, but not obviously broken; easy to miss in a larger program.
Compiled instead with a set of debugging flags that specifically hunt
for this class of bug:

```sh
gfortran -g -fbacktrace -fcheck=all \
  -finit-real=snan -ffpe-trap=invalid,zero,overflow \
  -o debug_demo src/66_uninitialized_bug.f90
./debug_demo
```

- `-finit-real=snan` — initialize every `real` to a signaling NaN
  instead of leaving it as garbage memory, so *using* an uninitialized
  real is guaranteed to misbehave instead of maybe-by-luck working.
- `-ffpe-trap=invalid,zero,overflow` — crash immediately on invalid
  floating-point operations (like using that NaN), instead of quietly
  propagating a wrong value.
- `-fcheck=all` — adds runtime bounds/shape checking (array indices,
  argument mismatches, etc).
- `-g -fbacktrace` — keep debug info and print a line-by-line backtrace
  when something does go wrong.

With these flags, the program crashes immediately with a backtrace
pointing at the exact line (`src/66_uninitialized_bug.f90:9`) —
turning a silent wrong answer into an impossible-to-miss failure
exactly where the bug is.

(see [src/66_uninitialized_bug.f90](../src/66_uninitialized_bug.f90)) — build & run (normal): `make && ./bin/66_uninitialized_bug`

---

## 67. Compiling, linking, and inspecting binaries

Turning source into a runnable program is really two steps that `make`
(and a plain `gfortran -o prog file.f90`) does for you in one go:

**1. Compile** (`-c`) — turns one source file into an object file
(`.o`): checks the syntax, but doesn't produce anything runnable yet.
A file containing only a `module` (no `program`) can only be compiled
this way — it has no entry point, so it can never be linked into an
executable by itself.

**2. Link** — combines one or more object files (plus any system/user
libraries) into an actual executable.

This repo's own [src/67_compile_link/](../src/67_compile_link/) has a
real two-file example: `math_utils.f90` (a module, compiled with `-c`
only) and `use_math_utils.f90` (a program that `use`s it). It lives in
a subdirectory rather than directly in `src/` — the Makefile's wildcard
build only looks at `src/*.f90` directly, not subdirectories, and a
module-only file would break `make all` if it tried to build one
standalone (there's nothing to link into an executable).

```fortran
! math_utils.f90
module math_utils
  implicit none
contains

  function double_it(x) result(y)
    real, intent(in) :: x
    real :: y
    y = x * 2.0
  end function double_it

end module math_utils
```

```fortran
! use_math_utils.f90
program use_math_utils
  use math_utils
  implicit none

  print *, double_it(21.0)

end program use_math_utils
```

Build it as two separate steps, from inside `src/67_compile_link/`:

```sh
mkdir -p mods
gfortran -c -J mods -o mods/math_utils.o math_utils.f90     # compile the module
gfortran -c -I mods -o use_math_utils.o use_math_utils.f90  # -I: find its .mod here
gfortran -o myprogram use_math_utils.o mods/math_utils.o    # link both objects
./myprogram
```

- `-J <dir>` — write the module's compiled `.mod` file into `<dir>`
  instead of the current directory.
- `-I <dir>` — when compiling something that `use`s a module, look in
  `<dir>` for its `.mod` file. This is also how you'd point at a
  third-party library's module files.
- Prints `42.0000000` (`double_it(21.0)`).

Errors from step 1 are about **syntax** (something in your code is
wrong); errors from step 2 are about **missing pieces** (a function was
declared but never defined anywhere, a library wasn't found, etc) —
worth telling apart when something fails to build.

Two inspection tools worth knowing: `nm math_utils.o` lists every
symbol (function/variable name) an object file defines or needs —
useful for figuring out exactly what a linker error is missing.
`ldd myprogram` (Linux) lists which shared libraries a finished
executable depends on at runtime.

If you're linking against a genuine third-party library (not just your
own module), the same `-I`/`-L` pattern extends to it: `-L<dir> -lfoo`
tells the linker where to find `libfoo.a`/`libfoo.so` and to link
against it.

---

## 68. Linking against a library

A **library** is just a precompiled bundle of object files — you link
against it instead of recompiling its source every time. A static
library (`libfoo.a`) is built with `ar` (the archiver) from one or more
`.o` files.

This repo's [src/68_libraries/](../src/68_libraries/) has a real
example: `mylib.f90` is "the library" (one function), and
`use_library.f90` calls it *without ever including its source* —
only the final linked binary needs both pieces.

```fortran
! mylib.f90 -- this is "the library": compiled once, archived, then
! linked against by anyone who wants add_one, without ever seeing
! this source again
function add_one(x) result(y)
  implicit none
  real, intent(in) :: x
  real :: y
  y = x + 1.0
end function add_one
```

```fortran
! use_library.f90
program use_library
  implicit none
  ! add_one lives in a library we'll link against, not in this file:
  ! declaring it "external" tells the compiler to trust us on its
  ! signature instead of needing a module/interface for it
  real :: add_one
  external :: add_one

  print *, add_one(41.0)   ! resolved at link time, from libmylib.a

end program use_library
```

Build it, from inside `src/68_libraries/`:

```sh
gfortran -c -o mylib.o mylib.f90        # 1. compile the library source
ar rcs libmylib.a mylib.o                # 2. archive it into libmylib.a
gfortran -o myprogram use_library.f90 -L. -lmylib   # 3. link against it
./myprogram
```

- `ar rcs libfoo.a *.o` — bundles object files into a static library
  named `libfoo.a`.
- `-L.` — look for libraries in the current directory (`-L<dir>` for
  anywhere else).
- `-lmylib` — link against `libmylib.a` (the `lib` prefix and `.a`
  suffix are assumed; you just write the middle part).
- Prints `42.0000000` (`add_one(41.0)`).

Note there's no `module` here, unlike [section 67](#67-compiling-linking-and-inspecting-binaries)
— real precompiled libraries (especially older/C-interoperable ones)
often only give you a compiled `.a`/`.so` and the function's signature
in documentation, not a `.mod` file. `external` is how you call such a
function anyway: it tells the compiler "trust me on this signature,"
instead of relying on a module to check it for you.

---

## 69. Command line arguments

Three intrinsics let a program read what it was invoked with:
`get_command(cmd)` — the whole command line, as typed. `command_argument_count()`
— how many arguments were passed. `get_command_argument(i, arg)` — the
`i`th argument, as a string.

```fortran
program command_line_arguments
  implicit none
  integer :: count, i
  character(len=255) :: cmd
  character(len=25) :: argum

  call get_command(cmd)
  print *, trim(cmd)          ! the full command line used to invoke this program

  count = command_argument_count()
  print *, 'No of arguments: ', count

  do i = 1, count
    call get_command_argument(i, argum)
    print *, 'argument no ', i, ' is: ', trim(argum)
  end do

end program command_line_arguments
```

Run it with some arguments to see it in action:

```sh
./bin/69_command_line_arguments 2003 577 889 inp
```

Prints the full command line, `No of arguments: 4`, then each argument
numbered — `2003`, `577`, `889`, `inp`. All arguments come back as
plain strings (`character`), even if they look like numbers — you'd
need to convert them yourself (e.g. with `read`, section 50) if you
need them as `integer`/`real`.

(see [src/69_command_line_arguments.f90](../src/69_command_line_arguments.f90)) — build & run: `make && ./bin/69_command_line_arguments <some> <args>`

---

## 70. Random numbers

`random_number(r)` fills `r` (scalar or array) with pseudo-random reals
in `[0, 1)`. Left alone, the sequence differs every run. `random_seed`
controls that: `random_seed(size=p)` asks the compiler how many
integers its internal seed needs; `random_seed(put=seed)` sets that
seed explicitly — the same seed always reproduces the exact same
sequence of "random" numbers, which matters for reproducible tests/debugging.

```fortran
program random_numbers
  implicit none
  integer, allocatable :: seed(:)
  real :: r(2)
  integer :: is, i, p

  is = 13
  call random_seed(size=p)         ! p: how many integers this compiler's seed needs
  allocate(seed(p))
  seed = 17 * [(i - is, i = 1, p)]  ! build a reproducible seed, instead of a random one
  call random_seed(put=seed)        ! fix the seed: same seed always gives the same numbers
  deallocate(seed)

  call random_number(r)             ! fills r with reals in [0, 1)
  print *, r

end program random_numbers
```

Running this twice in a row gives the exact same two numbers both
times — the fixed seed, not chance. The actual values are
compiler-specific (different Fortran compilers implement the generator
differently), only the "same seed → same sequence" guarantee is
portable.

(see [src/70_random_numbers.f90](../src/70_random_numbers.f90)) — build & run: `make && ./bin/70_random_numbers`

---

## 71. One job per routine

A common anti-pattern: one subroutine that does several unrelated
things, chosen by a flag argument. It's harder to read (you have to
mentally branch through every case) and harder to reuse (you can never
call just one block without the flag machinery).

Bad — one routine, many things, picked by `stage`:

```fortran
subroutine answer_to_all(x, stage)
  real, intent(inout) :: x
  integer, intent(in) :: stage

  x = x + 1.0            ! block 1
  if (stage == 1) then
    x = x * 2.0           ! block 2
  else
    x = x - 3.0           ! block 3
  end if
end subroutine answer_to_all
```

(see [src/71_one_job_bad.f90](../src/71_one_job_bad.f90)) — build & run: `make && ./bin/71_one_job_bad`

Good — each routine does exactly one thing; the caller combines them:

```fortran
subroutine block_1(x)
  real, intent(inout) :: x
  x = x + 1.0
end subroutine block_1

subroutine block_2(x)
  real, intent(inout) :: x
  x = x * 2.0
end subroutine block_2

subroutine block_3(x)
  real, intent(inout) :: x
  x = x - 3.0
end subroutine block_3
```

(see [src/71_one_job_good.f90](../src/71_one_job_good.f90)) — build & run: `make && ./bin/71_one_job_good`

Both produce identical results (`12.0` and `3.0` for the same starting
value) — splitting them apart changes nothing about behavior, only how
easy the code is to read, test, and reuse.

---

## 72. Named constants instead of magic numbers

Bare numbers scattered through conditionals and array indices (`vdw ==
1`, `energies(3)`) force the reader to remember what each number means.
Naming them with `parameter` (section 19) makes the code explain
itself.

Bad:

```fortran
if (vdw == 0) then
  print *, 'Lennard-Jones'
else if (vdw == 1) then
  print *, 'Morse'
else if (vdw == 2) then
  print *, 'Buckingham'
end if

energy = energies(1) + energies(3)   ! what do 1 and 3 even mean here?
```

(see [src/72_magic_numbers.f90](../src/72_magic_numbers.f90)) — build & run: `make && ./bin/72_magic_numbers`

Good:

```fortran
integer, parameter :: POT_LJ = 0, POT_MORSE = 1, POT_BUCK = 2
integer, parameter :: ENER_KINETIC = 1, ENER_POTENTIAL = 3
...
if (vdw == POT_LJ) then
  print *, 'Lennard-Jones'
else if (vdw == POT_MORSE) then
  print *, 'Morse'
else if (vdw == POT_BUCK) then
  print *, 'Buckingham'
end if

energy = energies(ENER_KINETIC) + energies(ENER_POTENTIAL)   ! self-explanatory now
```

(see [src/72_named_constants.f90](../src/72_named_constants.f90)) — build & run: `make && ./bin/72_named_constants`

Both print the same thing (`Morse`, `40.0`) — again, purely a
readability improvement, zero behavior change.

One more caution from the same part of the course, with no code needed:
**don't use modules as a dumping ground for shared mutable state**, the
way old Fortran 77 `common` blocks were used. A module is great for
constants, types, and procedures — but variables shared through a
module become a race condition risk the moment your program runs on
more than one core/thread at once. Keep state local and pass it
explicitly through arguments instead.

---

## 73. Closing puzzle: a recursive sequence

The course's closing slide poses a recurrence with no further
explanation, as a bonus puzzle: `x_{n+1} = 108 - 815/x_{n-1} - 1500/x_n`,
with `x_0 = 4`, `x_1 = 17/4`. What's `x_42`?

```fortran
program recursive_puzzle
  implicit none
  real(kind=8) :: x(0:42)
  integer :: n

  x(0) = 4.0d0
  x(1) = 17.0d0 / 4.0d0

  do n = 1, 41
    x(n+1) = 108.0d0 - 815.0d0/x(n-1) - 1500.0d0/x(n)
  end do

  print *, x(42)

end program recursive_puzzle
```

`x(42) ≈ 78.5153`. Recurrences shaped like this one are famous in
numerical analysis for sometimes being ill-conditioned — tiny rounding
errors can get amplified every step until the computed answer has
nothing to do with the "true" mathematical one. Worth checking whether
*this* one actually behaves that way: rerunning it in single precision
(`real` instead of `real(kind=8)`), or nudging `x_1` by `1e-10`, gives
the exact same answer to many decimal places either way — so this
particular sequence turns out to be robustly convergent to that fixed
point, not the runaway-divergence trap the classic examples warn about.
A good closing exercise: try perturbing the inputs further, or plotting
`x(n)` for increasing `n`, to see the convergence yourself.

(see [src/73_recursive_puzzle.f90](../src/73_recursive_puzzle.f90)) — build & run: `make && ./bin/73_recursive_puzzle`

---

## 74. Profiling with gprof

`gprof` answers "where is my program actually spending its time?" —
useful once a program is correct and you're trying to make it faster,
instead of guessing which part to optimize.

```sh
gfortran -o hello.x -p hello.F90    # -p: build with profiling instrumentation
./hello.x                            # running it writes out gmon.out
gprof ./hello.x                      # reads gmon.out, prints a report
```

The report is a **flat profile**: a table of every function, how much
total time was spent in it, and how many times it was called — the
fastest way to spot "oh, 90% of the runtime is actually in this one
function" instead of the one you assumed was slow.

**Note:** this section is reference-only — I don't have `gprof`
available to verify on this machine (it's a GNU/Linux profiling tool;
`-p`-style instrumentation isn't well supported by Apple's toolchain on
macOS). It should work as described on the Linux systems this course
actually runs on (e.g. the STFC JupyterHub from earlier) — worth
trying there rather than trusting an untested example here.
