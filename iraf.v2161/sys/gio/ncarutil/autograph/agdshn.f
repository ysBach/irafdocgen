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
      CHARACTER*16 FUNCTION AGDSHN (IDSH)
C
C The value of this function is the name of the dash pattern numbered
C IDSH - that is to say, the character string 'DASH/PATTERN/n.', where
C n is an integer between 1 and 99, equal to MAX0(1,MIN0(99,IDSH)).
C
      AGDSHN='DASH/PATTERN/  .'
C
      KDSH=MAX0(1,MIN0(99,IDSH))
C
      DO 101 I=15,14,-1
        AGDSHN(I:I)=CHAR(ICHAR('0')+MOD(KDSH,10))
        IF (KDSH.LE.9) GO TO 102
        KDSH=KDSH/10
  101 CONTINUE
C
  102 RETURN
C
      END
