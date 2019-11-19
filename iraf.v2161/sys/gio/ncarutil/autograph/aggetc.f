C
C                                                                               
C +-----------------------------------------------------------------+           
C |                                                                 |           
C |                Copyright (C) 1986 by UCAR                       |           
C |        University Corporation for Atmospheric Research          |           
C |                    All Rights Reserved                          |           
C |                                                                 |           
C |                 NCARGRAPHICS  Version 1.00                      |           
C |                                                                 |           
C +-----------------------------------------------------------------+           
C                                                                               
C                                                                               
C ---------------------------------------------------------------------
C
      SUBROUTINE AGGETC (TPID,CUSR)
C
      CHARACTER*(*) TPID,CUSR
C
      DIMENSION FURA(1)
C
C The routine AGGETC is used to get the character strings represented
C by the values of certain individual AUTOGRAPH parameters.  TPID is a
C parameter identifier (from the caller).  CUSR is a character string
C (returned to the caller).
C
C See what kind of parameter is being gotten.
C
      CALL AGCTCS (TPID,ITCS)
C
C If the parameter is not intrinsically of type character, log an error.
C
      IF (ITCS.EQ.0) GO TO 901
C
C Otherwise, get the integer value of the parameter and use that to get
C the desired character string.
C
      CALL AGGETP (TPID,FURA,1)
      CALL AGGTCH (IFIX(FURA(1)),CUSR,LNCS)
C
C Done.
C
      RETURN
C
C Error exit.
C
  901 CALL AGPPID (TPID)
      CALL SETER ('AGGETC - PARAMETER TO GET IS NOT INTRINSICALLY OF TYP
     +E CHARACTER',2,2)
C
      END
