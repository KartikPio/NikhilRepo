     **Free


       Ctl-Opt Option(*Nodebugio:*Srcstmt) Nomain;
       Dcl-F Question Disk Usage(*Input:*Output:*update) ;
       Dcl-F Eheadscrn Workstn Indds(Indds1) Sfile(SECQUES1:rrn);
       Dcl-Ds IndDs1;
        Cancel Ind Pos(12);
        SflEnd Ind Pos(30);
        SflClr Ind Pos(31);
        SflDsp Ind Pos(32);
        SflDspCtl Ind Pos(33);
       End-Ds;

       Dcl-S SecQstion Char(35);

       Dcl-s Rrn Zoned(4);


       Dcl-Proc SecurityPrompt Export;
       Dcl-Pi SecurityPrompt Char(35);
        P_Question Char(35);
       End-Pi;

          Dow  Cancel = *Off ;
              Clrsubfile();
              Loadsubfile();
              Dsplysubfile();

           Select;

           When Cancel = *On;
                Cancel = *Off ;
                If P_Question = *Blanks;
                  SecQstion = *Blanks;
                  Return SecQstion;
                Else;
                  SecQstion = P_Question;
                  Return SecQstion;
                EndIf;

           Other;

            Readc SECQUES1;
            Dow Not %EOF();

             Select ;

               When SOpt = 1;
               Clear SOpt ;
               Return SQUES ;

               Other ;
               Clear SOpt ;

             EndSl;

             ReadC SECQUES1;

            EndDo;

           EndSl;

          EndDo;

       End-Proc;


       Dcl-Proc Clrsubfile  ;

             Rrn =0    ;
             SflClr = *On ;
             Write SFLCTL1;
             SflClr = *Off  ;

       End-Proc;


       Dcl-Proc Loadsubfile ;

         Exec sql
            Set option commit = *None ;


         Exec sql
           Declare subcrsr Cursor For Select * from QUESTION;

         Exec sql
         Open Subcrsr;


         Exec sql
           Fetch from Subcrsr into :SecQstion ;

         Dow sqlcod = 0 ;
            SQues = SecQstion;
            Rrn = Rrn + 1 ;

            If  Rrn > 9999;
            Leave ;
            EndIf ;
            Write SECQUES1 ;

         Exec sql
           Fetch next from Subcrsr Into :SecQstion;

         Enddo;

         Exec sql
            Close Subcrsr;

       End-Proc;


       Dcl-Proc dsplysubfile;

           SflDsp = *On ;
           SflDspCtl = *On ;
           SflEnd = *On;

           If  Rrn = 0;
               SflDsp = *Off;
           Endif;


               Write SFOTER ;
               Exfmt SFLCTL1 ;


       End-Proc;
