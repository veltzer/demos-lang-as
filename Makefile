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
ALL:=$(BINARIES)

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
	$(info ALL is $(ALL))

#################
# pettern rules #
#################
$(BINARIES): %.elf: %.o
	$(info doing [$@])
	$(Q)ld -o $@ $<

$(OBJECTS): %.o: %.s
	$(info doing [$@])
	$(Q)gcc -c $< -o $@
