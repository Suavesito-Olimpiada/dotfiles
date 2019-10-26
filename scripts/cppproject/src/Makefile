CXX             = g++
CXXFLAGS        = -I$(INCDIR) -I$(LINDIR) -O2 -Wall -Werror -Wextra \
				  -pedantic -std=c++17 -fsanitize=address \
				  -fsanitize=undefined
CXXFLAGSDBG     = -I$(INCDIR) -I$(LINDIR) -O0 -g3 -Wall -Werror -Wextra \
				  -pedantic -std=c++17 -fsanitize=address \
				  -fsanitize=undefined

LIBFLAGS        = -lm -pthread
# For math and thread libraries

BLDDIR          = ../build
OBJDIR          = ../build/obj
OBJDIRDBG       = ../build/objdbg
INCDIR          = ../include
LIBDIR          = ../lib
LINDIR          = ../lib/include
TSTDIR          = ../test

_LIBINCLUDES    = argh.h
LIBINCLUDES     = $(patsubst %,$(INCDIR)/%,$(_INCLUDES))

_INCLUDES       =
INCLUDES        = $(patsubst %,$(INCDIR)/%,$(_INCLUDES))

_OBJECTS        = main.o
OBJECTS         = $(patsubst %,$(OBJDIR)/%,$(_OBJECTS))
OBJECTSDBG      = $(patsubst %,$(OBJDIRDBG)/%,$(_OBJECTS))

TARGET          = program
TARGETDBG       = programdbg

$(OBJDIR)/%.o: %.cpp $(INCLUDES) $(LIBINCLUDES)
	$(CXX) -c -o $@ $< $(CXXFLAGS) $(LIBFLAGS)

$(TARGET): $(OBJECTS)
	$(CXX) -o $(BLDDIR)/$@ $^ $(CXXFLAGS) $(LIBFLAGS)

$(OBJDIRDBG)/%.o: %.cpp $(INCLUDES) $(LIBINCLUDES)
	$(CXX) -c -o $@ $< $(CXXFLAGSDBG) $(LIBFLAGS)

$(TARGETDBG): $(OBJECTSDBG)
	$(CXX) -o $(BLDDIR)/$@ $^ $(CXXFLAGSDBG) $(LIBFLAGS)

.PHONY: clean

clean:
	rm -f $(BLDDIR)/$(OBJDIR)/*.o $(BLDDIR)/$(TARGET)

.PHONY: clean-debug

clean-debug:
	rm -f $(BLDDIR)/$(OBJDIRDBG)/*.o $(BLDDIR)/$(TARGETDBG)

.PHONY: clean-test

clean-test:
	rm -f $(TSTDIR)/out/* $(TSTDIR)/program.log

.PHONY: run

run: ./$(TARGET)
	$(BLDDIR)/$(TARGET) ${ARGS}

.PHONY: debug

debug: ./$(TARGETDBG)
	gdb --args $(BLDDIR)/$(TARGETDBG) ${ARGS}

.PHONY: test

test: ./$(TARGET)
	sh $(TSTDIR)/test.sh &>> $(TSTDIR)/program.log

