
#POM file passwords 
UsingJava1.7.sh mvn -X -f pldoc-cleartext_password-pom.xml pldoc:pldoc >pldoc-cleartext_password-pom.out 2>pldoc-cleartext_password-pom.err
UsingJava1.7.sh mvn -X -f pldoc-encoded_password-pom.xml pldoc:pldoc  >pldoc-encoded_password-pom.out 2>pldoc-encoded_password-pom.err

#Server file passwords 
UsingJava1.7.sh mvn -X -s maven_cleartext_settings.xml -f pldoc-missing_password-pom.xml pldoc:pldoc >pldoc-missing_password-cleartext.out 2>pldoc-missing_password-cleartext.err
UsingJava1.7.sh mvn -X -s maven_encoded_settings.xml -f pldoc-missing_password-pom.xml pldoc:pldoc >pldoc-missing_password-encoded.out 2>pldoc-missing_password-encoded.err

#Server file passwords 
UsingJava1.7.sh mvn -X -s maven_cleartext_settings.xml -f pldoc-missing_credentials-pom.xml pldoc:pldoc >pldoc-missing_credentials-cleartext.out 2>pldoc-missing_credentials-cleartext.err
UsingJava1.7.sh mvn -X -s maven_encoded_settings.xml -f pldoc-missing_credentials-pom.xml pldoc:pldoc >pldoc-missing_credentials-encoded.out 2>pldoc-missing_credentials-encoded.err

#Server file passwords 
UsingJava1.7.sh mvn -X -Dsettings.security=$PWD/local-settings-security.xml  -s maven_cleartext_settings.xml -f pldoc-missing_credentials-pom.xml pldoc:pldoc -Dsettings.security=$PWD/local-settings-security.xml  >pldoc-missing_credentials-cleartext-local-settings-security.out 2>pldoc-missing_credentials-cleartext-local-settings-security.err
UsingJava1.7.sh mvn -X -Dsettings.security=$PWD/local-settings-security.xml  -s maven_encoded_settings.xml -f pldoc-missing_credentials-pom.xml pldoc:pldoc -Dsettings.security=$PWD/local-settings-security.xml  >pldoc-missing_credentials-encoded-local-settings-security.out 2>pldoc-missing_credentials-encoded-local-settings-security.err

