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
      SUBROUTINE DISPLA (LFRA,LROW,LTYP)
C
C The subroutine DISPLA resets the parameters IFRA, IROW, and/or LLUX
C and LLUY.
C
      IF (LFRA.NE.0) CALL AGSETI ('FRAM.', MAX0(1,MIN0(3,LFRA)))
C
      IF (LROW.NE.0) CALL AGSETI ('ROW .',LROW)
C
      IF (LTYP.EQ.0) RETURN
C
      ITYP=MAX0(1,MIN0(4,LTYP))
      CALL AGSETI ('X/LOGA.',   (1-ITYP)/2)
      CALL AGSETI ('Y/LOGA.',MOD(1-ITYP,2))
C
      RETURN
C
      END
