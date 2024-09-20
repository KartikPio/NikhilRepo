     **Free
       Ctl-Opt Option(*Nodebugio:*Srcstmt) Nomain;
       Dcl-F STATEPF  Disk Usage(*Input:*Output:*update) ;
       Dcl-F Eheadscrn Workstn Indds(Indds1) Sfile(STATESFL:rrn);
       Dcl-Ds IndDs1;

         Cancel Ind Pos(12);
         SSflEnd Ind Pos(40);
         SSflClr Ind Pos(41);
         SSflDsp Ind Pos(42);
         SSflDspCtl Ind Pos(43);

       End-Ds;

       Dcl-S StateVar Char(15);

       Dcl-s Rrn Zoned(4);


       Dcl-Proc StatePrompt Export;
       Dcl-Pi StatePrompt Char(15);
         p_State Char(15);
       End-Pi;

        Dow  Cancel = *Off ;
              Clrsubfile();
              Loadsubfile();
              Dsplysubfile();

           Select ;
             When Cancel = *On;
                  Cancel = *Off;
                  If P_State = *Blanks;
                    StateVar = *Blanks;
                    Return StateVar;
                  Else;
                    StateVar = p_State;
                    Return StateVar;
                  EndIf;

             Other;

              Readc STATESFL;
              Dow Not %EOF();

              Select ;

                When SOpt = 1;
                Clear SOpt ;
                Return SSTATE   ;

              Other ;
                Clear SOpt ;

              EndSl;

              ReadC STATESFL;

              EndDo;
           EndSl;

        EndDo;

       End-Proc;

       Dcl-Proc Clrsubfile  ;

             Rrn =0    ;
             SSflClr = *On ;
             Write SSFLCTL;
             SSflClr = *Off  ;

       End-Proc;

       Dcl-Proc Loadsubfile ;

         Exec sql
            Set option commit = *None ;


         Exec sql
           Declare subcrsr Cursor For Select * from STATEPF ;

         Exec sql
         Open Subcrsr;


         Exec sql
           Fetch from Subcrsr into :StateVar  ;

         Dow sqlcod = 0 ;
            SSTATE = StateVar ;
            Rrn = Rrn + 1 ;

            If  Rrn > 9999;
            Leave ;
            EndIf ;
            Write STATESFL ;

         Exec sql
           Fetch next from Subcrsr Into :StateVar ;

         Enddo;

         Exec sql
            Close Subcrsr;

       End-Proc;

       Dcl-Proc dsplysubfile;

           SSflDsp = *On ;
           SSflDspCtl = *On ;
           SSflEnd = *On;

           If  Rrn = 0;
               SSflDsp = *Off;
           Endif;

           //Dow Cancel = *Off;
               Write STATEFOTER;
               Exfmt SSFLCTL ;
           //EndDo;

       End-Proc;
