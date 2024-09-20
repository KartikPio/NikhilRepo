**Free

  Ctl-Opt Option(*Nodebugio:*Srcstmt) Nomain;


  Dcl-F LoginPf Disk Usage(*Input:*Output:*Update) Keyed;
  Dcl-F CSTDTLPF Disk Usage(*Input:*Output:*Update) Keyed;


  Dcl-F Eheadscrn Workstn Indds(Indds1);

  Dcl-Ds IndDs1;

    Cancel Ind Pos(12);
    Prompt Ind Pos(04);
    Refresh Ind Pos(05);
    Insert Ind Pos(06);
    WrongPass Ind Pos(27);
    CnfPass ind Pos(28);
    Indname ind pos(29);
    Indstate ind pos(30);
    Indgmail ind pos(31);
    Indaddress ind pos(32);
    Indgender  ind pos(33);
    Indcity ind pos(34);
    Indmobile  ind pos(35);
    Indpincode ind pos(37);
    IndSecurity Ind Pos(38);
    IndSecQ Ind Pos(39);

  End-Ds;

  Dcl-s NewUsrid Char(6);
  Dcl-s Formatpart Char(4);
  Dcl-S Result zoned(1);
  Dcl-S Result1 Zoned(2);
  Dcl-S Result2 Zoned(2);
  Dcl-S Result3 Zoned(2);
  Dcl-S Result4 Zoned(2);
  Dcl-S Result5 Zoned(2);
  Dcl-S Len Zoned(2) ;
  Dcl-S Len1 Zoned(2) ;
  Dcl-S String Char(10) Inz('0123456789');
  Dcl-S String1 Char(26) Inz('ABCDEFGHIJKLMNOPQRSTUVWXYZ');
  Dcl-S String2 Char(36) Inz('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
  Dcl-S RegId Char(6);
  Dcl-S Id Zoned(4);
  Dcl-S InsChar Char(6);
  Dcl-S Encrypt Char(10);

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

  Dcl-Proc NewCstmReg Export;

    Dow Cancel = *Off;
      IdAutoPopulate();
      CnCountry = 'India';
      Exfmt NewCstReg;

    Select;
      When Cancel = *On;
           Cancel = *Off;
           Clear NEWCSTREG ;
           ResetIndicator();
           Leave;

      When Refresh = *On;
           Refresh = *Off;
           Clear NEWCSTREG ;
           ResetIndicator();

      When FLD = 'CNGENDER' And Prompt = *On;
           Prompt = *Off;

           Dow Cancel = *Off;

             Exfmt GENDEROPT ;

             Select ;

               When Gender = 1;
                   CnGender = 'M';

               When Gender = 2 ;
                   CnGender = 'F';

               When Gender = 3 ;
                   CnGender = 'O';

             EndSl;

             If Cancel = *On;
                Cancel = *Off;
                Clear NCError;
                ResetIndicator();
                Leave;
             Endif;

           EndDo;

      When FLD = 'SECQUE' And Prompt = *On;

           Prompt = *Off;

           SECQUE = SecurityPrompt(SECQUE);

      When FLD = 'CNSTATE' And Prompt = *On;
           Prompt = *Off;

           CNSTATE = StatePrompt(CnState);

      Other;

       DataPopulate();

    Endsl;

    Enddo;

  End-Proc;

  Dcl-Proc IdAutoPopulate ;
    Dcl-Pi IdAutoPopulate Char(6);
    End-Pi;

    Exec Sql
     Set option commit = *None;

    Exec Sql
      Select Max(CSTID) into :RegId from CSTDTLPF;
      CstId = RegId;
      If CstId = *blank;
      CstId = 'CT0001';
      CNUsrId = Cstid ;
      Return CNUsrId ;

      Else;

      Id = %Int(%Subst( CstId : 3 ));
      Id = Id + 1;
      Formatpart = %Editc( Id : 'X' );
      NewusrId = 'CT' + %Trimr(%Replace(Formatpart:'0':1));
      CnUsrId = NewusrId ;
      Return CNUsrId ;
      EndIf;

   End-Proc;

   Dcl-proc DataPopulate;

     Exec sql call qcmdExc('CHGJOB CCSID(37)');

     ResetIndicator();
     Clear NCERROR ;
     Validation();


     If NCERROR = *Blank And Insert = *On;


     Exec Sql
      Insert Into CstDtlPf  ( CSTID , CSTNAME , CSTSTATE , CSTGMAIL ,
                             CSTADDRESS , CSTGENDER , CSTCITY ,
                             CSTMOBILE , CSTCOUNTRY , CSTPINCODE )
        Values ( :CNUSRID , :CNNAME , :CNSTATE , :CNGMAIL ,
                :CNAddress , :CNGender , :CNCity , :CNMobile ,
                :CNCountry , :CNPINCODE );

       Exec sql
          SELECT SYSTOOLS.BASE64ENCODE(:CNCPASS) into :Encrypt
                 from SYSIBM.SYSDUMMY1  ;
     Exec Sql
        Insert Into LogInPf ( LOGINID , PASSWORD , SCURITYQUE ,
                              SCURITYANS , ROLE )
             Values ( :CNUSRID , :Encrypt , :SECQUE ,
                      :CNSECURITY , 'customer' );

      Insert = *Off;
      Clear NEWCSTREG ;
      NCERROR = 'Record Inserted Successfully' ;
     EndIf;


   End-Proc;

   Dcl-Proc ResetIndicator;

     WrongPass = *Off;
     CnfPass = *Off;
     IndName = *Off;
     IndState = *Off;
     IndGmail = *Off;
     IndAddress = *Off;
     IndGender = *Off;
     IndCity = *Off;
     IndMobile = *Off;
     Indpincode = *Off;
     IndSecurity = *Off;
     IndSecQ = *Off;

   End-Proc;

   Dcl-Proc Validation ;

   Dcl-s mailvalid varchar(100);

     Result = %Scan( '0' : %Char(CNMobile) : 1 );
     Len = %Len(%Trim(%Char(CnMobile)));
     Len1 = %Len(%Trim(%Char(CnPincode)));
     Result1 = %Check(String:%Char(CNMobile));
     Result2 = %Check(String:%Char(CNPincode));
     Result3 = %Check(String1:%Trim(CNCity));
     Result4 = %Check(String1:%Trim(CNName));
     Result5 = %Check(String2:%Trim(CNAddress));

     mailvalid = %Trim(cngmail);
     Regex = '^(?:\w+\.?)*\w+@(?:\w+\.)*\w+$';


     Exec Sql
         Set :Count = RegExp_Count(:mailvalid,:Regex);


     If CNPass = *Blank;
        NCError = ' Password field can not be blank';
        WrongPass = *On;
        Return;

     ElseIf CNCPass = *Blank Or CNPass <> CNCPass ;
            NCError = 'Password and confirm password field should be same';
            CnfPass = *On;
            Return;

     ElseIf CNName = *Blank ;
            NCError = ' Name field can not be blank';
            IndName = *On;
            Return;

     ElseIf Result4 <> 0;
            NCError = 'Only Characters are allowed';
            IndName = *On;
            Return;

     ElseIf CNState = *Blank ;
            NCError = ' State field can not be blank';
            IndState = *On;
            Return;

     Elseif CNGmail= *Blank ;
            NCError = ' Email field can not be blank';
            IndGmail = *On;
            Return;

     ElseIf Count <> 1 ;
            NCError = 'Invalid Email';
            IndGmail = *On;
            Return;



     Elseif CNAddress = *Blank ;
            NCError = ' Address field can not be blank';
            IndAddress = *On;
            Return;

     Elseif Result5 <> 0 ;
            NCError = ' Special Characters are not allowed';
            IndAddress = *On;
            Return;

     ElseIf SECQUE = *Blank;
            NCError = ' Security Question field can not be blank';
            IndSecQ = *On;
            Return;

     ElseIf CNGender = *Blank ;
            NCError = ' Gender field can not be blank';
            IndGender = *On;
            Return;

     Elseif CNCity = *Blank ;
            NCError = ' City field can not be blank';
            IndCity = *On;
            Return;

     ElseIf Result3 <> 0;
            NCError = 'Only Characters are allowed';
            IndCity = *On;
            Return;

     Elseif CNMobile = 0;
            NCError = ' Mobile field can not be blank';
            IndMobile = *On;
            Return;

     ElseIf Result = 1 ;
            NCError = ' Mobile number field should not strat with zero';
            IndMobile = *On;
            Return;

     ElseIf Len < 10 ;
            NCError = ' Mobile number should not Less than Ten';
            IndMobile = *On;
            Return;

     ElseIf Result1 <> 0;
            NCError = ' Character should not be in this field';
            IndMobile = *On;
            Return;

     ElseIf CNPincode = 0;
            NCError = ' Pincode field can not be blank';
            IndPincode = *On;
            Return;

     ElseIf Len1 < 6 ;
            NCError = ' Pincode field should not less than 6';
            IndPincode = *On;
            Return;

     ElseIf Result2 <> 0;
            NCError = ' Character should not be in this field';
            IndPincode = *On;
            Return;

     ElseIf CNPass <> CNCPass ;
            NCError = 'Password and confirm password field should be same';
            CnfPass = *On;
            Return;

     ElseIf CnSecurity = *Blank;
            NCError = ' Security Answer field Should not be blank';
            IndSecurity = *On;
            Return;

     Else;

           ResetIndicator();
           Clear NCERROR ;
      EndIf;

   End-Proc;
