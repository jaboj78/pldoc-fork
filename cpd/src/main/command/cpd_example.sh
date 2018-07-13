
# $Id$
./cpd.sh -verbose -outputfile cpd_pldoc_ignore_nothing.txt -inputencoding ISO-8859-15 samples/sample*.sql
./cpd.sh -verbose -ignoreidentifiers -outputfile cpd_pldoc_ignore_identifiers.txt -inputencoding ISO-8859-15 samples/sample*.sql
./cpd.sh -verbose -ignoreliterals -outputfile cpd_pldoc_ignore_literals.txt -inputencoding ISO-8859-15 samples/sample*.sql
./cpd.sh -verbose -ignorecomments  -outputfile cpd_pldoc_ignore_comments.txt -inputencoding ISO-8859-15 samples/sample*.sql
./cpd.sh -verbose -ignoreidentifiers -ignoreliterals -ignorecomments  -outputfile cpd_pldoc_ignore_all.txt -inputencoding ISO-8859-15 samples/sample*.sql

