     **Free

       Ctl-Opt Option(*Nodebugio:*Srcstmt) Nomain;
       Dcl-F Eheadscrn Workstn Indds(Indds1);
       Dcl-F LoginPf Disk Usage(*Input:*Output:*Update) Keyed;
       Dcl-F VNDDTLPF Disk Usage(*Input:*Output:*Update) Keyed;

       Dcl-Ds IndDs1;

         Cancel Ind Pos(12);
         Prompt Ind Pos(04);
         Refresh Ind Pos(05);
         Insert Ind Pos(06);
         IndPass Ind Pos(26);
         IndCPass Ind Pos(27);
         Indname ind pos(28);
         Indstate ind pos(29);
         IndGender ind pos(31);
         Indgmail  ind pos(32);
         IndAddress ind pos(33);
         IndPdtype  ind pos(34);
         Indcompname ind pos(35);
         IndMob Ind Pos(36);
         Indpincode Ind Pos(37);
         Inddob Ind Pos(38);
         Indage Ind Pos(39);
         Inddor Ind Pos(40);
         IndSecAns Ind Pos(41);
         IndSecQ Ind Pos(42);

        End-ds;

       Dcl-S TodayDate Date ;
       Dcl-s NewUsrid Char(6);
       Dcl-s Formatpart Char(4);
       Dcl-S RegId Char(6);
       Dcl-S Id Zoned(4);
       Dcl-S InsChar Char(6);
       Dcl-S Result zoned(1);
       Dcl-S Result1 Zoned(2);
       Dcl-S Result2 Zoned(2);
       Dcl-S Result3 Zoned(2);
       Dcl-S Result4 Zoned(2);
       Dcl-S Result5 Zoned(2);
       Dcl-S Result6 Char(4);
       Dcl-S Result7 Char(4);
       Dcl-S Result8 Zoned(4);
       Dcl-S Len Zoned(2) ;
       Dcl-S Len1 Zoned(2) ;
       Dcl-S String Char(10) Inz('0123456789');
       Dcl-S String1 Char(26) Inz('ABCDEFGHIJKLMNOPQRSTUVWXYZ');
       Dcl-S String2 Char(36) Inz('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
       Dcl-S Count Zoned(5);
       Dcl-S Regex VarChar(50);

       Dcl-Pr SecurityPrompt Char(35);
        P_Question Char(35);
       End-Pr;

       Dcl-Pr StatePrompt Char(15);
        P_State Char(15);
       End-Pr;

        Exec Sql
         Set option commit = *None;

       Dcl-Proc NwVndrReg Export;

         Dow Cancel = *Off;
           IdAutoPopulate();
           NVCOUNTRY = 'India';
           NVDOR = %Date();
           Exfmt NEWVNDRREG ;

         Select;

           When Cancel = *On;
                Cancel = *Off;
                Clear NEWVNDRREG;
                ResetIndicator();
                Leave;

           When Refresh = *On;
                Refresh = *Off;
                Clear NEWVNDRREG;
                ResetIndicator();

           When FLD = 'NVGENDER' And Prompt = *On;
                Prompt = *Off;

                Dow Cancel = *Off;

                  Exfmt GENDEROPT ;

                    Select ;

                      When Gender = 1;
                          NVGENDER = 'M';

                      When Gender = 2 ;
                          NVGENDER = 'F';

                      When Gender = 3 ;
                          NVGENDER = 'O';

                    EndSl;
                  If Cancel = *On;
                     Cancel = *Off;
                     Reset GENDEROPT ;
                     Clear NCError;
                     ResetIndicator();
                     Leave;
                  EndIf;
                EndDo;

           When FLD = 'NVSTATE' And Prompt = *On;
                Prompt = *Off;
                NVSTATE = StatePrompt(NVSTATE);


           When FLD = 'SECQUES' And Prompt = *On;
                Prompt = *Off;
                SECQUES = SecurityPrompt(SECQUES);

           Other;

            DataPopulate();


         EndSl;

         EndDo;

         End-Proc;


         Dcl-Proc IdAutoPopulate ;
           Dcl-Pi IdAutoPopulate Char(6);
           End-Pi;

           Exec Sql
            Set option commit = *None;

           Exec Sql
             Select Max(VNDID) into :Regid from VNDDTLPF;
             VNDID = RegId;

             If VNDID = *blank;
                VNDID = 'VD0001';
                NVUSRID = VNDID ;
                Return NVUSRID ;

             Else;

                Id = %Int(%Subst( VNDID : 3 ));
                Id = Id + 1;
                Formatpart = %Editc( Id : 'X' );
                NewusrId = 'VD' + %Trimr(%Replace(Formatpart:'0':1));
                NVUSRID = NewusrId ;
                Return NVUSRID ;
             EndIf;

         End-Proc;

         Dcl-proc DataPopulate;

         //Dcl-S Encrypt Char(10);
         //Exec sql call qcmdExc('CHGJOB CCSID(37)');

            ResetIndicator();
            Clear NCERROR ;
            Validation();


            If NCERROR = *Blank And Insert = *On;
               Insert = *Off;

            Exec Sql
             Insert Into VNDDTLPF  ( VNDID , VNDNAME , VNDSTATE , VNDEMAIL ,
                                    VNDADDRESS , VNDGENDER , VNDMOBILE ,
                                    VNDCOUNTRY , VNDPINCODE ,
                                    PRODTYPE , COMPNAME , DOB , AGE , DOR )

               Values (:NVUSRID , :NVNAME , :NVSTATE , :NVGMAIL ,
                       :NVADDRESS , :NVGENDER , :NVMOBILE , :NVCOUNTRY ,
                       :NVPINCODE , :NVPDTYPE , :NVCOMP , :NVDOB ,
                       :NVAGE , :NVDOR ) ;

              //Exec Sql
              //     Select Systools.Base64Encode(:NVPASS) into :Encrypt
              //              From Sysimb.SysDummy1;

            Exec Sql
               Insert Into LogInPf ( LOGINID , PASSWORD , SCURITYQUE ,
                                     SCURITYANS , ROLE )
                    Values ( :VNDID , :NVCPASS , :SECQUES ,
                             :NVSECANS , 'vendor' );


             Insert = *Off;
             Clear NEWVNDRREG;
             NCERROR = 'Record Inserted Successfully' ;
            EndIf;


          End-Proc;

          Dcl-Proc ResetIndicator ;

            Refresh = *Off ;
            IndPass = *Off ;
            IndCPass = *Off ;
            Indname = *Off ;
            Indstate = *Off ;
            IndGender = *Off ;
            Indgmail  = *Off ;
            IndAddress = *Off ;
            IndPdtype  = *Off ;
            Indcompname = *Off ;
            IndMob = *Off ;
            Indpincode = *Off ;
            Inddob = *Off ;
            Indage = *Off ;
            Inddor = *Off ;
            IndSecAns = *Off ;
            IndSecQ = *Off;

          End-Proc;

          Dcl-Proc Validation;

             Dcl-s mailvalid varchar(100);
             Result = %Scan( '0' : %Char(NVMobile) : 1 );
             Len = %Len(%Trim(%Char(NVMobile)));
             Len1 = %Len(%Trim(%Char(NVPincode)));
             Result1 = %Check(String:%Char(NVMobile));
             Result2 = %Check(String:%Char(NVPincode));
             Result4 = %Check(String1:%Trim(NVName));
             Result5 = %Check(String2:%Trim(NVADDRESS));

             If %Char(NVDOB) <> '0001-01-01';
               Result6 = %Subst(%Char(NVDOB) : 1 : 4 );
               TodayDate = %Date();
               Result7 = %Subst(%char(TodayDate) : 1 : 4 );
               Result8 = %Int(Result7) - %Int(Result6);
               NVAGE = Result8 ;
             EndIf;

             Mailvalid = %Trim(NVGmail);
             Regex = '^(?:\w+\.?)*\w+@(?:\w+\.)*\w+$';

             Exec Sql
                 Set :Count = RegExp_Count(:mailvalid,:Regex);

             Select ;
             When NVPass = *Blank;
                NCError = ' Password field can not be blank';
                IndPass = *On;
                Return;

             When NVCPass = *Blank Or NVPass <> NVCPass ;
                  NCError = 'Both password field should be Same';
                  IndCPass = *On;
                  Return;

             When NVName = *Blank ;
                  NCError = ' Name field can not be blank';
                  IndName = *On;
                  Return;

             When Result4 <> 0;
                    NCError = 'Only Characters are allowed';
                    IndName = *On;
                    Return;

             When NVState = *Blank ;
                    NCError = ' State field can not be blank';
                    IndState = *On;
                    Return;

             When NVGender = *Blank ;
                     NCError = ' Gender field can not be blank';
                     IndGender = *On;
                     Return;

             When NVGmail = *Blank;
                     NCError = 'Email Field can not be blank';
                     IndGmail = *ON;
                     Return;

             When Count <> 1;
                       NCError = 'Invalid Email';
                       IndGmail = *ON;
                       Return;

             When  NVADDRESS = *Blank ;
                     NCError = ' Address field can not be blank';
                     IndAddress = *On;
                     Return;

             When  Result5 <> 0 ;
                     NCError = ' Special Characters are not allowed';
                     IndAddress = *On;
                     Return;

              When  SECQUES = *Blank;
                    NCError = ' Security Question field should not be blank';
                    IndSecQ = *On;
                    Return;



             When NVPdtype = *Blank ;
                     NCError = ' Product type field can not be blank ';
                     indPdtype = *On;
                     Return;

             When NVComp = *Blank;
                     NCError = ' Compnay name field should not be blank';
                     Indcompname = *On;
                     Return;

              When NVMobile = *Blank;
                   NCError = ' Mobile field can not be blank';
                   IndMob    = *On;
                   Return;

              When Result = 1 ;
                   NCError = ' Mobile number field should not strat with zero';
                   IndMob = *On;
                   Return;

              When Len < 10 ;
                   NCError = ' Mobile number should not Less than Ten';
                   IndMob = *On;
                   Return;



              When NVPincode = *Blank;
                       NCError = ' Pincode field can not be blank';
                       IndPincode = *On;
                       Return;

              When Len1 < 6 ;
                       NCError = ' Pincode field should not less than 6';
                       IndPincode = *On;
                       Return;

              When %Char(NVDOB) = *Blank;
                       NcError = ' Dob field  should not lbe blank';
                       Inddob  = *On;
                       Return;

              When NVAGE = 0;
                       NcError = ' Age field  should not lbe blank';
                       IndAge  = *On;
                       Return;

              When NVAGE <= 21 ;
                       NcError = 'Age should not be Lessthan 21';
                       IndAge  = *On;
                       Return;

              When %Char(NVDOR) = '0001-01-01';
                       NcError = 'DOR field  should not lbe blank';
                       IndDor  = *On;
                       Return;

              When NVSECANS = *Blank;
                   NcError = ' Security Answer field  should not be blank';
                       IndSecAns = *On;
                       Return;

              EndSl;
            End-Proc;
