# hodea-cpp-exception-costs-study

## Evaluating the costs of C++ exceptions.

This project is used to evaluate the costs of C++ exceptions. The code runs
on a STM32 Nucleo-F091RC board and is compiled with different compilers.

The program polls the blue push button B1 and outputs its state to the
green LED LD2.

When the button is pressed the LED is turned on, when the button is
released it is turned off.

If CONFIG_USE_EXCEPTIONS is defined in main.cpp the implementation uses
an exception to report the state of the button. If CONFIG_USE_EXCEPTION
is undefined the implementation does not use exceptions.

## Comparison of the footprint

The tables below compare the different compilers. All sizes are in [byte].

### arm-none-eabi-g++ v6.3.1, newlib nano

no exceptions:

| Optimization | Text      | Data    | Bss        | Flash |
|--------------|-----------|---------|------------|-------|
|-O0           | 772       | 8       | 1568       | 780   |
|-O3           | 640       | 8       | 1568       | 646   |
|-Os           | 636       | 8       | 1568       | 644   |


exceptions:

| Optimization | text        | data      | bss        | Flash |
|--------------|-------------|-----------|------------|-------|
|-O0           | 10152       | 120       | 1612       | 10272 |
|-O3           |  9976       | 120       | 1612       | 10096 |
|-Os           |  9976       | 120       | 1612       | 10096 |

#### Note

We recompiled the compiler toolchain, with exceptions enabled for
libstdc++. Details are documented in the
[hodea-lib Wiki](https://github.com/hodea/hodea-lib/wiki/GNU-Arm-Embedded-Toolchain).

### armcc v5.06 update 5

no exceptions:

| Optimization | Code | RO-data | RW-data | ZI-data | Flash |
|--------------|------|---------|---------|---------|-------|
|-O0           | 536  | 204     | 0       | 1632    | 740   |
|-O3           | 456  | 204     | 0       | 1632    | 660   |


exceptions:

| Optimization | Code       | RO-data | RW-data | ZI-data | Flash |
|--------------|------------|---------|-------- |---------|-------|
|-O0           | 6632       | 932     | 0       | 1632    | 7564  |
|-O3           | 6560       | 916     | 0       | 1632    | 7476  |

### armcc v6.7

no exceptions:

| Optimization | Code  | RO-data | RW-data | ZI-data | Flash |
|--------------|-------|---------|---------|---------|-------|
|-O0           | 1076  | 204     | 0       | 1632    | 1280  |
|-O3           | 456   | 204     | 0       | 1632    | 660   |
|-Oz           | 456   | 204     | 0       | 1632    | 660   |

exceptions:

| Optimization | Code       | RO-data | RW-data | ZI-data | Flash |
|--------------|------------|---------|-------- |---------|-------|
|-O0           | 13416      | 2516    | 8       | 2168    | 15940 |
|-O3           | 13000      | 2492    | 8       | 2168    | 15500 |
|-Oz           | 12956      | 2488    | 8       | 2168    | 15452 |

