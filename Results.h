#ifndef ROOT_Results
#define ROOT_Results

#include "TObject.h"

class Results: public TObject {

public:

	Int_t m_eventn, m_pid, m_fluxID;
	Double_t m_E, m_cx, m_cy, m_cz;
	Double_t m_vx, m_vy, m_vz;
	Double_t m_weight, m_weight2;

	Int_t m_motherID;
	Int_t m_procID;
	Double_t m_motherE;

	Double_t m_vertexX, m_vertexY, m_vertexZ;

public:

	Results() :
			m_eventn(0), m_fluxID(0), m_pid(0), m_E(0), m_cx(0), m_cy(0), m_cz(0), m_vx(0), m_vy(0), m_vz(0), m_weight(0), m_weight2(0), m_motherID(0), m_procID(0), m_motherE(0), m_vertexX(0), m_vertexY(0), m_vertexZ(0) {
	}
	Results(Int_t eventn, Int_t fluxID, Int_t pid, Double_t m_E, Double_t cx, Double_t cy, Double_t cz, Double_t vx, Double_t vy, Double_t vz, Double_t weight, Double_t weight2);

	void setMother(Int_t id, Int_t procID, Double_t E) {
		m_motherID = id;
		m_procID = procID;
		m_motherE = E;
	}
	void setVertex(Double_t vx, Double_t vy, Double_t vz) {
		m_vertexX = vx;
		m_vertexY = vy;
		m_vertexZ = vz;
	}

	virtual ~Results();

ClassDef(Results,1)
	;

};

#endif
