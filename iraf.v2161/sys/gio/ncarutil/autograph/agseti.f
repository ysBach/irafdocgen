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
      SUBROUTINE AGSETI (TPID,IUSR)
C
      CHARACTER*(*) TPID
      DIMENSION FURA(1)
C
C The routine AGSETI may be used to set the integer-equivalent value of
C any single AUTOGRAPH control parameter.
C
      FURA(1)=FLOAT(IUSR)
      CALL AGSETP (TPID,FURA,1)
      RETURN
C
      END
