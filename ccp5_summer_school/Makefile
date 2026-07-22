FC = gfortran
FCFLAGS = -Wall -Wextra -O2

EXERCISES = 01_intrinsic_functions 02_quadratic_solver 03_sum_computation \
            04_functions_subroutines 05_simpsons_rule 06_vector_module \
            07_dynamic_allocation 08_monte_carlo_pi 09_game_of_life

BIN = $(addprefix bin/,$(EXERCISES))

all: $(BIN)

bin/%: shared/types.f90 %/exercise.f90
	mkdir -p bin
	$(FC) $(FCFLAGS) -J bin -o $@ $^

clean:
	rm -rf bin
