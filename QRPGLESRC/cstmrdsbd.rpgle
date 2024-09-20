     **Free

       Ctl-Opt Option(*Nodebugio:*Srcstmt) Nomain;

       Dcl-F Eheadscrn Workstn Indds(Indds1);

       Dcl-ds Indds1;

         Exit Ind pos(03);
         LogOut  Ind Pos(10);
         Refresh Ind pos(05);

       End-Ds ;

       Dcl-proc CstDb Export;

        LogOut = *Off;

        Dow LogOut = *Off;
         Exfmt CstmrDsbrd;
         Select;

          When LogOut = *On;
            LogOut = *Off;
            Leave;

         Endsl;
        Enddo;

       End-Proc;
