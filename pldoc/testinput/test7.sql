create or replace package cmpl_package
is

procedure cmpl(
    i_def         boolean := true       /* if true, all sources 
                                                   those which are  
                                                   marked */
  );

end;