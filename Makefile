# all:
# 	arm-none-eabi-gcc -mthumb-interwork -specs=gba.specs -o kernel.out -c kernel.c
# 	arm-none-eabi-objcopy -O binary kernel.out kernel.gba
# 	# ./gbafix kernel.gba

PROJ    := main
TARGET  := $(PROJ)

OBJS    := $(PROJ).o graphics.o mem.o
# HEADS	:= strucures.h

# --- Build defines ---------------------------------------------------

PREFIX  := arm-none-eabi-
CC      := $(PREFIX)gcc
LD      := $(PREFIX)gcc
OBJCOPY := $(PREFIX)objcopy

ARCH    := -mthumb-interwork -mthumb
SPECS   := -specs=gba.specs

CFLAGS  := $(ARCH) -Wall -fno-strict-aliasing -g
LDFLAGS := $(ARCH) $(SPECS)


.PHONY : build clean

# --- Build -----------------------------------------------------------
# Build process starts here!
build: $(TARGET).gba

# Strip and fix header (step 3,4)
$(TARGET).gba : $(TARGET).elf
	$(OBJCOPY) -v -O binary $< $@
	-@./gbafix $@

# Link (step 2)
$(TARGET).elf : $(OBJS)
	$(LD) $^ $(LDFLAGS) -o $@

# Compile (step 1)
$(OBJS) : %.o : %.c
	$(CC) -c $< $(CFLAGS) -o $@
	$(CC) -S $< $(CFLAGS)
		
# --- Clean -----------------------------------------------------------

clean :
	@rm -fv *.gba
	@rm -fv *.elf
	@rm -fv *.o