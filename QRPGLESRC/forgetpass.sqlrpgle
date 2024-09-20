     **Free

     *******File Declaration***********
     **************************************

       Ctl-Opt Option(*Nodebugio:*Srcstmt) Nomain;
       Dcl-F EHEADSCRN Workstn Indds (Indds1);

       Dcl-ds Indds1;

         Cancel Ind pos(12);
         Refresh Ind pos(05);
         IndFgid Ind Pos(31);
         IndFgSecAns Ind Pos(32);
         IndFgNewPass Ind Pos(33);
         IndFgCnfPass Ind Pos(34);
       End-ds ;

       Dcl-S SecurityAns Char(8);

       Exec Sql
            Set option Commit = *None;

     *******Forget*password*Procedure**
     **********************************
       Dcl-proc ForgtPassword Export ;

            Dow Cancel = *Off ;


                Exfmt FORGETPASS;


                 Select;

                   When Refresh = *On;
                        Refresh = *Off;
                        Clear FORGETPASS;
                        ResetInd();

                   When Cancel = *On;
                        ResetInd();
                        Cancel = *Off;
                        Clear FORGETPASS;
                        Leave;

                   Other ;

                   FgPassValidation();

                 EndSl;

            EndDo;

       End-Proc;

     ************Validation*********
     *******************************

        Dcl-Proc FgPassValidation;

          ResetInd();

          Select;

          When FGLOGINID <> *Blank ;

          Exec Sql
            Select SCURITYQUE , SCURITYANS Into :FgQue , :SecurityAns
            from LoginPf Where LogInId = :FGLOGINID;

          If Sqlcod = 0 ;

            If  FGLOGINID = *Blank ;
                FGERROR = 'User Id Field should not be blank';
                IndFgId = *On;
                Return;

            ElseIf FGANS = *Blank;
               FGERROR = ' Security Answer Field should not be blank';
               IndFgSecAns  = *On;
               Return;

            ElseIf SecurityAns <> FGANS  ;
               FGERROR = ' Wrong Security answer';
               IndFgSecAns = *on;
               Return;

            ElseIf  FGNEWPASS = *Blank;
                   FGERROR = ' New Password Field should not be blank';
                   IndFgNewPass = *On;
                   Return;


            ElseIf  FGCNFMPASS = *Blank;
                    FGERROR = 'Confm password Field should not be blank';
                    IndFgCnfPass = *On;
                    Return;

            ElseIf FGNEWPASS <> FGCNFMPASS;
                   FGERROR = 'Both Field should be blank';
                   IndFgCnfPass = *On;
                   Return;

            Else ;

             ResetInd();
             Clear FGERROR ;


             Exec Sql
               Update loginpf set PASSWORD = :FGCNFMPASS
               Where LOGINID = :FGLOGINID;
               Clear FORGETPASS ;
               FGERROR  = 'Password Changed';


            EndIf;

          Else ;

            FGERROR = 'Wrong Login id';
            IndFgId = *On ;

          ENdIf;

          When FGLOGINID = *Blank ;
               FGERROR = 'Field should not be blank';
               IndFgId = *On;
               Return;


          EndSl;

        End-Proc;

     ***********Reset*Indicators*******
     **********************************

        Dcl-Proc ResetInd ;

          IndFgId = *Off;
          IndFgNewPass = *Off;
          IndFgSecAns = *Off;
          IndFgCnfPass = *Off;
          Cancel = *Off;
          Refresh = *Off;

        End-Proc;
