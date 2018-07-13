/* Copyright (C) 2002 Albert Tumanov

$Id: Files.java,v 1.2 2004/07/03 10:43:06 altumano Exp $

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

public final class Files extends Object
{

  public static Collection readList(String propFile) throws IOException
  {
    long t1, t2;
    t1 = System.currentTimeMillis();
    DBSourceExtractor.debug("Start reading list");

    BufferedReader file = null;
    StreamTokenizer st;
    ArrayList list = new ArrayList();
    int ttype;

    try {
      file = new BufferedReader(new FileReader(propFile));
      st = new StreamTokenizer(file);
      st.quoteChar('"');
      st.eolIsSignificant(true);

      String prevString = null;
      String name = null;
      String values[] = new String[3];
      int valueIndex = 0;

      CYCLE:
      while(true)
      {
        ttype = st.nextToken();
        switch(ttype)
        {
          case '"':
            prevString = st.sval;
            break;
          case '=':
            if (prevString != null)
              name = prevString;
            prevString = null;
            valueIndex = 0;
            break;
          case ',':
          case StreamTokenizer.TT_EOL:
          case StreamTokenizer.TT_EOF:
            if (prevString != null)
              values[valueIndex] = prevString;
            prevString = null;
            valueIndex ++;
            break;
          default: // single character in ttype
        }
        // if end of line/file is reached, add last line into the list, 
        // unless it was empty
        if (ttype == StreamTokenizer.TT_EOL || ttype == StreamTokenizer.TT_EOF) {
          if (name != null)
            list.add(new DBObject(name,values[0],values[1],values[2]));
          name = null;
        }
        if (ttype == StreamTokenizer.TT_EOF)
          break CYCLE;
      }
      file.close();

    } finally {
      if (file != null) 
        file.close();
    }

    t2 = System.currentTimeMillis();
    DBSourceExtractor.debug("List is read, " + ((t2-t1)) + " ms");
    return list;
  }

  public static void stringToFile(StringBuffer s, File file, boolean append) throws IOException
  {
    BufferedWriter outFile = null;

    // write result into the file
    try
    {
      // open the file, encoding ISO-8859-1 (to preserve funny letters)
      outFile =
        new BufferedWriter(
           new OutputStreamWriter(
             new FileOutputStream(file, append),
             "ISO-8859-1"
           )
        );

      // lines
      outFile.write(s.toString());

      // close the file
      outFile.close();
    } finally {
      if (outFile != null) 
        outFile.close();
    }

  }

}

