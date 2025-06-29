##############
# parameters #
##############
# do you want to show the commands executed ?
DO_MKDBG?=0
# should we depend on the Makefile itself?
DO_ALLDEP:=1
# do src?
DO_SRC:=1
# do src no c?
DO_SRC_NO_C:=1
# do src_32?
DO_SRC_32:=0
# do src_64?
DO_SRC_64:=1

########
# code #
########
SOURCES=$(shell find src -type f -and -name "*.s")
OBJECTS=$(addsuffix .o,$(basename $(SOURCES)))
BINARIES=$(addsuffix .elf,$(basename $(SOURCES)))

SOURCES_NO_C=$(shell find src_no_c -type f -and -name "*.s")
OBJECTS_NO_C=$(addsuffix .o,$(basename $(SOURCES_NO_C)))
BINARIES_NO_C=$(addsuffix .elf,$(basename $(SOURCES_NO_C)))

SOURCES_32=$(shell find src_32 -type f -and -name "*.S")
OBJECTS_32=$(addsuffix .o,$(basename $(SOURCES_32)))
BINARIES_32=$(addsuffix .elf,$(basename $(SOURCES_32)))

SOURCES_64=$(shell find src_64 -type f -and -name "*.S")
OBJECTS_64=$(addsuffix .o,$(basename $(SOURCES_64)))
BINARIES_64=$(addsuffix .elf,$(basename $(SOURCES_64)))

# silent stuff
ifeq ($(DO_MKDBG),1)
Q:=
# we are not silent in this branch
else # DO_MKDBG
Q:=@
#.SILENT:
endif # DO_MKDBG

ALL:=

ifeq ($(DO_SRC),1)
ALL+=$(BINARIES)
endif # DO_SRC

ifeq ($(DO_SRC_NO_C),1)
ALL+=$(BINARIES_NO_C)
endif # DO_SRC_NO_C

ifeq ($(DO_SRC_32),1)
ALL+=$(BINARIES_32)
endif # DO_SRC_32

ifeq ($(DO_SRC_64),1)
ALL+=$(BINARIES_64)
endif # DO_SRC_64

#########
# rules #
#########
.PHONY: all
all: $(ALL)
	@true

.PHONY: clean
clean:
	$(info doing [$@])
	$(Q)-rm -f $(ALL) $(OBJECTS)
.PHONY: clean_hard
clean_hard:
	$(info doing [$@])
	$(Q)git clean -qffxd
.PHONY: build_standalone

.PHONY: debug
debug:
	$(info SOURCES is $(SOURCES))
	$(info OBJECTS is $(OBJECTS))
	$(info BINARIES is $(BINARIES))
	$(info SOURCES_NO_C is $(SOURCES_NO_C))
	$(info OBJECTS_NO_C is $(OBJECTS_NO_C))
	$(info BINARIES_NO_C is $(BINARIES_NO_C))
	$(info SOURCES_32 is $(SOURCES_32))
	$(info OBJECTS_32 is $(OBJECTS_32))
	$(info BINARIES_32 is $(BINARIES_32))
	$(info SOURCES_64 is $(SOURCES_64))
	$(info OBJECTS_64 is $(OBJECTS_64))
	$(info BINARIES_64 is $(BINARIES_64))
	$(info ALL is $(ALL))

############
# patterns #
############
$(OBJECTS): %.o: %.s
	$(info doing [$@])
	$(Q)gcc -c $< -o $@

$(BINARIES): %.elf: %.o
	$(info doing [$@])
	$(Q)gcc -z noexecstack -no-pie -o $@ $<

$(OBJECTS_NO_C): %.o: %.s
	$(info doing [$@])
	$(Q)gcc -c $< -o $@

$(BINARIES_NO_C): %.elf: %.o
	$(info doing [$@])
	$(Q)ld -o $@ $<

$(OBJECTS_32): %.o: %.S
	$(info doing [$@])
	$(Q)gcc -static -m32 -c $< -o $@

$(BINARIES_32): %.elf: %.o
	$(info doing [$@])
	$(Q)gcc -static -m32 -nostdlib -o $@ $<

$(OBJECTS_64): %.o: %.S
	$(info doing [$@])
	$(Q)gcc -static -m64 -c $< -o $@

$(BINARIES_64): %.elf: %.o
	$(info doing [$@])
	$(Q)gcc -static -m64 -nostdlib -o $@ $<

##########
# alldep #
##########
ifeq ($(DO_ALLDEP),1)
.EXTRA_PREREQS+=$(foreach mk, ${MAKEFILE_LIST},$(abspath ${mk}))
endif # DO_ALLDEP
