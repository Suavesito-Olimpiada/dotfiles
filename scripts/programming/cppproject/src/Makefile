CXX             = g++
CXXFLAGS        = -I$(INCDIR) -I$(LINDIR) -O2 -Wall -Werror -Wextra -Wshadow \
				  -pedantic -std=c++17 -march=native -fsanitize=address \
				  -fsanitize=undefined
CXXFLAGSREL     = -I$(INCDIR) -I$(LINDIR) -O2 -flto -Wall -Werror -Wextra -Wshadow \
				  -pedantic -std=c++17 -march=native
CXXFLAGSDBG     = -I$(INCDIR) -I$(LINDIR) -Og -g3 -Wall -Werror -Wextra -Wshadow \
				  -pedantic -std=c++17 -march=native -fsanitize=address \
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

_LINCLUDES      = $(wildcard $(LINDIR)/*.hpp)
LIBINCLUDES     = $(patsubst %,$(LINDIR)/%,$(_LINCLUDES))

_INCLUDES       = $(wildcard $(INCDIR)/*.hpp)
INCLUDES        = $(patsubst %,$(INCDIR)/%,$(_INCLUDES))

_SRC            = $(wildcard *.cpp)
_OBJECTS        = $(_SRC:.cpp=.o)
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

$(TARGETREL): $(OBJECTSREL)
	$(CXX) -o $(BLDDIR)/$@ $^ $(CXXFLAGSREL) -fwhole-program $(LIBFLAGS)

$(OBJDIRDBG)/%.o: %.cpp $(INCLUDES) $(LIBINCLUDES)
	$(CXX) -c -o $@ $< $(CXXFLAGSDBG) $(LIBFLAGS)

$(TARGETDBG): $(OBJECTSDBG)
	$(CXX) -o $(BLDDIR)/$@ $^ $(CXXFLAGSDBG) $(LIBFLAGS)

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
