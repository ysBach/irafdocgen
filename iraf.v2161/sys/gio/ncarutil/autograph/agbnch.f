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
      CHARACTER*16 FUNCTION AGBNCH (IDSH)
C
C The value of this function is the character-dash-pattern equivalent of
C the integer dash pattern IDSH, a string of quotes and/or dollar signs.
C Note that the support routines IAND and ISHIFT are used.
C
      KDSH=IDSH
C
      DO 101 I=16,1,-1
        IF (IAND(KDSH,1).EQ.0) THEN
          AGBNCH(I:I)=''''
        ELSE
          AGBNCH(I:I)='$'
        END IF
        KDSH=ISHIFT(KDSH,-1)
  101 CONTINUE
C
      RETURN
C
      END
