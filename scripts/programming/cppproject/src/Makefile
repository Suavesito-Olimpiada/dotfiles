CXX             = g++
CXXFLAGS        = -I$(INCDIR) -I$(LINDIR) -O2 -Wall -Werror -Wextra -Wshadow \
				  -pedantic -std=c++17 -fsanitize=address \
				  -fsanitize=undefined
CXXFLAGSREL     = -I$(INCDIR) -I$(LINDIR) -O2 -Wall -Werror -Wextra -Wshadow \
				  -pedantic -std=c++17
CXXFLAGSDBG     = -I$(INCDIR) -I$(LINDIR) -O0 -g3 -Wall -Werror -Wextra -Wshadow \
				  -pedantic -std=c++17 -fsanitize=address \
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

_LIBINCLUDES    = argh.h
LIBINCLUDES     = $(patsubst %,$(INCDIR)/%,$(_INCLUDES))

_INCLUDES       =
INCLUDES        = $(patsubst %,$(INCDIR)/%,$(_INCLUDES))

_OBJECTS        = main.o
OBJECTS         = $(patsubst %,$(OBJDIR)/%,$(_OBJECTS))
OBJECTSREL      = $(patsubst %,$(OBJDIRREL)/%,$(_OBJECTS))
OBJECTSDBG      = $(patsubst %,$(OBJDIRDBG)/%,$(_OBJECTS))

TARGET          = program
TARGETREL       = programrel
TARGETDBG       = programdbg

$(OBJDIR)/%.o: %.cpp $(INCLUDES) $(LIBINCLUDES)
	$(CXX) -c -o $@ $< $(CXXFLAGS) $(LIBFLAGS)

$(TARGET): $(OBJECTS)
	$(CXX) -o $(BLDDIR)/$@ $^ $(CXXFLAGS) $(LIBFLAGS)

$(OBJDIRREL)/%.o: %.cpp $(INCLUDES) $(LIBINCLUDES)
	$(CXX) -c -o $@ $< $(CXXFLAGSREL) $(LIBFLAGS)

$(TARGETREL): $(OBJECTS)
	$(CXX) -o $(BLDDIRREL)/$@ $^ $(CXXFLAGSREL) $(LIBFLAGS)

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

.PHONY: release

release: ./$(TARGETREL)

.PHONY: test

test: ./$(TARGET)
	sh $(TSTDIR)/test.sh &>> $(TSTDIR)/program.log

