      SUBROUTINE CONLOC (NDP,XD,YD,NT,IPT,NL,IPL,XII,YII,ITI,IWK,WK)
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
C
C THIS SUBROUTINE LOCATES A POINT, I.E., DETERMINES TO WHAT TRI-
C ANGLE A GIVEN POINT (XII,YII) BELONGS.  WHEN THE GIVEN POINT
C DOES NOT LIE INSIDE THE DATA AREA, THIS SUBROUTINE DETERMINES
C THE BORDER LINE SEGMENT WHEN THE POINT LIES IN AN OUTSIDE
C RECTANGULAR AREA, AND TWO BORDER LINE SEGMENTS WHEN THE POINT
C LIES IN AN OUTSIDE TRIANGULAR AREA.
C THE INPUT PARAMETERS ARE
C     NDP = NUMBER OF DATA POINTS,
C     XD,YD = ARRAYS OF DIMENSION NDP CONTAINING THE X AND Y
C           COORDINATES OF THE DATA POINTS,
C     NT  = NUMBER OF TRIANGLES,
C     IPT = INTEGER ARRAY OF DIMENSION 3*NT CONTAINING THE
C           POINT NUMBERS OF THE VERTEXES OF THE TRIANGLES,
C     NL  = NUMBER OF BORDER LINE SEGMENTS,
C     IPL = INTEGER ARRAY OF DIMENSION 3*NL CONTAINING THE
C           POINT NUMBERS OF THE END POINTS OF THE BORDER
C           LINE SEGMENTS AND THEIR RESPECTIVE TRIANGLE
C           NUMBERS,
C     XII,YII = X AND Y COORDINATES OF THE POINT TO BE
C           LOCATED.
C THE OUTPUT PARAMETER IS
C     ITI = TRIANGLE NUMBER, WHEN THE POINT IS INSIDE THE
C           DATA AREA, OR
C           TWO BORDER LINE SEGMENT NUMBERS, IL1 AND IL2,
C           CODED TO IL1*(NT+NL)+IL2, WHEN THE POINT IS
C           OUTSIDE THE DATA AREA.
C THE OTHER PARAMETERS ARE
C     IWK = INTEGER ARRAY OF DIMENSION 18*NDP USED INTER-
C           NALLY AS A WORK AREA,
C     WK  = ARRAY OF DIMENSION 8*NDP USED INTERNALLY AS A
C           WORK AREA.
C DECLARATION STATEMENTS
C
      DIMENSION       XD(1)      ,YD(1)      ,IPT(1)     ,IPL(1)     ,
     1                IWK(1)     ,WK(1)
C
C
C
      DIMENSION       NTSC(9)    ,IDSC(9)
      COMMON /CONRA5/ NIT        ,ITIPV
C
        SAVE
C
C STATEMENT FUNCTIONS
C
      SIDE(U1,V1,U2,V2,U3,V3) = (U1-U3)*(V2-V3)-(V1-V3)*(U2-U3)
      SPDT(U1,V1,U2,V2,U3,V3) = (U1-U2)*(U3-U2)+(V1-V2)*(V3-V2)
C
C PRELIMINARY PROCESSING
C
      NT0 = NT
      NL0 = NL
      NTL = NT0+NL0
      X0 = XII
      Y0 = YII
C
C PROCESSING FOR A NEW SET OF DATA POINTS
C
      IF (NIT .NE. 0) GO TO  170
      NIT = 1
C
C - DIVIDES THE X-Y PLANE INTO NINE RECTANGULAR SECTIONS.
C
      XMN = XD(1)
      XMX = XMN
      YMN = YD(1)
      YMX = YMN
      DO  100 IDP=2,NDP
         XI = XD(IDP)
         YI = YD(IDP)
         XMN = AMIN1(XI,XMN)
         XMX = AMAX1(XI,XMX)
         YMN = AMIN1(YI,YMN)
         YMX = AMAX1(YI,YMX)
  100 CONTINUE
      XS1 = (XMN+XMN+XMX)/3.0
      XS2 = (XMN+XMX+XMX)/3.0
      YS1 = (YMN+YMN+YMX)/3.0
      YS2 = (YMN+YMX+YMX)/3.0
C
C - DETERMINES AND STORES IN THE IWK ARRAY TRIANGLE NUMBERS OF
C - THE TRIANGLES ASSOCIATED WITH EACH OF THE NINE SECTIONS.
C
      DO  110 ISC=1,9
         NTSC(ISC) = 0
         IDSC(ISC) = 0
  110 CONTINUE
      IT0T3 = 0
      JWK = 0
      DO  160 IT0=1,NT0
         IT0T3 = IT0T3+3
         I1 = IPT(IT0T3-2)
         I2 = IPT(IT0T3-1)
         I3 = IPT(IT0T3)
         XMN = AMIN1(XD(I1),XD(I2),XD(I3))
         XMX = AMAX1(XD(I1),XD(I2),XD(I3))
         YMN = AMIN1(YD(I1),YD(I2),YD(I3))
         YMX = AMAX1(YD(I1),YD(I2),YD(I3))
         IF (YMN .GT. YS1) GO TO  120
         IF (XMN .LE. XS1) IDSC(1) = 1
         IF (XMX.GE.XS1 .AND. XMN.LE.XS2) IDSC(2) = 1
         IF (XMX .GE. XS2) IDSC(3) = 1
  120    IF (YMX.LT.YS1 .OR. YMN.GT.YS2) GO TO  130
         IF (XMN .LE. XS1) IDSC(4) = 1
         IF (XMX.GE.XS1 .AND. XMN.LE.XS2) IDSC(5) = 1
         IF (XMX .GE. XS2) IDSC(6) = 1
  130    IF (YMX .LT. YS2) GO TO  140
         IF (XMN .LE. XS1) IDSC(7) = 1
         IF (XMX.GE.XS1 .AND. XMN.LE.XS2) IDSC(8) = 1
         IF (XMX .GE. XS2) IDSC(9) = 1
  140    DO  150 ISC=1,9
            IF (IDSC(ISC) .EQ. 0) GO TO  150
            JIWK = 9*NTSC(ISC)+ISC
            IWK(JIWK) = IT0
            NTSC(ISC) = NTSC(ISC)+1
            IDSC(ISC) = 0
  150    CONTINUE
C
C - STORES IN THE WK ARRAY THE MINIMUM AND MAXIMUM OF THE X AND
C - Y COORDINATE VALUES FOR EACH OF THE TRIANGLE.
C
         JWK = JWK+4
         WK(JWK-3) = XMN
         WK(JWK-2) = XMX
         WK(JWK-1) = YMN
         WK(JWK) = YMX
  160 CONTINUE
      GO TO  200
C
C CHECKS IF IN THE SAME TRIANGLE AS PREVIOUS.
C
  170 IT0 = ITIPV
      IF (IT0 .GT. NT0) GO TO  180
      IT0T3 = IT0*3
      IP1 = IPT(IT0T3-2)
      X1 = XD(IP1)
      Y1 = YD(IP1)
      IP2 = IPT(IT0T3-1)
      X2 = XD(IP2)
      Y2 = YD(IP2)
      IF (SIDE(X1,Y1,X2,Y2,X0,Y0) .LT. 0.0) GO TO  200
      IP3 = IPT(IT0T3)
      X3 = XD(IP3)
      Y3 = YD(IP3)
      IF (SIDE(X2,Y2,X3,Y3,X0,Y0) .LT. 0.0) GO TO  200
      IF (SIDE(X3,Y3,X1,Y1,X0,Y0) .LT. 0.0) GO TO  200
      GO TO  260
C
C CHECKS IF ON THE SAME BORDER LINE SEGMENT.
C
  180 IL1 = IT0/NTL
      IL2 = IT0-IL1*NTL
      IL1T3 = IL1*3
      IP1 = IPL(IL1T3-2)
      X1 = XD(IP1)
      Y1 = YD(IP1)
      IP2 = IPL(IL1T3-1)
      X2 = XD(IP2)
      Y2 = YD(IP2)
      IF (IL2 .NE. IL1) GO TO  190
      IF (SPDT(X1,Y1,X2,Y2,X0,Y0) .LT. 0.0) GO TO  200
      IF (SPDT(X2,Y2,X1,Y1,X0,Y0) .LT. 0.0) GO TO  200
      IF (SIDE(X1,Y1,X2,Y2,X0,Y0) .GT. 0.0) GO TO  200
      GO TO  260
C
C CHECKS IF BETWEEN THE SAME TWO BORDER LINE SEGMENTS.
C
  190 IF (SPDT(X1,Y1,X2,Y2,X0,Y0) .GT. 0.0) GO TO  200
      IP3 = IPL(3*IL2-1)
      X3 = XD(IP3)
      Y3 = YD(IP3)
      IF (SPDT(X3,Y3,X2,Y2,X0,Y0) .LE. 0.0) GO TO  260
C
C LOCATES INSIDE THE DATA AREA.
C - DETERMINES THE SECTION IN WHICH THE POINT IN QUESTION LIES.
C
  200 ISC = 1
      IF (X0 .GE. XS1) ISC = ISC+1
      IF (X0 .GE. XS2) ISC = ISC+1
      IF (Y0 .GE. YS1) ISC = ISC+3
      IF (Y0 .GE. YS2) ISC = ISC+3
C
C - SEARCHES THROUGH THE TRIANGLES ASSOCIATED WITH THE SECTION.
C
      NTSCI = NTSC(ISC)
      IF (NTSCI .LE. 0) GO TO  220
      JIWK = -9+ISC
      DO  210 ITSC=1,NTSCI
         JIWK = JIWK+9
         IT0 = IWK(JIWK)
         JWK = IT0*4
         IF (X0 .LT. WK(JWK-3)) GO TO  210
         IF (X0 .GT. WK(JWK-2)) GO TO  210
         IF (Y0 .LT. WK(JWK-1)) GO TO  210
         IF (Y0 .GT. WK(JWK)) GO TO  210
         IT0T3 = IT0*3
         IP1 = IPT(IT0T3-2)
         X1 = XD(IP1)
         Y1 = YD(IP1)
         IP2 = IPT(IT0T3-1)
         X2 = XD(IP2)
         Y2 = YD(IP2)
         IF (SIDE(X1,Y1,X2,Y2,X0,Y0) .LT. 0.0) GO TO  210
         IP3 = IPT(IT0T3)
         X3 = XD(IP3)
         Y3 = YD(IP3)
         IF (SIDE(X2,Y2,X3,Y3,X0,Y0) .LT. 0.0) GO TO  210
         IF (SIDE(X3,Y3,X1,Y1,X0,Y0) .LT. 0.0) GO TO  210
         GO TO  260
  210 CONTINUE
C
C LOCATES OUTSIDE THE DATA AREA.
C
  220 DO  240 IL1=1,NL0
         IL1T3 = IL1*3
         IP1 = IPL(IL1T3-2)
         X1 = XD(IP1)
         Y1 = YD(IP1)
         IP2 = IPL(IL1T3-1)
         X2 = XD(IP2)
         Y2 = YD(IP2)
         IF (SPDT(X2,Y2,X1,Y1,X0,Y0) .LT. 0.0) GO TO  240
         IF (SPDT(X1,Y1,X2,Y2,X0,Y0) .LT. 0.0) GO TO  230
         IF (SIDE(X1,Y1,X2,Y2,X0,Y0) .GT. 0.0) GO TO  240
         IL2 = IL1
         GO TO  250
  230    IL2 = MOD(IL1,NL0)+1
         IP3 = IPL(3*IL2-1)
         X3 = XD(IP3)
         Y3 = YD(IP3)
         IF (SPDT(X3,Y3,X2,Y2,X0,Y0) .LE. 0.0) GO TO  250
  240 CONTINUE
      IT0 = 1
      GO TO  260
  250 IT0 = IL1*NTL+IL2
C
C NORMAL EXIT
C
  260 ITI = IT0
      ITIPV = IT0
      RETURN
      END
