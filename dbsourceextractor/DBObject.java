/* Copyright (C) 2002 Albert Tumanov

$Id: DBObject.java,v 1.1.1.1 2003/08/18 18:43:46 altumano Exp $

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

public final class DBObject
{
  private String name;
  private String type1;
  private String type2;
  private String filename;

  public DBObject(String name, String type1, String type2, String filename)
  {
    this.name = name;
    this.type1 = type1;
    this.type2 = type2;
    this.filename = filename;
  }

  public String name()
  {
    return this.name;
  }

  public String type1()
  {
    return this.type1;
  }

  public String type2()
  {
    return this.type2;
  }

  public String filename()
  {
    return this.filename;
  }

  public String toString()
  {
    return (type1 + ", " + type2 + ", " + filename);
  }

}
