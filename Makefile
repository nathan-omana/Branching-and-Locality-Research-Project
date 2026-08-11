# CMPT 295 Mini-Project — Makefile

CC      = gcc
STD     = -std=c11
WARN    = -Wall -Wextra -Wpedantic
ARCH    = -march=native
COMMON  = $(STD) $(WARN) $(ARCH)

SRCS    = src/sorts.c src/gen.c src/verify.c
BENCH_SRC = src/bench.c
TEST_SRC  = src/test.c

# ── Default: O2 bench 

.PHONY: all
all: bench

bench: $(SRCS) $(BENCH_SRC)
	$(CC) $(COMMON) -O2 -DOPT_LEVEL='"O2"' \
	    $(SRCS) $(BENCH_SRC) -o bench


bench_vec_info: $(SRCS) $(BENCH_SRC)
	gcc $(COMMON) -O2 -DOPT_LEVEL='"O2"' -fopt-info-vec \
	    $(SRCS) $(BENCH_SRC) -o bench 2>&1 | tee asm/vec_info.txt

# ── Tests 

.PHONY: test
test: test_runner
	./test_runner

test_runner: $(SRCS) $(TEST_SRC)
	$(CC) $(COMMON) -O2 $(SRCS) $(TEST_SRC) -o test_runner

# ── Multi-opt-level binaries

.PHONY: all_opt
all_opt: bench_O0 bench_O1 bench_O2 bench_O3

bench_O0: $(SRCS) $(BENCH_SRC)
	$(CC) $(COMMON) -O0 -DOPT_LEVEL='"O0"' $(SRCS) $(BENCH_SRC) -o bench_O0

bench_O1: $(SRCS) $(BENCH_SRC)
	$(CC) $(COMMON) -O1 -DOPT_LEVEL='"O1"' $(SRCS) $(BENCH_SRC) -o bench_O1

bench_O2: $(SRCS) $(BENCH_SRC)
	$(CC) $(COMMON) -O2 -DOPT_LEVEL='"O2"' $(SRCS) $(BENCH_SRC) -o bench_O2

bench_O3: $(SRCS) $(BENCH_SRC)
	$(CC) $(COMMON) -O3 -DOPT_LEVEL='"O3"' $(SRCS) $(BENCH_SRC) -o bench_O3

# ── Assembly 
ASM_DIR = asm

.PHONY: asm
asm: $(ASM_DIR)/sorts_O0.s $(ASM_DIR)/sorts_O1.s \
     $(ASM_DIR)/sorts_O2.s $(ASM_DIR)/sorts_O3.s

$(ASM_DIR)/sorts_O0.s: src/sorts.c src/sorts.h
	mkdir -p $(ASM_DIR)
	$(CC) $(COMMON) -O0 -S -fverbose-asm $< -o $@

$(ASM_DIR)/sorts_O1.s: src/sorts.c src/sorts.h
	mkdir -p $(ASM_DIR)
	$(CC) $(COMMON) -O1 -S -fverbose-asm $< -o $@

$(ASM_DIR)/sorts_O2.s: src/sorts.c src/sorts.h
	mkdir -p $(ASM_DIR)
	$(CC) $(COMMON) -O2 -S -fverbose-asm $< -o $@

$(ASM_DIR)/sorts_O3.s: src/sorts.c src/sorts.h
	mkdir -p $(ASM_DIR)
	$(CC) $(COMMON) -O3 -S -fverbose-asm $< -o $@

# ── Clean 

.PHONY: clean
clean:
	rm -f bench bench_O0 bench_O1 bench_O2 bench_O3 test_runner
	rm -f $(ASM_DIR)/sorts_O*.s
