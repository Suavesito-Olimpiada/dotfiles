CXX             = g++
CXXFLAGS        = -I$(INCDIR) -I$(LINDIR) -g -Wall -Werror -Wextra -pedantic -std=c++2a \
                  -fconcepts
# _-fconcepts_ is for the C++ Starndard Technical
# Specification of concepts in C++17 (or later),
# enabling it in gcc compiler.

LIBFLAGS        = -lm -pthread
# For math and thread libraries

BLDDIR          = ../build
OBJDIR          = ../build/obj
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

TARGET          = program

$(OBJDIR)/%.o: %.cpp $(INCLUDES) $(LIBINCLUDES)
	$(CXX) -c -o $@ $< $(CXXFLAGS) $(LIBFLAGS)

$(TARGET): $(OBJECTS)
	$(CXX) -o $(BLDDIR)/$@ $^ $(CXXFLAGS) $(LIBFLAGS)

.PHONY: clean

clean:
	rm -f $(BLDDIR)/$(OBJDIR)/*.o $(BLDDIR)/$(TARGET)

.PHONY: run

run: ./$(TARGET)
	$(BLDDIR)/$(TARGET) ${ARGS}

.PHONY: debug

debug: ./$(TARGET)
	gdb --args $(BLDDIR)/$(TARGET) ${ARGS}

.PHONY: test

test: ./$(TARGET)
	sh $(TSTDIR)/test.sh &>> $(TSTDIR)/program.log

