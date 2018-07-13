/**
 * BSD-style license; for more info see http://pmd.sourceforge.net/license.html
 */
package net.sourceforge.pldoc.cpd;

import java.io.Reader;
import net.sourceforge.pmd.cpd.SourceCode;

/**
 * An extension that allows use of CPD against datavase source code.
 */ 
public class DatabaseCodeLoader extends SourceCode.CodeLoader {
	/** Notional file path if no pseudo-file path is given*/
	public static final String DEFAULT_NAME = "CODE_LOADED_FROM_DATABASE";

	/** Reader containing source code */
	private Reader code;

	/** Notional file path*/
	private String name;

	/**
	 * Create a CodeLoader that can search source code from Reader with a default notional file path.
	 *
	 * @param code  source code to compare.
	 */
	public DatabaseCodeLoader(Reader code) {
	    this(code, DEFAULT_NAME);
	}

	/**
	 * Create a CodeLoader that can search source code from Reader.
	 *
	 * @param code  source code to compare.
	 * @param name  notional file path  of this source code 
	 */
	public DatabaseCodeLoader(Reader code, String name) {
	    this.code = code;
	    this.name = name;
	}

	@Override
	public Reader getReader() {
	    return code;
	}

	@Override
	public String getFileName() {
	    return name;
	}
}


