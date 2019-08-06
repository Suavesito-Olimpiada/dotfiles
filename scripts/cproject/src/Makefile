IDIR =../include
CC=gcc
CFLAGS=-I$(IDIR) -g -Wall

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

$(ODIR)/%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

$(BIN): $(OBJ)
	$(CC) -o $(BDIR)/$@ $^ $(CFLAGS) $(LIBS)

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
