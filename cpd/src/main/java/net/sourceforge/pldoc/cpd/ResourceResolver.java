/* Copyright (C) 2002-2013 Albert Tumanov

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

package net.sourceforge.pldoc.cpd;

import javax.xml.transform.URIResolver;
import javax.xml.transform.Source;
import javax.xml.transform.TransformerException;
import javax.xml.transform.stream.StreamSource;
import java.io.InputStream;

public class ResourceResolver implements URIResolver
{
  public Source resolve(String href, String base) 
                              throws TransformerException
  {
    if(null==href || href.length() == 0 )
      return null; // will make Oracle XSLT processor explode, 
                   // even though it's correct 
    try    {
      String resource = href; 
      ResourceLoader loader = new ResourceLoader();
      return new StreamSource(loader.getResourceStream(resource), resource);
    } // try
    catch(Exception ex)
    {
      throw new TransformerException(ex);
    } // catch
  } // resolve
} // ResourceResolver

