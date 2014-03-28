package servlets;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.xml.parsers.*;
import javax.xml.transform.*;
import javax.xml.xquery.XQException;
import org.xml.sax.SAXException;

public class Graphes extends Base {

    public final String /**
             * The path to the stylesheet.
             */
            XSLT_PATH = "WEB-INF/graphes.xsl";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws javax.servlet.ServletException
     */
    @Override
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException {
        try {
           
            String fichierXml = this.getResultsEntries("");
            
            this.transformXml(fichierXml, XSLT_PATH, response);
        } catch (XQException ex) {
            throw new ServletException(ex);
        } catch (IOException ex) {
            Logger.getLogger(Liste.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SAXException ex) {
            Logger.getLogger(Detail.class.getName()).log(Level.SEVERE, null, ex);
        } catch (TransformerException ex) {
            Logger.getLogger(Detail.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParserConfigurationException ex) {
            Logger.getLogger(Graphes.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}