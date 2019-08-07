# Makefile for the ROOT test programs.
# This Makefile shows nicely how to compile and link applications
# using the ROOT libraries on all supported platforms.
#
# Copyright (c) 2000 Rene Brun and Fons Rademakers
#
# Author: Fons Rademakers, 29/2/2000

ARCH          = linux
CXX           =
ObjSuf        = o
SrcSuf        = cpp
ExeSuf        =
DllSuf        = so
OutPutOpt     = -o

ROOTCFLAGS   := $(shell root-config --cflags)
ROOTLIBS     := $(shell root-config --libs)
ROOTGLIBS    := $(shell root-config --glibs)

# Linux with egcs, gcc 2.9x, gcc 3.x (>= RedHat 5.2)
CXX           = g++
GFORTRAN      = gfortran
CXXFLAGS      = -O -Wall -fPIC -DgFortran
LD            = g++
LDFLAGS       = -O
SOFLAGS       = -shared
LIBFLUKA      = -lflukahp -L$(FLUPRO)

CXXFLAGS     += $(ROOTCFLAGS)
LIBS          = $(ROOTLIBS) $(SYSLIBS)
GLIBS         = $(ROOTGLIBS) $(SYSLIBS)

#------------------------------------------------------------------------------

RESULTSO        = Results.o CycleSummary.o
RESULTSS        = Results.cpp ResultsDict.cpp CycleSummary.cpp CycleSummaryDict.cpp
RESULTSSO       = Results.o ResultsDict.o CycleSummary.o CycleSummaryDict.o
RESULTSH        = Results.h CycleSummary.h

OBJS            = usrout.o magfld.o mgdraw.o stuprf.o

#copied from fluka
FOPTS=-O3 -mtune=generic \
-fexpensive-optimizations -funroll-loops -fstrength-reduce -std=legacy \
-Wall -Wuninitialized -Wno-tabs -Wline-truncation -Wno-unused-function \
-Wno-unused-parameter \
-Wno-unused-variable -Wunused-label \
-Waggregate-return -Wcast-align -Wsystem-headers \
-ftrapping-math -frange-check -fbackslash \
-fdump-core -fbacktrace -ffpe-trap=invalid,zero,overflow -finit-local-zero \
-ffixed-form -ffixed-line-length-80 -frecord-marker=4 -funderscoring \
 -fno-automatic -msse2 -mfpmath=sse -fPIC


#------------------------------------------------------------------------------

all:            libResults.so FluLib.o rootfluka

libResults.so:  $(RESULTSSO) $(RESULTSH)
		$(LD) $(SOFLAGS) $(LDFLAGS) $(RESULTSSO) $(GLIBS) -o libResults.so
		@echo "$@ done"

ResultsDict.cpp:Results.h ResultsLinkDef.h
		@echo "Generating dictionary $@..."
		@$(ROOTSYS)/bin/rootcint -f ResultsDict.cpp -c -p Results.h ResultsLinkDef.h
		
CycleSummaryDict.cpp:CycleSummary.h CycleSummaryLinkDef.h
		@echo "Generating dictionary $@..."
		@$(ROOTSYS)/bin/rootcint -f CycleSummaryDict.cpp -c -p CycleSummary.h CycleSummaryLinkDef.h
		

FluLib.o:   Results.h FluLib.cpp
	    @echo "Generating Library $@..."
	    g++ -c FluLib.cpp $(ROOTCFLAGS) -DgFortran

.f.$(ObjSuf):
	       $(FLUPRO)/flutil/fff $?

rootfluka:     $(OBJS) FluLib.$(ObjSuf) libResults.so
	       ar x $(FLUPRO)/libflukahp.a fluka.o
	       $(GFORTRAN) $(FOPTS) -Wl,-rpath=/project/Gruppo3/fiber5/celentano/bdxFlukaFull -o $@ fluka.o FluLib.o usrout.o magfld.o mgdraw.o stuprf.o libResults.so $(ROOTLIBS) $(LIBFLUKA) -lstdc++


clean:
		@rm -f rootfluka Results.o ResultsDict.o CycleSummary.o CycleSummaryDict.o FluLib.o core *.so ResultsDict.cpp $(OBJS) *.FOR fluka.o stuprf.o magfld.o mgdraw.o usrout.o

.$(SrcSuf).$(ObjSuf):
	$(CXX) $(CXXFLAGS) -c $<
