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

### arm-none-eabi-g++ v6.3.1, newlib nano

without exceptions:

| Optimization | text      | data    | bss        |
|--------------|-----------|---------|------------|
|-O0           | 772 bytes | 8 bytes | 1568 bytes |
|-O3           | 640 bytes | 8 bytes | 1568 bytes |


with exceptions enabled:

| Optimization | text        | data      | bss        |
|--------------|-------------|-----------|------------|
|-O0           | 10152 bytes | 120 bytes | 1612 bytes |
|-O3           |  9976 bytes | 120 bytes | 1612 bytes |

#### Note

We recompiled the compiler toolchain, with exceptions enabled for
libstdc++. Details are documented in the
[hodea-lib Wiki](https://github.com/hodea/hodea-lib/wiki/GNU-Arm-Embedded-Toolchain).
