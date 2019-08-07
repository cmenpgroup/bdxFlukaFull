using namespace std;

#include "Results.h"
#include "iostream"

ClassImp(Results)

Results::Results(Int_t eventn, Int_t fluxID, Int_t pid, Double_t E, Double_t cx, Double_t cy, Double_t cz, Double_t vx, Double_t vy, Double_t vz, Double_t weight, Double_t weight2) {
	m_eventn = eventn;
	m_fluxID = fluxID;
	m_pid = pid;
	m_E = E;
	m_cx = cx;
	m_cy = cy;
	m_cz = cz;
	m_vx = vx;
	m_vy = vy;
	m_vz = vz;
	m_weight = weight;
	m_weight2 = weight2;
}

Results::~Results() {
}

