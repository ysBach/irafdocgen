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
      SUBROUTINE AGPWRT (XPOS,YPOS,CHRS,NCHS,ISIZ,IORI,ICEN)
C
      CHARACTER*(*) CHRS
C
C This routine just passes its arguments along to the character-drawing
C routine PWRIT, in the system plot package.  By substituting his/her
C own version of AGPWRT, the user can cause a fancier character-drawer
C to be used.
C
      CALL PWRIT (XPOS,YPOS,CHRS,NCHS,ISIZ,IORI,ICEN)
C
C Done.
C
      RETURN
C
      END
