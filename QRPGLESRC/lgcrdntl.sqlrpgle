     **Free
       //----------------------------------------------------------------------
       // Created By..........: Programmers.io @ 2024
       // Created Date........: 2024/07/24
       // Developer...........: Nikhil Sankhla
       // Description.........: Module for LogIn credentioal
       //----------------------------------------------------------------------
       // MODIFICATION LOG:
       //----------------------------------------------------------------------
       // Date    | Mod_ID  | Developer  | Case and Description
       //----|---------|------------|------------------------------------------
       // 24/07/24|         | Nikhil S   | Program Creation

       Ctl-Opt Option(*Nodebugio:*Srcstmt) Nomain;
       Dcl-F LoginPf Disk Usage(*Input:*Output:*Update) Keyed;

       Dcl-F Eheadscrn Workstn Indds(Indds1);
        Dcl-Ds Indds1;

          LId Ind pos(25);
          LPass Ind Pos(26);

        End-Ds ;

       Dcl-s Encrypt1 Char(10);
       Dcl-s encrptPass Char(10);

       Dcl-S pass Char(10);
       Dcl-S role1 Char(10);

       Dcl-Pr AdminDb;
       End-Pr;

       Dcl-Pr VndrDb;
       End-Pr;

       Dcl-Pr CstDb;
       End-Pr;

       Dcl-Proc Login export;


       Dcl-Pi Login Likeds(ErMsg);
        P_LoginId Char(6);
        p_Loginpass char(10);
       End-Pi;

       Dcl-Ds ErMsg Qualified;
         LginError Char(70);
         Indicator Ind;
         Indicator1 ind;
         LRole Char(10);
         LPas  Char(10);
         P_encrypt Char(10);
         L_pass char(10);
         //VndID Char(6)    ;
       End-Ds;


       Exec Sql
        Set option commit = *None;

       Select ;

        When P_LoginId = *Blank;

          ErMsg.LginError = 'Login Id can not be blank';
          ErMsg.Indicator = *On;
          Return ErMsg ;


        When p_Loginpass = *Blank ;

          ErMsg.LginError = 'Password field can not be blank';
          ErMsg.Indicator1 = *On;
          Return ErMsg;


       Other;

        Exec sql
         Select PASSWORD , ROLE into :pass ,:role1
         from Loginpf Where LOGINID = :P_LoginId;

          Exec Sql
               Select Systools.Base64Encode(:p_Loginpass) into :Encrypt1
                        From Sysibm.SysDummy1;


         If Sqlcod = 0 ;
         //ErMsg.VndId = P_LoginId ;
         Clear LgPass;
         Clear LgInId;
         ErMsg.LginError = *Blank;
         ErMsg.Indicator = *Off;
         ErMsg.LRole = Role1;
         ErMsg.LPas  = Pass ;
         ErMsg.P_encrypt = Encrypt1 ;
         ErMsg.L_pass = Pass ;

           If Encrypt1 <> Pass ;

            ErMsg.LginError = 'Wrong Password';
            ErMsg.Indicator1 = *On;
            Return ErMsg;

           EndIf;


         Else;

          ErMsg.LginError = 'Wrong loginid';
          ErMsg.Indicator = *On;
          Return ErMsg;

         EndIf;

       Return ErMsg;

       Endsl;
       ErMsg.LginError = *Blanks;
       Return ErMsg.LginError;
       Return ErMsg.LRole;
       Return ErMsg.LPas ;
       Return ErMsg.P_encrypt ;
       Return ErMsg.L_Pass ;
       //Return ErMsg.VndId  ;

       End-Proc;
