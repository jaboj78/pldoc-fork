CREATE OR REPLACE AND Compile
/**
 * Simple Class to expose method to generate SHA1 digest from RAW bytes.
 *@headcom 
 */
JAVA source named java_schema."Sha1" AS
import java.security.*;
public class Sha1 {
public static byte[] GetHash ( byte[] s ) throws
NoSuchAlgorithmException {
MessageDigest sha = MessageDigest.getInstance("SHA-1");
return sha.digest(s);
}
}
