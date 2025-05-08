################################################################################
###
### @file       common/config.7189_di03_rtos.cmake
###
### @project    EM7189
###
### @brief
###
### @classification  Confidential
###
################################################################################
###
################################################################################
###
### @copyright Copyright (C) 2019 EM Microelectronic
### @cond
###
### All rights reserved.
###
### Redistribution and use in source and binary forms, with or without
### modification, are permitted provided that the following conditions are met:
### 1. Redistributions of source code must retain the above copyright notice,
### this list of conditions and the following disclaimer.
### 2. Redistributions in binary form must reproduce the above copyright notice,
### this list of conditions and the following disclaimer in the documentation
### and/or other materials provided with the distribution.
###
################################################################################
###
### THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
### AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
### IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
### ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
### LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
### CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
### SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
### INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
### CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
### ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
### POSSIBILITY OF SUCH DAMAGE.
### @endcond
################################################################################
SET(RELEASE_MAJOR 3)
SET(RELEASE_MINOR 0)

SET(STACK_SIZE 4096)
SET(NUM_OPTIONAL_RAM_BANKS 7)

set(ROM_NAME bosch_rom)

set(HOST_INTERFACE Streaming)
SET(TARGET_HW 7189)
SET(ROM_VERSION ROM_7189_DI02)

SET(BUILD_ROM 0)
SET(BUILD_KERNEL 0)
SET(ROM_TAG 7189_di02)

SET(USE_FLASH_BOOTLOADER 0)
IF(USE_FLASH_BOOTLOADER)
    # Max number of sectors to reserve for firmware when the second-stage bootloader is used.
    SET(MAX_FLASH_FW_SIZE_SECTORS 32)
ELSE()
    # Max number of sectors to reserve for firmware when the second-stage bootloader is not used.
    SET(MAX_FLASH_FW_SIZE_SECTORS 2046)
ENDIF()

# When set, causes the kernel image to be build with support for an encrypted user payload
SET(SUPPORT_ENCRYPTED_FW 0)

# When set, user firmware is linked with the encryption kernel. In addition, the key located at $SDK/keys/custkey.aes is used to encrypt the user payload.
SET(ENCRYPT_USER_PAYLOAD 0)

# When set, includes windows build files in the resulting SDK.
SET(MAKE_WIN_SDK 1)

# Available security types: SIGNED_ALL SIGNED_UNSIGNED UNSIGNED_ALL
SET(SECURITY_TYPE SIGNED_ALL)

# Available signing methods: SIGN_LOCAL SIGN_SERVER
SET(SIGN_METHOD SIGN_LOCAL)

# Include FLASH builds
SET(BUILD_FLASH 0)
IF(ENCRYPT_USER_PAYLOAD)
   SET(BUILD_FLASH 0)
ENDIF()

# Auto exec values: ON - For Flash images, attempt to execute the image immediately after a hard reset
#                   OFF - For Flash images, do not execute the image immediately after a hard reset
SET(FLASH_AUTOEXEC ON)

#install boot rom source
SET(BOOT_ROM_SOURCE 0)

# Can the resulting SDK generate more SDKs?
SET(GENERATES_SDK 0)
SET(NEXT_SDK )

# eliminate -rdynamic from link flags
set(CMAKE_SHARED_LIBRARY_LINK_C_FLAGS )

set(ARC_C_FLAGS
)

set(DEFINES
)

IF(${TOOLCHAIN} STREQUAL arc)
    SET(PURGE -Hpurge)
    SET(LINK_PURGE -zpurge)
ELSE()
    SET(PURGE -ffunction-sections -fdata-sections)
    SET(LINK_PURGE -Wl,--gc-sections)
ENDIF()

set(LIB_C_FLAGS
    ${LIB_C_FLAGS}
    ${PURGE}
)
set(LIB_ASM_FLAGS
    ${LIB_ASM_FLAGS}
    ${PURGE}
)

set(DRIVER_C_FLAGS
    ${DRIVER_C_FLAGS}
    -DNO_JLI_CALLS
    ${PURGE}
)

set(DRIVER_ASM_FLAGS
    ${DRIVER_ASM_FLAGS}
    ${PURGE}
)

set(C_ASM_FLAGS
    -Werror
    -Wno-error=deprecated-declarations
    -g
    -DROM_NAME=${ROM_NAME}
    -DROM_VERSION=${ROM_VERSION}

    -DUSE_RTOS=1
    -DRAM_BANKS_OPTIONAL_MAX=${NUM_OPTIONAL_RAM_BANKS}
    -DUSE_FLASH_BOOTLOADER=${USE_FLASH_BOOTLOADER}
    -DENCRYPT_USER_PAYLOAD=${ENCRYPT_USER_PAYLOAD}
    -DMAX_FLASH_FW_SIZE_SECTORS=${MAX_FLASH_FW_SIZE_SECTORS}
    -DJTAG_DISABLE=1
    
    #-DBHI360_GYRO_SENSITIVITY_CORRECTION    # Use gyro sensitivity correction for BHI360
    -DBHI360_GYRO_TIMOSC_PLL               # Use TIMOSC trimming based on Gyro ODR
    -DBHI360_GYRO_EXTERNAL_TCO
    -DDEBUG_ACTIVITY_WEAR
    -DDEBUG_ACTIVITY_HEAR
)

IF(${TOOLCHAIN} STREQUAL arc)
    SET(C_ASM_FLAGS ${C_ASM_FLAGS}
        -Mb
        -Hnoxcheck
        -Hoff=Stackcheck
        -Hoff=Stackcheck_alloca
        -Hnocrt
        -Hon=Long_enums
        -Hhostlib=
    )
ELSE()
    SET(C_ASM_FLAGS ${C_ASM_FLAGS}
        -nostartfiles
        -fno-stack-check
        -mlong-calls
    )
ENDIF()

if(ARC)
    ADD_C_FLAGS( ${ARC_C_FLAGS} )
    ADD_ASM_FLAGS(
        ${C_ASM_FLAGS}
    )
endif()

# BST Reserved Parameter Pages Configuration
#         Page 8 is reserved for external customers
#         Page 9-13 are reserved for BST
set(KLIO_RESERVED_PAGE 9)
#set(PDR_RESERVED_PAGE 10)
#set(ALGO1_RESERVED_PAGE 11)
#set(ALGO2_RESERVED_PAGE 12)
set(MULTI_TAP_RESERVED_PAGE 13)
set(ACTIVITY_RESERVED_PAGE 15)

ADD_C_FLAGS(
    -include "\"${EM718X_TOP}/common/includes/hw_versions.h\""
    ${C_ASM_FLAGS}
    -DBHY2_KLIO_PAGE=${KLIO_RESERVED_PAGE}
    #-DBHY2_PDR_PAGE=${PDR_RESERVED_PAGE}
    -DBHY2_ACTIVITY_PAGE=${ACTIVITY_RESERVED_PAGE}
    -DBHY2_MULTI_TAP_PAGE=${MULTI_TAP_RESERVED_PAGE}
)

ADD_LD_FLAGS(
	${LINK_PURGE}
)

##################################################################################
############################# Library Configurations #############################
##################################################################################
# Libraries to export full source in generated SDKs.
set(EXPORT_LIB_SOURCE
)

# Libraries to export headers and pre-built binaries in generated SDKs.
set(EXPORT_LIB_BINARIES
    MetawarePrintf
    MetawareDouble
    MultiTap
    BSEC
    HeadMisalignmentCalibrator
    OrientationCorrector
    Activity
    ActivityHearable
)

# Libraries to export headers only in generated SDKs.
set(EXPORT_LIB_HEADERS
    Bootloader
    Time
    SensorInterface
    HostInterface
    HostInterface${HOST_INTERFACE}
    I2CInterface
    SPIInterface
    OuterloopROM
    Config
    OTPInterface
    openrtos
    Ram

    OscTrim
    SensorCalibration
    Hooks

    BSX
    BSXSupport
    Security
    Outerloop
)

# Extra Libraries and library directories that are needed for the build
SET(EXTRA_LIBS
    SHA256_ARC
    ECC_ARC
)

# Libraries that must be built to genererate the SDK.
SET(BUILD_LIBS
    ${EXPORT_LIB_SOURCE}
    ${EXPORT_LIB_BINARIES}
    DMA
    SensorInterfaceInit
    SensorInterfaceRAM
    DMAUnitTests
    HIDUnitTests
    HostInterfaceStreamingRAM

    BSXSupport
    OscTrim
    SensorCalibration
    Outerloop
)

IF(SUPPORT_ENCRYPTED_FW)
    LIST(APPEND BUILD_LIBS
        Encryption
        EncryptionUnitTests
    )
    LIST(APPEND EXTRA_LIBS
        SecurityEncryption
        FWEncCry_ARC
        AES128_ARC
    )
ENDIF()

list(APPEND BUILD_LIBS  my_classifier)

##################################################################################
################################# Device Drivers #################################
##################################################################################
# list all possible drivers here. The order affects which driver
# will be picked up when multiple possible drivers match an ID referenced
# in board file
set(DRIVERS_NO_SOURCE
    BHI360Accel
    BHI360Gyro
    BHI360Activity
    BHI360NoMotion
    BHI360AnyMotion
    BHI360StepCounter
    BHI360StepDetector
    BHI360WristGesture
    BHI360WristWearWakeup

    BMM150Mag
    BMM150Mag_aux_BHI360
    BMM350Mag
    BMM350Dummy
    BMP3Baro
    BMP580

    BME680Gas
    BME688Gas
    BME68xHumidity
    BME68xPressure
    BME68xTemperature

    VirtBSX
    VirtHangDetection
)

set(ENABLED_DRIVERS
     AK09918Mag

     TMG4903Light
     TMG4903Proximity

     VirtBHI360Activity
     VirtBHI360NoMotion
     VirtBHI360AnyMotion

#    VirtStepCounter
#    VirtWakeupStepCounter
#    VirtStepDetector
#    VirtWakeupStepDetector
#    VirtWakeupAnyMotion
#    VirtSignificantMotion

#    VirtAccelPassthrough
#    VirtAccel
#    VirtWakeupAccel

#    VirtMagPassthrough
#    VirtMag

#    VirtGyroPassthrough
#    VirtGyro

    VirtIMUStepCounter
    VirtIMUStepDetect
    VirtWakeupActivity
    VirtWakeupIMUWristGesture
    VirtWakeupIMUWristWearWakeup
    VirtBSXAccelPassthrough
    VirtBSXAccel
    VirtBSXWakeupAccel
    VirtBSXAccelOffset
    VirtBSXAccelUncal
    VirtBSXWakeupAccelUncal
    VirtBSXLinearAccel
    VirtBSXWakeupLinearAccel
    VirtBSXGravity
    VirtBSXWakeupGravity

    VirtBSXGyroPassthrough
    VirtBSXGyro
    VirtBSXWakeupGyro
    VirtBSXGyroOffset
    VirtBSXGyroUncal
    VirtBSXWakeupGyroUncal

    VirtBSXMagPassthrough
    VirtBSXMag
    VirtBSXWakeupMag
    VirtBSXMagOffset
    VirtBSXMagUncal
    VirtBSXWakeupMagUncal

    VirtBSXRotation
    VirtBSXWakeupRotation
    VirtBSXGameRotation
    VirtBSXWakeupGameRotation
    VirtBSXGeoRotation
    VirtBSXWakeupGeoRotation
    VirtBSXOrientation
    VirtBSXWakeupOrientation

    VirtHumidity
    VirtPressure
    VirtTemperature
    VirtGas
    VirtWakeupHumidity
    VirtWakeupPressure
    VirtWakeupTemperature
    VirtWakeupGas

    VirtLight
    VirtProximity
    VirtWakeupLight
    VirtWakeupProximity
    
    VirtBSXCustomAccelDataSource
    VirtBSXCustomGyroDataSource
    #VirtBSXCustomMagDataSource
    VirtBSXCustomIMURVDataSource
    VirtBSXCustomRVDataSource
    VirtMultiTap
    VirtIAQ
    VirtActivityHearable
    
    VirtHeadMisalignmentCalibrator
    VirtOrientationCorrector
    VirtNdofOrientationCorrector
    VirtOrientationCorrectorEuler
    VirtNdofOrientationCorrectorEuler
    VirtMyClassifier

    # Example Injection driver
    AccelInject

    ${DRIVERS_NO_SOURCE}
)

# extra drivers not pulled in by boards to build
set(DRIVERS_EXTRA
)

##################################################################################
################################# Kernel Payload #################################
##################################################################################
# libraries linked to standard kernel images
set(KERNEL_LIBS
    # OTPInterface
    Outerloop
    SensorInterfaceInit
    BSXConfigBHI360
    BSXSupport
    # BSXPatch
    SensorInterfaceRAM
    HostInterface${HOST_INTERFACE}RAM
    SensorCalibration
    OscTrim
    DMA
)

# ram patches
set(KERNEL_RAM_PATCHES
    system_monitor
    param_io
    custom_command
    #fifo_test
    spt_cmd
    SensorDataInjection
    determineVirtualSensors
    rtos_di02
    rtos_stacks
    portasm_di02
    patch_jli
    i2c_timing
    chp_diagnostic
    ram_banks
    sensor_bus
    reportEventAlways
    stack_usage
    Timer
    bsthash
    #___errno
    getBuildTime
    getDefaultDynamicRange
    performSelfTest
    write_bytes_inline_nonblocking
    write_bytes_slow_nonblocking
    write_bytes_slow_inline_nonblocking
    read_bytes_slow_nonblocking
    r30_fix
    es_init
)

# distributable ram patch source
set(KERNEL_RAM_PATCHES_SRC
)

# headers to be included
set(KERNEL_RAM_PATCHES_HEADERS
    SensorDataInjection
)

##################################################################################
################################## User Payload ##################################
##################################################################################
# libraries linked to standard user images
set(BOARDS_LIBS
    MetawareDouble
    MetawarePrintf
    MultiTap
    BSEC
    HeadMisalignmentCalibrator
    OrientationCorrector
    Activity
    ActivityHearable
)

# ram patches
set(RAM_PATCHES
    getBuildTime
    hostboot_pin_pullup_check
    custom_virtual_sensor_support
    bhi360_jtag_m3_multiplex_check
)

# headers to be included
set(RAM_PATCHES_HEADERS
    custom_virtual_sensor_support
)

list(APPEND BOARDS_LIBS my_classifier)

# distributable ram patch source
set(RAM_PATCHES_SRC
    # example1
)

##################################################################################
############################## Board Configurations ##############################
##################################################################################
IF(NOT BOARDS)
    set(BOARDS
        Bosch_Shuttle3_BHI360_BMM350C_HeadOrientation_hearable
        Bosch_Shuttle3_BHI360_BMM150_HeadOrientation_hearable
        Bosch_Shuttle3_BHI360_HeadOrientation_hearable
        Bosch_Shuttle3_BHI360_Aux_BMM150
        Bosch_Shuttle3_BHI360_BMM150
        Bosch_Shuttle3_BHI360_Turbo
        Bosch_Shuttle3_BHI360
        Bosch_Shuttle3_BHI360_MyModel      
    )
ENDIF()

##################################################################################
############################### Misc Configurations ##############################
##################################################################################

set(CAT_FLAGS
    -p
)

set(TESTS
    #jli_test
    check_jli
    copyright
)

SET(APPS
)

IF(USE_FLASH_BOOTLOADER)
    LIST(APPEND APPS
        SecondStageBootloader
    )
    LIST(APPEND EXTRA_LIBS
        SecondStageBootloader
    )
ENDIF()

# Sections to mark as force-include when linking a library to an exec.
set(INCLUDE_SECTIONS
    .phys_sensor_descriptors
    .timer_sensor_descriptors
    .virt_sensor_descriptors
    .hook_.*
    .test_group
)

# List of utilities needed by the generated SDK.
SET(INSTALL_UTILS
    initdat
    stuffelf
    elf2bin
    cat
    backtrace
    isign
)

# Libraries without CMakeLists.txt or directories that should be removed for avoiding bulding warings in the custom SDK. 
SET(REMOVED_LIBS 
    BSX
    DMA
    SensorInterfaceInit
    SensorInterfaceRAM
    DMAUnitTests
    HIDUnitTests
    HostInterfaceStreamingRAM

    AES_ARC
    SHA256_ARC
    ECC_ARC
)
