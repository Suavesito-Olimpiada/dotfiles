IDIR =../include
CXX=g++
CXXFLAGS=-I$(IDIR) -g -Wall -std=c++17

ODIR=../build/obj
LDIR=../lib
TDIR=../test
BDIR=../build

LIBS=-lm

_DEPS = 
DEPS = $(patsubst %,$(IDIR)/%,$(_DEPS))

_OBJ = main.o
OBJ = $(patsubst %,$(ODIR)/%,$(_OBJ))

BIN = program

$(ODIR)/%.o: %.cpp $(DEPS)
	$(CXX) -c -o $@ $< $(CXXFLAGS)

$(BIN): $(OBJ)
	$(CXX) -o $(BDIR)/$@ $^ $(CXXFLAGS) $(LIBS)

.PHONY: clean

clean:
	rm -f $(BDIR)/$(ODIR)/*.o *~ core $(INCDIR)/*~ $(BDIR)/$(BIN)

.PHONY: run

run: ./$(BIN)
	$(BDIR)/$(BIN) ${ARGS}

.PHONY: debug

debug: ./$(BIN)
	gdb --args $(BDIR)/$(BIN) ${ARGS}

.PHONY: test

test: ./$(BIN)
	sh $(TDIR)/test.sh &>> $(TDIR)/program.log
