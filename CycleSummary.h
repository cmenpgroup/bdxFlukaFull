/*
 * CycleSummary.h
 *
 *  Created on: Aug 8, 2017
 *      Author: celentan
 */

#ifndef CYCLESUMMARY_H_
#define CYCLESUMMARY_H_

#include "TObject.h"

class CycleSummary: public TObject {

private:
	int nEOT;

public:
	CycleSummary() :
			nEOT(0) {
	}
	CycleSummary(int ncases);
	virtual ~CycleSummary();

	int getEOT() const {
		return nEOT;
	}

	void setEOT(int eot) {
		nEOT = eot;
	}

	ClassDef(CycleSummary,1);
};

#endif /* CYCLESUMMARY_H_ */
