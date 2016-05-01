/*
* To change this license header, choose License Headers in Project Properties.
* To change this template file, choose Tools | Templates
* and open the template in the editor.
 */
package presentationLayer.servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
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
import serviceLayer.exceptions.BuildingException;

/**
 *
 * @author Patrick
 */
public class UploadServlet extends HttpServlet {
    // The file we are going to write
    private File file;
    //Used to define the directory we write the file to
    private String filePath;
    // Name of the file
    private String fileName;
    // Value used for check up reports
    private int conditionLevel;
    private BuildingController bc;
    // The text that goes with the file you upload (the note)
    private String note;
    private int buildingId;
    // Used to fetch all data that is formfield from multi part.
    private ArrayList<FileItem> stack;
    // Used for logic
    boolean isPathSet;
    boolean isWritten;
    // Text used when throwing exceptions
    private String error;

    @Override
    public void init() {
        // The file path is specified in folder Configuration Files -> web.xml.
        bc = new BuildingController();
        fileName = null;
        note = null;
        conditionLevel = Integer.MIN_VALUE;
        buildingId = 0;
        stack = new ArrayList();
        isPathSet = false;
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws org.apache.commons.fileupload.FileUploadException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, FileUploadException, Exception {
        response.setContentType("text/html;charset=UTF-8");
        
        // We catch the data from the form coing in with the request
        boolean isMultipart = ServletFileUpload.isMultipartContent(request);

        try (PrintWriter out = response.getWriter()) {
            
            if (isMultipart) {
                // Max allowed file size
                int maxMemSize = 50 * 1024;
                // Class from library commons-fileupload that handles writing files to disk
                DiskFileItemFactory factory = new DiskFileItemFactory();
                // Set maximum allowed file size
                factory.setSizeThreshold(maxMemSize);
                // Where we write files to temporaily if they are above threshold
                factory.setRepository(new File("C:\\PolygonFiles"));
                ServletFileUpload uploadHandler = new ServletFileUpload(factory);
                // All of the multi part data
                List fileItems = uploadHandler.parseRequest(request);
                // We create an Iterator object so we can iterate through every
                // element from our fileItems list
                Iterator i = fileItems.iterator();
                
                // While there is another element to iterate through
                while (i.hasNext()) {
                    // We pass the element from the list to a FileItem and assign it
                    FileItem fi = (FileItem) i.next();
                    // Check to see if the element is a file or formfield data
                    if (!fi.isFormField()) {
                        // Get the name of the file and store in a temp and perm variable
                        String tempFileName = fi.getName();
                        fileName = tempFileName;
                        // We are at the end of the name
                        if (tempFileName.lastIndexOf("\\") >= 0) {
                            // Speficy file and directory to write it to
                            file = new File(filePath
                                    + tempFileName.substring(tempFileName.lastIndexOf("\\")));
                        } else {
                            file = new File(filePath
                                    + tempFileName.substring(tempFileName.lastIndexOf("\\") + 1));
                        }
                        // Write the file!
                        fi.write(file);
                        // We have now written and set our logic
                        isWritten = true;
                    } else {
                        // If it isn't a file then it's formfield data
                        // Add all of the elements to a stack
                        stack.add(fi);
                        if (!isPathSet && fi.getFieldName().equals("directory")) {
                            // If we haven't specified the directory, do so
                            filePath = getServletContext().getInitParameter(fi.getString());
                            // Update our logic
                            isPathSet = true;
                        }
                    }
                }
                // When a file has been written successfully
                if (isWritten) {
                    for (FileItem fileItem : stack) {
                        
                        // For each element in our stack that is formfield data
                        // find out what parameter it belonged to and execute
                        // the right sequence
                        
                        String fieldName = fileItem.getFieldName();
                        
                        switch (fieldName) {
                            case "conditionlevel": {
                                conditionLevel = 0;
                                
                                try {
                                    conditionLevel = Integer.parseInt(fileItem.getString());
                                } catch (NumberFormatException ex) {
                                }
                                break;
                            }
                            case "buildingId": {
                                buildingId = 0;
                                
                                try {
                                    buildingId = Integer.parseInt(fileItem.getString());
                                } catch (NumberFormatException ex) {
                                }
                                break;
                            }
                            case "note": {
                                note = fileItem.getString();
                                break;
                            }
                        }
                    }
                    // Determine the action we need to perform from the request
                    String action = null;
                    for (FileItem fileItem : stack) {
                        if (fileItem.getFieldName().equals("action")) {
                            action = fileItem.getString();
                            break;
                        }
                    }
                    // Based on which action we handle uploading differently
                    // If all goes well we send the result along with a redirect
                    if (action != null) {
                        switch (action) {
                            case "upload-report": {
                                try {
                                    // Use the variables we set using the stack
                                    // to run the right method with those parameters
                                    bc.addCheckUpReport(fileName, conditionLevel, buildingId);
                                    String message = "The checkup has been added to the checkup list.";
                                    response.sendRedirect("/PolygonApp/admin/viewbuilding.jsp?buildingId=" + buildingId + "&success=" + URLEncoder.encode(message, "UTF-8"));
                                } catch (BuildingException ex) {
                                    error = ex.getMessage();
                                    response.sendRedirect("/PolygonApp/admin/uploadreport.jsp?buildingId=" + buildingId + "&error=" + URLEncoder.encode(error, "UTF-8"));
                                }
                                break;
                            }
                            case "upload-document": {
                                User user = (User) request.getSession().getAttribute("user");
                                
                                try {
                                    bc.addCustomerDocument(note, fileName, buildingId);
                                    String message = "The document has been added to the document list.";
                                    
                                    if (user.getUserType().equals(User.userType.CUSTOMER)) {
                                        response.sendRedirect("viewbuilding.jsp?buildingId=" + buildingId + "&success=" + URLEncoder.encode(message, "UTF-8"));
                                    } else {
                                        response.sendRedirect("/PolygonApp/admin/viewbuilding.jsp?buildingId=" + buildingId + "&success=" + URLEncoder.encode(message, "UTF-8"));
                                    }
                                } catch (BuildingException ex) {
                                    error = ex.getMessage();

                                    if (user.getUserType().equals(User.userType.CUSTOMER)) {
                                        response.sendRedirect("uploaddocuments.jsp?buildingId=" + buildingId + "&error=" + URLEncoder.encode(error, "UTF-8"));
                                    } else {
                                        response.sendRedirect("/PolygonApp/admin/uploadfile.jsp?buildingId=" + buildingId + "&error=" + URLEncoder.encode(error, "UTF-8"));
                                    }
                                }
                                break;
                            }
                        }
                    }
                } 
            }
        } catch (FileUploadException ex) {
        } catch (Exception ex) {
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
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
