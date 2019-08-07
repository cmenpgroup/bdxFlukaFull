*$ CREATE MAGFLD.FOR
*COPY MAGFLD
*
*===magfld=============================================================*
*
	SUBROUTINE MAGFLD ( X, Y, Z, BTX, BTY, BTZ, B, NREG, IDISC )

	INCLUDE '(DBLPRC)'
	INCLUDE '(DIMPAR)'
	INCLUDE '(IOUNIT)'
	INCLUDE '(CMEMFL)'
	INCLUDE '(CSMCRY)'
*
*----------------------------------------------------------------------*
*                                                                      *
*     Copyright (C) 1988-2010      by Alberto Fasso` & Alfredo Ferrari *
*     All Rights Reserved.                                             *
*                                                                      *
*                                                                      *
*     Created  in     1988         by    Alberto Fasso`                *
*                                                                      *
*                                                                      *
*     Last change on 06-Nov-10     by    Alfredo Ferrari               *
*                                                                      *
*     Input variables:                                                 *
*            x,y,z = current position                                  *
*            nreg  = current region                                    *
*     Output variables:                                                *
*            btx,bty,btz = cosines of the magn. field vector           *
*            B = magnetic field intensity (Tesla)                      *
*            idisc = set to 1 if the particle has to be discarded      *
*                                                                      *
*----------------------------------------------------------------------*

	LOGICAL LFIRST
	SAVE LFIRST


	DIMENSION ri (6267842)
	DIMENSION zi (6267842)	
	DIMENSION phideg (6267842)
	DIMENSION Br (6267842)
	DIMENSION Bphi (6267842)
	DIMENSION Bz (6267842)
	DIMENSION xi (6267842)
	DIMENSION yi (6267842)
	DIMENSION phirad (6267842)
	DIMENSION Bx (6267842)
	DIMENSION By (6267842)
	DIMENSION Bi (6267842)
	DIMENSION calpha (6267842)
	DIMENSION cbeta (6267842)
	DIMENSION cgamma (6267842)
	DIMENSION cmagnitude (6267842)
	DIMENSION BTXi (6267842)
	DIMENSION BTYi (6267842)
	DIMENSION BTZi (6267842)
	DIMENSION ricorr (6267842)
	DIMENSION zicorr (6267842)
	INTEGER I
	PARAMETER (pi = 3.14159265359)
	PARAMETER (septant = 51.4285714286)
	DOUBLE PRECISION R, Phi
	PARAMETER (dr = 0.2)
	PARAMETER (dphi = 1*pi/180)
	PARAMETER (dz = 10)
	IDISC = 0



	DATA LFIRST / .TRUE. /
	IF (LFIRST) THEN



	OPEN(10, FILE = '/home/russ2/MagField/blockyUpstream_1.1_csv.txt')

		DO I = 1,193851

			READ(10,*) zi(I), ri(I), phideg(I), Br(I), Bphi(I), Bz(I)

		END DO
	
	CLOSE(10)


		DO I = 193852,1356957
			zi(I) = zi(I-193851)
			ri(I) = ri(I-193851)
			phideg(I) = phideg(I-193851) + septant
			Br(I) = Br(I-193851)
			Bphi(I) = Bphi(I-193851)
			Bz(I) = Bz(I-193851)
		END DO




	OPEN(11, FILE = '/home/russ2/MagField/blockyHybrid_3.0_csv.txt')
		
		DO I = 1356958,2058512

			READ(11,*) ri(I), phideg(I), zi(I), Br(I), Bphi(I), Bz(I)

		END DO

	CLOSE(11)

	
	DO I = 2058513,6267842

		zi(I) = zi(I-701555)
		ri(I) = ri(I-701555)
		phideg(I) = phideg(I-701555) + septant
		Br(I) = Br(I-701555)
		Bphi(I) = Bphi(I-701555)
		Bz(I) = Bz(I-701555)

	END DO



	DO I = 1,6267842
	
		phirad(I) = phideg(I)*pi/180
		ricorr(I) = ri(I) * 100		
		zicorr(I) = (zi(I) * 100) - 7700
		xi(I) = ricorr(I)*cos(phirad(I))
		yi(I) = ricorr(I)*sin(phirad(I))
		Bx(I) = Br(I)*cos(phirad(I))-Bphi(I)*sin(phirad(I))
		By(I) = Br(I)*sin(phirad(I))+Bphi(I)*cos(phirad(I))
		Bi(I) = sqrt(Br(I)**2+Bphi(I)**2+Bz(I)**2)
		calpha(I) = Bx(I)/Bi(I)
		cbeta(I) = By(I)/Bi(I)
		cgamma(I) = Bz(I)/Bi(I)
		cmagnitude(I) = sqrt(calpha(I)**2+cbeta(I)**2+cgamma(I)**2)
		BTXi(I) = abs(calpha(I))/cmagnitude(I)
		BTYi(I) = abs(cbeta(I))/cmagnitude(I)
		BTZi(I) = abs(cgamma(I))/cmagnitude(I)

	END DO

	LFIRST = .FALSE.
	END IF



	R = sqrt(X**2 + Y**2)
	Phi = atan(Y/X)

	IF (Phi .GT. 5.84) THEN
		Phi = Phi-(2*pi)
	END IF 

	IF (Z .GT. -6800) THEN
		I = 1356958
			IF (PHI .GT. 25*pi/180) THEN
				I = I + 701555
			END IF

			IF (PHI .GT. 76.5*pi/180) THEN
				I = I + 701555
			END IF

			IF (PHI .GT. 128*pi/180) THEN
				I = I + 701555
			END IF

			IF (PHI .GT. 180*pi/180) THEN
				I = I + 701555
			END IF

			IF (PHI .GT. 231*pi/180) THEN
				I = I + 701555
			END IF

			IF (PHI .GT. 283*pi/180) THEN
				I = I + 701555
			END IF
	ELSE
		I = 1
			IF (PHI .GT. 25*pi/180) THEN
				I = I + 193851
			END IF

			IF (PHI .GT. 76.5*pi/180) THEN
				I = I + 193851
			END IF

			IF (PHI .GT. 128*pi/180) THEN
				I = I + 193851
			END IF

			IF (PHI .GT. 180*pi/180) THEN
				I = I + 193851
			END IF

			IF (PHI .GT. 231*pi/180) THEN
				I = I + 193851
			END IF

			IF (PHI .GT. 283*pi/180) THEN
				I = I + 193851
			END IF
	END IF

	

	DO WHILE (Z .GT. zicorr(I)+(dz/2))
		I = I + 1
	END DO

	DO WHILE (Phi .GT. phirad(I)+(dphi/2))
		I = I + 1
	END DO
	
	DO WHILE (R .GT. ricorr(I)+(dr/2))
		I = I + 1
	END DO


	B = Bi(I)
	BTX = BTXi(I)
	BTY = BTYi(I)
	BTZ = BTZi(I)

	RETURN

*=== End of subroutine Magfld =========================================*
      END


