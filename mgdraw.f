*$ CREATE MGDRAW.FOR
*COPY MGDRAW
*                                                                      *
*=== mgdraw ===========================================================*
*                                                                      *
      SUBROUTINE MGDRAW ( ICODE, MREG )


      INCLUDE '(DBLPRC)'
      INCLUDE '(DIMPAR)'
      INCLUDE '(IOUNIT)'
*
*----------------------------------------------------------------------*
*                                                                      *
*     Copyright (C) 1990-2013      by        Alfredo Ferrari           *
*     All Rights Reserved.                                             *
*                                                                      *
*                                                                      *
*     MaGnetic field trajectory DRAWing: actually this entry manages   *
*                                        all trajectory dumping for    *
*                                        drawing                       *
*                                                                      *
*     Created on   01 March 1990   by        Alfredo Ferrari           *
*                                              INFN - Milan            *
*     Last change   12-Nov-13      by        Alfredo Ferrari           *
*                                              INFN - Milan            *
*                                                                      *
*----------------------------------------------------------------------*
*
      INCLUDE '(CASLIM)'
      INCLUDE '(COMPUT)'
      INCLUDE '(SOURCM)'
      INCLUDE '(FHEAVY)'
      INCLUDE '(FLKSTK)'
      INCLUDE '(GENSTK)'
      INCLUDE '(MGDDCM)'
      INCLUDE '(PAPROP)'
      INCLUDE '(QUEMGD)'
      INCLUDE '(SUMCOU)'
      INCLUDE '(TRACKR)'    
*
      DIMENSION DTQUEN ( MXTRCK, MAXQMG )
*
      
    


      CHARACTER*20 FILNAM
      CHARACTER*8 REGNAME,REGNAME2
      INTEGER IREGERR,IREGERR2
      LOGICAL LFIRST  
      SAVE  LFIRST

      DATA LFIRST / .TRUE. /
*
*----------------------------------------------------------------------*
*                                                                      *
*     Icode = 1: call from Kaskad                                      *
*     Icode = 2: call from Emfsco                                      *
*     Icode = 3: call from Kasneu                                      *
*     Icode = 4: call from Kashea                                      *
*     Icode = 5: call from Kasoph                                      *
*                                                                      *
*----------------------------------------------------------------------*
*                                                                   *
      IF (LFIRST) THEN
         LFIRST = .FALSE.
         IF ( KOMPUT .EQ. 2 ) THEN
            FILNAM = '/'//CFDRAW(1:8)//' DUMP A'
         ELSE
            FILNAM = CFDRAW
         END IF
         PRINT *,'MGDRAW ',FILNAM,' -- ',LFIRST
         CALL MYUSRINI(FILNAM)
         PRINT *,'MYUSRINI CALLED'
      END IF

c      CALL GEOR2N(MREG,REGNAME,IREGERR)

        

  
*  +-------------------------------------------------------------------*
*  |  Quenching is activated
c      IF ( LQEMGD ) THEN
c         IF ( MTRACK .GT. 0 ) THEN
c            RULLL  = ZERZER
c            CALL QUENMG ( ICODE, MREG, RULLL, DTQUEN )
c            WRITE (IODRAW) ( ( SNGL (DTQUEN (I,JBK)), I = 1, MTRACK ),
c     &                         JBK = 1, NQEMGD )
c         END IF
c      END IF
*  |  End of quenching
*  +-------------------------------------------------------------------*
      RETURN
*
*======================================================================*
*                                                                      *
*     Boundary-(X)crossing DRAWing:                                    *
*                                                                      *
*     Icode = 1x: call from Kaskad                                     *
*             19: boundary crossing                                    *
*     Icode = 2x: call from Emfsco                                     *
*             29: boundary crossing                                    *
*     Icode = 3x: call from Kasneu                                     *
*             39: boundary crossing                                    *
*     Icode = 4x: call from Kashea                                     *
*             49: boundary crossing                                    *
*     Icode = 5x: call from Kasoph                                     *
*             59: boundary crossing                                    *
*                                                                      *
*======================================================================*
*                                                                      *
      ENTRY BXDRAW ( ICODE, MREG, NEWREG, XSCO, YSCO, ZSCO )
      IF (LFIRST) THEN
         LFIRST = .FALSE.
         IF ( KOMPUT .EQ. 2 ) THEN
            FILNAM = '/'//CFDRAW(1:8)//' DUMP A'
         ELSE
            FILNAM = CFDRAW
         END IF
         PRINT *,'BXDRAW ',FILNAM
         CALL MYUSRINI(FILNAM)      
      END IF


 
c This is exiting-from region
      CALL GEOR2N(MREG,REGNAME,IREGERR)
c This is entering-to region
      CALL GEOR2N(NEWREG,REGNAME2,IREGERR2)

c Check particles entering crystals
      if  ((REGNAME.eq.'DETCONC1').and.(REGNAME2.eq.'DETHOUSI')) then
       CALL eventcreate(NCASE,1,JTRACK,ETRACK,CXTRCK,CYTRCK,CZTRCK,
     &                    XSCO,YSCO,ZSCO,WTRACK,WSCRNG)
       CALL vertexsave(ISPUSR(1),ISPUSR(2),SPAUSR(1),SPAUSR(2), 
     &                 SPAUSR(3),
     &                 SPAUSR(4))
       CALL eventsave
            
      else if ((REGNAME.eq.'DETHOUSI').and.(REGNAME2.eq.'DETECT')) then
       CALL eventcreate(NCASE,3,JTRACK,ETRACK,CXTRCK,CYTRCK,CZTRCK,
     &                    XSCO,YSCO,ZSCO,WTRACK,WSCRNG)
       CALL vertexsave(ISPUSR(1),ISPUSR(2),SPAUSR(1),SPAUSR(2), 
     &                 SPAUSR(3),
     &                 SPAUSR(4))
       CALL eventsave
c Following are of-axis detectors
    
      else if ((REGNAME.eq.'DETHOUSI').and.(REGNAME2.eq.'DETECT1')) then
       CALL eventcreate(NCASE,4,JTRACK,ETRACK,CXTRCK,CYTRCK,CZTRCK,
     &                    XSCO,YSCO,ZSCO,WTRACK,WSCRNG)
       CALL vertexsave(ISPUSR(1),ISPUSR(2),SPAUSR(1),SPAUSR(2),
     &                 SPAUSR(3),
     &                 SPAUSR(4))
       CALL eventsave
       
      else if ((REGNAME.eq.'DETHOUSI').and.(REGNAME2.eq.'DETECT2')) then
       CALL eventcreate(NCASE,5,JTRACK,ETRACK,CXTRCK,CYTRCK,CZTRCK,
     &                    XSCO,YSCO,ZSCO,WTRACK,WSCRNG)
       CALL vertexsave(ISPUSR(1),ISPUSR(2),SPAUSR(1),SPAUSR(2), 
     &                 SPAUSR(3),
     &                 SPAUSR(4))
       CALL eventsave
       
      else if ((REGNAME.eq.'DETHOUSI').and.(REGNAME2.eq.'DETECT3')) then
       CALL eventcreate(NCASE,6,JTRACK,ETRACK,CXTRCK,CYTRCK,CZTRCK,
     &                    XSCO,YSCO,ZSCO,WTRACK,WSCRNG)
       CALL vertexsave(ISPUSR(1),ISPUSR(2),SPAUSR(1),SPAUSR(2), 
     &                 SPAUSR(3),
     &                 SPAUSR(4))
       CALL eventsave
	   endif
	 
c Following are "counters" along the z-axis. 
c I avoid neutrinos to save space and I keep only those at the end
c I.e. I count from MUABS13 to MUABS14 and following
	 
       if ((JTRACK.ne.5).and.(JTRACK.ne.6).and.(JTRACK.ne.27).
     & and.(JTRACK.ne.28)) then
	   IDFLUX=0     
       CALL regionsToFluxId(IDFLUX,REGNAME,REGNAME2)                            
       if (IDFLUX.ge.127) then
       CALL eventcreate(NCASE,IDFLUX,JTRACK,ETRACK,CXTRCK,CYTRCK,CZTRCK,
     &                   XSCO,YSCO,ZSCO,WTRACK,WSCRNG)
       CALL vertexsave(ISPUSR(1),ISPUSR(2),SPAUSR(1),SPAUSR(2), 
     &                  SPAUSR(3),
     &                  SPAUSR(4))
       CALL eventsave
       endif
	   endif		




      RETURN
*
*======================================================================*
*                                                                      *
*     Event End DRAWing:                                               *
*                                                                      *
*======================================================================*
*                                                                      *
      ENTRY EEDRAW ( ICODE )
	
c	  print *,'END EVENT'    

      RETURN
*
*======================================================================*
*                                                                      *
*     ENergy deposition DRAWing:                                       *
*                                                                      *
*     Icode = 1x: call from Kaskad                                     *
*             10: elastic interaction recoil                           *
*             11: inelastic interaction recoil                         *
*             12: stopping particle                                    *
*             13: pseudo-neutron deposition                            *
*             14: escape                                               *
*             15: time kill                                            *
*     Icode = 2x: call from Emfsco                                     *
*             20: local energy deposition (i.e. photoelectric)         *
*             21: below threshold, iarg=1                              *
*             22: below threshold, iarg=2                              *
*             23: escape                                               *
*             24: time kill                                            *
*     Icode = 3x: call from Kasneu                                     *
**             30: target recoil                                        *
*             31: below threshold                                      *
*             32: escape                                               *
*             33: time kill                                            *
*     Icode = 4x: call from Kashea                                     *
*             40: escape                                               *
*             41: time kill                                            *
*             42: delta ray stack overflow                             *
*     Icode = 5x: call from Kasoph                                     *
*             50: optical photon absorption                            *
*             51: escape                                               *
*             52: time kill                                            *
*                                                                      *
*======================================================================*
*                                                                      *
      ENTRY ENDRAW ( ICODE, MREG, RULL, XSCO, YSCO, ZSCO )
      IF (LFIRST ) THEN
         LFIRST = .FALSE.
         IF ( KOMPUT .EQ. 2 ) THEN
            FILNAM = '/'//CFDRAW(1:8)//' DUMP A'
         ELSE
            FILNAM = CFDRAW
         END IF
         PRINT *, 'ENDRAW ',FILNAM
         CALL MYUSRINI(FILNAM)
c         OPEN ( UNIT = IODRAW, FILE = FILNAM, STATUS = 'NEW', FORM =
c     &          'FORMATTED' )
      END IF
      
c      CALL GEOR2N(MREG,REGNAME,IREGERR)
     
    
      RETURN
*
*======================================================================*
*                                                                      *
*     SOurce particle DRAWing:                                         *
*                                                                      *
*======================================================================*
*
      ENTRY SODRAW
      IF (LFIRST) THEN
         LFIRST = .FALSE.
         IF ( KOMPUT .EQ. 2 ) THEN
            FILNAM = '/'//CFDRAW(1:8)//' DUMP A'
         ELSE
            FILNAM = CFDRAW
         END IF
         CALL MYUSRINI(FILNAM)
         PRINT *,'SODRAW ',FILNAM
c         OPEN ( UNIT = IODRAW, FILE = FILNAM, STATUS = 'NEW', FORM =
c     &          'FORMATTED' )
      END IF
*  |
*  +-------------------------------------------------------------------*
      RETURN
*
*======================================================================*
*                                                                      *
*     USer dependent DRAWing:                                          *
*                                                                      *
*     Icode = 10x: call from Kaskad                                    *
*             100: elastic   interaction secondaries                   *
*             101: inelastic interaction secondaries                   *
*             102: particle decay  secondaries                         *
*             103: delta ray  generation secondaries                   *
*             104: pair production secondaries                         *
*             105: bremsstrahlung  secondaries                         *
*             110: decay products                                      *
*     Icode = 20x: call from Emfsco                                    *
*             208: bremsstrahlung secondaries                          *
*             210: Moller secondaries                                  *
*             212: Bhabha secondaries                                  *
*             214: in-flight annihilation secondaries                  *
*             215: annihilation at rest   secondaries                  *
*             217: pair production        secondaries                  *
*             219: Compton scattering     secondaries                  *
*             221: photoelectric          secondaries                  *
*             225: Rayleigh scattering    secondaries                  *
*             237: mu pair     production secondaries                  *
*     Icode = 30x: call from Kasneu                                    *
*             300: interaction secondaries                             *
*     Icode = 40x: call from Kashea                                    *
*             400: delta ray  generation secondaries                   *
*  For all interactions secondaries are put on GENSTK common (kp=1,np) *
*  but for KASHEA delta ray generation where only the secondary elec-  *
*  tron is present and stacked on FLKSTK common for kp=npflka          *
*                                                                      *
*======================================================================*
*
      ENTRY USDRAW ( ICODE, MREG, XSCO, YSCO, ZSCO )
      IF (LFIRST) THEN
         LFIRST = .FALSE.
         IF ( KOMPUT .EQ. 2 ) THEN
            FILNAM = '/'//CFDRAW(1:8)//' DUMP A'
         ELSE
            FILNAM = CFDRAW
         END IF
         PRINT *,'ENDRAW ',FILNAM
         CALL MYUSRINI(FILNAM)
c         OPEN ( UNIT = IODRAW, FILE = FILNAM, STATUS = 'NEW', FORM =
c     &          'FORMATTED' )
      END IF
c      if ((ICODE.eq.103.).OR.(ICODE.eq.400)) then
c      PRINT *,'QUA',ICODE,JTRACK,ETRACK,ZSCO
c      PRINT *,'SEC ARE:'
c      do ip=1,np
c         print *,ip,kpart(ip),tki(ip)
c      end do
c      end if
* No output by default:
      RETURN
*=== End of subrutine Mgdraw ==========================================*
      END

