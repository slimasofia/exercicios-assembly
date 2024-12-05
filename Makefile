.PHONY: all clean image run-%

# Directories
SRC_DIR = src
BIN_DIR = bin

# Tools and flags
ASM = as
LD = ld
DD = dd
BOCHS_CMD = bochs -q -f bochsrc.txt

# Floppy disk image
FLOPPY_IMG = floppy.img

# Source files and corresponding binaries
SRC_FILES = $(wildcard $(SRC_DIR)/*.s)
OBJ_FILES = $(patsubst $(SRC_DIR)/%.s, $(BIN_DIR)/%.o, $(SRC_FILES))
BIN_FILES = $(patsubst $(SRC_DIR)/%.s, $(BIN_DIR)/%.bin, $(SRC_FILES))

# Default target: build the floppy disk image
all: $(FLOPPY_IMG)

# Generate an empty floppy disk image
$(FLOPPY_IMG):
	@mkdir -p $(BIN_DIR)
	$(DD) if=/dev/zero of=$@ bs=512 count=2880

# Compile individual source files to object files
$(BIN_DIR)/%.o: $(SRC_DIR)/%.s
	$(ASM) $< -o $@

# Link object files to 16-bit binaries
$(BIN_DIR)/%.bin: $(BIN_DIR)/%.o
	$(LD) --Ttext 0x7c00 --oformat=binary $< -o $@

# Create the floppy image and copy the first binary to it
image: $(BIN_FILES) $(FLOPPY_IMG)
	$(DD) if=$(BIN_FILES) of=$(FLOPPY_IMG) bs=512 count=1 conv=notrunc

# Run a specific binary using Bochs
run-%: $(BIN_DIR)/%.bin $(FLOPPY_IMG)
	$(DD) if=$< of=$(FLOPPY_IMG) bs=512 count=1 conv=notrunc
	$(BOCHS_CMD)

# Clean all generated files
clean:
	rm -f $(FLOPPY_IMG) $(BIN_DIR)/*.o $(BIN_DIR)/*.bin
