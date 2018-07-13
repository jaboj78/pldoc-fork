CREATE OR REPLACE PACKAGE 
pkg_qstrings 
AS 
 /**
  *This PACKAGE is a placeholder to test Q-Quoted strings 
  *
  *@headcom
  */
/**
 Package name defined as a constant Q-quoted String.
*/
g_package_name CONSTANT VARCHAR2(30) := q'[A Quoted String]';
g_package_var VARCHAR2(30) := q'[Another Quoted String]';
g_package_var1 VARCHAR2(30) := q'[A Q-Quoted String which contains a singlequote(').]';
g_package_var2 VARCHAR2(30) := q'{A Q-Quoted String which contains 2 singlequotes('').}';
g_package_var3 VARCHAR2(30) := q'(A Q-Quoted String which contains 3 singlequotes['''].)';
g_package_var4 VARCHAR2(30) := q'<A Q-Quoted String which contains 4 singlequotes('''').>';
g_package_var5 VARCHAR2(30) := q'!A Q-Quoted String which contains 5 singlequotes(''''').!';
g_package_var6 VARCHAR2(30) := q'/A Q-Quoted String which contains 6 singlequotes('''''')./';
g_package_var10 VARCHAR2(30) := q'/A Q-Quoted String('') which contains 6 singlequotes('''''')./';
g_package_null CONSTANT VARCHAR2(30) ;
g_package_defaulted date  := SysDatE;
END;
/

