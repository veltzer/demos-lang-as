##############
# parameters #
##############
# do you want to show the commands executed ?
DO_MKDBG?=0


#############
# variables #
#############
SOURCES=$(shell find src -name "*.s")
OBJECTS=$(addsuffix .o,$(basename $(SOURCES)))
BINARIES=$(addsuffix .elf,$(basename $(SOURCES)))

SOURCES_NO_C=$(shell find src_no_c -name "*.s")
OBJECTS_NO_C=$(addsuffix .o,$(basename $(SOURCES_NO_C)))
BINARIES_NO_C=$(addsuffix .elf,$(basename $(SOURCES_NO_C)))

########
# code #
########
# silent stuff
ifeq ($(DO_MKDBG),1)
Q:=
# we are not silent in this branch
else # DO_MKDBG
Q:=@
#.SILENT:
endif # DO_MKDBG

# sources from the git perspective
ALL:=$(BINARIES) $(BINARIES_NO_C)

#########
# rules #
#########
.PHONY: all
all: $(ALL)
	$(info doing [$@])

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
	$(info ALL is $(ALL))

#################
# pettern rules #
#################
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

