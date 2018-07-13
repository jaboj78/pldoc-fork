/* Copyright (C) 2002 Albert Tumanov

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this library; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

*/

package net.sourceforge.pldoc;

import java.util.*;
/**
* Parser of pldoc source comments.<P>
* @author Albert Tumanov
* @version $Header: /cvsroot/pldoc/sources/src/java/net/sourceforge/pldoc/CommentParser.java,v 1.2 2004/07/03 10:11:32 altumano Exp $
*/
public class CommentParser
{
  public static final char PARAM_CHAR = '@';
  private ArrayList inputLines;
  private String mainSentence;
  private String text;
  private Hashtable tags;
  private String packageComment;

  /** Constructor.
  * @param input the whole input comment string (comment chars included)
  */
  public CommentParser(String input)
  {
    // break input into lines and store internally
    inputLines = breakIntoLines(input);
    removeCommentChars();
    removeBlankLines();
    text = extractText();
    mainSentence = extractMainSentence();
    tags = extractTags();
    packageComment = extractPackageComment();
  }

  /** Breaks a string into array of lines. */
  private ArrayList breakIntoLines(String s)
  {
    ArrayList lines = new ArrayList();
    int newlinepos=0, prevpos=0;
    while ((newlinepos = s.indexOf("\n", prevpos)) != -1) {
      // MMUE #1: extract lines without line break since it got
      // removed anyway in removeCommentChars() before
      // insideCode handling has been added
      if (newlinepos == prevpos) {
        lines.add("");
      } else {
        if (s.charAt(newlinepos - 1) == '\r')
          lines.add(s.substring(prevpos, newlinepos - 1));
        else
          lines.add(s.substring(prevpos, newlinepos));
      }
      prevpos = newlinepos + 1;
    }
    lines.add(s.substring(prevpos));
    return lines;
  }

  /** Removes comment symbols --,/*,/**,... from the array of lines. */
  private void removeCommentChars()
  {
    // MMUE #1
    boolean insideCode = false;
    
    for (int i=0; i < inputLines.size(); i++) {
      String line = ((String) inputLines.get(i)).trim();
      if (line == null) continue;
      
      // MMUE #1: inside of preformated blocks (enclosed by <pre></pre>)
      // do not remove or trim except for leading *'s
      if (!insideCode) {
        line = line.trim();
        // trim opening comment
        if (line.startsWith("--"))
          line = line.substring(2).trim();
        else if (line.startsWith("/**"))
          line = line.substring(3);
        else if (line.startsWith("/*"))
          line = line.substring(2);
        // trim closing comment
        if (line.endsWith("*/"))
          line = line.substring(0, line.length()-2);
      }
      // remove * and spaces before it
      if (line.trim().startsWith("*"))
        line = line.substring(line.indexOf('*')+1);

      // MMUE #1
      if (line.indexOf("<pre>") != -1)
        insideCode = true;
      if (line.indexOf("</pre>") != -1)
        insideCode = false;

      // update the line
      inputLines.set(i, line);
    }
  }

  /** Removes blank lines. */
  private void removeBlankLines()
  {
    // MMUE #2
    boolean insideCode = false;
    
    for (int i=0; i < inputLines.size(); i++) {
      String line = (String) inputLines.get(i);
      // MMUE #2
      if (!insideCode && (line == null || line.trim().length() == 0))
        inputLines.remove(i);
      // MMUE #2
      if (line.indexOf("<pre>") != -1)
        insideCode = true;
      if (line.indexOf("</pre>") != -1)
        insideCode = false;
    }
  }

  /** Returns the entire parsed comment, but without the tag section(s). */
  private String extractText()
  {
    String line;
    StringBuffer buf = new StringBuffer();
    // concatenate lines until PARAM_CHAR is first on line
    for (int i=0; i < inputLines.size(); i++) {
      line = (String) inputLines.get(i);
      // stop after first string starting with PARAM_CHAR is encountered
      if (line.trim().indexOf(PARAM_CHAR) == 0) {
        break;
      }
      // otherwise, collect the text and remove the line
      buf.append(line).append('\n');
      inputLines.remove(i);
      i--; // adjust for the next index
    }
    return buf.toString();
  }

  /** Extracts "first line" of the string.
  * The first line is ended with dot followed by whitespace and may contain linebreaks.
  * First Sentence
  * The first sentence of each doc comment should be a summary sentence, containing a concise but complete description of the API item. This means the first sentence of each member, class, interface or package description. The Javadoc tool copies this first sentence to the appropriate member, class/interface or package summary. This makes it important to write crisp and informative initial sentences that can stand on their own.

  * This sentence ends at the first period that is followed by a blank, tab, or line terminator, or at the first tag (as defined below). For example, this first sentence ends at "Prof.":

   /**
    * This is a simulation of Prof. Knuth's MIX computer.
    * /
  * 
  */
  private String extractMainSentence()
  {
    String s = text; // by default, main sentence is the whole text
    // SRT 20110422 int pos = s.indexOf('.')  ;
    //We are actually looking for the first instance of regular expression pattern 
    // "\.\s"
    
    for (int pos = s.indexOf('.') 
	 ;((pos != -1) && (pos != (s.length() - 1)) ) // Whilst  
	 ;pos = s.indexOf('.', pos+1) //Look fo the next dot  
	)	    
    {
	    // If the next chracter is whitespace, assign the String and stop the search
	    if ((pos != (s.length() - 1)) && Character.isWhitespace(s.charAt(pos + 1))) {
	      s = s.substring(0, pos + 1);
	      break;
	    }
    }
    return s;
  }

  /** Returns hashtable of tags and their values.
  * Hashtable is indexed by tag names (including preceding PARAM_CHAR).
  */
  private Hashtable extractTags()
  {
    Hashtable htOuter = new Hashtable();
    ArrayList values;
    String tag, tagValue;

    // now, inputLines contains only the tags section.
    // combine
    for (int i=0; i < inputLines.size(); i++) {
      String line = (String) inputLines.get(i);
      // if line does not start with PARAM_CHAR, it's a continuation of the previous tag text
      if (line.trim().indexOf(PARAM_CHAR) != 0 && i > 0) {
        // concatenate with previous
        String previousLine = (String) inputLines.get(i-1);
        inputLines.set(i-1, previousLine + "\n" + line);
        // remove
        inputLines.remove(i);
        i--; // adjust for the next index
      }
    }

    for (int i=0; i < inputLines.size(); i++) {

      String line = (String) inputLines.get(i);
      if (line.trim().indexOf(PARAM_CHAR) == 0) {

        // tag line found, parse it
        tag = null;
        // use tokenizer, because tokens maybe separated by spaces or tabs
        StringTokenizer st = new StringTokenizer(line);
        // extract tag, the rest is the value
        if (st.hasMoreTokens()) {
          tag = st.nextToken();
        }
        if (tag == null) continue;
        // extract tag value
        int restStart = line.indexOf(tag) + tag.length() + 1;
        if (restStart < line.length())
          tagValue = line.substring(restStart).trim();
        else
          tagValue = "";

        // read old content of the tag
        if (htOuter.containsKey(tag))
          values = (ArrayList) htOuter.get(tag);
        else
          // if was not present before, create new
          values = new ArrayList();
        // add new key and its value
        values.add(tagValue);
        // update tag content
        htOuter.put(tag, values);

      }
      else { // if not starting with PARAM_CHAR
      }
    }
    return htOuter;
  }


  /** 
  * Identify and assign package comment when recognized by @headcom tag. 
  *
  * @return package level comment 
  */
  private String extractPackageComment()
  {
    String packageComment = null;
    if (tags != null && tags.containsKey("@headcom")) {
      packageComment = text;
      text = null;
      mainSentence = null;
    }
    return packageComment;
  }

  /** Get package comment.
  *
  * @return package level comment 
  */
  public String getPackageComment()
  {
    return packageComment;
  }

  /** Get "first sentence" of the string - is ended with dot and may contain linebreaks. 
  *
  * @return first sentence 
  */ 
  public String getMainSentence()
  {
    return mainSentence;
  }

  /** Return the entire parsed comment, but without the tag section(s). 
   *
   *
   * @return comment text
   */
  public String getText()
  {
    return text;
  }

  /** Return hashtable of tags and their values.
  *
  *
  *<p>The hashtable is indexed by tag names (including preceding PARAM_CHAR).
  *</p>
  *
  * @return all tags 
  */
  public Hashtable getTags()
  {
    return tags;
  }

  /** 
  *
  * @return all input lines 
  */
  public String toString()
  {
    return inputLines.toString();
  }

  /**
   * The main method, for testing only.
   *
   * @param args array of command-line parameters 
   */
  public static void main(String[] args)
  {
    String[] tests = {
      "--  xyz\n--  abcdef\n--qwerty",
      "/* abcde\ngde\nqwerty opi\n*/",
      "/**\n  *  abcdef\n  *  qwerty.\n  * @param x xyz\n  * @param y werty\n  * @return error code\n*/",
      "/**@headcom\n"+
        "* Gets defaults of an advice type (for given sector).\n"+
        "* @param p_sector           business sector\n"+
        "* @param p_dir              direction (IN/OUT)\n"+
        "* @param p_type             advice type code\n"+
        "* @param def_medium         default medium\n"+
        "* @param def_medium_option  default medium option\n"+
        "* @param def_party          default party\n"+
        "* @param party_fixed        party is fixed (TRUE/FALSE)\n"+
        "* @param r_result           return code, 0=ok\n"+
        "* @param r_message          return message\n"+
        "* %throws e_InvalidOrder Raised when the value of p_order is invalid.\n"+
        "* %author Anybody\n" + "* %see org.utils\n"+
        "* %version 1.0\n"+
        "*/"
    };

    CommentParser commentParser = null;
    String mainSentence = null, text = null, packageComment = null;
    Hashtable tags = null;

    long start = System.currentTimeMillis();
    for(int i=0; i < tests.length; i++) { // loop through all test cases
      for(int c=0; c < 10000; c++) { // loop for measuring performance
        commentParser = new CommentParser(tests[i]);
        mainSentence = commentParser.getMainSentence();
        text = commentParser.getText();
        packageComment = commentParser.getPackageComment();
        tags = commentParser.getTags();
        commentParser = null; // free the reference
      }
      System.out.println(commentParser);
      System.out.println(mainSentence);
      System.out.println(text);
      System.out.println(packageComment);
      System.out.println(tags);
    }
    long finish = System.currentTimeMillis();
    System.out.println("Time: " + (finish-start)/1000.00);
  }

}
