/* Copyright (C) 2002 Albert Tumanov

$Id: Utils.java,v 1.1.1.1 2003/08/18 18:43:46 altumano Exp $

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

package org.dbsourceextractor;

import java.io.*;
import java.util.*;

public final class Utils
{
  public static final String BR = System.getProperty("line.separator");

  /** 
  * Replaces Oracle linebreaks (chr(10)) with normal linebreaks (BR=13) 
  *
  * @param b original text (remains unchanged)
  * @return original text with chr(10) replaces with chr(13)
  */
  public static StringBuffer replaceLineBreaks(StringBuffer b)
  {
    final byte CHR0 = 0;
    final byte CHR10 = 10;
    StringBuffer temp = new StringBuffer(b.toString());
    for (int i = 0; i < temp.length(); i++)
    {
      if (temp.charAt(i) == CHR0 || temp.charAt(i) == CHR10) {
        temp.replace(i, i + BR.length() - 1, BR);
        i += BR.length() - 1;
      }
    }
    return temp;
  }

  /** 
  * Replaces single quotes with double single quotes.
  * This might be needed for SQL scripts where the text is already inside single quotes.
  *
  * @param str original text (remains unchanged)
  * @return original text with single quotes replaced
  */
  public static String adaptQuotes(String str)
  {
    final char SINGLE_QUOTE = '\'';
    StringBuffer temp = new StringBuffer(str);
    for (int i = 0; i < temp.length(); i++)
    {
      if (temp.charAt(i) == SINGLE_QUOTE) {
        temp.insert(i, SINGLE_QUOTE);
        i += 2; // jump over both quotes
      }
    }
    return temp.toString();
  }

  /**
   * Pads a string with spaces on the right.
   *
   * @param str String to add spaces
   * @param width Width of string after padding
   */
  public static void pad(StringBuffer buf, int width) 
  {
      int space = width - buf.length();
      while ( space-- > 0 ) {
          buf.append(' ');
      }
  }
  
}

