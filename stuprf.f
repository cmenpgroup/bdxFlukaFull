*$ CREATE STUPRF.FOR
*COPY STUPRF
*
*=== stuprf ===========================================================*
*
      SUBROUTINE STUPRF ( IJ, MREG, XX, YY, ZZ, NPSECN, NPPRMR )

      INCLUDE '(DBLPRC)'
      INCLUDE '(DIMPAR)'
      INCLUDE '(IOUNIT)'
*
*----------------------------------------------------------------------*
*                                                                      *
*     Copyright (C) 1997-2005      by    Alfredo Ferrari & Paola Sala  *
*     All Rights Reserved.                                             *
*                                                                      *
*                                                                      *
*     SeT User PRoperties for Fluka particles:                         *
*                                                                      *
*     Created on  09 october 1997  by    Alfredo Ferrari & Paola Sala  *
*                                                   Infn - Milan       *
*                                                                      *
*     Last change on  14-jul-05    by    Alfredo Ferrari               *
*                                                                      *
*                                                                      *
*----------------------------------------------------------------------*
*
      INCLUDE '(EVTFLG)'
      INCLUDE '(FLKSTK)'
      INCLUDE '(TRACKR)'
      INCLUDE '(GENSTK)'

      LOGICAL SVFLAG
*
* Store the properties of the mother particle IF this particle
* is being written to the stack due to an inelastic interaction OR a decay
* Save the ID of the decaying particle / primary particle in inelastic event
* Save its energy and the coordinates

c     First sparek
      IFST1 = 1
c     First ispark
      IFST2 = 1
c     The process 
      IPROC = 0
      SVFLAG=.FALSE.
c     USE a generic flag to check when to write parent
c     Alway for inelastic
      if (LINEVT) then
         SVFLAG=.TRUE.
         IPROC=2
c     Always for decay
      else  if (LDECAY) then
         SVFLAG=.TRUE.
         IPROC=3
c     Delta ray, only for the delta ray itself, not for the muon
      else if (LDLTRY.AND.(ILOFLK(NPFLKA).eq.3)) then
          SVFLAG=.TRUE.
          IPROC=4
c     Pair production gamma->e+ e-
      else if (LPAIRP.AND.((ILOFLK(NPFLKA).eq.3).or.
     &  (ILOFLK(NPFLKA).eq.4))) then 
         SVFLAG=.TRUE.
         IPROC=5
c     Pair production gamma->mu+ mu-
      else if (LPAIRP.AND.((ILOFLK(NPFLKA).eq.10).or.
     &  (ILOFLK(NPFLKA).eq.11))) then 
         SVFLAG=.TRUE.
         IPROC=5
c     Bremmsstrahlung, only for the photon, not for the e-
      else if (LBRMSP.and.(ILOFLK(NPFLKA).eq.7)) then
         SVFLAG=.TRUE.
         IPROC=6
      else if (LRDCAY) then
         SVFLAG=.TRUE.
         IPROC=15
      end if
      
      if (SVFLAG) then
         ISPARK(1,NPFLKA) = IJ
         ISPARK(2,NPFLKA) = IPROC
         SPAREK(1,NPFLKA) = ETRACK
         SPAREK(2,NPFLKA) = XX
         SPAREK(3,NPFLKA) = YY
         SPAREK(4,NPFLKA) = ZZ
         IFST1=5
         IFST2=3
      end if

c     Save variables
      DO 100 ISPR = IFST1, MKBMX1
         SPAREK (ISPR,NPFLKA) = SPAUSR (ISPR)
  100 CONTINUE
      DO 200 ISPR = IFST2, MKBMX2
         ISPARK (ISPR,NPFLKA) = ISPUSR (ISPR)
  200 CONTINUE
  
*  Increment the track number and put it into the last flag:
      IF ( NPSECN .GT. NPPRMR ) THEN
         IF ( NTRCKS .EQ. 2000000000 ) NTRCKS = -2000000000
         NTRCKS = NTRCKS + 1
         ISPARK (MKBMX2,NPFLKA) = NTRCKS
      END IF


      RETURN
*=== End of subroutine Stuprf =========================================*
      END

