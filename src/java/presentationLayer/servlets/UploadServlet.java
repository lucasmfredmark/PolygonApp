/*
* To change this license header, choose License Headers in Project Properties.
* To change this template file, choose Tools | Templates
* and open the template in the editor.
*/
package presentationLayer.servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import serviceLayer.controllers.BuildingController;
import serviceLayer.entities.User;

/**
 *
 * @author Patrick
 */
public class UploadServlet extends HttpServlet {

    private File file;
    private String filePath;
    private String fileName;
    private String note;
    private int buildingId;
    private ArrayList<String> stack;
    
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    public void init() {
        // The file path is specified in folder Configuration Files -> web.xml. 
        // The file path is set to work for a user, so it won't run on your computer. Fow now.
        filePath = getServletContext().getInitParameter("document-upload");
        fileName = null;
        note = null;
        buildingId = -1;
        stack = new ArrayList();
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        
        User user = (User) request.getSession().getAttribute("user");
        
        // Check that we have a file upload request
        boolean isMultipart = ServletFileUpload.isMultipartContent(request);
        
        try (PrintWriter out = response.getWriter()) {
            
            if (!isMultipart) {
                /* TODO output your page here. You may use following sample code. */
                out.println("<!DOCTYPE html>");
                out.println("<html>");
                out.println("<head>");
                out.println("<title>Servlet UploadServlet</title>");
                out.println("</head>");
                out.println("<body>");
                out.println("<p> No file is uploaded <p>");
                out.println("</body>");
                out.println("</html>");
            } else {
                int maxMemSize = 50 * 1024;
                // Create a factory for disk-based file items
                DiskFileItemFactory factory = new DiskFileItemFactory();
                // Set maximum allowed file size before files are written to the disk
                factory.setSizeThreshold(maxMemSize);
                // Set the directory for files saved to the disk
                factory.setRepository(new File("C:\\PolygonFiles"));
                // Create our upload handler that will parse the upload request and create a list for the multi-part request
                ServletFileUpload uploadHandler = new ServletFileUpload(factory);
                // Store all the parts of the request in a list
                List fileItems = uploadHandler.parseRequest(request);
                // Process the uploaded file items
                Iterator i = fileItems.iterator();
                
                while (i.hasNext()) {
                    FileItem fi = (FileItem)i.next();
                    if (!fi.isFormField()) {
                        //Get the uploaded file name
                        String tempFileName = fi.getName();
                        fileName = tempFileName;
                        //Write the file
                        if (tempFileName.lastIndexOf("\\") >= 0) {
                            file = new File ( filePath +
                            tempFileName.substring( tempFileName.lastIndexOf("\\")));
                        } else {
                            file = new File (filePath + 
                                    tempFileName.substring(tempFileName.lastIndexOf("\\")+1));
                        }
                        
                        fi.write(file);
                        
                        
                        
                        // Pass name of the file, the id of the building it was uploaded to as well as the user's id to the controller
                        
                        out.print("<div>Uploaded File: " + tempFileName + " succesfully to " + ": Path: " + filePath + "</div>");
                    } else {
                        stack.add(fi.getString());
                    }
                }
                int k = 0;
                for (String str : stack) {
                    System.out.println("String in stack: " + k + ": " + str);
                    k++;
                }
                
                // Fetch the building id before uncommenting below:
                // addDocuments needs: file name, building id, user id and a note
                    //uc.addDocument(fileName, buildingId, user.getUserId(),);
                
                
            }
        } catch (FileUploadException ex) {
            Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
        } 
    }
    
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
    
}
