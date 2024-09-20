     **Free

       Ctl-opt Option(*Nodebugio:*Srcstmt) Nomain Datfmt(*Iso);
       //Ctl-Opt BndDir('EHEADLIB/ADMINBND');

       Dcl-F Eheadscrn Workstn Indds(Indds1);
       Dcl-F PDDTLPF Disk Usage(*Input:*Output:*Update) ;
       Dcl-F VNDDTLPF Disk Usage(*Input:*Output:*Update) ;
       Dcl-F ORDMGPF Disk Usage(*Input:*Output:*Update) ;
       Dcl-F EHEADADMIN Workstn Indds(Indds1) Sfile(VIEWINVNT:Rrn)
                                              Sfile(VNDRMNGMNT:VMRrn)
                                              Sfile(DLTMULTRCD:#Rrn1)
                                              Sfile(VWCSTMRPR:Rrn2)
                                              Sfile(ORDMNGMNT:ORrn)
                                              Sfile(ODREDPD:OPRrn)
                                              Sfile(REPORTMG:RPRrn)
                                              Sfile(SALEPRTF:SRPRrn)
                                              Sfile(COMPLAINSF:CmpRrn)
                                              Sfile(FDBCKDTL:FDRrn);

       Dcl-f VENDERRP Printer Usage(*Output) UsrOpn;
       Dcl-f SALEREPORT Printer Usage(*Output) usrOpn;
       Dcl-Ds Indds1;

         Exit Ind pos(03);
         LogOut  Ind Pos(10);
         Refresh Ind pos(05);
         ChngPass Ind Pos(07);
         UpdateInd Ind Pos(2);
         Prompt Ind Pos(04);
         Cancel Ind Pos(12);

         SRPSflEnd Ind Pos(75);
         SRPSflClr Ind Pos(76);
         SRPSflDsp Ind Pos(77);
         SRPSflDspCtl Ind Pos(78);

         CMPSflEnd Ind Pos(91);
         CMPSflClr Ind Pos(92);
         CMPSflDsp Ind Pos(93);
         CMPSflDspCtl Ind Pos(94);

         FDSflEnd Ind Pos(95);
         FDSflClr Ind Pos(96);
         FDSflDsp Ind Pos(97);
         FDSflDspCtl Ind Pos(98);

         IndAdmin Ind Pos(99);

         RPSflEnd Ind Pos(17);
         RPSflClr Ind Pos(18);
         RPSflDsp Ind Pos(19);
         RPSflDspCtl Ind Pos(20);

         OrdSflEnd Ind Pos(21);
         OrdSflClr Ind Pos(22);
         OrdSflDsp Ind Pos(23);
         OrdSflDspCtl Ind Pos(24);

         OrdPSflEnd Ind Pos(25);
         OrdPSflClr Ind Pos(26);
         OrdPSflDsp Ind Pos(27);
         OrdPSflDspCtl Ind Pos(28);

         SflEnd Ind Pos(31);
         SflClr Ind Pos(32);
         SflDsp Ind Pos(33);
         SflDspCtl Ind Pos(34);
         IndOpt Ind Pos(41);
         IndUOpt Ind Pos(42);
         IndOpt1 Ind Pos(51);
         IndOpt2 Ind Pos(52);
         IndOpt3 Ind Pos(53);
         IndOpt4 Ind Pos(54);
         IndOpt5 Ind Pos(55);
         IndOpt6 Ind Pos(56);
         IndOpt7 Ind Pos(57);
         IndOvrly Ind Pos(58);
         IndOvrly1 Ind Pos(59);

         IndSflNxtChg Ind Pos(81);
         IndSflNxtChg1 Ind Pos(82);
         IndSflNxtChg2 Ind Pos(83);
         IndSflNxtChg3 Ind Pos(84);
         IndSflNxtChg4 Ind Pos(85);
         IndSflNxtChg5 Ind Pos(86);
         IndSflNxtChg6 Ind Pos(87);
         IndSflNxtChg7 Ind Pos(88);
         IndSflNxtChg8 Ind Pos(89);

         VMSflEnd Ind Pos(35);
         VMSflClr Ind Pos(36);
         VMSflDsp Ind Pos(37);
         VMSflDspCtl Ind Pos(38);

         IndDltSflEnd    Ind Pos(43);
         IndDltSlfClr    Ind Pos(44);
         IndDltSflDsp    Ind Pos(45);
         IndDltSflDspCtl Ind Pos(46);

         VCSflEnd Ind Pos(47);
         VCSflClr Ind Pos(48);
         VCSflDsp Ind Pos(49);
         VCSflDspCtl Ind Pos(50);

         IndUName Ind Pos(65);
         IndUMob  Ind Pos(66);
         IndUEmail Ind Pos(67);
         IndUState Ind Pos(68);
         IndUAdd  Ind Pos(69);
         IndUGender Ind Pos(70);
         IndUDor  Ind Pos(71);
         IndUDob  Ind Pos(72);
         IndUPin  Ind Pos(73);
         IndUAge  Ind Pos(74);

         IndFromDate Ind pos(13);
         IndTodate Ind Pos(14);

         IndSLFromDate Ind pos(11);
         IndSLTodate Ind Pos(16);

       End-ds ;

         Dcl-S TodayDate Date ;
         Dcl-S String Char(10) Inz('0123456789');
         Dcl-S String1 Char(30) Inz('1234567890!@#$%^&*()-_=+<>,.?/');

         Dcl-S String2 Char(36) Inz('!@#$%^&*()_+=,.<>?/');
         Dcl-S Count Zoned(5);
         Dcl-S Regex VarChar(50);
         Dcl-S Len Zoned(2) ;
         Dcl-S Len1 Zoned(2) ;
         Dcl-S Result6 Char(4);
         Dcl-S Result7 Char(4);
         Dcl-S Result8 Zoned(4);
         Dcl-S Result1 Zoned(2);
         Dcl-S Result3 Zoned(2);
         Dcl-S Result2 zoned(1);

         Dcl-S #Rrn1 Zoned(4) Inz(*Zero);
         Dcl-S Idx Zoned(5) Inz(*Zero);
         Dcl-S Idx1 Zoned(4) Inz(1);
         Dcl-S #CrId Char(20) Inz(*Blank);
         Dcl-S ArrCrId  Char(20) Dim(9999);
         Dcl-S Deleteflag Ind Inz(*Off);

       Dcl-Ds DSUpdate;

         UVNDID       Char(6) ;
         UVNDNAME     Char(10) ;
         UVNDSTATE    Char(15) ;
         UVNDEMAIL    Char(30) ;
         UVNDADDRES   Char(50) ;
         VNDGENDER    Char(1) ;
         UVNDMOBILE   Char(10) ;
         UVNDPINCOE   Char(6) ;
         UDOB         Date ;
         UAGE         Zoned(3);
         UDOR         Date  ;

       End-Ds;

       //Prototype define

       Dcl-Pr ChangePasswordFunction
       End-Pr;

       Dcl-Pr StatePrompt Char(15);
        P_State Char(15);
       End-Pr;

       Dcl-PR ViewFeedBackInformation ;
        DFDBACKID Char(6);
       End-PR;

       Dcl-Pr ViewComplaintInformation ;
         DCmpId char(6);
       End-Pr;

       Dcl-Pr ViewInvntry ;
         SPDVNDRID char(6);
       End-Pr;

       Dcl-Pr ViewVMProfile;
         VMVNDID char(6);
       End-Pr;

       Dcl-Pr OrderedPd;
         DODPDID char(6);
       End-Pr;

       Dcl-Pr UpdateVMProfile ;
         SVNDID char(6);
       End-Pr;

       Dcl-Pr CustomerProfile;
         VCCSTID Char(6);
       End-Pr;

       Dcl-Pr TotalAmount Packed(5);
         DODRID  CHAR(6);
       End-Pr;

       Dcl-S Rrn Zoned(4);
       Dcl-S Rrn2 Zoned(4);
       Dcl-S VMRrn Zoned(4);
       Dcl-S ORrn Zoned(4);
       Dcl-S OPRrn Zoned(4);
       Dcl-S RPRrn Zoned(4);
       Dcl-S SRPRrn Zoned(4);
       Dcl-S CmpRrn Zoned(4);
       Dcl-S FDRrn Zoned(4);



       Dcl-proc AdminDb export;

        Dow LogOut = *Off;
          User = 'Admin';
          Exfmt AdminDsbrd;
          Clear ADBERROR ;
          Reset IndAdmin ;
          Select;

           When LogOut = *On;
             LogOut = *Off;
             Clear ADMINDSBRD;
             Clear Lgpass;
             Clear LgInId;
             Leave;

           When Refresh = *On;
                Refresh = *Off;
                Clear ADMINDSBRD ;
                Clear AOPTION ;

           When ChngPass = *On;
                ChngPass = *Off;
                ChangePasswordFunction();

           When AOPTION = 1 ;
                Clear AOPTION ;
                ViewInventory();

           When AOption = 2;
                Clear AOPTION ;
                VnderManagement();

           When Aoption = 3;
                Clear Aoption;
                ViewCustomerProfile();

           When Aoption = 4;
                Clear Aoption;
                OrderManagement();

           When Aoption = 5;
                Clear Aoption;
                VenderReport();

           When Aoption = 6;
                Clear Aoption;
                SalesReport();

           When Aoption = 7;
                Clear Aoption;
                ComplaintInformation();

           When Aoption = 8;
                Clear Aoption;
                ViewFeedBackDetails();

           Other ;
                ADBERROR = 'Invalid Option';
                IndAdmin = *On ;


          Endsl;
        Enddo;

       End-Proc;

       //View Inventory Procedure

       Dcl-Proc ViewInventory ;

       Cancel = *OFf;
       Dow  Cancel = *Off ;

            Clrsubfile();

            //Select ;

            //  When POSITIONTO = *Blank ;
                   Loadsubfile();

            //  When POSITIONTO <> *Blank ;
            //       PostionToBy();

            //EndSl;

              Dsplysubfile();


       EndDo;
              Cancel = *Off;

       End-Proc;

       //Clear Subfile Procedure

       Dcl-Proc Clrsubfile  ;

             Rrn =0    ;
             SflClr = *On ;
             Write VISFLCTL;
             SflClr = *Off  ;

       End-Proc;

       //Load Subfile Procedure

       Dcl-Proc Loadsubfile ;



         Exec sql
           Declare SubCrsr Cursor For Select PDVNDRID ,
           PDNAME , PDSTOCK , PDBRAND , PDADDDATE
           From PDDTLPF ;

         Exec sql
           Open Subcrsr;

         Exec sql
           Fetch from Subcrsr Into :SPDVNDRID , :SPDNAME ,
           :SPDSTOCK , :SPDBRAND , :SPDADDDATE ;


         Dow Sqlcod = 0 ;

            Rrn = Rrn + 1 ;

            If  Rrn > 9999;
            Leave ;
            EndIf ;
            Write VIEWINVNT ;

         Exec sql
           Fetch from Subcrsr Into :SPDVNDRID , :SPDNAME ,
           :SPDSTOCK , :SPDBRAND , :SPDADDDATE ;


         Enddo;

         Exec sql
             Close Subcrsr;

       End-Proc;

         //Display Subfile Procedure

       Dcl-Proc dsplysubfile;

        Dow Cancel = *Off;
          SflDsp = *On ;
          SflDspCtl = *On ;
          SflEnd = *On;

          If  Rrn = 0;
              SflDsp = *Off;
          Endif;

          User = 'Admin';
          Write VIFOOTER ;
          Exfmt VISFLCTL;
          //IndSflNxtChg = *Off;
            Select;

               When Cancel = *On;
                    IndOpt = *Off;
                    Clear Soption ;
                    Clear VIERROR ;
                    Clear POSITIONTO;
                    leave;

               When Refresh = *ON ;
                    Refresh = *Off;
                    Clear VIERROR ;
                    Clear POSITIONTO;
                    IndOpt = *Off;
                    IndSflNxtChg = *Off;
                    RefreshLogic();

               When FLD = 'POSITIONTO'  ;
                       Clrsubfile();

                    Select ;

                     When POSITIONTO <> *Blank ;
                       PostionToBy();

                     Other;
                       Loadsubfile();

                    Endsl;

               When FLD = 'POSITIONTO' And POSITIONTO = *Blank ;
               Clrsubfile();
               Loadsubfile();

               Other;

               OptionLogic();

            EndSl;
        EndDo;

       End-Proc;


         //Display using option

       Dcl-Proc OptionLogic;


            Readc VIEWINVNT ;
            Dow not %eof();
             IndSflNxtChg = *On;
             IndOpt = *Off;


             Select ;



             When SOption = 5;
                ViewInvntry(SPDVNDRID);
               // IndSflNxtChg = *Off;
                IndOpt  = *Off;
                Clear SOPTION ;

             When SOption <> 5  ;
                 VIERROR = 'Invalid Option';
                 IndOpt  = *On;
                 //IndSflNxtChg = *On;
                 // Update VIEWINVNT ;

             //When POSITIONTO <> *Blank ;
             //     PostionToBy();

             Other ;

              Clear Soption ;
              Clear VIERROR ;
              IndOpt = *Off;
              //IndSflNxtChg = *Off;
              Return;

            Endsl;
             //Clear SOption;
             Update VIEWINVNT ;
             Readc VIEWINVNT;

           EndDo;
             Clear SOption;
             IndSflNxtChg = *Off;


       End-Proc;

       //Add Data in record

       Dcl-Proc ViewInvntry;

            Dcl-Pi ViewInvntry ;
              SPDVNDRID char(6);
            End-Pi;

            Exec Sql
              Select PDVNDRID , PRODUCTID , PDNAME , PDBRAND ,
                     PDUNITPR , PDCATGRY , PDSTOCK , PDADDDATE ,
                     PDLSTUPDT  Into :VPDVNDRID ,
                     :VPRODUCTID , :VPDNAME , :VPDBRAND ,
                     :VPDUNITPR , :VPDCATGRY , :VPDSTOCK ,
                     :VPDADDDATE , :VPDLSTUPDT
                     From  PDDTLPF
                     Where PDVNDRID = :SPDVNDRID ;

            Dow Cancel = *Off;

              //Write VIFOOTER ;
              Exfmt VINVENTORY ;

              IF Cancel = *On;
                 Cancel = *Off;
                 Clear SOption;
                 Leave;
              EndIf;

            EndDo;

       End-Proc;

        //Position to by Procedure

       Dcl-Proc PostionToBy ;

          Exec sql
            Declare CrsrPosition Cursor for select
            PDVNDRID , PDNAME , PDSTOCK , PDBRAND , PDADDDATE
            from PDDTLPF Where
            PDVNDRID Like '%' Concat Trim(:PositionTo) Concat '%' Or
            PDNAME   Like '%' Concat Trim(:PositionTo) Concat '%' Or
            PDBRAND  Like '%' Concat Trim(:PositionTo) Concat '%' ;


          Exec Sql
             Open CrsrPosition;

          Exec Sql
             Fetch From CrsrPosition Into :SPDVNDRID , :SPDNAME ,
             :SPDSTOCK , :SPDBRAND , :SPDADDDATE ;

          Dow Sqlcod = 0;

              Rrn = Rrn + 1;

              If Rrn > 9999;
               Leave;
              EndIf;

              Write VIEWINVNT ;

           Exec Sql
              Fetch Next From CrsrPosition Into :SPDVNDRID ,
              :SPDNAME , :SPDSTOCK , :SPDBRAND , :SPDADDDATE ;

          EndDo;

          Exec Sql
             Close CrsrPosition;

        End-Proc;

        //Refresh procedure

        Dcl-Proc RefreshLogic ;

            Clrsubfile();
            Loadsubfile();
            Dsplysubfile();

        End-Proc;

         //Vender Management Procedure

        Dcl-Proc VnderManagement ;

           Cancel = *OFf;
           Dow  Cancel = *Off ;

             VMClrsubfile();

             //Select ;

               //When VMPOSITION = *Blank ;
                    VMLoadsubfile();

               //When VMPOSITION <> *Blank ;
                //    VMPositionToBy();

             //EndSl;

               VMDsplysubfile();

           EndDo;

             Cancel = *Off;

        End-Proc;

        //Clear Subfile Procedure

        Dcl-Proc VMClrsubfile  ;

             VMRrn =0    ;
             VMSflClr = *On ;
             Write VNDMSFLCTL ;
             VMSflClr = *Off  ;

        End-Proc;

        //Load Subfile Procedure

        Dcl-Proc VMLoadsubfile ;

          //Exec sql
          //  Set option commit = *None ;


          Exec sql
            Declare VndrCrsr Cursor For Select VNDID ,
            VNDNAME , VNDGENDER , VNDSTATE , VNDMOBILE
            From VNDDTLPF ;

          Exec sql
            Open VndrCrsr;

          Exec sql
            Fetch from VndrCrsr Into :SVNDID ,
            :SVNDNAME , :SVNDGENDER , :SVNDSTATE ,
            :SVNDMOBILE ;

          Dow Sqlcod = 0 ;

            VMRrn = VMRrn + 1 ;

            If  VMRrn > 9999;
              Leave ;
            EndIf ;
            Write VNDRMNGMNT ;

          Exec Sql
              Fetch Next from VndrCrsr Into :SVNDID ,
              :SVNDNAME , :SVNDGENDER , :SVNDSTATE ,
              :SVNDMOBILE ;

          Enddo;

          Exec sql
             Close VndrCrsr ;

        End-Proc;

          //Display Subfile Procedure

        Dcl-Proc VMDsplySubfile;

          Dow Cancel = *Off;
            IndOvrly = *On;
            VMSflDsp = *On ;
            VMSflDspCtl = *On ;
            VMSflEnd = *On;

            If  VMRrn = 0;
              IndOvrly = *Off;
              VMSflDsp = *Off;
            Endif;

            User = 'Admin';
            Write VIFOOTER ;
            Exfmt VNDMSFLCTL;
            Clear VIERROR ;

            Select;

               When Cancel = *On;
                    IndUOpt = *Off;
                    Clear Soption ;
                    Clear VIERROR ;
                    Clear VMPOSITION ;
                    leave;

               When Refresh = *ON ;
                    Refresh = *Off;
                    IndUOpt = *Off;
                    Clear VIERROR ;
                    IndSflNxtChg1 = *Off;
                    Clear VMPOSITION ;
                    VMRefreshLogic();

               When FLD = 'VMPOSITION'  ;
                     VMClrsubfile();

                     Select ;
                       When VMPOSITION <> *Blank;
                            VMPositionToBy();
                       Other ;
                         VMLoadsubfile();
                     EndSl;

                When FLD = 'VMPOSITION' And VMPOSITION = *Blank ;
                VMClrsubfile();
                VMLoadsubfile();

               Other;

                VMOptionLogic();

            EndSl;

          EndDo;

        End-Proc;

        //Procedure for refresh

        Dcl-Proc VMRefreshLogic;

          VMClrsubfile();
          VMLoadsubfile();
          VMDsplySubfile();

        End-Proc;

         //Procedure for PositionTo

        Dcl-Proc VMPositionToBy ;

          clear SVNDID ;
          clear svndname;
          clear SVNDGENDER;
          clear svndstate;
          clear svndmobile;


          Exec sql
            Declare VMCrsr Cursor for Select
            VNDID , VNDNAME , VNDGENDER , VNDSTATE , VNDMOBILE
            from VNDDTLPF Where
            VNDID Like '%' Concat Trim(:VMPOSITION) Concat '%' Or
            VNDNAME  Like '%' Concat Trim(:VMPOSITION) Concat '%' ;



          Exec Sql
             Open VMCrsr;

          Exec Sql
             Fetch From VMCrsr Into :SVNDID , :SVNDNAME ,
             :SVNDGENDER , :SVNDSTATE , :SVNDMOBILE ;

          Dow Sqlcod = 0;

              VMRrn = VMRrn + 1;

              If VMRrn > 9999;
               Leave;
              EndIf;

              Write VNDRMNGMNT ;

           Exec Sql
               Fetch Next From VMCrsr Into :SVNDID , :SVNDNAME ,
               :SVNDGENDER , :SVNDSTATE , :SVNDMOBILE ;

          EndDo;

          Exec Sql
             Close VMCrsr;

        End-Proc;

        Dcl-Proc VMOptionLogic;

           Readc VNDRMNGMNT ;
            Dow not %eof();
             IndSflNxtChg1 = *On;
             IndUOpt = *Off;

            Select ;

                When Soption = 2 ;
                     UpdateVMProfile(SVNDID);
                    // IndOpt  = *Off;
                     Clear SOPTION ;

                When Soption = 4;
                     Clear SOPTION ;
                     ArrCrId(Idx1) = SVNDID;
                     Idx1 += 1;
                     Deleteflag = *On;


                When Soption = 5 ;
                     ViewVMProfile(SVNDID);
                     IndUOpt  = *Off;
                     Clear SOPTION ;

                When SOption <> 5 Or SOption <> 2 Or SOption <> 4;
                    VIERROR = 'Invalid Option';
                    IndUOpt  = *On;

                When Cancel = *On;
                     Cancel = *Off;
                     Leave ;
            Other;

              IndUOpt = *Off;
              Clear Soption ;
              Clear VIERROR ;
              Return;

            EndSl;
              Update VNDRMNGMNT;
              Readc VNDRMNGMNT;

            EndDo;
              Clear SOption;
              IndSflNxtChg1 = *Off;

              If Deleteflag = *On;
               DeleteVMProfile() ;
              EndIf;

        End-Proc ;

        Dcl-Proc ViewVMProfile;

           Dcl-Pi ViewVMProfile ;
             SVNDID char(6);
           End-Pi;

           Exec Sql
             Select VNDID , VNDNAME , VNDMOBILE , VNDEMAIL ,
                    VNDSTATE , VNDADDRESS , VNDGENDER , AGE ,
                    DOR , DOB , VNDPINCODE Into :VMVNDID ,
                    :VMVNDNAME , :VVNDMOBILE , :VMVNDEMAIL ,
                    :VMVNDSTATE , :VVNDADDRES , :VVNDGENDER ,
                    :VMAGE , :VMDOR , :VMDOB , :VVNDPINCOD
                    From  VNDDTLPF
                    Where VNDID = :SVNDID ;

             Dow Cancel = *Off;

             Exfmt VMPROFILE ;

               IF Cancel = *On;
                  Cancel = *Off;
                  Clear SOption;
                  Leave;
               EndIf;

           EndDo;

        End-Proc;

        Dcl-Proc UpdateVMProfile;


            Dcl-Pi UpdateVMProfile;
              SVNDID char(6);
            End-Pi;

          Clear UERROR   ;

          Exec Sql
             Select VNDID , VNDNAME , VNDSTATE , VNDEMAIL ,
             VNDADDRESS , VNDGENDER , VNDMOBILE ,
             VNDPINCODE , DOB , AGE , DOR Into :DSUpdate
             From VNDDTLPF Where VNDID = :SVNDID;

          Dow Cancel = *Off;
             Exfmt VMUPDATE ;
             Clear UERROR;
             ResetUpdateInd();
             UpdateValidation();

          Select;

            When Cancel = *On ;
              Cancel = *Off;
              Clear SOption ;
              Clear UERROR ;
              ResetUpdateInd();
              Leave;

            When FLD = 'VNDGENDER' And Prompt = *On;
                Prompt = *Off;

                Dow Cancel = *Off;

                  Exfmt GENDEROPT1 ;

                    Select ;

                      When Gender = 1;
                          VNDGENDER = 'M';

                      When Gender = 2 ;
                          VNDGENDER = 'F';

                      When Gender = 3 ;
                          VNDGENDER = 'O';

                    EndSl;

                    If Cancel = *On;
                         Cancel = *Off;
                         Reset GENDEROPT1;
                         Clear UError;
                         ResetUpdateInd();
                         Leave;
                    EndIf;
                EndDo;

            When FLD = 'UVNDSTATE' And Prompt = *On;
                 Prompt = *Off;
                 UVNDSTATE = StatePrompt(UVNDSTATE);

          EndSl;




            If UError = *Blank And UpdateInd = *On;
               UpdateInd = *Off;
               UpdateRecord(SVNDID);
               Clear VMUPDATE;
               //UERROR = 'Record Updated successfully';
               VIERROR = 'Record Updated successfully';
               Leave;
            EndIf;

          EndDo;

        End-Proc;

        Dcl-Proc UpdateRecord;

             Dcl-Pi UpdateRecord;
               SVNDID char(6);
             End-Pi;

           //Exec Sql
            // set Option commit = *None ;

           Exec Sql
              Update VNDDTLPF
              Set VNDID = :UVNDID ,
                  VNDNAME = :UVNDNAME ,
                  VNDSTATE = :UVNDSTATE ,
                  VNDEMAIL = :UVNDEMAIL ,
                  VNDADDRESS = :UVNDADDRES ,
                  VNDGENDER = :VNDGENDER ,
                  VNDMOBILE = :UVNDMOBILE ,
                  VNDPINCODE = :UVNDPINCOE ,
                  DOB = :UDOB ,
                  AGE = :UAGE ,
                  DOR = :UDOR
              Where VNDID = :SVNDID;

              Clear SOption;

          End-Proc;

          Dcl-Proc UpdateValidation;

              Dcl-s mailvalid varchar(100);

              Result1 = %Check(String1:%Trim(UVNDNAME));
              Result2 = %Scan( '0' : %Char(UVNDMOBILE) : 1 );
              Result3 = %Check(String2:%Trim(UVNDADDRES));
              Len1 = %Len(%Trim(%Char(UVNDPINCOE)));
              Len = %Len(%Trim(%Char(UVNDMOBILE)));

              //Auto Age
              If %Char(UDOB) <> '0001-01-01';
                Result6 = %Subst(%Char(UDOB) : 1 : 4 );
                TodayDate = %Date();
                Result7 = %Subst(%char(TodayDate) : 1 : 4 );
                Result8 = %Int(Result7) - %Int(Result6);
                UAGE = Result8 ;
              EndIf;



              Mailvalid = %Trim(UVNDEMAIL);
              Regex = '^(?:\w+\.?)*\w+@(?:\w+\.)*\w+$';

              Exec Sql
                  Set :Count = RegExp_Count(:mailvalid,:Regex);

              Select ;

              When UVNDNAME = *Blank;
                 UERROR  = 'Name field can not be blank';
                 IndUName = *On;
                 Return;

              When Result1 <> 1;
                     UError = 'Only Characters are allowed';
                     IndUName = *On;
                     Return;

              When UVNDMOBILE = *Blank;
                   UError = 'Mobile field can not be blank';
                   IndUMob   = *On;
                   Return;

              When Result2 = 1 ;
                   UError = 'Mobile number should not strat with zero';
                   IndUMob = *On;
                   Return;

              When Len < 10 ;
                   UError = 'Mobile number should not Less than Ten';
                   IndUMob = *On;
                   Return;

              When UVNDEMAIL = *Blank;
                      UError = 'Email Field can not be blank';
                      IndUEmail = *ON;
                      Return;

              When Count <> 1;
                        UError = 'Invalid Email';
                        IndUEmail = *ON;
                        Return;

              When  UVNDADDRES = *Blank ;
                      UError = 'Address field can not be blank';
                      IndUAdd = *On;
                      Return;

              When  Result3 <> 1 ;
                      UError = 'Special Characters are not allowed';
                      IndUAdd = *On;
                      Return;

              When UAGE  <= 21 ;
                       UError = 'Age should not be Lessthan 21';
                       IndUAge = *On;
                       Return;

              When %Char(UDOB) = *Blank;
                       UError = 'Dob field  should not be blank';
                       IndUDob = *On;
                       Return;

              When Len1 < 6 ;
                       UError = 'Pincode field should not less than 6';
                       IndUPin = *On;
                       Return;



              EndSl;

          End-Proc;

          Dcl-Proc ResetUpdateInd;

             IndUName = *Off;
             IndUMob  = *Off;
             IndUEmail = *Off;
             IndUState = *Off;
             IndUAdd  = *Off;
             IndUGender = *Off;
             IndUDor  = *Off;
             IndUDob  = *Off;
             IndUPin  = *Off;
             IndUAge  = *Off;

          End-Proc;

          //Delete Multipal record
          Dcl-Proc DeleteVMProfile;

            Dow Cancel = *Off;
              ClearDltSfl();
              LoadDltSfl();
              DisplayDltSfl();

              If Cancel = *On;
               Cancel = *Off;
               Reset Idx;
               Reset Idx1;
               Reset #CrId;
               Clear ArrCrId;
               Deleteflag = *Off;
               Leave;

              Else;

               For Idx = 1 to Idx1-1;
               #CrId = ArrCrId(Idx);
               Exec Sql

               Delete From VNDDTLPF
               Where VNDID = :#CrId;
               EndFor;
               Clear SOPTION ;
               VIERROR = 'Data deleted succuessfully';
               Deleteflag = *Off;
               Leave;

              EndIf;
            EndDo;
          End-Proc;

          Dcl-Proc ClearDltSfl;
            IndDltSlfClr = *On;
            #Rrn1 = 0;
            Write DLTMLTCTL;
            IndDltSlfClr = *Off;
          End-Proc;


          Dcl-Proc LoadDltSfl;
            For Idx = 1 to Idx1-1;
            #CrId = ArrCrId(Idx);

            Exec Sql
              Select VNDID , VNDNAME , VNDGENDER ,
              VNDSTATE, VNDMOBILE
              Into :DDVNDID , :DDVNDNAME , :DDVNDGENDR ,
              :DDVNDSTATE , :DDVNDMOBIL
              From VNDDTLPF
              Where VNDID = :#CrId;

              #Rrn1 += 1;

            If #Rrn1 > 9999;
             Leave;
            EndIf;

            Write DLTMULTRCD;

            EndFor;

          End-Proc;


          Dcl-Proc DisplayDltSfl;

           IndDltSflDsp    = *On;
           IndDltSflDspCtl = *On;
           IndDltSflEnd    = *On;

            If #Rrn1 < 1;
               IndDltSflDsp = *Off;
            EndIf;

            Write DLTFOOTER;

            Exfmt DLTMLTCTL;

          End-Proc;

          Dcl-Proc ViewCustomerProfile ;

             Cancel = *OFf;

             Dow  Cancel = *Off ;

                  CstmClrsubfile();
                  CstmLoadsubfile();
                  CstmDsplysubfile();

             EndDo;

          End-Proc;

          Dcl-Proc CstmClrsubfile  ;

                 Rrn2 = 0    ;
                 VCSflClr = *On ;
                 Write CSTMRCTL;
                 VCSflClr = *Off  ;

          End-Proc;


          Dcl-Proc CstmLoadsubfile ;

             //Exec sql
             // Set option commit = *None ;


             Exec sql
              Declare CstmCrsr Cursor For Select CSTID ,
              CSTNAME , CSTGENDER , CSTSTATE , CSTMOBILE
              From CSTDTLPF ;

             Exec sql
              Open CstmCrsr ;

             Exec sql
                Fetch from CstmCrsr Into :VCCSTID , :VCCSTNAME ,
                :VCSTGENDER , :VCSTSTATE , :VCSTMOBILE ;


             Dow Sqlcod = 0 ;

                 Rrn2 = Rrn2 + 1 ;

                 If  Rrn2 > 9999;
                  Leave ;
                  EndIf ;
                  Write VWCSTMRPR ;

                 Exec sql
                   Fetch Next from CstmCrsr Into :VCCSTID , :VCCSTNAME ,
                   :VCSTGENDER , :VCSTSTATE , :VCSTMOBILE ;


             Enddo;

             Exec sql
                 Close CstmCrsr;

          End-Proc;

          Dcl-Proc CstmDsplySubfile;

             Dow Cancel = *Off;
             FDSflDsp = *On ;
             VCSflDsp = *On ;
             VCSflDspCtl = *On ;
             VCSflEnd = *On;

             If  Rrn2 = 0;
               FDSflDsp = *Off;
               VCSflDsp = *Off;
             Endif;

             User = 'Admin';
             Write VIFOOTER ;
             Exfmt CSTMRCTL;
             Select;

                When Cancel = *On;
                     IndOpt1 = *Off;
                     Clear Soption ;
                     Clear VIERROR ;
                     Clear CPOSITION ;
                     leave;

                When Refresh = *ON ;
                     Refresh = *Off;
                     Clear VIERROR ;
                     Clear CPOSITION ;
                     IndOpt1 = *Off;
                     IndSflNxtChg2 = *Off;
                     VCRefreshLogic();

                When FLD = 'CPOSITION'  ;
                     CstmClrsubfile();

                     Select ;

                       When CPOSITION  <> *Blank ;
                            VCPostionToBy();

                       Other;
                           CstmLoadsubfile();

                     Endsl;

                When FLD = 'POSITIONTO' And POSITIONTO = *Blank ;
                     CstmClrsubfile();
                     CstmLoadsubfile();

                Other;

                   VCOptionLogic();

             EndSl;
             EndDo;

          End-Proc;

          Dcl-Proc VCOptionLogic ;
             Readc VWCSTMRPR;
             Dow not %eof();
              IndSflNxtChg2 = *On;
              IndOpt1 = *Off;

              Select ;

               When SOption = 5;
                 CustomerProfile(VCCSTID);
                 IndOpt1 = *Off;
                 Clear SOPTION ;

               When SOption <> 5  ;
                  VIERROR = 'Invalid Option';
                  IndOpt1 = *On;

               Other ;

                 Clear Soption ;
                 Clear VIERROR ;
                 IndOpt1 = *Off;
                 Return;

              Endsl;
                Update VWCSTMRPR ;
                Readc VWCSTMRPR;

             EndDo;
               Clear SOption;
               IndSflNxtChg2 = *Off;

          End-Proc;

          Dcl-Proc CustomerProfile;

            Dcl-Pi CustomerProfile;
              VCCSTID Char(6);
            End-Pi;

            Exec Sql
             Select CSTID , CSTNAME , CSTMOBILE , CSTGMAIL ,
                    CSTSTATE , CSTCITY , CSTADDRESS ,
                    CSTCOUNTRY , CSTGENDER ,
                    CSTPINCODE Into :CPCSTID ,
                     :CPCSTNAME , :CPCSTMOBIL , :CPCSTGMAIL ,
                     :CPCSTSTATE , :CPCSTCITY , :CPCSTADDRE ,
                     :CPCSTCOUNT , :CPCSTGENDE , :CPCSTPINCO
                     From  CSTDTLPF
                     Where CSTID = :VCCSTID ;

            Dow Cancel = *Off;

              //Write VIFOOTER ;
              Exfmt VCPROFILE ;

              IF Cancel = *On;
                 Cancel = *Off;
                 Clear SOption;
                 Leave;
              EndIf;

            EndDo;


          End-Proc;

          Dcl-Proc VCRefreshLogic;

            CstmClrsubfile();
            CstmLoadsubfile();
            CstmDsplysubfile();

          End-Proc;

          Dcl-Proc VCPostionToBy;

            Exec sql
             Declare CstmPosition Cursor for select
             CSTID , CSTNAME , CSTGENDER , CSTSTATE , CSTMOBILE
             from CSTDTLPF Where
             CSTID Like '%' Concat Trim(:CPOSITION) Concat '%' Or
             CSTNAME Like '%' Concat Trim(:CPOSITION) Concat '%' ;


            Exec Sql
             Open CstmPosition;

            Exec Sql
              Fetch From CstmPosition Into :VCCSTID , :VCCSTNAME ,
              :VCSTGENDER , :VCSTSTATE , :VCSTMOBILE ;

            Dow Sqlcod = 0;

               Rrn2 = Rrn2 + 1;

               If Rrn2 > 9999;
                 Leave;
               EndIf;

               Write VWCSTMRPR ;

              Exec Sql
                Fetch Next From CstmPosition Into :VCCSTID , :VCCSTNAME ,
                :VCSTGENDER , :VCSTSTATE , :VCSTMOBILE ;

            EndDo;

            Exec Sql
              Close CstmPosition;

          End-Proc;

          //-----------------------------------------------------------//
          //ProcedureName-OrderManagement                              //
          //-----------------------------------------------------------//

          Dcl-Proc OrderManagement ;

            Cancel = *OFf;
            Dow Cancel = *Off ;

              OrdClrsubfile();
              OrdLoadsubfile();
              OrdDsplysubfile();


            EndDo;
            Cancel = *Off;

          End-Proc;

          //-----------------------------------------------------------//
          //ProcedureName-OrdClrsubfile                                //
          //Description-Procedure to Clear subfile                     //
          //-----------------------------------------------------------//

          Dcl-Proc OrdClrsubfile  ;

             ORrn = 0    ;
             OrdSflClr = *On ;
             Write ORDSFLCTL;
             OrdSflClr = *Off  ;

          End-Proc;

          //-----------------------------------------------------------//
          //ProcedureName-OrdLoadsubfile                               //
          //Description-Procedure to load subfile                      //
          //-----------------------------------------------------------//

          Dcl-Proc OrdLoadsubfile ;


            Exec sql
               Declare OrdCrsr Cursor For Select ODRID ,
               ODRCSTID , ODRCSTNAME , ODRTAMT , ODRDATE
               From ORDMGPF ;

            Exec sql
               Open OrdCrsr;

            Exec sql
               Fetch from Ordcrsr Into :DODRID , :DODRCSTID ,
               :DODRCSTNAM , :DODRTAMT , :DODRDATE ;


            Dow Sqlcod = 0 ;

             ORrn = ORrn + 1 ;
             If ORrn > 9999;
                Leave ;
                EndIf ;
                Write ORDMNGMNT ;

             Exec sql
              Fetch Next from Ordcrsr Into :DODRID , :DODRCSTID ,
              :DODRCSTNAM , :DODRTAMT , :DODRDATE ;

            Enddo;

            Exec sql
               Close Ordcrsr;

          End-Proc;

          //-----------------------------------------------------------//
          //ProcedureName-OrdDsplysubfile                              //
          //Description-Procedure to disply subfile                    //
          //-----------------------------------------------------------//

          Dcl-Proc OrdDsplysubfile;

            Dow Cancel = *Off;
               IndOvrly = *On ;
               OrdSflDsp = *On ;
               OrdSflDspCtl = *On ;
               OrdSflEnd = *On;

               If ORrn = 0;
                  IndOvrly = *Off;
                  OrdSflDsp = *Off;
               Endif;

               User = 'Admin';
               Write VIFOOTER ;
               Clear FLD ;
               Exfmt ORDSFLCTL;
               Select;

                When Cancel = *On;
                    IndOpt2 = *Off;
                    Clear Soption ;
                    Clear VIERROR ;
                    Clear OPOSITION;
                    leave;

                When Refresh = *ON ;
                    Refresh = *Off;
                    Clear VIERROR ;
                    Clear OPOSITION;
                    IndOpt2 = *Off;
                    IndSflNxtChg3 = *Off;
                    OrdRefreshLogic();

                When FLD = 'OPOSITION'  ;
                         OrdClrSubfile();

                        Select ;

                          When OPOSITION <> *Blank ;
                               OrdPositionToBy();

                          Other;

                           OrdLoadsubfile();

                        Endsl;

                When FLD = 'OPOSITION' And OPOSITION = *Blank ;
                    OrdClrsubfile();
                    OrdLoadsubfile();

                  Other;

                   OrdOptionLogic();

               EndSl;
            EndDo;

          End-Proc;

          //-----------------------------------------------------------//
          //ProcedureName-OrdPostionToBy                               //
          //Description-Procedure to PositiontoBy                      //
          //-----------------------------------------------------------//
            Dcl-Proc OrdPositionToBy;

             Exec sql
               Declare OrdPosition Cursor for select
               ODRID , ODRCSTID , ODRCSTNAME , ODRTAMT ,
               ODRDATE from ORDMGPF Where
               ODRID Like '%' Concat Trim(:OPOSITION) Concat '%' Or
               ODRCSTID Like '%' Concat Trim(:OPOSITION) Concat '%';


           Exec Sql
             Open OrdPosition;

           Exec Sql
             Fetch From OrdPosition Into :DODRID , :DODRCSTID ,
             :DODRCSTNAM , :DODRTAMT , :DODRDATE ;

           Dow Sqlcod = 0;

             ORrn = ORrn + 1;

             If ORrn > 9999;
              Leave;
             EndIf;

             Write ORDMNGMNT ;

           Exec Sql
             Fetch Next From OrdPosition Into :DODRID , :DODRCSTID ,
             :DODRCSTNAM , :DODRTAMT , :DODRDATE ;

           EndDo;

           Exec Sql
            Close OrdPosition;

          End-Proc;

          //-----------------------------------------------------------//
          //ProcedureName-OptionLogic                                  //
          //Description-Procedure for multipalOption                   //
          //-----------------------------------------------------------//

          Dcl-Proc OrdOptionLogic;

              Readc ORDMNGMNT ;
              Dow not %eof();
              IndSflNxtChg3 = *On;
              IndOpt2 = *Off;

              Select ;

                When SOption = 5;
                     Clear SOPTION ;
                     OrderedProduct();
                     IndOpt2 = *Off;

                When SOption <> 5  ;
                     VIERROR = 'Invalid Option';
                     IndOpt2 = *On;

                Other ;

                     Clear Soption ;
                     Clear VIERROR ;
                     IndOpt2 = *Off;
                     Return;

              Endsl;

                  Update ORDMNGMNT ;
                  Readc ORDMNGMNT;

             EndDo;

                 Clear SOption;
                 IndSflNxtChg3 = *Off;

          End-Proc;

          Dcl-Proc OrdRefreshLogic ;

            OrdClrsubfile();
            OrdLoadSubfile();
            OrdDsplySubfile();

          End-Proc;

          //Ordered Product Procedure
          Dcl-Proc OrderedProduct;

            Cancel = *OFf;
            Dow Cancel = *Off ;

              OrdPClrsubfile();
              OrdPLoadsubfile();
              OrdPDsplysubfile();


            EndDo;
            Cancel = *Off;

          End-Proc;

          //-----------------------------------------------------------//
          //ProcedureName-OrdPClrsubfile                                //
          //Description-Procedure to Clear subfile                     //
          //-----------------------------------------------------------//

          Dcl-Proc OrdPClrsubfile  ;

             OPRrn = 0    ;
             OrdPSflClr = *On ;
             Write ODRPSFLCTL;
             OrdPSflClr = *Off  ;

          End-Proc;

          //-----------------------------------------------------------//
          //ProcedureName-OrdLoadsubfile                               //
          //Description-Procedure to load subfile                      //
          //-----------------------------------------------------------//

          Dcl-Proc OrdPLoadsubfile ;


            Exec sql
               Declare OrdPCrsr Cursor For Select ODPDID ,
               ODRCSTID , ODRPDNAME , ODRUTPZ , ODRDATE
               From ORDMGPF Where ODRID = :DODRID;

            Exec sql
               Open OrdPCrsr;

            Exec sql
               Fetch from OrdPcrsr Into :DODPDID , :DODRCSTID ,
               :DODRPDNAME , :DODRUTPZ , :DODRDATE ;


            Dow Sqlcod = 0 ;

             OPRrn = OPRrn + 1 ;
             If OPRrn > 9999;
                Leave ;
                EndIf ;
                Write ODREDPD ;

             Exec sql
              Fetch Next from OrdPcrsr Into :DODPDID , :DODRCSTID ,
              :DODRPDNAME , :DODRUTPZ , :DODRDATE ;

            Enddo;

            Exec sql
               Close OrdPcrsr;

          End-Proc;

          //-----------------------------------------------------------//
          //ProcedureName-OrdDsplysubfile                              //
          //Description-Procedure to disply subfile                    //
          //-----------------------------------------------------------//

          Dcl-Proc OrdPDsplysubfile;

            Dow Cancel = *Off;
               OrdPSflDsp = *On ;
               OrdPSflDspCtl = *On ;
               OrdPSflEnd = *On;

               If OPRrn = 0;
                  OrdPSflDsp = *Off;
               Endif;

               User = 'Admin';
               OPDID = DODRID ;
               OPDCSTNAME = DODRCSTNAM;
               ORPDTAMT = TotalAmount(DODRID);
               Write VIFOOTER ;
               Exfmt ODRPSFLCTL;
               Select;

                When Cancel = *On;
                    IndOpt3 = *Off;
                    Clear Soption ;
                    Clear VIERROR ;
                    Clear OPPOSITION;
                    leave;

                When Refresh = *ON ;
                    Refresh = *Off;
                    Clear VIERROR ;
                    Clear OPPOSITION;
                    IndOpt3 = *Off;
                    IndSflNxtChg4 = *Off;
                    OrdPRefreshLogic();

                When FLD = 'OPPOSITION' ;
                         OrdPClrSubfile();

                        Select ;

                          When OPPOSITION <> *Blank ;
                               OrdPPositionToBy();

                          Other;

                           OrdPLoadsubfile();

                        Endsl;

                When FLD = 'OPPOSITION' And OPPOSITION = *Blank ;
                     OrdPClrsubfile();
                     OrdPLoadsubfile();

                Other;

                   OrdPOptionLogic();

               EndSl;
            EndDo;
          End-Proc;


       //-----------------------------------------------------------//
       //ProcedureName-OrdPOptionLogic                              //
       //Description-Procedure For Option logic                     //
       //-----------------------------------------------------------//
       Dcl-Proc OrdPOptionLogic;


            Readc ODREDPD ;
            Dow not %eof();
             IndSflNxtChg4 = *On;
             IndOpt3 = *Off;

             Select ;

             When SOption = 5;
                Clear SOPTION ;
                OrderedPd(DODPDID);
                IndOpt2 = *Off;

             When SOption <> 5  ;
                 VIERROR = 'Invalid Option';
                 IndOpt3 = *On;


             Other ;

              Clear Soption ;
              Clear VIERROR ;
              IndOpt3 = *Off;
              Return;

            Endsl;
             Update ODREDPD ;
             Readc ODREDPD;

           EndDo;
             Clear SOption;
             IndSflNxtChg4 = *Off;


          End-Proc;

          Dcl-Proc OrderedPd ;

            Dcl-Pi OrderedPd ;
              DODPDID char(6);
            End-Pi;

            Exec Sql
              Select ODRID , ODPDID , ODRCSTID , ODRPDNAME ,
                     ODRCSTNAME , ODRMOBILE , ODRADDRESS , ODRPDCLR ,
                     ODRBRAND , ODRQUNT , ODRUTPZ , ODRDATE ,
                     ODRTAMT  Into :SODRID , :SODPDID , :SODRCSTID ,
                     :SODRPDNAME , :SODRCSTNAM , :SODRMOBILE ,
                     :SODRADDRES , :SODRPDCLR , :SODRBRAND ,
                     :SODRQUNT , :SODRUTPZ , :SODRDATE , :SODRTAMT
                     From  ORDMGPF
                     Where ODPDID = :DODPDID ;

            Dow Cancel = *Off;

              Exfmt ORDERPROD  ;

              IF Cancel = *On;
                 Cancel = *Off;
                 Clear SOption;
                 Leave;
              EndIf;

            EndDo;

         End-Proc ;

         Dcl-Proc OrdPPositionToBy;

          Exec sql
            Declare OrdPPositionCrsr Cursor for select
            ODPDID , ODRCSTID , ODRPDNAME , ODRUTPZ , ODRDATE
            from ORDMGPF Where
            ODPDID Like '%' Concat Trim(:OPPOSITION) Concat '%' ;


          Exec Sql
             Open OrdPPositionCrsr;

          Exec Sql
             Fetch From OrdPPositionCrsr  Into :DODPDID , :DODRCSTID ,
             :DODRPDNAME , :DODRUTPZ , :DODRDATE ;

          Dow Sqlcod = 0;

              OPRrn = OPRrn + 1;

              If OPRrn > 9999;
               Leave;
              EndIf;

              Write ODREDPD ;

           Exec Sql
            Fetch Next From OrdPPositionCrsr  Into :DODPDID ,
            :DODRCSTID , :DODRPDNAME , :DODRUTPZ , :DODRDATE ;

          EndDo;

          Exec Sql
             Close OrdPPositionCrsr;

         End-Proc;


        //-----------------------------------------------------------//
        //ProcedureName-OrdPRefreshLogic                             //
        //Description-Procedure For Refresh logic                    //
        //-----------------------------------------------------------//
        Dcl-Proc OrdPRefreshLogic ;

          OrdPClrsubfile();
          OrdPLoadSubfile();
          OrdPDsplySubfile();

        End-Proc ;


        //-----------------------------------------------------------//
        //ProcedureName-TotalAmount                                  //
        //Description-Procedure For Total amount                     //
        //-----------------------------------------------------------//
        Dcl-Proc TotalAmount ;

          Dcl-Pi TotalAmount Packed(5);
            DODRID  CHAR(6);
          End-Pi;
          Dcl-S ResultAmount Packed(5);

          Exec Sql
          Select Sum(ODRTAMT) Into :ResultAmount from ORDMGPF
          Where ODRID = :DODRID ;


          Return ResultAmount;

        End-Proc;

        //-----------------------------------------------------------//
        //ProcedureName-VenderReport                                 //
        //Description-Procedure For Vender report (option=5)         //
        //-----------------------------------------------------------//
        Dcl-Proc VenderReport ;

             Dow  Cancel = *Off ;
                RPClrsubfile();
                RPLoadsubfile();
                RPDsplysubfile();
             EndDo;
             Cancel = *Off;

        End-Proc;

        //-----------------------------------------------------------//
        //ProcedureName-RPClrsubfile                                 //
        //Description-Procedure For Clear subfile                    //
        //-----------------------------------------------------------//
        Dcl-Proc RPClrsubfile  ;

             RPRrn =0    ;
             RPSflClr = *On ;
             Write RPSFLCTL;
             RPSflClr = *Off  ;

        End-Proc;

        //-----------------------------------------------------------//
        //ProcedureName-RPLoadsubfile                                //
        //Description-Procedure For Load  subfile                    //
        //-----------------------------------------------------------//
        Dcl-Proc RPLoadsubfile ;


          Exec sql
            Declare RPCrsr Cursor For Select VNDID ,
            VNDNAME , PRODTYPE , DOR
            From VNDDTLPF ;

          Exec sql
            Open RPcrsr;

          Exec sql
           Fetch from RPcrsr Into :RVNDID , :RVNDNAME,
           :RPRODTYPE , :RDOR  ;


          Dow Sqlcod = 0 ;

            RPRrn = RPRrn + 1 ;

            If  RPRrn > 9999;
            Leave ;
            EndIf ;
            Write REPORTMG ;

          Exec sql
           Fetch Next from RPcrsr Into :RVNDID , :RVNDNAME,
           :RPRODTYPE , :RDOR  ;

          Enddo;

          Exec sql
             Close RPcrsr;

          End-Proc;

          //-----------------------------------------------------------//
          //ProcedureName-RPLoadsubfile                                //
          //Description-Procedure For Load  subfile                    //
          //-----------------------------------------------------------//
          Dcl-Proc RPDsplysubfile;

          Dow Cancel = *Off;
            IndOvrly = *On ;
            RPSflDsp = *On ;
            RPSflDspCtl = *On ;
            RPSflEnd = *On;

          If  RPRrn = 0;
              IndOvrly = *Off;
              RPSflDsp = *Off;
          Endif;

          User = 'Admin';
          Write VIFOOTER ;
          Exfmt RPSFLCTL;
          Clear VIError;
          Reset IndFromDate;
          Reset IndToDate;
          DateRangeValidation();

            Select;

               When Cancel = *On;
                    IndOpt4 = *Off;
                    Clear Soption ;
                    Clear VIERROR ;
                    Clear RMPOSITION;
                    Clear FromDate;
                    Clear ToDate;
                    leave;

               When Refresh = *ON ;
                    Refresh = *Off;
                    Clear VIERROR ;
                    Clear RMPOSITION;
                    Clear FromDate;
                    Clear ToDate;
                    IndOpt4 = *Off;
                    IndSflNxtChg5 = *Off;
                    RPRefreshLogic();

               When FLD = 'RMPOSITION'  ;
                        RPClrsubfile();

                    Select ;

                      When RMPOSITION <> *Blank ;
                           RPPostionToBy();

                      Other;
                        RPLoadsubfile();

                    Endsl;

               When FLD = 'RMPOSITION' And RMPOSITION = *Blank ;
                   RPClrsubfile();
                   RPLoadsubfile();


               When (FLD = 'FROMDATE' And (%Char(FROMDATE)
               <> '0001-01-01' And %Char(TODATE) <> '0001-01-01'))
               OR (FLD = 'TODATE' And ( %Char(FROMDATE)
               <> '0001-01-01' And %Char(TODATE) <> '0001-01-01') );

              // When FLD = 'FROMDATE' And FLD = 'TODATE' ;
                    RPClrsubfile();

                    Select ;

                     When %Char(FROMDATE) <> '0001-01-01'
                     And %Char(TODATE) <> '0001-01-01';
                     LoadDateFilterSubfile();

                     Other;
                        RPLoadsubfile();

                    Endsl;

               Other;

                   RPOptionLogic();

             EndSl;
          EndDo;

          End-Proc;

          //-----------------------------------------------------------//
          //ProcedureName-RPRefreshLogic                               //
          //Description-Procedure For Refresh File                     //
          //-----------------------------------------------------------//
          Dcl-Proc RPRefreshLogic;

            RPClrsubfile();
            RPLoadsubfile();
            RPDsplysubfile();

          End-Proc;

          //-----------------------------------------------------------//
          //ProcedureName-RPPostionToBy                                //
          //Description-Procedure For Positionto                       //
          //-----------------------------------------------------------//
          Dcl-Proc RPPostionToBy;

            Exec sql
              Declare RPCrsrPosition Cursor for select
              VNDID , VNDNAME , PRODTYPE , DOR
              from VNDDTLPF Where
              VNDID Like '%' Concat Trim(:RMPOSITION) Concat '%' ;


           Exec Sql
              Open RPCrsrPosition ;

           Exec Sql
              Fetch From RPCrsrPosition Into :RVNDID , :RVNDNAME ,
              :RPRODTYPE , :RDOR ;

           Dow Sqlcod = 0;

               RPRrn = RPRrn + 1;

               If RPRrn > 9999;
                Leave;
               EndIf;

               Write REPORTMG ;

            Exec Sql
                Fetch Next From RPCrsrPosition Into :RVNDID ,:RVNDNAME ,
                :RPRODTYPE , :RDOR ;

           EndDo;

           Exec Sql
              Close RPCrsrPosition;

           End-Proc ;

           //-----------------------------------------------------------//
           //ProcedureName-ReportLogic                                  //
           //Description-Procedure For Option Logic                     //
           //-----------------------------------------------------------//
           Dcl-Proc ReportLogic;

              Dcl-S HRRVNDID    Char(6);
              Dcl-S HRRVNDNAME  Char(10);
              Dcl-S HRRDOB      Date;
              Dcl-S HRRDOR      Date;
              Dcl-S HRRVEDGENDE Char(1);
              Dcl-S HRRPRODTYPE Char(15);
              Dcl-S HPRUNITSOLD Zoned(5);
              Dcl-S HPRSALES    Zoned(7);
              Dcl-S HRPPERFORM  Char(10);

             Exec Sql
                Select VNDID , VNDNAME , DOB , DOR , VNDGENDER ,
                PRODTYPE Into :HRRVNDID , :HRRVNDNAME , :HRRDOB ,
                :HRRDOR , :HRRVEDGENDE  , :HRRPRODTYPE
                FROM VNDDTLPF Where VndId = :RVNDID ;

             Exec Sql
                Select Sum(ODRQUNT) Into :HPRUNITSOLD from ORDMGPF
                Where ODRVNDID = :RVNDID ;

             Open VENDERRP;

             Exec Sql
                Select Sum(ODRTAMT) Into :HPRSALES From ORDMGPF Where
                ODRVNDID = :RVNDID ;

             Select ;
               When HPRSALES <= 30000 ;
                    HRPPERFORM = 'Bad';

               When HPRSALES > 30000 And HPRSALES < 50000;
                    HRPPERFORM = 'Average';

               When HPRSALES > 50000 And HPRSALES < 70000;
                    HRPPERFORM = 'Good';

               When HPRSALES > 70000;
                    HRPPERFORM = 'Excellent';

               EndSl;


             USERNAME = 'Admin';
             CURENTDATE = %date();
             CURENTTIME = %Time();

             RRVNDID     =  HRRVNDID   ;
             RRVNDNAME   =  HRRVNDNAME ;
             RRDOB       =  HRRDOB     ;
             RRDOR       =  HRRDOR     ;
             RRVNDGENDE  =  HRRVEDGENDE;
             RRPRODTYPE  =  HRRPRODTYPE;
             PRUNITSOLD  =  HPRUNITSOLD;
             PRSALES     =  HPRSALES   ;
             RPPERFORM   =  HRPPERFORM  ;

             Write Header1 ;
             Write Header6 ;
             Write Header2 ;
             Write Header7 ;
             Write Header3 ;
             Write Header8 ;
             Write Data1   ;
             Write Header9 ;
             Write Data2   ;
             Write Header10;
             Write Data3   ;
             Write Header11;
             Write Data4   ;
             Write Header12;
             Write Data5   ;

             Close VENDERRP;
             VIError = ' Report Generated Successfully';

          End-Proc;

          Dcl-Proc RPOptionLogic;

            Readc REPORTMG ;
            Dow not %eof();
             IndSflNxtChg5 = *On;
             IndOpt4 = *Off;

             Select ;

              When SOption = 5;
                      //open VENDERRP;
                     ReportLogic();
                 //ViewInvntry(SPDVNDRID);
                   IndOpt4  = *Off;
                Clear SOPTION ;

             When SOption <> 5  ;
                 VIERROR = 'Invalid Option';
                   IndOpt4  = *On;

             Other ;

              Clear Soption ;
              Clear VIERROR ;
              IndOpt4 = *Off;
              Return;

            Endsl;
             Update REPORTMG ;
             Readc REPORTMG;

           EndDo;
             Clear SOption;
             IndSflNxtChg5 = *Off;

          End-Proc;



          Dcl-Proc LoadDateFilterSubfile;

           Exec sql
            Declare DateCrsr Cursor for select
            VNDID , VNDNAME , PRODTYPE , DOR
            from VNDDTLPF Where DOR Between :FROMDATE and
            :TODATE ;


           Exec sql
            Open Datecrsr;

           Exec sql
            Fetch from Datecrsr Into :RVNDID , :RVNDNAME ,
            :RPRODTYPE , :RDOR ;


           Dow Sqlcod = 0 ;

            RPRrn = RPRrn + 1 ;

            If  RPRrn > 9999;
            Leave ;
            EndIf ;
            Write REPORTMG ;

           Exec sql
             Fetch Next from Datecrsr Into :RVNDID , :RVNDNAME ,
             :RPRODTYPE , :RDOR ;


           Enddo;

           Exec sql
             Close Datecrsr ;

          End-Proc;

          //-----------------------------------------------------------//
          //ProcedureName-ReportOnSale                                 //
          //Description-Procedure For Sale report                      //
          //-----------------------------------------------------------//
          Dcl-Proc SalesReport ;

             Dow  Cancel = *Off ;
               SRPClrsubfile();
               SRPLoadsubfile();
               SRPDsplysubfile();
             EndDo;
             Cancel = *Off;

           End-Proc;

        //-----------------------------------------------------------//
        //ProcedureName-SRPClrsubfile                                 //
        //Description-Procedure For Clear subfile                    //
        //-----------------------------------------------------------//
        Dcl-Proc SRPClrsubfile  ;

             SRPRrn = 0    ;
             SRPSflClr = *On ;
             Write PRTFSFLCTL ;
             SRPSflClr = *Off  ;

        End-Proc;

        //-----------------------------------------------------------//
        //ProcedureName-RPLoadsubfile                                //
        //Description-Procedure For Load  subfile                    //
        //-----------------------------------------------------------//
        Dcl-Proc SRPLoadsubfile;

          Exec Sql
            Declare SRPCrsr Cursor For Select ODRVNDID ,
            ODRPDNAME , ODRDLDT , ODRDATE
            From ORDMGPF  ;

          Exec Sql
            Open SRPcrsr;

          Exec sql
           Fetch from SRPcrsr Into :SODRVNDID , :SODRPDNAME,
           :SODRDLDT , :SODRDATE  ;


          Dow Sqlcod = 0 ;

            SRPRrn = SRPRrn + 1 ;

            If  SRPRrn > 9999;
            Leave ;
            EndIf ;
            Write SALEPRTF ;

          Exec sql
           Fetch Next from SRPcrsr Into :SODRVNDID , :SODRPDNAME,
           :SODRDLDT , :SODRDATE  ;

          Enddo;

          Exec sql
             Close SRPcrsr;

          End-Proc;

          //-----------------------------------------------------------//
          //ProcedureName-SRPDisplysubfile                             //
          //Description-Procedure For Disply subfile                   //
          //-----------------------------------------------------------//
          Dcl-Proc SRPDsplysubfile;

          Dow Cancel = *Off;
            IndOvrly = *On ;
            SRPSflDsp = *On ;
            SRPSflDspCtl = *On ;
            SRPSflEnd = *On;

          If  SRPRrn = 0;
              IndOvrly = *Off;
              SRPSflDsp = *Off;
          Endif;

          User = 'Admin';
          Write VIFOOTER ;
          Exfmt PRTFSFLCTL;
          Reset IndSLFromDate ;
          Reset IndSLToDate   ;
          Clear Vierror;
          SLDateRangeValidation();

            Select;

               When Cancel = *On;
                    IndOpt6 = *Off;
                    Clear Soption ;
                    Clear VIERROR ;
                    Clear SLPOSITION;
                    Reset IndSLFromDate ;
                    Reset IndSLToDate   ;
                    leave;

               When Refresh = *ON ;
                    Refresh = *Off;
                    Clear VIERROR ;
                    Clear SLPOSITION;
                    Clear Soption;
                    Clear SlFromDate;
                    Clear SLTodate;
                    IndOpt6 = *Off;
                    IndSflNxtChg7 = *Off;
                    SRPRefreshLogic();

               When FLD = 'SLPOSITION'  ;
                         SRPClrsubfile();

                      Select ;

                        When SLPOSITION <> *Blank ;
                             SRPPostionToBy();

                        Other;
                          SRPLoadsubfile();

                      Endsl;

               When (FLD = 'SLFROMDATE' And (%Char(SLFROMDATE)
               <> '0001-01-01' And %Char(SLTODATE) <> '0001-01-01'))
               OR (FLD = 'SLTODATE' And ( %Char(SLFROMDATE)
               <> '0001-01-01' And %Char(SLTODATE) <> '0001-01-01') );

               SRPClrsubfile();

               Select ;

                When %Char(SLFROMDATE) <> '0001-01-01'
                And %Char(SLTODATE) <> '0001-01-01' ;
                DateFilterSubfile();
                //SLDateRangeValidation();

                Other;
                   SRPLoadsubfile();

               EndSl;

               //When FLD = 'SLFROMDATE' OR FLD = 'SLTODATE';
               //     SLDateRangeValidation();

               Other;

                  SaleRPOptionLogic();

             EndSl;
            EndDo;

           End-Proc;

           Dcl-Proc SRPRefreshLogic;

             SRPClrsubfile();
             SRPLoadsubfile();
             SRPDsplysubfile();

           End-Proc;

           Dcl-Proc DateRangeValidation;

              If FLD = 'FROMDATE' OR FLD = 'TODATE' ;

              Select ;

                When %Char(FROMDATE) = '0001-01-01' And
                     %Char(ToDATE) = '0001-01-01' ;
                IndFromDate = *On;
                IndToDate = *On;
                VIERROR = 'FromDate And ToDate field should not be blank';

                When %Char(FROMDATE) = '0001-01-01' ;
                IndFromDate = *On;
                VIERROR = 'FromDate field should not be blank';

                When %Char(ToDATE) = '0001-01-01' ;
                IndToDate = *On;
                VIERROR = 'ToDate field should not be blank';

                When FromDate > ToDate ;
                IndFromDate = *On;
                VIERROR = 'ToDate field should not be lessthan FromDate';

                //When FromDate < ToDate ;
                //IndFromDate = *On;
                //VIERROR = 'ToDate field should not be lessthan FromDate';

              EndSl;
              EndIf;
          End-Proc;

          Dcl-Proc SRPPostionToBy;

            Exec sql
              Declare SaleRPCrsr Cursor for select
              ODRVNDID , ODRPDNAME , ODRDLDT , ODRDATE
              from ORDMGPF Where
              ODRVNDID Like '%' Concat Trim(:SLPOSITION) Concat '%' ;


           Exec Sql
              Open SaleRPCrsr ;

           Exec Sql
              Fetch From SaleRPCrsr Into :SODRVNDID , :SODRPDNAME ,
              :SODRDLDT , :SODRDATE ;

           Dow Sqlcod = 0;

              SRPRrn = SRPRrn + 1;

               If SRPRrn > 9999;
                Leave;
               EndIf;

               Write SALEPRTF ;

            Exec Sql
                 Fetch From SaleRPCrsr Into :SODRVNDID , :SODRPDNAME ,
                 :SODRDLDT , :SODRDATE ;

           EndDo;

           Exec Sql
              Close SaleRPCrsr;

          End-Proc ;

          Dcl-Proc DateFilterSubfile;

           Exec sql
            Declare SlDateCrsr Cursor for select
            ODRVNDID , ODRPDNAME , ODRDLDT , ODRDATE
            from ORDMGPF Where ODRDATE Between :SLFROMDATE
            and :SLTODATE ;


           Exec sql
            Open SLDatecrsr;

           Exec sql
            Fetch from SLDatecrsr Into :SODRVNDID , :SODRPDNAME ,
            :SODRDLDT , :SODRDATE ;


           Dow Sqlcod = 0 ;

            SRPRrn = SRPRrn + 1 ;

            If SRPRrn > 9999;
            Leave ;
            EndIf ;
            Write SALEPRTF ;

           Exec sql
             Fetch from SLDatecrsr Into :SODRVNDID , :SODRPDNAME ,
             :SODRDLDT , :SODRDATE ;


           Enddo;

           Exec sql
             Close SLDatecrsr ;

          End-Proc;

          Dcl-Proc SLDateRangeValidation;

              If FLD = 'SLFROMDATE' OR FLD = 'SLTODATE' ;

              Select ;

                When %Char(SLFROMDATE) = '0001-01-01' And
                     %Char(SLToDATE) = '0001-01-01' ;
                IndSLFromDate = *On;
                IndSLToDate = *On;
                VIERROR = 'FromDate And ToDate field should not be blank';

                When %Char(SLFROMDATE) = '0001-01-01' ;
                IndSLFromDate = *On;
                VIERROR = 'FromDate field should not be blank';

                When %Char(SLToDATE) = '0001-01-01' ;
                IndSLToDate = *On;
                VIERROR = 'ToDate field should not be blank';

                When SLFromDate > SLToDate ;
                IndSLFromDate = *On;
                VIERROR = 'ToDate field should not be lessthan FromDate';


              EndSl;
              EndIf;
          End-Proc;

          //SaleOptionLogic
          Dcl-Proc SaleRPOptionLogic ;

            Readc SALEPRTF ;
            Dow not %eof();
             IndSflNxtChg7 = *On;
             IndOpt6 = *Off;

             Select ;

              When SOption = 5;
                If %open(SALEREPORT) = *Off;
                  OPEN SALEREPORT;
                Endif;

                   SaleReportLogic(SODRVNDID);
                   IndOpt6  = *Off;
                   Clear SOPTION ;

             When SOption <> 5  ;
                  VIERROR = 'Invalid Option';
                  IndOpt6  = *On;

             Other ;

              Clear Soption ;
              Clear VIERROR ;
              IndOpt6 = *Off;
              Return;

            Endsl;
             Update SALEPRTF ;
             Readc SALEPRTF;

           EndDo;
             Clear SOption;
             IndSflNxtChg7 = *Off;

          End-Proc;

          Dcl-Proc SaleReportLogic;
          Dcl-pi SaleReportLogic;
             SODRVNDID Char(6);
          End-Pi;

             //Dcl-S SaleBrand Char(10);
             //Dcl-S SaleUnit  Zoned(6);
             //Dcl-S SaleAvgPrice  Zoned(6);
             //Dcl-S SaleTotSal Zoned(9);
             USERNAME   = 'Admin';
             CURRENTDT = %Date();
             SLODRVNDID = SODRVNDID;
             SLODRPDNAM = SODRPDNAME ;
             Write sHeader1 ;
             Write sHeader2 ;
             Write sHeader3 ;
             Write sHeader4 ;
             Write sHeader5 ;
             Write sHeader6 ;
             Write sHeader7 ;
             Write sHeader8;
             Write sHeader9;

             Exec Sql
                Declare SlRpCrsr Cursor for
                Select Odrbrand , Sum(ODRQUNT) , Avg(ODRUTPZ) ,
                Sum( ODRUTPZ * ODRQUNT ) as Totalsale from ORDMGPF
                Where ODRVNDID = :SODRVNDID  group by OdrBrand ;



             Exec sql
              Open SlRpCrsr;

             Exec sql
              Fetch from SlRpCrsr Into :SODRBRAND ,:SUNITSOLD ,
              :AVGPRICE , :TOTSAL ;

             Dow Sqlcod = 0 ;

              If Sqlcod = 100;
                 Leave;
              Endif;

              Write sHeader10;

              Exec sql
               Fetch Next from SlRpCrsr Into :SODRBRAND , :SUNITSOLD ,
               :AVGPRICE , :TOTSAL ;

             Enddo;

             Exec sql
                   Close SlRpCrsr ;

             Close SALEREPORT;
             VIError = ' Report Generated Successfully';

          End-Proc;

          Dcl-Proc ComplaintInformation;

           Cancel = *OFf;
           Dow  Cancel = *Off ;

            CMPClrsubfile();
            CMPLoadsubfile();
            CMPDsplysubfile();

           EndDo;
           Cancel = *Off;

          End-Proc;

          //Clear Subfile Procedure

          Dcl-Proc CMPClrsubfile  ;

             CMPRrn =0    ;
             CMPSflClr = *On ;
             Write COMPSFLCTL;
             CMPSflClr = *Off  ;

          End-Proc;

          //Load Subfile Procedure

          Dcl-Proc CMPLoadsubfile ;

          Exec sql
            Declare CMPCrsr Cursor For Select CMPID ,
            CMPCSTNAME , COMPTYPE , CMPDOS , CMPSTATUS
            From CMPPF ;

          Exec sql
            Open CMPCrsr;

          Exec sql
           Fetch from CMPCrsr Into :DCMPID , :DCMPCSTNAM ,
           :DCOMPTYPE , :DCMPDOS , :DCMPSTATUS ;


          Dow Sqlcod = 0 ;

            CMPRrn = CMPRrn + 1 ;

            If  CMPRrn > 9999;
            Leave ;
            EndIf ;
            Write COMPLAINSF;

          Exec sql
           Fetch Next from CMPCrsr Into :DCMPID , :DCMPCSTNAM ,
           :DCOMPTYPE , :DCMPDOS , :DCMPSTATUS ;


          Enddo;

          Exec sql
             Close CMPCrsr;

          End-Proc;

         //Display Subfile Procedure

          Dcl-Proc CMPDsplysubfile;

          Dow Cancel = *Off;
           IndOvrly1= *On ;
           CMPSflDsp = *On ;
           CMPSflDspCtl = *On ;
           CMPSflEnd = *On;

          If  CMPRrn = 0;
              IndOvrly1= *Off;
              CMPSflDsp = *Off;
          Endif;

          USERNAME = 'Admin';
          Write VIFOOTER ;
          Exfmt COMPSFLCTL;
          Select;

               When Cancel = *On;
                    IndOpt5 = *Off;
                    Clear Soption ;
                    Clear VIERROR ;
                    Clear CPOSITION;
                    leave;

               When Refresh = *ON ;
                    Refresh = *Off;
                    Clear VIERROR ;
                    Clear CPOSITION;
                    IndOpt5 = *Off;
                    IndSflNxtChg6 = *Off;
                    CMPRefreshLogic();

               When FLD = 'CPOSITION'  ;
                      CMPClrsubfile();

                      Select ;

                       When CPOSITION <> *Blank ;
                         CMPPostionToBy();

                       Other;
                         CMPLoadsubfile();

                      Endsl;


               Other;

               ComplaintOptionLogic();

          EndSl;
          EndDo;

          End-Proc;

          Dcl-Proc CMPRefreshLogic;

            CMPClrsubfile();
            CMPLoadsubfile();
            CMPDsplysubfile();

          End-Proc;

          Dcl-Proc CMPPostionToBy;

             Exec sql
              Declare CMPCrsrPosition Cursor for select
              CMPID , CMPCSTNAME , COMPTYPE , CMPDOS , CMPSTATUS
              from CMPPF Where
              CMPID like '%' Concat Trim(:CPOSITION) Concat '%' Or
              CMPCSTNAME Like '%' Concat Trim(:CPOSITION) Concat '%' Or
              CMPSTATUS  Like '%' Concat Trim(:CPOSITION) Concat '%' ;


             Exec Sql
                Open CMPCrsrPosition;

             Exec Sql
                Fetch From CMPCrsrPosition Into :DCMPID , :DCMPCSTNAM ,
                :DCOMPTYPE , :DCMPDOS , :DCMPSTATUS ;

             Dow Sqlcod = 0;

                 CMPRrn = CMPRrn + 1;

                 If CMPRrn > 9999;
                  Leave;
                 EndIf;

                 Write COMPLAINSF;

              Exec Sql
               Fetch Next From CMPCrsrPosition Into :DCMPID ,
                 :DCMPCSTNAM , :DCOMPTYPE , :DCMPDOS , :DCMPSTATUS ;

             EndDo;

             Exec Sql
                Close CMPCrsrPosition;

           End-Proc;


           Dcl-Proc ComplaintOptionLogic;

            Readc COMPLAINSF ;
            Dow not %eof();
             IndSflNxtChg6 = *On;
             IndOpt5 = *Off;

             Select ;

             When SOption = 5;
                ViewComplaintInformation(DCmpId);
                IndOpt5  = *Off;
                Clear SOPTION ;

             When SOption <> 5  ;
                 VIERROR = 'Invalid Option';
                 IndOpt5  = *On;


             Other ;

              Clear Soption ;
              Clear VIERROR ;
              IndOpt5 = *Off;
              Return;

            Endsl;
             Update COMPLAINSF;
             Readc COMPLAINSF;

           EndDo;
             Clear SOption;
             IndSflNxtChg6 = *Off;


          End-Proc;


          Dcl-Proc ViewComplaintInformation;

            Dcl-Pi ViewComplaintInformation ;
              DCMPID char(6);
            End-Pi;

            Exec Sql
              Select CMPID , CMPCSTID , CMPCSTNAME , CMPEMAIL ,
                     CMPDOS , COMPTYPE , CMPDESP , CMPSTATUS ,
                     CMPRSDATE Into :DCMPID ,
                     :DCMPCSTID , :DMPCSTNAME , :DCMPEMAIL ,
                     :DCMPDOS , :DCOMPTYPE , :DCMPDESP ,
                     :DCMPSTATUS , :DCMPRSDATE
                     From  CMPPF
                     Where CMPID = :DCMPID ;

            Dow Cancel = *Off;

              Exfmt COMPDETAIL ;

              IF Cancel = *On;
                 Cancel = *Off;
                 Clear SOption;
                 Leave;
              EndIf;

            EndDo;

          End-Proc;

          //-----------------------------------------------------------//
          //ProcedureName-ViewFeedBackDetails                          //
          //Description-Procedure to Having all detail related FDBack  //
          //-----------------------------------------------------------//

          Dcl-Proc ViewFeedBackDetails ;

           Cancel = *Off;
           Dow  Cancel = *Off ;

            FDClrSubfile();
            FDLoadSubfile();
            FDDsplySubfile();

           EndDo;
           Cancel = *Off;

          End-Proc;

          //-----------------------------------------------------------//
          //ProcedureName-FDClrsubfile                                 //
          //Description-Procedure to Clear Subfile                     //
          //-----------------------------------------------------------//

          Dcl-Proc FDClrsubfile  ;

             FDRrn =0    ;
             FDSflClr = *On ;
             Write FDBKSFLCTL;
             FDSflClr = *Off  ;

          End-Proc;

          //-----------------------------------------------------------//
          //ProcedureName-CMPLoadsubfile                               //
          //Description-Procedure to load  Subfile                     //
          //-----------------------------------------------------------//

          Dcl-Proc FDLoadsubfile ;

          Exec sql
            Declare FDCrsr Cursor For Select FDBACKID ,
            FDCSTNAME , FDTYPE , FDDOS , FDRATING
            From FDBackPf;

          Exec sql
            Open FDCrsr;

          Exec sql
           Fetch from FDCrsr Into :DFDBACKID , :DFDCSTNAME ,
           :DFDTYPE , :DFDDOS , :DFDRATING ;

          Dow Sqlcod = 0 ;

            FDRrn = FDRrn + 1 ;

            If  FDRrn > 9999;
            Leave ;
            EndIf ;
            Write FDBCKDTL;

          Exec sql
           Fetch Next from FDCrsr Into :DFDBACKID , :DFDCSTNAME ,
           :DFDTYPE , :DFDDOS , :DFDRATING ;


          Enddo;

          Exec sql
             Close FDCrsr;

          End-Proc;

         //Display Subfile Procedure

          Dcl-Proc FDDsplysubfile;

          Dow Cancel = *Off;
           IndOvrly = *On;
           FDSflDsp = *On ;
           FDSflDspCtl = *On ;
           FDSflEnd = *On;

          If  FDRrn = 0;
              FDSflDsp = *Off;
              IndOvrly = *Off;
          Endif;

          USERNAME = 'Admin';
          Write VIFOOTER ;
          Exfmt FDBKSFLCTL ;
          Select;

               When Cancel = *On;
                    IndOpt7 = *Off;
                    Clear Soption ;
                    Clear VIERROR ;
                    Clear FDPOSITION;
                    leave;

               When Refresh = *ON ;
                    Refresh = *Off;
                    Clear VIERROR ;
                    Clear FDPOSITION;
                    IndOpt7 = *Off;
                    IndSflNxtChg8 = *Off;
                    FDRefreshLogic();

               When FLD = 'FDPOSITION' ;
                      FDClrsubfile();

                      Select ;

                       When FDPOSITION <> *Blank ;
                         FDPostionToBy();

                       Other;
                         FDLoadsubfile();

                      Endsl;


               Other;

               FEEDBACKOptionLogic();

          EndSl;
          EndDo;

          End-Proc;

          Dcl-Proc FDRefreshLogic;

            FDClrsubfile();
            FDLoadsubfile();
            FDDsplysubfile();

          End-Proc;

          Dcl-Proc FDPostionToBy;

             Exec sql
              Declare FDCrsrPosition Cursor for select
              FDBACKID , FDCSTNAME , FDTYPE , FDDOS , FDRATING
              from FDBACKPF Where
              FDBACKID Like '%' Concat Trim(:FDPOSITION) Concat '%' Or
              FDCSTNAME Like '%' Concat Trim(:FDPOSITION) Concat '%' ;

             Exec Sql
                Open FDCrsrPosition;

             Exec Sql
              Fetch From FDCrsrPosition Into :DFDBACKID , :DFDCSTNAME ,
                :DFDTYPE , :DFDDOS , :DFDRATING ;

             Dow Sqlcod = 0;

                 FDRrn = FDRrn + 1;

                 If FDRrn > 9999;
                  Leave;
                 EndIf;

                 Write FDBCKDTL;

              Exec Sql
               Fetch Next From FDCrsrPosition Into :DFDBACKID ,
                 :DFDCSTNAME , :DFDTYPE , :DFDDOS , :DFDRATING ;

             EndDo;

             Exec Sql
                Close FDCrsrPosition;

           End-Proc;


           Dcl-Proc FeedBackOptionLogic;

            Readc FDBCKDTL ;
            Dow not %eof();
             IndSflNxtChg8 = *On;
             IndOpt7 = *Off;

             Select ;

             When SOption = 5;
                ViewFeedBackInformation(DFDBACKID);
                IndOpt7  = *Off;
                Clear SOPTION ;

             When SOption <> 5  ;
                 VIERROR = 'Invalid Option';
                 IndOpt7  = *On;

             Other ;

              Clear Soption ;
              Clear VIERROR ;
              IndOpt7 = *Off;
              Return;

            Endsl;
             Update FDBCKDTL;
             Readc FDBCKDTL ;

           EndDo;
             Clear SOption;
             IndSflNxtChg8 = *Off;


          End-Proc;


          Dcl-Proc ViewFeedBackInformation;

            Dcl-Pi ViewFeedBackInformation ;
             DFDBACKID Char(6);
            End-Pi;

            Exec Sql
              Select FDBACKID , FDCSTID , FDCSTNAME ,FDPDID ,
                     FDPDNAME , FDPDCTGORY , FDEMAIL , FDDESP ,
                     FDDOS , FDRATING , FDTYPE
                     Into
                     :VFDBACKID , :VFDCSTID , :VFDCSTNAME , :VFDPDID ,
                     :VFDPDNAME , :VFDPDCTGOR , :VFDEMAIL , :VFDDESP ,
                     :VFDDOS , :VFDRATING , :VFDTYPE
                     From  FDBACKPF
                     Where FDBACKID = :DFDBACKID ;

            Dow Cancel = *Off;

              Exfmt VIEWFDBK ;

              IF Cancel = *On;
                 Cancel = *Off;
                 Clear SOption;
                 Leave;
              EndIf;

            EndDo;
          END-PROC;
