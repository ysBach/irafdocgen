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
      SUBROUTINE ANOTAT (LABX,LABY,LBAC,LSET,NDSH,DSHL)
C
      CHARACTER*(*) LABX,LABY,DSHL(*)
C
C The routine ANOTAT resets background annotation.
C
C Declare the type of the dash-pattern-parameter-name generator.
C
      CHARACTER*16 AGDSHN
C
C Set up the x-axis label.
C
      IF (ICHAR(LABX(1:1)).NE.0) THEN
        CALL AGSETC ('LABE/NAME.', 'B')
        CALL AGSETI ('LINE/NUMB.',-100)
        CALL AGSETC ('LINE/TEXT.',LABX)
      END IF
C
C Set up the y-axis label.
C
      IF (ICHAR(LABY(1:1)).NE.0) THEN
        CALL AGSETC ('LABE/NAME.', 'L')
        CALL AGSETI ('LINE/NUMB.', 100)
        CALL AGSETC ('LINE/TEXT.',LABY)
      END IF
C
C Set up the background the user wants.
C
      IF (LBAC.GT.0) CALL AGSETI ('BACK.',LBAC)
C
C Set the parameter ISET.
C
      IF (LSET.NE.0) CALL AGSETI ('SET .',LSET)
C
C Set up the dash patterns the user wants.
C
      IF (NDSH.NE.0) THEN
        IDSH=MIN0(26,NDSH)
        CALL AGSETI ('DASH/SELE.',IDSH)
        IF (IDSH.LT.0) RETURN
        DO 101 I=1,IDSH
          CALL AGSETC (AGDSHN(I),DSHL(I))
  101   CONTINUE
      END IF
C
      RETURN
C
      END
