cmake_minimum_required(VERSION 3.3)

set(LINKER_SCRIPT "${CMAKE_CURRENT_LIST_DIR}/STM32F302R8Tx_FLASH.ld")
set(CPU -mcpu=cortex-m4)
set(FPU -mfpu=fpv4-sp-d16)
set(CHIP -DSTM32F302x8)
set(HAL -DUSE_HAL_DRIVER)

set(CMAKE_TOOLCHAIN_FILE "toolchain.cmake")

project(test1)
enable_language(C CXX ASM)


list(APPEND STM_SOURCE_FILES
"Core/Src/stm32f3xx_it.c"
"Core/Src/stm32f3xx_hal_msp.c"
"Drivers/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_tim.c"
"Drivers/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_tim_ex.c"
"Drivers/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_uart.c"
"Drivers/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_uart_ex.c"
"Drivers/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal.c"
"Drivers/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_rcc.c"
"Drivers/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_rcc_ex.c"
"Drivers/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_gpio.c"
"Drivers/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_dma.c"
"Drivers/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_cortex.c"
"Drivers/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_pwr.c"
"Drivers/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_pwr_ex.c"
"Drivers/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_flash.c"
"Drivers/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_flash_ex.c"
"Drivers/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_i2c.c"
"Drivers/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_i2c_ex.c"
"Drivers/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_exti.c"
"Core/Src/system_stm32f3xx.c"
"startup_stm32f302x8.s"
)

list(APPEND STM_INCLUDE_DIRS
"Core/Inc"
"Drivers/STM32F3xx_HAL_Driver/Inc"
"Drivers/STM32F3xx_HAL_Driver/Inc/Legacy"
"Drivers/CMSIS/Device/ST/STM32F3xx/Include"
"Drivers/CMSIS/Include"
)

embedded_add_executable(test1 Core/Src/main.cc ${STM_SOURCE_FILES})
target_include_directories(test1 PUBLIC ${STM_INCLUDE_DIRS})

add_custom_target(
	image ALL
	DEPENDS test1.ihex
)