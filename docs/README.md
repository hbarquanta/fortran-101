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
