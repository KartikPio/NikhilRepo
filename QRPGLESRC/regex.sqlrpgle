     D Cnt             S              5S 0  Inz
     D Email           S            100A    Inz  Varying
     D Regex           S             50A    Inz  Varying
      /Free
         Email = 'ankintshar6@gmail.com';
         Regex = '^(\w|\.|\_|\-)+[@](\w|\_|\-|\.)+[.]\w{2,3}$';
         Exec Sql Set Option Commit = *None;
         Exec Sql
             Set :Cnt = RegExp_Count(:Email,:Regex);
               If Cnt = 1;
                    Dsply 'Valid Email';
                    Else;
                    Dsply 'Bad Email';
               EndIf;
         *INLR = *ON;
