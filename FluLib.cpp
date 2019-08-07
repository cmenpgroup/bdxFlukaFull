#ifndef __CFORTRAN_LOADED
#include "cfortran.h"
#endif

#include <stdio.h>

#include <TROOT.h>
#include "Results.h"
#include "CycleSummary.h"
#include <TTree.h>
#include <TFile.h>


#ifndef WIN32
#define myusrini myusrini_
#else
#define myusrini MYUSRINI
#endif

static TFile *RootFile = 0;

/*Tree to save event-by-event passing trough particles*/
static TTree *RootTree = 0;
static Results *TheResults = 0;

/*Tree to save end-of-cycle data*/
static TTree *RootTreeCycleData = 0;
static CycleSummary *TheCycleSummary =0;

extern "C" {
void myusrini(char *fname, int length) {
	printf("Executing MYUSRINI\n");
	fname[length--] = '\0'; //null-terminate the string
	RootFile = new TFile(fname, "recreate");

	/*Create TTree to hold event-by-event data*/
	RootTree = new TTree("out", "out");
	RootTree->Branch("flux", &TheResults, 64000, 1);


	/*Create TTree to hold summary data*/
	RootTreeCycleData = new TTree("CycleSummary","CycleSummary");
	RootTreeCycleData->Branch("CycleSummary",&TheCycleSummary);


	printf("---> %s <--string--lenght--> %i <---- \n", fname, length);

}
}

#ifndef WIN32
#define regionsToFluxId regionstofluxid_
#else
#define regionsToFluxId REGIONSTOFLUXID
#endif

extern "C" {
void regionsToFluxId(int &fluxID, char *reg1, char *reg2, int length1, int length2) {

	reg1[length1--] = '\0'; //null-terminate the string
	reg2[length2--] = '\0'; //null-terminate the string

	/*trim the strings*/
	for (size_t i = 0, j = 0; reg1[j] = reg1[i]; j += !isspace(reg1[i++]));
	for (size_t i = 0, j = 0; reg2[j] = reg2[i]; j += !isspace(reg2[i++]));

	/*First check the first regions*/
	if ((strcmp(reg1, "CONCFWD") == 0) && (strcmp(reg2, "CONCFW0") == 0)) {
		fluxID = 100;
		return;
	} else if ((strcmp(reg1, "CONCFW12") == 0) && (strcmp(reg2, "MUABS0") == 0)) {
		fluxID = 113;
	} else {
		for (int ii = 0; ii < 12; ii++) {
			if ((strcmp(reg1, Form("CONCFW%i", ii)) == 0) && (strcmp(reg2, Form("CONCFW%i", ii + 1)) == 0)) {
				fluxID = 100 + ii + 1;
				return;
			}
		}
		for (int ii = 0; ii <= 18; ii++) {
			if ((strcmp(reg1, Form("MUABS%i", ii)) == 0) && (strcmp(reg2, Form("MUABS%i", ii + 1)) == 0)) {
				fluxID = 113 + ii + 1;
				return;
			}
		}
	}
}
}

#ifndef WIN32
#define eventcreate eventcreate_
#else
#define eventcreate EVENTCREATE
#endif

extern "C" {
void eventcreate(Int_t &eventn, Int_t &fluxID, Int_t &pid, Double_t &E, Double_t &cx, Double_t &cy, Double_t &cz, Double_t &vx, Double_t &vy, Double_t &vz, Double_t &weight, Double_t &weight2) {
	if (TheResults) {
		delete TheResults;
		TheResults = 0;
	}
	TheResults = new Results(eventn, fluxID, pid, E, cx, cy, cz, vx, vy, vz, weight, weight2);
}
}

#ifndef WIN32
#define eventsave eventsave_
#else
#define eventsave EVENTSAVE
#endif

extern "C" {
void eventsave() {
	RootTree->Fill();
}
}

#ifndef WIN32
#define vertexsave vertexsave_
#else
#define vertexsave VERTEXSAVE_
#endif

extern "C" {
void vertexsave(Int_t &motherID, Int_t &procID, Double_t &motherE, Double_t &vx, Double_t &vy, Double_t &vz) {
	if (TheResults == 0) {
		return;
	} else {
		TheResults->setMother(motherID, procID, motherE);
		TheResults->setVertex(vx, vy, vz);
	}
}
}

#ifndef WIN32
#define fileclose fileclose_
#else
#define fileclose FILECLOSE
#endif

extern "C" {
void fileclose(Int_t &ncases) {
	printf("Executing FILECLOSE: %i \n",ncases);


	/*Save cycle summary*/
	if (TheCycleSummary) {
		delete TheCycleSummary;
		TheCycleSummary = 0;
	}

	TheCycleSummary = new CycleSummary(ncases);
	RootTreeCycleData->Fill();

	/*Clean*/
	if (TheResults) {
		delete TheResults;
		TheResults = 0;
	}

	if (TheCycleSummary){
		delete TheCycleSummary;
		TheCycleSummary = 0;
	}

	/*Save file*/
	if (RootFile) {
		RootTree->Write();
		RootTreeCycleData->Write();
		RootFile->Close();
	}
	printf("DONE\n");

}
}

