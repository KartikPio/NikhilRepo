     **Free

       Ctl-Opt Option(*Nodebugio:*Srcstmt) Nomain;

       Dcl-F EHEADADMIN Workstn Indds(Indds1);
       Dcl-F LOGINPF Disk Usage(*Input:*Output:*Update) Keyed;

       Dcl-Ds Indds1;

         Cancel Ind pos(12);
         IndCid Ind Pos(31);
         IndCPass Ind Pos(32);
         IndCNPass Ind Pos(33);
         IndCCpass ind Pos(34);

       End-ds ;

       Dcl-S C_Id Char(6);
       Dcl-S C_PASS Char(10);

       Dcl-Proc ChangePasswordFunction export ;

          Dow Cancel = *Off;

             Exfmt CGPASSSCRN;

           Select ;

             When Cancel = *On;
                 Cancel = *Off;
                 ResetIndicator();
                 Clear CGPASSSCRN ;
                 Leave;

             Other;

                 Chngpasslogic();

           Endsl;

          EndDo;

       End-Proc;

       Dcl-Proc Chngpasslogic;

         ResetIndicator();
         Exec Sql
         Select Password Into :C_Pass
         from LoginPf Where LogInId = :ClgId;

         Select ;


           When ClGId <> *Blank;
             Exec Sql
              Select LOGINID Into :C_Id
              from LoginPf Where LogInId = :ClgId;

           If Sqlcod = 0;


            If CLGID = *Blank;
               Cerror = 'Id Field should not be blank';
               IndCid = *On;
               Return;

            ElseIf CCPASS = *Blank;
                Cerror = 'Passroed Field should not be blank';
                IndCPass = *On;
                Return;

            ElseIf CCPASS <> C_Pass ;
                   Cerror = 'Invalid Password';
                   IndCPass = *On;
                   Return;


            ElseIf CNPASSWRD = *Blank;
                Cerror = 'New Password Field should not be blank';
                IndCNPass = *On;
                Return;

            ElseIf CCNFMPASS = *Blank;
                Cerror = 'Confirm Password Field should not be blank';
                IndCCpass = *On;
                Return;

            ElseIf  CNPASSWRD <>  CCNFMPASS ;
                 Cerror = 'Both Password Field should be same';
                 IndCCpass = *On;
                 Return;

            Else;

              ResetIndicator();
              Clear CError;

              Exec Sql
                Update LOGINPF set PASSWORD=:CCNFMPASS
                Where LogInId=:CLGID ;

              Clear CGPASSSCRN ;
              CError = 'Password Successfully Changed';

            EndIf;

           Else ;
             Cerror = 'Invalid LogInId';
             IndCid = *On;
             Return;

           EndIf;

          When CLGID = *Blank;
            Cerror = 'Id Field should not be blank';
            IndCid = *On;
            Return;

         EndSl;

       End-proc;

       Dcl-Proc ResetIndicator;

        Cancel = *Off;
        IndCid = *Off;
        IndCPass = *Off;
        IndCNPass = *Off;
        IndCCpass = *Off ;

       End-Proc;
