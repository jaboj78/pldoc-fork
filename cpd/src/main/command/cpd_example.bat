
./cpd.sh -verbose -outputfile cpd_pldoc_ignore_nothing.txt -inputencoding ISO-8859-15 samples/sample*.sql
call ./cpd.bat -verbose -ignoreidentifiers -outputfile cpd_pldoc_ignore_identifiers.txt -inputencoding ISO-8859-15 samples/sample*.sql
call ./cpd.bat -verbose -ignoreliterals -outputfile cpd_pldoc_ignore_literals.txt -inputencoding ISO-8859-15 samples/sample*.sql
call ./cpd.bat -verbose -ignorecomments  -outputfile cpd_pldoc_ignore_comments.txt -inputencoding ISO-8859-15 samples/sample*.sql
call ./cpd.bat -verbose -ignoreidentifiers -ignoreliterals -ignorecomments  -outputfile cpd_pldoc_ignore_all.txt -inputencoding ISO-8859-15 samples/sample*.sql


PAUSE
