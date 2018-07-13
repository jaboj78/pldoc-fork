/**
 * BSD-style license; for more info see http://pmd.sourceforge.net/license.html
 */
package net.sourceforge.pldoc.cpd;

import java.io.Reader;
import net.sourceforge.pmd.cpd.SourceCode;

/** Provide a trivial Code loader suitable for loading source code from thw database.
 */
public class DatabaseCodeLoader extends SourceCode.CodeLoader {
	/** Fallback pseudo-file name if none is provided. */
	public static final String DEFAULT_NAME = "CODE_LOADED_FROM_DATABASE";

	/** Database derived source code */
	private Reader code;

	/** Pseudo-path to notional source code file. */
	private String name;

	/** Create CodeLoader with default name.  
	 *
	 *@param code source code  
	 */
	public DatabaseCodeLoader(Reader code) {
	    this(code, DEFAULT_NAME);
	}

	/** Create CodeLoader with default name.  
	 *
	 *@param code source code  
	 *@param name pseudo-path to notional source code file.
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


