     HOption(*Nodebugio:*Srcstmt) Nomain

     FPDDTLPF   UF A E           k Disk
     FEheadscrn CF   E             Workstn Indds(Indds1)
     FEHEADVNDR CF   E             Workstn Sfile(PDMNGMNT:Rrn)
     F                                     Sfile(DLTPDDTL:#Rrn1)
     F                                     Indds(Indds1)


     DIndDs1           Ds
     DUpdateInd                       1n   Overlay(Indds1:02)
     DExit                            1n   Overlay(Indds1:03)
     DRefresh                         1n   Overlay(Indds1:05)
     DIndInsert                       1n   Overlay(Indds1:06)
     DChngPass                        1n   Overlay(Indds1:07)
     DLogOut                          1n   Overlay(Indds1:10)
     DCancel                          1n   Overlay(Indds1:12)

     DSflEnd                          1n   Overlay(Indds1:51)
     DSflClr                          1n   Overlay(Indds1:52)
     DSflDsp                          1n   Overlay(Indds1:53)
     DSflDspCtl                       1n   Overlay(Indds1:54)

     DDPSflEnd                        1n   Overlay(Indds1:55)
     DDPSflClr                        1n   Overlay(Indds1:56)
     DDPSflDsp                        1n   Overlay(Indds1:57)
     DDPSflDspCtl                     1n   Overlay(Indds1:58)

     DIndPDID                         1n   Overlay(Indds1:21)
     DIndPDName                       1n   Overlay(Indds1:22)
     DIndPDBrand                      1n   Overlay(Indds1:23)
     DIndPDUnt                        1n   Overlay(Indds1:24)
     DIndPDCatgry                     1n   Overlay(Indds1:25)
     DIndPDDes                        1n   Overlay(Indds1:26)
     DIndPDColor                      1n   Overlay(Indds1:27)
     DIndPDGrt                        1n   Overlay(Indds1:28)
     DIndPDSck                        1n   Overlay(Indds1:29)
     DIndAddDT                        1n   Overlay(Indds1:30)
     DIndUPDdt                        1n   Overlay(Indds1:31)
     DIndLtdt                         1n   Overlay(Indds1:32)

     DOvrlayInd                       1n   Overlay(Indds1:30)

     DIndSflNxtChg                    1n   Overlay(Indds1:51)
     DIndOPt                          1n   Overlay(Indds1:61)

     D#Rrn1            S              4S 0 Inz(*zero)
     DIdx              S              5S 0 Inz(*zero)
     DIdx1             S              5S 0 Inz(1)
     D#crid            S             20A   Inz(*Blank)
     DArrcrId          S             20A   Dim(9999)
     DDeleteflag       S               N   Inz(*Off)

     DString1          S             30A   Inz('1234567890!@#$%^&*()-_=+<>,.?/')
     DResult1          S              2S 0
     DResult2          S              2S 0
     DRrn              S              4S 0
     DvVndId           S              6A
     DVVPDNAME         S             15A

     DVndrDb           PR
     DVndID                           6A

     DViewPD           pr
     DSPRODUCTID                      6A

     DUpdtPdDetail     pr
     DSPRODUCTID                      6A

     DUpdateDS         DS
     DUPRODUCTID                      6A
     DUPDNAME                        15A
     DUPDBRAND                       10A
     DUPDUNITPR                       6s 0
     DUPDCOLOR                       10A
     DUPDCATGRY                      30A
     DUABOUTPD                       50A
     DUPDGUARNTE                     15A
     DUPDSTOCK                        4s 0
     DUPDADDDATE       S               D
     DUPDLSTUPDT       S               D

     PVndrDb           B                   export
     DVndrDb           PI
     Dlginid                          6A

     C                   Eval      VVndId = lginid
     C/Exec sql
     C+ select PDNAME Into :VVPDNAME from pddtlpf
     C+ where PDVNDRID = :VVndId
     C/End-Exec

     C                   Dow       logout = *Off
     C                   Exfmt     VndrDsbrd
     C                   Select
     C                   When      Logout = *On
     C                   Eval      Logout = *Off
     C                   clear                   ADMINDSBRD
     C                   Clear                   LgPass
     C                   Clear                   LgInId
     C                   Leave

     C                   When      Refresh = *On
     C                   Eval      Refresh = *Off
     C                   Clear                   VNDRDSBRD
     C                   Clear                   VOPTION


     C                   When      VOption = 1
     C                   Clear                   VOption
     C                   Callp     VndrPDMG()


     C                   EndSl
     C                   EndDo

     PVndrDb           E

     PVndrPDMG         B

     C                   CallP     PMClrsubfile()
     C                   CallP     PMLoadSubfile()
     C                   CallP     PMDsplySubfile()

     PVndrPDMG         E

     PPMClrsubfile     B

     C                   Eval      Rrn = 0
     C                   Eval      SflClr = *On
     C                   Write     PDMGSFLCTL
     C                   Eval      SflClr  = *Off

     PPMClrsubfile     E

     PPMLoadSubfile    B

     C/Exec sql
     C+ Declare PDMGCrsr Cursor For Select PRODUCTID ,
     C+ PDBRAND , PDUNITPR , PDCOLOR , PDSTOCK
     C+ From PDDTLPF Where PDVNDRID = :VVndId
     C/End-Exec

     C/Exec sql
     C+ Open PDMGCrsr
     C/End-Exec

     C/Exec sql
     C+ Fetch from PDMGCrsr Into :SPRODUCTID , :SPDBRAND ,
     C+ :SPDUNITPR , :SPDCOLOR , :SPDSTOCK
     C/End-Exec

     C                   Dow       Sqlcod = 0
     C                   Eval      Rrn = Rrn + 1
     C                   IF        Rrn > 9999
     C                   Leave
     C                   EndIf
     C                   Write     PDMNGMNT

     C/Exec sql
     C+ Fetch Next from PDMGCrsr Into :SPRODUCTID , :SPDBRAND ,
     C+ :SPDUNITPR , :SPDCOLOR , :SPDSTOCK
     C/End-Exec


     C                   EndDo

     C/Exec sql
     C+ Close PDMGCrsr
     C/End-Exec

     PPMLoadSubfile    E




     PPMDsplySubfile   B

     C                   Dow       Cancel = *Off
     C                   Eval      OvrlayInd = *On
     C                   Eval      SflDsp    = *On
     C                   Eval      SflDspCtl = *On
     C                   Eval      SflEnd    = *On

     C                   If        Rrn       <  1
     C                   Eval      OvrlayInd = *Off
     C                   Eval      SflDsp    = *Off
     C                   EndIf

     C                   Eval      PDUSERNAME = VVndId
     C                   Eval      VPDVNDID = VVndId
     C                   Eval      VPDNAME  = VVPDNAME
     C                   Write     VFooter
     C                   Exfmt     PDMGSFLCTL
     C                   Clear                   PDERROR
     C                   Eval      IndOpt = *Off

     C                   Select
     C                   When      Cancel = *On
     C                   Eval      Cancel = *Off
     C                   Eval      IndOpt = *Off
     C                   Clear                   VOption
     C                   Clear                   VPDPOSITN
     C                   Clear                   PDERROR
     C                   Leave

     C                   When      Refresh = *On
     C                   Eval      Refresh = *Off
     C                   Eval      IndOpt = *Off
     C                   Clear                   VOption
     C                   Clear                   VPDPOSITN
     C                   Clear                   PDError
     C                   Eval      IndSflNxtChg  = *Off
     C                   CallP     RefreshLG()

     C                   When      IndInsert=*On
     C                   Eval      IndInsert = *Off
     C                   CallP     InsertPdInfo()
     C                   CallP     PMClrsubfile()
     C                   CallP     PMLoadSubfile()
     C                   Clear                   VOPTION

     C                   When      FLD = 'VPDPOSITN'
     C                   CallP     PMClrsubfile()

     C                   Select
     C                   When      VPDPOSITN <> *Blank
     C                   CallP     PDPostiontoBy()

     C                   Other
     C                   CallP     PMLoadSubfile()
     C                   EndSl

     C                   Other
     C                   Callp     PdOptionLogic
     C                   EndSl
     C                   EndDo

     PPMDsplySubfile   E

     PRefreshLG        B

     C                   CallP     PMClrsubfile()
     C                   CallP     PMLoadSubfile()
     C                   CallP     PMDsplySubfile()

     PRefreshLG        E

     PPdOptionLogic    B

     C                   Readc     PDMNGMNT
     C                   Dow       Not %EOF()
     C                   Eval      IndSflNxtChg  = *off
     C                   Eval      IndOpt = *Off
     C                   Select

     C                   When      VOption = 2
     C                   CallP     UpdtPdDetail(SPRODUCTID)
     C                   Clear                   VOPTION

     C                   When      VOPTION=4
     C*                  Clear                   VOPTION
     C                   Eval      ArrCrId(Idx1)=SPRODUCTID
     C                   Eval      Idx1 += 1
     C                   Eval      Deleteflag = *On

     C                   When      VOPTION=5
     C                   CallP     ViewPDMG(SPRODUCTID)
     C                   Clear                   VOPTION


     C                   When      VOption<>5 Or VOption<>2 Or VOption<>4
     C                   Eval      PDERROR = 'Invalid Option'
     C                   Eval      IndOpt  = *On
     C                   Eval      IndSflNxtChg = *On

     C                   If        VOption = 0
     C                   Eval      IndOpt  = *Off
     C                   Eval      IndSflNxtChg = *Off
     C                   EndIf

     C                   When      Cancel = *On
     C                   Eval      Cancel = *Off
     C                   Clear                   PDERROR
     C                   Clear                   Voption
     C                   Leave

     C                   Other
     C                   Clear                   Voption
     C                   clear                   PDERROR
     C                   Eval      IndOpt = *Off
     C                   Return

     C                   EndSl
     C                   Update    PDMNGMNT
     C                   Readc     PDMNGMNT

     C                   EndDo
     C                   Clear                   VOption
     C                   Eval      IndSflNxtChg = *Off
     C                   If        Deleteflag = *On
     C                   CallP     DeletePDProfile()
     C                   CallP     PMClrsubfile()
     C                   CallP     PMLoadSubfile()
     C                   EndIf

     PPdOptionLogic    E


     PViewPDMG         B
     DViewPDMG         PI
     DSPRODUCTID                      6A

     C/Exec sql
     C+ Select PRODUCTID , PDNAME , PDBRAND , PDUNITPR ,
     C+ PDCOLOR ,PDCATGRY , ABOUTPD , PDGUARNTE ,
     C+ PDSTOCK ,PDADDDATE , PDLSTUPDT Into :VPRODUCTID ,
     C+ :VPDNAME , :VPDBRAND , :VPDUNITPR , :VPDCOLOR ,
     C+ :VPDCATGRY , :VABOUTPD , :VPDGUARNTE , :VPDSTOCK ,
     C+ :VPDADDDATE , :VPDLSTUPDT
     C+ From PDDTLPF Where PRODUCTID = :SPRODUCTID
     C/End-Exec

     C                   Dow       Cancel = *Off
     C                   Eval      VERROR  = 'Data Dislyed Successfully'
     C                   Eval      USERNAME = VVndId
     C                   Exfmt     VIEWPDDTL

     C                   If        Cancel = *On
     C                   Eval      Cancel = *Off
     C                   Clear                   VIEWPDDTL
     C                   Clear                   UERROR
     C                   Clear                   VOPTION
     C                   Leave
     C                   EndIf
     C                   EndDo
     PViewPDMG         E

     PUpdtPdDetail     B
     DUpdtPdDetail     PI
     DSPRODUCTID                      6A

     C/Exec sql
     C+ Select PRODUCTID , PDNAME , PDBRAND , PDUNITPR ,
     C+ PDCOLOR , PDCATGRY , ABOUTPD , PDGUARNTE ,
     C+ PDSTOCK , PDADDDATE , PDLSTUPDT
     C+ Into :UpdateDS From PDDTLPF Where
     C+ PRODUCTID = :SPRODUCTID And PDVNDRID = :VVndId
     C/End-Exec

     C                   Dow       Cancel = *Off

     C                   Eval      USERNAME = VVndId
     C                   Exfmt     UPDTPDDTL
     C                   Clear                   UERROR
     C                   CallP     ResetUpdateInd()
     C                   CallP     UpdtVald()

     C                   Select
     C                   When      Cancel = *On
     C                   Eval      Cancel = *Off
     C                   Clear                   PDERROR
     C                   Clear                   VOption
     C                   CallP     ResetUpdateInd()
     C                   Leave
     C                   EndSl

     C                   If        UError = *Blank And UpdateInd=*On
     C                   Eval      UpdateInd = *Off
     C                   CallP     UpdateRcrd(SPRODUCTID)
     C                   Eval      Verror='Record Update Successfully'
     C                   Leave
     C                   EndIf

     C                   EndDo

     PUpdtPdDetail     E

     PUpdateRcrd       B
     DUpdateRcrd       PI
     DSPRODUCTID                      6A

     C/Exec sql
     C+ Update PDDTLPF
     C+ Set PRODUCTID = :UPRODUCTID ,
     C+ PDNAME = :UPDNAME  ,
     C+ PDBRAND = :UPDBRAND  ,
     C+ PDUNITPR = :UPDUNITPR  ,
     C+ PDCOLOR = :UPDCOLOR  ,
     C+ PDCATGRY = :UPDCATGRY  ,
     C+ ABOUTPD = :UABOUTPD  ,
     C+ PDGUARNTE = :UPDGUARNTE ,
     C+ PDSTOCK   = :UPDSTOCK ,
     C+ PDADDDATE = :UPDADDDATE ,
     C+ PDLSTUPDT = :UPDLSTUPDT
     C+ Where PRODUCTID = :SPRODUCTID
     C/End-Exec
     C                   Clear                   VOPTION

     PUpdateRcrd       E

     PResetUpdateInd   B

     C                   Eval      IndPDID = *Off
     C                   Eval      IndPDName = *Off
     C                   Eval      IndPDBrand = *Off
     C                   Eval      IndPDUnt = *Off
     C                   Eval      IndPDCatgry = *Off
     C                   Eval      IndPDDes = *Off
     C                   Eval      IndPDColor = *Off
     C                   Eval      IndPDGrt = *Off
     C                   Eval      IndPDSck = *Off
     C                   Eval      IndAddDT = *Off
     C                   Eval      IndUPDdt = *Off
     C                   Eval      IndLtdt  = *Off

     PResetUpdateInd   E

     PUpdtVald         B

     C                   Eval      Result1 = %Check(String1:%Trim(UPDNAME))
     C                   Eval      Result2 = %Check(String1:%Trim(UPDBRAND))

     C                   Select

     C                   When      UPDNAME = *Blank
     C                   Eval      UERROR = 'Name Field should not be Blank'
     C                   Eval      IndPDName = *On

     C                   When      Result1 <> 1
     C                   Eval      UERROR = 'Only Characters are allowed'
     C                   Eval      IndPDName = *On

     C                   When      UPDBRAND= *Blank
     C                   Eval      UERROR = 'Brand Field should not be Blank'
     C                   Eval      IndPDBrand =*On

     C                   When      Result2 <> 1
     C                   Eval      UERROR = 'Only Characters are allowed'
     C                   Eval      IndPDBrand= *On

     C                   When      UPDUNITPR=0
     C                   Eval      UERROR = 'Price Field should not be Blank'
     C                   Eval      IndPDUnt   =*On

     C                   When      UPDCATGRY = *Blank
     C                   Eval      UERROR='Category Field should not be Blank'
     C                   Eval      IndPDCatgry=*On

     C                   When      UABOUTPD = *Blank
     C                   Eval      UERROR='Field should not be Blank'
     C                   Eval      IndPDDes=*On

     C                   When      UPDCOLOR = *Blank
     C                   Eval      UERROR='Color Field should not be Blank'
     C                   Eval      IndPDColor=*On

     C                   When      UPDGUARNTE= *blank
     C                   Eval      UERROR='Guarntee Field should not be Blank'
     C                   Eval      IndPDGrt=*On

     C                   When      UPDSTOCK=0
     C                   Eval      UERROR='Stock Field should not be Blank'
     C                   Eval      IndPDSck=*On

     C                   When      %Char(UPDLSTUPDT) = '0001-01-01'
     C                   Eval      UERROR='Field should not be Blank'
     C                   Eval      IndLTDT=*On

     C                   EndSl

     PUpdtVald         E

     PDeletePDProfile  B

     C                   Dow       Cancel = *Off
     C                   CallP     DPClrsubfile()
     C                   CallP     DPLoadSubfile()
     C                   CallP     DPDsplySubfile()

     C                   If        Cancel = *On
     C                   Eval      Cancel = *Off
     C                   Reset                   Idx
     C                   Reset                   Idx1
     C                   Reset                   #CrId
     C                   Clear                   ArrCrId
     C                   Eval      Deleteflag = *Off
     C                   Leave

     C                   Else
     C                   For       Idx = 1 to Idx1-1
     C                   Eval      #CrId = ArrCrId(Idx)
     C/Exec sql
     C+ Delete From PDDTLPF
     C+ Where PRODUCTID = :#CrId
     C/End-Exec
     C                   EndFor
     C                   Clear                   VOPTION
     C                   Eval      PDERROR='Data deleted succuessfully'
     C                   Eval      Deleteflag = *Off
     C                   Leave
     C                   EndIf
     C                   Enddo
     PDeletePDProfile  E

     PDPClrsubfile     B
     C                   Eval      DPSflClr = *On
     C                   Eval      #Rrn1 = 0
     C                   Write     DPDSFLCTL
     C                   Eval      DPSflClr = *Off
     PDPClrsubfile     E

     PDPLoadSubfile    B

     C                   For       Idx = 1 to Idx1-1
     C                   Eval      #CrId = ArrCrId(Idx)

     C/Exec sql
     C+  Select PRODUCTID , PDBRAND , PDUNITPR ,
     C+  PDCOLOR , PDSTOCK
     C+  Into :DLRODUCTID , :DLPDBRAND , :DLPDUNITPR ,
     C+  :DLPDCOLOR  , :DLPDSTOCK
     C+  From PDDTLPF
     C+  Where PRODUCTID = :#CrId
     C/End-Exec
     C                   Eval      #Rrn1 += 1

     C                   If        #Rrn1 > 9999
     C                   Leave
     C                   EndIf
     C                   Write     DLTPDDTL
     C                   EndFor

     PDPLoadSubfile    E

     PDPDsplySubfile   B
     C                   Eval      DPSflDsp   =*On
     C                   Eval      DPSflDspCtl=*On
     C                   Eval      DPSflEnd   =*On
     C
     C                   If        #Rrn1 < 1
     C                   Eval      DPSflDsp = *Off
     C                   EndIf

     C*                  Write     DLTFOOTER

     C                   Exfmt     DPDSFLCTL


     PDPDsplySubfile   E

     PPDPostiontoBy    B

     C/Exec sql
     C+ Declare PDMGPositionCrsr Cursor for Select
     C+ PRODUCTID , PDBRAND , PDUNITPR , PDCOLOR , PDSTOCK
     C+ from PDDTLPF  Where
     C+ PRODUCTID Like '%' Concat Trim(:VPDPOSITN) Concat '%' Or
     C+ PDBRAND  Like '%' Concat Trim(:VPDPOSITN) Concat '%'
     C/End-Exec

     C/Exec sql
     C+ Open PDMGPositionCrsr
     C/End-Exec

     C/Exec sql
     C+ Fetch from PDMGPositionCrsr Into :SPRODUCTID , :SPDBRAND ,
     C+ :SPDUNITPR , :SPDCOLOR , :SPDSTOCK
     C/End-Exec

     C                   Dow       Sqlcod = 0
     C                   Eval      Rrn = Rrn + 1
     C                   If        Rrn > 9999
     C                   Leave
     C                   EndIf
     C                   Write     PDMNGMNT

     C/Exec sql
     C+ Fetch Next from PDMGPositionCrsr Into :SPRODUCTID , :SPDBRAND ,
     C+ :SPDUNITPR , :SPDCOLOR , :SPDSTOCK
     C/End-Exec

     C                   EndDo

     C/Exec sql
     C+ Close PDMGPositionCrsr
     C/End-Exec

     PPDPostiontoBy    E

     PInsertPdInfo     B

     C                   Dow       Cancel = *Off
     C                   Eval      PDVNDRID = VVndId
     C                   Eval      IPDADDDATE = %date()
     C                   Eval      IPDLSTUPDT = %date()
     C                   Exfmt     INSRTPDDTL

     C                   Select

     C                   When      Cancel = *On
     C                   Eval      Cancel = *Off
     C                   Clear                   INSRTPDDTL
     C                   CallP     ResetUpdateInd()
     C                   Leave
     C                   Other
     C                   CallP     InserPDRcd()
     C                   EndSl
     C                   EndDo

     PInsertPdInfo     E

     PInserPDRcd       B

     C                   CallP     ResetUpdateInd()
     C                   Clear                   VERROR
     C                   CallP     InstVald()

     C                   If        VERROR=*Blank and IndInsert=*On
     C                   Eval      IndInsert = *Off

     C/Exec sql
     C+ Insert Into PDDTLPF ( PDVNDRID, PRODUCTID , PDNAME , PDBRAND ,
     C+ PDUNITPR , PDCATGRY , ABOUTPD , PDCOLOR , PDSTOCK ,
     C+                        PDGUARNTE , PDLSTUPDT )
     C+ Values ( :PDVNDRID ,:IPRODUCTID , :IPDNAME , :IPDBRAND ,
     C+ :IPDUNITPR , :IPDCATGRY , :IABOUTPD , :IPDCOLOR ,
     C+         :IPDSTOCK , :IPDGUARNTE , :IPDLSTUPDT )
     C/End-Exec

     C                   Clear                   INSRTPDDTL
     C                   Eval      VERROR ='Record Inserted Successfully'
     C                   EndIf


     PInserPDRcd       E

     PInstVald         B

     C                   Eval      Result1 = %Check(String1:%Trim(IPDNAME))
     C                   Eval      Result2 = %Check(String1:%Trim(IPDBRAND))

     C                   Select

     C                   When      IPRODUCTID = *Blank
     C                   Eval      VERROR = 'ProductId should not be Blank'
     C                   Eval      IndPDID = *On

     C                   When      IPDNAME = *Blank
     C                   Eval      VERROR = 'Name Field should not be Blank'
     C                   Eval      IndPDName = *On

     C                   When      Result1 <> 1
     C                   Eval      Verror = 'Only Characters are allowed'
     C                   Eval      IndPDName = *On

     C                   When      IPDBRAND= *Blank
     C                   Eval      VERROR = 'Brand Field should not be Blank'
     C                   Eval      IndPDBrand =*On

     C                   When      Result2 <> 1
     C                   Eval      VERROR = 'Only Characters are allowed'
     C                   Eval      IndPDBrand= *On

     C                   When      IPDUNITPR=0
     C                   Eval      VERROR = 'Price Field should not be Blank'
     C                   Eval      IndPDUnt   =*On

     C                   When      IPDCOLOR =*Blank
     C                   Eval      VERROR = 'Color Field should not be Blank'
     C                   Eval      IndPDColor =*On

     C                   When      IPDCATGRY = *Blank
     C                   Eval      VERROR='Category Field should not be Blank'
     C                   Eval      IndPDCatgry=*On

     C                   When      IABOUTPD = *Blank
     C                   Eval      VERROR='Field should not be Blank'
     C                   Eval      IndPDDes=*On


     C                   When      IPDGUARNTE= *blank
     C                   Eval      VERROR='Guarntee Field should not be Blank'
     C                   Eval      IndPDGrt=*On

     C                   When      IPDSTOCK=0
     C                   Eval      VERROR='Stock Field should not be Blank'
     C                   Eval      IndPDSck=*On

     C                   When      %char(IPDADDDATE)='0001-01-01'
     C                   Eval      VError='InsertDate should not be blank'
     C                   Eval      IndAddDT=*On

     C                   When      %char(IPDLSTUPDT)='0001-01-01'
     C                   Eval      VError='InsertDate should not be blank'
     C                   Eval      IndUPDDt=*On

     C                   EndSl

     PInstVald         E
