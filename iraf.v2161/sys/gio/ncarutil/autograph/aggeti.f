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
      SUBROUTINE AGGETI (TPID,IUSR)
C
      CHARACTER*(*) TPID
      DIMENSION FURA(1)
C
C The routine AGGETI may be used to get the integer-equivalent value of
C any single AUTOGRAPH control parameter.
C
      CALL AGGETP (TPID,FURA,1)
      IUSR=IFIX(FURA(1))
      RETURN
C
      END
