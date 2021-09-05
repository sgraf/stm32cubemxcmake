cmake_minimum_required(VERSION 3.0)

# 'Generic' for embedded system without an OS.
set(CMAKE_SYSTEM_NAME Generic)

# Set C compiler.
set(CMAKE_C_COMPILER arm-none-eabi-gcc)

# Set objcopy utility.
set(CMAKE_OBJCOPY arm-none-eabi-objcopy)
set(CMAKE_SIZE arm-none-eabi-size)

# Prevents linking issue while testing compiler.
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# Set CMAKE_SYSROOT as find_program() root.
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# Set CMAKE_FIND_ROOT_PATH as find_library() root.
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
# Set CMAKE_FIND_ROOT_PATH as find_file()/find_path() root.
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
# Set CMAKE_FIND_ROOT_PATH as find_package() root.
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

set(COMMON_FLAGS "${HAL} ${CHIP} ${CPU} -mthumb ${FPU} ${FLOAT_ABI}")
# Set compiler flags.
set(CMAKE_C_FLAGS  "${COMMON_FLAGS} -Os -ffunction-sections -fdata-sections -Wall -mlong-calls -g3 -Wall -std=gnu99")
set(CMAKE_CXX_FLAGS  "${COMMON_FLAGS} -Os -ffunction-sections -fdata-sections -mlong-calls -g3 -Wall -std=gnu++17 -fno-threadsafe-statics -fno-rtti -fno-exceptions")
set(CMAKE_ASM_FLAGS "${COMMON_FLAGS} -x assembler-with-cpp -Wall -fdata-sections -ffunction-sections")
# Set linker flags.
set(CMAKE_EXE_LINKER_FLAGS "${COMMON_FLAGS} -Wl,--start-group -lm -lc -lnosys -Wl,--end-group --specs=nano.specs -Wl,--gc-sections -T${LINKER_SCRIPT}")


macro(embedded_add_executable target_name)

	set(elf_name ${target_name}.elf)
	set(bin_name ${target_name}.bin)

	set(elf_path ${CMAKE_BINARY_DIR}/${elf_name})
	set(bin_path ${CMAKE_BINARY_DIR}/${bin_name})

    # Outputs elf file.
    add_executable(${target_name} ${ARGN})

	# Rename the elf file.
	set_target_properties(${target_name} PROPERTIES OUTPUT_NAME ${elf_name})

    # Generate bin file.
	add_custom_command(
		TARGET ${target_name} POST_BUILD
		COMMAND ${CMAKE_OBJCOPY} -O binary ${elf_path} ${bin_path}
	)

    add_custom_command(
        OUTPUT ${target_name}.ihex
	    COMMAND ${CMAKE_OBJCOPY} -O ihex ${CMAKE_BINARY_DIR}/${target_name}.elf ${CMAKE_BINARY_DIR}/${target_name}.ihex
	    COMMAND ${CMAKE_SIZE} ${CMAKE_BINARY_DIR}/${target_name}.elf
        DEPENDS ${target_name}
    )

endmacro(embedded_add_executable)