CC             = gcc
CCFLAGS        = -I$(INCDIR) -I$(LINDIR) -O2 -Wall -Werror -Wextra -Wshadow \
				  -pedantic -std=c11 -march=native -fsanitize=address \
				  -fsanitize=undefined
CCFLAGSREL     = -I$(INCDIR) -I$(LINDIR) -O2 -flto -Wall -Werror -Wextra -Wshadow \
				  -pedantic -std=c11 -march=native
CCFLAGSDBG     = -I$(INCDIR) -I$(LINDIR) -Og -g3 -Wall -Werror -Wextra -Wshadow \
				  -pedantic -std=c11 -march=native -fsanitize=address \
				  -fsanitize=undefined

LIBFLAGS        = -lm -pthread
# For math and thread libraries

BLDDIR          = ../build
OBJDIR          = ../build/obj
OBJDIRREL       = ../build/objrel
OBJDIRDBG       = ../build/objdbg
INCDIR          = ../include
LIBDIR          = ../lib
LINDIR          = ../lib/include
TSTDIR          = ../test

_LIBINCLUDES    =
LIBINCLUDES     = $(patsubst %,$(INCDIR)/%,$(_INCLUDES))

_INCLUDES       = $(wildcard $(INCDIR)/*.h)
INCLUDES        = $(patsubst %,$(INCDIR)/%,$(_INCLUDES))

_SRC            = $(wildcard *.c)
_OBJECTS        = $(_SRC:.c=.o)
OBJECTS         = $(patsubst %,$(OBJDIR)/%,$(_OBJECTS))
OBJECTSREL      = $(patsubst %,$(OBJDIRREL)/%,$(_OBJECTS))
OBJECTSDBG      = $(patsubst %,$(OBJDIRDBG)/%,$(_OBJECTS))

TARGET          = program
TARGETREL       = programrel
TARGETDBG       = programdbg

$(OBJDIR)/%.o: %.c $(INCLUDES) $(LIBINCLUDES)
	$(CC) -c -o $@ $< $(CCFLAGS) $(LIBFLAGS)

$(TARGET): $(OBJECTS)
	$(CC) -o $(BLDDIR)/$@ $^ $(CCFLAGS) $(LIBFLAGS)

$(OBJDIRREL)/%.o: %.c $(INCLUDES) $(LIBINCLUDES)
	$(CC) -c -o $@ $< $(CCFLAGSREL) $(LIBFLAGS)

$(TARGETREL): $(OBJECTSREL)
	$(CC) -o $(BLDDIR)/$@ $^ $(CCFLAGSREL) -fwhole-program $(LIBFLAGS)

$(OBJDIRDBG)/%.o: %.c $(INCLUDES) $(LIBINCLUDES)
	$(CC) -c -o $@ $< $(CCFLAGSDBG) $(LIBFLAGS)

$(TARGETDBG): $(OBJECTSDBG)
	$(CC) -o $(BLDDIR)/$@ $^ $(CCFLAGSDBG) $(LIBFLAGS)

.PHONY: clean
clean:
	rm -f $(BLDDIR)/$(OBJDIR)/*.o $(BLDDIR)/$(TARGET)

.PHONY: clean-release
clean-release:
	rm -f $(BLDDIR)/$(OBJDIRREL)/*.o $(BLDDIR)/$(TARGETREL)

.PHONY: clean-debug
clean-debug:
	rm -f $(BLDDIR)/$(OBJDIRDBG)/*.o $(BLDDIR)/$(TARGETDBG)

.PHONY: clean-test
clean-test:
	rm -f $(TSTDIR)/out/* $(TSTDIR)/program.log

.PHONY: clean-dist
clean-dist:
	rm -f ../assets/project.zip

.PHONY: clean-all
clean-all: clean clean-release clean-debug clean-test clean-dist

.PHONY: run
run: ./$(TARGET)
	$(BLDDIR)/$(TARGET) ${ARGS}

.PHONY: runrel
runrel: ./$(TARGETREL)
	$(BLDDIR)/$(TARGETREL) ${ARGS}

.PHONY: debug
debug: ./$(TARGETDBG)
	gdb --args $(BLDDIR)/$(TARGETDBG) ${ARGS}

.PHONY: release
release: ./$(TARGETREL)

.PHONY: test
test: ./$(TARGET)
	sh $(TSTDIR)/test.sh &>> $(TSTDIR)/program.log

ifndef DIST
DIST            = project
endif
PARENT          = $(shell dirname ${CURDIR} | sed -En 's:.+/(.+):\1:p')
.PHONY: dist
dist: clean clean-release clean-debug clean-dist
	rm -rf .clangd .gdb_history
	rm -f ../G* ../tags
	cd ../..; \
	zip -r "$(PARENT)"/assets/$(DIST).zip $(PARENT)
