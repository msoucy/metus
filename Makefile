#!/usr/bin/make

# The subdirectory where intermediate files (.o, etc.) will be stored
DOBJDIR = bin
COBJDIR = cbin

# The doxygen config file name
DOXYFILE=Doxyfile

C_LIBS=-lncurses -lzmq
D_LIBS=${addprefix -L, $(C_LIBS)}
D_FLAGS=-property -wi -od"$(DOBJDIR)" $(D_LIBS) -J"testing"
SRC_PREFIX=testing
DBLD=rdmd --build-only $(D_FLAGS)
CBLD=g++ -Wall -Wextra $(C_LIBS) -o"$@"


$(DOBJDIR)/%: $(SRC_PREFIX)/%.d
	@echo "$<"
	@if [ ! -d $(DOBJDIR) ] ; then mkdir -p $(DOBJDIR) ; fi
	$(DBLD) "$<"

$(COBJDIR)/%: $(SRC_PREFIX)/%.cpp
	@echo "$<"
	@if [ ! -d $(COBJDIR) ] ; then mkdir -p $(COBJDIR) ; fi
	$(CBLD) "$<"

testing: clean progs

testing32: clean
	${MAKE} D_FLAGS="${D_FLAGS} -m32" testing

progs: dprogs cprogs

dprogs: $(patsubst $(SRC_PREFIX)/%,$(DOBJDIR)/%,$(patsubst %.d,%,$(wildcard $(SRC_PREFIX)/*.d)))

cprogs: $(patsubst $(SRC_PREFIX)/%,$(COBJDIR)/%,$(patsubst %.cpp,%,$(wildcard $(SRC_PREFIX)/*.cpp)))

docs:
	doxygen $(DOXYFILE)

clean:
	rm -rf $(DOBJDIR) $(COBJDIR) docs &> /dev/null
