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
      SUBROUTINE AGINIT
C
C This routine is called to initialize some machine-dependent constants.
C
C The following common block contains the AUTOGRAPH control parameters,
C all of which are real.  If it is changed, all of AUTOGRAPH (especially
C the routine AGSCAN) must be examined for possible side effects.
C
      COMMON /AGCONP/ QFRA,QSET,QROW,QIXY,QWND,QBAC , SVAL(2) ,
     +                XLGF,XRGF,YBGF,YTGF , XLGD,XRGD,YBGD,YTGD , SOGD ,
     +                XMIN,XMAX,QLUX,QOVX,QCEX,XLOW,XHGH ,
     +                YMIN,YMAX,QLUY,QOVY,QCEY,YLOW,YHGH ,
     +                QDAX(4),QSPA(4),PING(4),PINU(4),FUNS(4),QBTD(4),
     +                BASD(4),QMJD(4),QJDP(4),WMJL(4),WMJR(4),QMND(4),
     +                QNDP(4),WMNL(4),WMNR(4),QLTD(4),QLED(4),QLFD(4),
     +                QLOF(4),QLOS(4),DNLA(4),WCLM(4),WCLE(4) ,
     +                QODP,QCDP,WOCD,WODQ,QDSH(26) ,
     +                     QDLB,QBIM,FLLB(10,8),QBAN ,
     +                QLLN,TCLN,QNIM,FLLN(6,16),QNAN ,
     +                XLGW,XRGW,YBGW,YTGW , XLUW,XRUW,YBUW,YTUW ,
     +                XLCW,XRCW,YBCW,YTCW , WCWP,HCWP,SCWP ,
     +                XBGA(4),YBGA(4),UBGA(4),XNDA(4),YNDA(4),UNDA(4),
     +                QBTP(4),BASE(4),QMNT(4),QLTP(4),QLEX(4),QLFL(4),
     +                QCIM(4),QCIE(4),RFNL(4),WNLL(4),WNLR(4),WNLB(4),
     +                WNLE(4),QLUA(4) ,
     +                RBOX(6),DBOX(6,4),SBOX(6,4)
C
C The following common block contains other AUTOGRAPH variables, both
C real and integer, which are not control parameters.
C
      COMMON /AGORIP/ SMRL , ISLD , MWCL,MWCM,MWCE,MDLA,MWCD,MWDQ ,
     +                INIF
C
C Fill in the names of the four pre-defined labels.
C
      CALL AGSTCH ('L',1,IDCS)
      FLLB(1,1)=FLOAT(IDCS)
      CALL AGSTCH ('R',1,IDCS)
      FLLB(1,2)=FLOAT(IDCS)
      CALL AGSTCH ('B',1,IDCS)
      FLLB(1,3)=FLOAT(IDCS)
      CALL AGSTCH ('T',1,IDCS)
      FLLB(1,4)=FLOAT(IDCS)
C
C Declare the rest of the label-definition slots to be available.
C
      LBIM=IFIX(QBIM)
C
      DO 101 J=5,LBIM
        FLLB(1,J)=0.
  101 CONTINUE
C
C Fill in the text of the four pre-defined lines.
C
      CALL AGSTCH ('Y',1,IDCS)
      FLLN(4,1)=FLOAT(IDCS)
      CALL AGSTCH (' ',1,IDCS)
      FLLN(4,2)=FLOAT(IDCS)
      CALL AGSTCH ('X',1,IDCS)
      FLLN(4,3)=FLOAT(IDCS)
      CALL AGSTCH (' ',1,IDCS)
      FLLN(4,4)=FLOAT(IDCS)
C
C Declare the rest of the line-definition slots to be available.
C
      LNIM=IFIX(QNIM)
C
      DO 102 J=5,LNIM
        FLLN(1,J)=SVAL(1)
  102 CONTINUE
C
C Set the value of 'LINE/TERMINATOR.'
C
      CALL AGSTCH ('$',1,IDCS)
      TCLN=FLOAT(IDCS)
C
C SMRL is used by AUTOGRAPH for rounding operations.
C
      SMRL=10.**(3-IFIX(ALOG10(FLOAT(I1MACH(10)))*FLOAT(I1MACH(11))))
C
C ISLD is an integer containing 16 one bits (right-justified with zero
C fill to the left).  It is used to direct the DASHCHAR package to draw
C solid lines.  To generate it, we start with a 15-bit mask and then
C add another bit.
C
      ISLD = 32767
      ISLD = ISHIFT(ISLD,1)
      ISLD = IOR(ISLD,1)
C
C Set the initialization flag to indicate initialization has been done.
C
      INIF=1
C
C Done.
C
      RETURN
C
      END
