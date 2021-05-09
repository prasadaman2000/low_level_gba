# all:
# 	arm-none-eabi-gcc -mthumb-interwork -specs=gba.specs -o kernel.out -c kernel.c
# 	arm-none-eabi-objcopy -O binary kernel.out kernel.gba
# 	# ./gbafix kernel.gba

PROJ    := main

OBJS    := $(PROJ).o graphics.o mem.o timint.o
SRCFOLDER := ./src/
BUILDFOLDER := ./build/

TARGET  := $(BUILLDFOLDER)$(PROJ)


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
	$(OBJCOPY) -v -O binary $< $(BUILLDFOLDER)$@
	-@./gbafix $(BUILLDFOLDER)$@

# Link (step 2)
$(BUILLDFOLDER)$(TARGET).elf : $(BUILLDFOLDER)$(OBJS)
	$(LD) $^ $(LDFLAGS) -o $(BUILLDFOLDER)$@

# Compile (step 1)
$(OBJS) : $(BUILLDFOLDER)%.o : $(SRCFOLDER)%.c
	$(CC) -c $< $(CFLAGS) -o $(BUILLDFOLDER)$@
	$(CC) -S $< $(CFLAGS)
		
# --- Clean -----------------------------------------------------------

clean :
	@rm -fv *.gba
	@rm -fv *.elf
	@rm -fv *.o
	@rm -fv *.sav
	@rm -fv *.s