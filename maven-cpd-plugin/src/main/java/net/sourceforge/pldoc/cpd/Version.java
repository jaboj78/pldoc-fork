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

package net.sourceforge.pldoc.cpd;
/**
* This class defines the current version of PLDoc.<P>
* @author Albert Tumanov
* @version ${project.version}
*/
public class Version {

  // the Name will be substituted with release tag by CVS 
  private static final String tagName = "${project.version}";

  private Version() {
    // don't instantiate
  }

  /** Version ID in the form 0.0.0
   *@return plugin version number
  */
  public static String id() {

    /*
     Simply use the maven project Version 
    */
    return tagName;
  }

}
