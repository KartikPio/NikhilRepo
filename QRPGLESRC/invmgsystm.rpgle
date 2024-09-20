     **Free
        //----------------------------------------------------------------------
        // Created By..........: Programmers.io @ 2024
        // Created Date........: 2024/07/24
        // Developer...........: Nikhil Sankhla
        // Description.........: Module To Load Airline Subfile(Admin)
        //----------------------------------------------------------------------
        // MODIFICATION LOG:
        //----------------------------------------------------------------------
        // Date    | Mod_ID  | Developer  | Case and Description
        //----|---------|------------|------------------------------------------
        // 24/07/24|         | Nikhil S   | Program Creation

       Ctl-Opt Option(*Nodebugio:*Srcstmt);
       Ctl-Opt BndDir('EHEADLIB/MAINBNDDIR');
       Dcl-F EheadScrn Workstn Indds(Indds1);

       Dcl-ds Indds1;

         Exit Ind pos(03);
         Cancel Ind Pos(12);
         NewCst Ind Pos(07);
         NewVndr Ind Pos(08);
         FgPass Ind Pos(04);
         Refresh Ind pos(05);
         LId Ind pos(25);
         LPass Ind Pos(26);

       End-ds ;

        Dcl-s encrpt Char(10);
        Dcl-s C_encrpt Char(10);


         Dcl-Pr NewCstmReg
         End-Pr;

         Dcl-Pr NwVndrReg
         End-Pr;

         Dcl-Pr AdminDb;
         End-Pr;

         Dcl-Pr VndrDb;
           VndId Char(6);
         End-Pr;

         Dcl-Pr CstDb;
         End-Pr;

         Dcl-Pr ForgtPassword;
         End-Pr;


        Dcl-S LginRole Char(10);
        Dcl-S LginPass Char(10);


        Dcl-Pr Login LikeDs(ErMsg);
         P_Loginid char(6);
         P_LoginPass char(10);
        End-Pr;

       Dcl-Ds ErMsg Qualified;
         LginError Char(70);
         Indicator  Ind Inz(*Off);
         Indicator1 Ind Inz(*Off);
         LRole Char(10);
         LPas  Char(10);
         Epass Char(10);
         P_encrypt Char(10);
         L_Pass char(10);
         //VndId Char(6) ;

       End-Ds;
       Dcl-S VndId Char(6);

       Dow Exit = *Off;

        Exfmt LoginScrn ;
        Clear LgError;


        Select ;

         When Refresh = *On;
          Reset ErMsg.Indicator ;
          Reset ErMsg.Indicator1 ;
          Clear LoginScrn;

         When FgPass = *On;
              FgPass = *Off;
              ForgtPassword();

         When NewCst = *On;
              NewCst = *Off;
              NewCstmReg();

         When NewVndr = *On;
              NewVndr = *Off;
              NwVndrReg();

        Other;
          ErMsg   = Login(lginid:lgpass);
          Lgerror = Ermsg.LginError ;
          Lid= ErMsg.Indicator ;
          LPass = ErMsg.Indicator1;
          LginPass = ErMsg.LPas ;
          LginRole = ErMsg.Lrole ;
          Encrpt = ErMsg.P_encrypt;
          C_encrpt = ErMsg.L_Pass;
          //VndId = ErMsg.VndId;

          If LginPass <> *Blank and LginRole <> *Blank;

          Select;

             When LginPass = LgPass And LginRole = 'admin';
              AdminDb();
              Clear LgInId;
              Clear LgPass;
              Clear LGERROR ;

             When LginPass = LgPass and LginRole = 'vendor';
              VndrDb(lginid);
              Clear LgInId;
              Clear LgPass;
              Clear LGERROR;

             When Encrpt = LginPass and LginRole = 'customer';
              CstDb();
              Clear LgInId;
              Clear LgPass;
              Clear LGERROR ;

          EndSl;

          EndIf;


        Endsl;


       Enddo;

       *Inlr=*On;
