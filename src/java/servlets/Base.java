/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.StringReader;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Templates;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.sax.SAXResult;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import javax.xml.xquery.XQConnection;
import javax.xml.xquery.XQDataSource;
import javax.xml.xquery.XQException;
import javax.xml.xquery.XQPreparedExpression;
import javax.xml.xquery.XQResultSequence;
import net.xqj.basex.BaseXXQDataSource;
import org.apache.fop.apps.FOPException;
import org.apache.fop.apps.Fop;
import org.apache.fop.apps.FopFactory;
import org.apache.fop.apps.MimeConstants;
import org.w3c.dom.Document;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

/**
 *
 * @author Christian
 */
public abstract class Base extends HttpServlet {

    private FopFactory fopFactory = FopFactory.newInstance();
    private TransformerFactory tFactory = TransformerFactory.newInstance();

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     */
    protected abstract void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException;

    /**
     * Initializes the servlet.
     *
     * @param config
     * @throws javax.servlet.ServletException
     */
    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        ServletContext webApp = this.getServletContext();

        try {
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
    }

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws javax.servlet.ServletException
     * @throws java.io.IOException
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, java.io.IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws javax.servlet.ServletException
     * @throws java.io.IOException
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, java.io.IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     */
    @Override
    public String getServletInfo() {
        return "Coucou";
    }

    protected String getResultsEntries(String requete) throws XQException {
        XQDataSource xqs = new BaseXXQDataSource();
        String fichierXml = "";
        xqs.setProperty("serverName", "localhost");
        xqs.setProperty("port", "1984");

        XQConnection conn = xqs.getConnection("admin", "passe");

        XQPreparedExpression xqpe
                = conn.prepareExpression("doc('entries_hotels')" + requete);

        XQResultSequence rs = xqpe.executeQuery();

        while (rs.next()) {
            fichierXml += rs.getItemAsString(null);
            fichierXml += "\n";
        }
        conn.close();
        return fichierXml;

    }

    protected void transformXml(String xml, String xsl, HttpServletResponse response) throws TransformerConfigurationException, ParserConfigurationException, SAXException, IOException, TransformerException {
        ServletContext webApp = this.getServletContext();

        // Get concrete implementation
        TransformerFactory tFactory = TransformerFactory.newInstance();

        // Create a reusable templates for a particular stylesheet
        Templates templates = tFactory.newTemplates(new StreamSource(webApp.getRealPath(xsl)));
        // Create a transformer
        Transformer transformer = templates.newTransformer();

        // Get concrete implementation
        DocumentBuilderFactory dFactory = DocumentBuilderFactory.newInstance();
        // Need a parser that support namespaces
        dFactory.setNamespaceAware(true);
        // Create the parser
        DocumentBuilder parser = dFactory.newDocumentBuilder();

        StringReader sr = new StringReader(xml);
        InputSource is = new InputSource(sr);

        // Parse the XML document
        Document doc = parser.parse(is);

        // Get the XML source
        Source xmlSource = new DOMSource(doc);
        response.setContentType("text/html");
        // Transform input XML doc in HTML stream
        transformer.transform(xmlSource, new StreamResult(response.getWriter()));
    }

    protected void transformPdf(String xml, String xsl, HttpServletResponse response) throws FOPException, TransformerConfigurationException, TransformerException, IOException {
        ServletContext webApp = this.getServletContext();
        //Setup a buffer to obtain the content length
        ByteArrayOutputStream out = new ByteArrayOutputStream();

        //Setup FOP
        Fop fop = fopFactory.newFop(MimeConstants.MIME_PDF, out);

        //Setup Transformer
        Source xsltSrc = new StreamSource(webApp.getRealPath(xsl));
        Transformer transformer = tFactory.newTransformer(xsltSrc);

        //Make sure the XSL transformation's result is piped through to FOP
        Result res = new SAXResult(fop.getDefaultHandler());

        //Setup input
        Source src = new StreamSource(new StringReader(xml));

        //Start the transformation and rendering process
        transformer.transform(src, res);

        //Prepare response
        response.setContentType("application/pdf");
        response.setContentLength(out.size());

        //Send content to Browser
        response.getOutputStream().write(out.toByteArray());
        response.getOutputStream().flush();
    }
}
