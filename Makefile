
CC := arm-none-eabi-gcc
CXX := arm-none-eabi-g++
OBJCOPY := arm-none-eabi-objcopy

TARGET := cpp_exception_costs_study
BUILD_DIR := build

INCLUDE := \
    -I ../hodea-stm32f0-vpkg/CMSIS/Include \
    -I ../hodea-stm32f0-vpkg/CMSIS/Device/ST/STM32F0xx/Include

CFLAGS := \
    -O3 -g -Wall -ffreestanding -ffunction-sections -fdata-sections \
    -fno-common -mcpu=cortex-m0 -mthumb -std=c11 \
    $(INCLUDE) -DSTM32F091xC


CXXFLAGS := \
    -O3 -g -Wall -ffreestanding -ffunction-sections -fdata-sections \
    -fno-common -mcpu=cortex-m0 -mthumb -std=c++11 \
    $(INCLUDE) -DSTM32F091xC


LDFLAGS := \
    --specs=nosys.specs --specs=nano.specs -Xlinker --gc-sections \
    -T../src/gcc/stm32f091rc.ld \
    -Xlinker -Map=$(TARGET).map


VPATH = ../src:../src/gcc

.PHONY: all clean

all:
	mkdir -p $(BUILD_DIR) && \
        $(MAKE) -C $(BUILD_DIR) -f ../Makefile $(TARGET).bin

$(TARGET).bin: $(TARGET).elf
	$(OBJCOPY) -Obinary $^ $@

$(TARGET).elf: main.o system_stm32f0xx.o startup_stm32f091xc.o
	$(CXX) $(CXXFLAGS) $(LDFLAGS) $^ -o $@


main.o: main.cpp
	$(CXX) $(CXXFLAGS) -c $^ -o $@

system_stm32f0xx.o: system_stm32f0xx.c
	$(CC) $(CFLAGS) $^ -c -o $@

startup_stm32f091xc.o: startup_stm32f091xc.s
	$(CC) $(CFLAGS) $^ -c -o $@

clean:
	rm -rf $(BUILD_DIR)


