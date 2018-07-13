package net.sourceforge.pldoc;

import java.util.*;
import java.io.*;
import javax.xml.parsers.*;

import org.xml.sax.SAXException;

import org.apache.xml.serializer.*;

import org.w3c.dom.*;

/**
 *  Description of the Class
 *
 *<p>created    April 18, 2004</p>
 */
public class XMLWriter {

  private OutputStream outStream;
  private Document doc;
  private Stack upperNodes;
  private LinkedList pendingAttributes = new LinkedList(); // acts as queue

  private Properties serProperties;


  /**
   *  Constructor for the XMLWriter object
   *
   *@param  outStream                Description of the Parameter
   *@exception  java.io.IOException  Description of the Exception
   */
  public XMLWriter(OutputStream outStream)
       throws java.io.IOException {

    this.outStream = outStream;
    serProperties = new Properties();
    setMethod("xml");
    /* XML 1.0 was prescriptive (Napoleionic Code- anything not specifically allowed is forbidden), 
       XML 1.1 is proscriptive/permissive (Common Law- anything not specifically forbidden is allowed)   
       This change allows future UNICODE 
       The specific example which caused this change was a character reference "&#27;" which is not allowed under 1.0,
       but which is allowed under 1.1
    */
    setVersion("1.1"); 
    setEncoding("UTF-8");
    setIndent(true);
    setIndentSize(2);
    setOmitXMLDeclaration(false);
    setStandalone(false);
  }


  /**
   *  Constructor for the XMLWriter object
   *
   *@exception  java.io.IOException  Description of the Exception
   */
  public XMLWriter()
       throws java.io.IOException {

    this(null);
  }


  /**
   * Set the method attribute of the XMLWriter object
   *
   *@param  method  The new method value
   */
  public void setMethod(String method) {
    serProperties.setProperty("method", method);
    serProperties.putAll(OutputPropertiesFactory.getDefaultMethodProperties(method));
  }


  /**
   *  Set the version attribute of the XMLWriter object
   *
   *@param  version  The new version value
   */
  private void setVersion(String version) {
    serProperties.setProperty("version", version);
  }


  /**
   *  Set the encoding attribute of the XMLWriter object
   *
   *@param  encoding  The new encoding value
   */
  public void setEncoding(String encoding) {
    serProperties.setProperty("encoding", encoding);
  }


  /**
   *  Set the indent attribute of the XMLWriter object
   *
   *@param  indent  The new indent value
   */
  public void setIndent(boolean indent) {
    serProperties.setProperty("indent", indent ? "yes" : "no");
  }


  /**
   *  Sets the indentSize attribute of the XMLWriter object
   *
   *@param  indentSize  The new indentSize value
   */
  private void setIndentSize(int indentSize) {
    serProperties.setProperty("{http://xml.apache.org/xalan}indent-amount", String.valueOf(indentSize));
  }


  /**
   *  Sets the omitXMLDeclaration attribute of the XMLWriter object
   *
   *@param  omit  The new omitXMLDeclaration value
   */
  private void setOmitXMLDeclaration(boolean omit) {
    serProperties.setProperty("omit-xml-declaration", omit ? "yes" : "no");
  }


  /**
   *  Sets the standalone attribute of the XMLWriter object
   *
   *@param  standalone  The new standalone value
   */
  private void setStandalone(boolean standalone) {
    serProperties.setProperty("standalone", standalone ? "yes" : "no");
  }


  /**
   *  Sets the docType attribute of the XMLWriter object
   *
   *@param  sPublic  The new docType value
   *@param  sSystem  The new docType value
   */
  public void setDocType(String sPublic, String sSystem) {
    if (sPublic != null) {
      serProperties.setProperty("doctype-public", sPublic);
    }
    if (sSystem != null) {
      serProperties.setProperty("doctype-system", sSystem);
    }
  }


  //
  // ContentHandler
  //

  /**
   *  Start new Document.
   *
   *@exception  SAXException  Description of the Exception
   */
  public void startDocument()
       throws SAXException {
    try {
      doc = DocumentBuilderFactory.newInstance().newDocumentBuilder().newDocument();
    } catch(ParserConfigurationException e) {
      throw new SAXException(e.toString());
    }
    upperNodes = new Stack();
    upperNodes.push(new Object[] {doc, new LinkedList()});
  }


  /**
   *  Finalize current Document, writing it out.
   *
   *@exception  SAXException  Description of the Exception
   */
  public void endDocument()
       throws SAXException {
    // write the result to the stream
    if (outStream != null) {
      try {
        Serializer serializer = SerializerFactory.getSerializer(serProperties);
        //System.out.println(serProperties.toString());
        serializer.setOutputStream(outStream);
        serializer.asDOMSerializer().serialize(doc);
      } catch(IOException e) {
        throw new SAXException(e.toString());
      }
    }
  }


  //
  // extensions
  //

  /**
   *  Add an attribute to the queue.
   *  
   *  <p><b>Should be called before calling the respective startElement()</b></p>.
   *
   *@param  name              Description of the Parameter
   *@param  value             Description of the Parameter
   *@exception  SAXException  Description of the Exception
   */
  public void pushAttribute(String name, String value)
       throws SAXException {
    if (pendingAttributes == null) {
      pendingAttributes = new LinkedList();
    }
    Attr attr = doc.createAttribute(name);
    attr.setValue(value);
    pendingAttributes.add(attr);
  }


  /**
   *  Generate start tag. 
   *
   *@param  name              Description of the Parameter
   *@exception  SAXException  Description of the Exception
   */
  public void startElement(String name)
       throws SAXException {
    upperNodes.push(new Object[] {doc.createElement(name), pendingAttributes});
    pendingAttributes = new LinkedList();
  }


  /**
   *  Generate end tag.
   *
   *@param  name              Description of the Parameter
   *@exception  SAXException  Description of the Exception
   */
  public void endElement(String name)
       throws SAXException {
    Object[] pendingNodeArray = (Object[]) upperNodes.pop();
    Node pendingNode = (Node) pendingNodeArray[0];
    LinkedList pendingAttributes = (LinkedList) pendingNodeArray[1];
    if (! (pendingNode instanceof Element)) {
      throw new IllegalStateException("Element " + name + " was not started !");
    }
    Element pendingElement = (Element) pendingNode;
    if (!pendingElement.getTagName().equals(name)) {
      throw new IllegalStateException("Element " + name + " was not started !");
    }
    while (!pendingAttributes.isEmpty()) {
      Attr attr = (Attr) pendingAttributes.removeFirst();
      pendingElement.setAttributeNode(attr);
    }
    // append pending node to the parent
    Object[] upperNodeArray = (Object[]) upperNodes.peek();
    Node upperNode = (Node) upperNodeArray[0];
    upperNode.appendChild(pendingElement);
  }


  /**
   *  Generate end tags for any open tags.
   *
   *@param  name              Description of the Parameter
   *@exception  SAXException  Description of the Exception
   */
  public void endElementRecursive(String name)
       throws SAXException {
    Element pendingElement = null;
    do
    {
        Object[] pendingNodeArray = (Object[]) upperNodes.peek();
        Node pendingNode = (Node) pendingNodeArray[0];
        LinkedList pendingAttributes = (LinkedList) pendingNodeArray[1];
        if (! (pendingNode instanceof Element)) {
          throw new IllegalStateException("Element " + name + " was not started !");
        }
        pendingElement = (Element) pendingNode;
        if (!pendingElement.getTagName().equals(name)) {
          endElement(pendingElement.getTagName());
        }
        else 
        {
            upperNodes.pop();
            break;
        }
    }
    while (true);

    while (!pendingAttributes.isEmpty()) {
      Attr attr = (Attr) pendingAttributes.removeFirst();
      pendingElement.setAttributeNode(attr);
    }
    // append pending node to the parent
    Object[] upperNodeArray = (Object[]) upperNodes.peek();
    Node upperNode = (Node) upperNodeArray[0];
    upperNode.appendChild(pendingElement);
  }



  /**
   *  Convenience method.
   *
   *@param  name              Description of the Parameter
   *@exception  SAXException  Description of the Exception
   */
  public void element(String name)
       throws SAXException {
    startElement(name);
    endElement(name);
  }


  /**
   *  Description of the Method
   *
   *@param  str               Description of the Parameter
   *@exception  SAXException  Description of the Exception
   */
  public void cdata(String str)
       throws SAXException {
    // append <[CDATA[ to the parent
    Object[] upperNodeArray = (Object[]) upperNodes.peek();
    Node upperNode = (Node) upperNodeArray[0];
    upperNode.appendChild(doc.createCDATASection(str));
  }


  /**
   *  Get the DOM Document written so far.
   *  
   *  @return current Document
   */
  public Document getDocument() {
    return doc;
  }

  /**
   *  Append node to  document.
   *
   *@param  node                          node whose children to append
   *@exception  org.xml.sax.SAXException  Description of the Exception
   */
  public void appendNodeChildren(Node node)
       throws org.xml.sax.SAXException {
    // get the upper node
    Object[] upperNodeArray = (Object[]) upperNodes.peek();
    Node upperNode = (Node) upperNodeArray[0];
    // append all the children to the upper node
    for (Node n = node.getFirstChild(); n != null; n = n.getNextSibling()) {
      upperNode.appendChild(doc.importNode(n, true));
    }
  }

  /**
   *  Locate the Schema and the Object in the current DOM.
   *
   *@param  schemaName  Oracle Schema name 
   *@param objectName   Oracle Object name 
   *@exception  org.xml.sax.SAXException  Description of the Exception
   *
   *@return located node
   */
  public Node findObjectNode(String schemaName, String objectName)
       throws org.xml.sax.SAXException {
    Iterator it = upperNodes.iterator();
    // skip the Document
    it.next();
    // get the APPLICATION node
    Object[] upperNodeArray = (Object[]) it.next();
    Node application = (Node) upperNodeArray[0];
    // find the child of the APPLICATION node with the required tag name and attributes
    for (Node n = application.getFirstChild(); n != null; n = n.getNextSibling()) {
      Element object = (Element) n;
      if (object.getAttribute("SCHEMA").equalsIgnoreCase(schemaName) &&
          object.getAttribute("NAME").equalsIgnoreCase(objectName)) {
            // object found
            return object;
      }
    }
    // object not found
    return null;
  }


  /**
   *  Create element with name of <i>tagName</i>.
   *
   *@param  tagName                          text
   *@exception  org.w3c.dom.DOMException  Description of the Exception
   *
   *@return tag as Element
   */
  public Element createElement(String tagName) throws DOMException {
    return doc.createElement(tagName);
  }

  /**
   * Convert data into CDATA.
   *
   *@param  data                          text
   *@exception  org.w3c.dom.DOMException  Description of the Exception
   *
   *@return text as  CDATA 
   */
  public CDATASection createCDATASection(String data) throws DOMException {
    return doc.createCDATASection(data);
  }
}

