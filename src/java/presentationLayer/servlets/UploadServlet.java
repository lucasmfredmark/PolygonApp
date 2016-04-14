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

/**
 *
 * @author Patrick
 */
public class UploadServlet extends HttpServlet {
    private File file;
    private String filePath;
    private String path;
    private String fileName;
    private int conditionLevel;
    private BuildingController bc;
    private String note;
    private int buildingId;
    private int orderId;
    private ArrayList<FileItem> stack;
    boolean isPathSet;
    boolean isWritten;
    
    @Override
    public void init() {
        // The file path is specified in folder Configuration Files -> web.xml.
        // The file path is set to work for a user, so it won't run on your computer. Fow now.
        bc = new BuildingController();
        fileName = null;
        path = null;
        note = null;
        conditionLevel = Integer.MIN_VALUE;
        orderId = 0;
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
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, FileUploadException, Exception {
        response.setContentType("text/html;charset=UTF-8");
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
                    FileItem fi = (FileItem) i.next();
                    if (!fi.isFormField()) {
                        //Get the uploaded file name
                        String tempFileName = fi.getName();
                        fileName = tempFileName;
                        //Write the file
                        if (tempFileName.lastIndexOf("\\") >= 0) {
                            file = new File(filePath
                                    + tempFileName.substring(tempFileName.lastIndexOf("\\")));
                        } else {
                            file = new File(filePath
                                    + tempFileName.substring(tempFileName.lastIndexOf("\\") + 1));
                        }
                        fi.write(file);
                        isWritten = true;
                    } else {
                        stack.add(fi);
                        System.out.println(isPathSet);
                        if (!isPathSet && fi.getFieldName().equals("directory")) {
                            filePath = getServletContext().getInitParameter(fi.getString());
                            isPathSet = true;
                        }
                    }
                }
                
                if (isWritten) {
                    String action = null;
                    for (FileItem fileItem : stack) {
                        if (fileItem.getFieldName().equals("action")) {
                            action = fileItem.getString();
                            break;
                        }
                    }
                    
                    User user = (User) request.getSession().getAttribute("user");
                    
                    switch (action) {
                        case "upload-report": {
                            for (FileItem fileItem : stack) {
                                String fieldName = fileItem.getFieldName();
                                path = fileItem.getFieldName();
                                
                                switch (fieldName) {
                                    case "conditionLevel": {
                                        conditionLevel = 0;
                                        try {
                                            conditionLevel = Integer.parseInt(fileItem.getString());
                                        } catch (NumberFormatException ex) {
                                        }
                                        System.out.println(conditionLevel);
                                        break;
                                    }
                                    case "buildingId": {
                                        buildingId = 0;
                                        
                                        try {
                                            buildingId = Integer.parseInt(fileItem.getString());
                                        } catch (NumberFormatException ex) {
                                        }
                                        System.out.println(buildingId);
                                        break;
                                    }
                                    case "orderId": {
                                        orderId = 0;
                                        
                                        try {
                                            orderId = Integer.parseInt(fileItem.getString());
                                        } catch (NumberFormatException ex) {
                                        }
                                        System.out.println(orderId);
                                        break;
                                    }
                                    
                                }
                            }
                            if (bc.addCheckUpReport(path, conditionLevel, buildingId, orderId)) {
                                String message = "The checkup has been added to the checkup list.";
                                response.sendRedirect("/PolygonApp/admin/uploadreport.jsp?buildingId=" + buildingId + "&success=" + URLEncoder.encode(message, "UTF-8"));
                            } else {
                                String message = "The document couldn't be added to the document list.";
                                response.sendRedirect("/PolygonApp/admin/uploadreport.jsp?buildingId=" + buildingId + "&error=" + URLEncoder.encode(message, "UTF-8"));
                            }
                            break;
                        }
                        case "upload-document": {
                            for (FileItem fileItem : stack) {
                                String fieldName = fileItem.getFieldName();
                                
                                switch (fieldName) {
                                    case "note": {
                                        note = fileItem.getString();
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
                                }
                            }
                            
                            if (bc.addCustomerDocument(note, fileName, buildingId, user.getUserId())) {
                                String message = "The document has been added to the document list.";
                                response.sendRedirect("viewbuilding.jsp?buildingId=" + buildingId + "&success=" + URLEncoder.encode(message, "UTF-8"));
                            } else {
                                String message = "The document couldn't be added to the document list.";
                                response.sendRedirect("viewbuilding.jsp?buildingId=" + buildingId + "&error=" + URLEncoder.encode(message, "UTF-8"));
                            }
                            break;
                        }
                        
                        case "upload-image": {
                            for (FileItem fileItem : stack) {
                                String fieldName = fileItem.getFieldName();
                                path = fileItem.getFieldName();
                                switch (fieldName) {
                                    case "buildingId": {
                                        buildingId = 0;
                                        
                                        try {
                                            buildingId = Integer.parseInt(fileItem.getString());
                                        } catch (NumberFormatException ex) {
                                        }
                                        break;
                                    }
                                }
                            }
                            if (bc.addCheckUpReport(path, conditionLevel, buildingId, orderId)) {
                                String message = "The checkup has been added to the checkup list.";
                                response.sendRedirect("/PolygonApp/admin/uploadimg.jsp?buildingId=" + buildingId + "&success=" + URLEncoder.encode(message, "UTF-8"));
                            } else {
                                String message = "The document couldn't be added to the document list.";
                                response.sendRedirect("/PolygonApp/admin/uploadimg.jsp?buildingId=" + buildingId + "&error=" + URLEncoder.encode(message, "UTF-8"));
                            }
                            break;
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
