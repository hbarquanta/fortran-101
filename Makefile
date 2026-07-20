FC = gfortran
FCFLAGS = -Wall -Wextra -O2

BIN = $(patsubst src/%.f90,bin/%,$(wildcard src/*.f90)) $(patsubst src/%.f,bin/%,$(wildcard src/*.f))

all: $(BIN)

bin/%: src/%.f90
	mkdir -p bin
	$(FC) $(FCFLAGS) -o $@ $<

bin/%: src/%.f
	mkdir -p bin
	$(FC) $(FCFLAGS) -o $@ $<

clean:
	rm -rf bin
