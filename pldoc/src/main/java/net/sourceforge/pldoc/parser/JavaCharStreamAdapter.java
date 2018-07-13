package net.sourceforge.pldoc.parser;

import java.io.Reader;

/**
 * Allow a parser to pass its current CharStream to a PMD language parser. 
 */

public class JavaCharStreamAdapter extends net.sourceforge.pmd.lang.ast.JavaCharStream
{

  /**
   * 
   */
  protected SimpleCharStream m_source;

  @Override
  protected void setTabSize(int i) { m_source.setTabSize(i); }
  @Override
  protected int getTabSize(int i) { return m_source.getTabSize(i); }

  public JavaCharStreamAdapter( SimpleCharStream source ) {
      super( (Reader) null );
      m_source = source;
  }

  @Override
  protected void ExpandBuff(boolean wrapAround)
  {
	  m_source.ExpandBuff(wrapAround);
  }

  @Override
  protected void FillBuff() throws java.io.IOException
  {
	  m_source.FillBuff();
  }

  @Override
  protected char ReadByte() throws java.io.IOException
  {
     //@TODO SimpleCharSTream does not have an ReadByte() method; use readChar() instead
     return m_source.readChar();
  }

/** @return starting character for token. */
  @Override
  public char BeginToken() throws java.io.IOException
  {
     return m_source.BeginToken();
  }

  @Override
  protected void AdjustBuffSize()
  {
     //@TODO SimpleCharSTream does not have an AdjustBuffSize() method
     ; //m_source.AdjustBuffSize();
  }

  @Override
  protected void UpdateLineColumn(char c)
  {
     m_source.UpdateLineColumn(c);
  }

/** Read a character. */
  @Override
  public char readChar() throws java.io.IOException
  {
    return m_source.readChar();
  }

  /**
   * @deprecated
   * @see #getEndColumn
   */
  @Override
  public int getColumn() {
     return m_source.getColumn();
  }

  /**
   * @deprecated
   * @see #getEndLine
   */
  @Override
  public int getLine() {
     return m_source.getLine();
  }

/** Get end column. */
  @Override
  public int getEndColumn() {
     return m_source.getEndColumn();
  }

/** Get end line. */
  @Override
  public int getEndLine() {
     return m_source.getEndLine();
  }

/** @return column of token start */
  @Override
  public int getBeginColumn() {
     return m_source.getBeginColumn();
  }

/** @return line number of token start */
  @Override
  public int getBeginLine() {
     return m_source.getBeginLine();
  }

/** Retreat. */
  @Override
  public void backup(int amount) {
    m_source.backup(amount);
  }

/** Reinitialise. */
  @Override
  public void ReInit(java.io.Reader dstream,
                 int startline, int startcolumn, int buffersize)
  {
	  m_source.ReInit(dstream,startline,startcolumn,buffersize);
  }

/** Reinitialise. */
  @Override
  public void ReInit(java.io.Reader dstream,
                                        int startline, int startcolumn)
  {
    m_source.ReInit(dstream, startline, startcolumn);
  }

/** Reinitialise. */
  @Override
  public void ReInit(java.io.Reader dstream)
  {
     m_source.ReInit(dstream);
  }
/** Reinitialise. */
  @Override
  public void ReInit(java.io.InputStream dstream, String encoding, int startline,
  int startcolumn, int buffersize) throws java.io.UnsupportedEncodingException
  {
    m_source.ReInit(dstream, encoding, startline, startcolumn, buffersize) ;
  }

/** Reinitialise. */
  @Override
  public void ReInit(java.io.InputStream dstream, int startline,
  int startcolumn, int buffersize)
  {
    m_source.ReInit(dstream, startline, startcolumn, buffersize);
  }
/** Reinitialise. */
  @Override
  public void ReInit(java.io.InputStream dstream, String encoding, int startline,
                     int startcolumn) throws java.io.UnsupportedEncodingException
  {
     m_source.ReInit(dstream, encoding, startline, startcolumn) ;
  }
/** Reinitialise. */
  @Override
  public void ReInit(java.io.InputStream dstream, int startline,
                     int startcolumn)
  {
     m_source.ReInit(dstream, startline, startcolumn);
  }
/** Reinitialise. */
  @Override
  public void ReInit(java.io.InputStream dstream, String encoding) throws java.io.UnsupportedEncodingException
  {
     m_source.ReInit(dstream, encoding) ;
  }

/** Reinitialise. */
  @Override
  public void ReInit(java.io.InputStream dstream)
  {
     m_source.ReInit(dstream);
  }

  /** @return token image as String */
  @Override
  public String GetImage()
  {
        return m_source.GetImage();
  }

  /** @return suffix */
  @Override
  public char[] GetSuffix(int len)
  {
     return m_source.GetSuffix(len);
  }

  /** Set buffers back to null when finished. */
  @Override
  public void Done()
  {
    m_source.Done();
  }

  /**
   * Method to adjust line and column numbers for the start of a token.
   */
  @Override
  public void adjustBeginLineColumn(int newLine, int newCol)
  {
    m_source.adjustBeginLineColumn(newLine, newCol);
  }

}

