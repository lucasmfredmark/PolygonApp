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
    private String error;

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
     * @throws org.apache.commons.fileupload.FileUploadException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, FileUploadException, Exception {
        response.setContentType("text/html;charset=UTF-8");
        
        boolean isMultipart = ServletFileUpload.isMultipartContent(request);

        try (PrintWriter out = response.getWriter()) {
            
            if (isMultipart) {
                int maxMemSize = 50 * 1024;
                DiskFileItemFactory factory = new DiskFileItemFactory();
                factory.setSizeThreshold(maxMemSize);
                factory.setRepository(new File("C:\\PolygonFiles"));
                ServletFileUpload uploadHandler = new ServletFileUpload(factory);
                List fileItems = uploadHandler.parseRequest(request);
                Iterator i = fileItems.iterator();

                while (i.hasNext()) {
                    FileItem fi = (FileItem) i.next();
                    if (!fi.isFormField()) {
                        String tempFileName = fi.getName();
                        fileName = tempFileName;
                        
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
                        if (!isPathSet && fi.getFieldName().equals("directory")) {
                            filePath = getServletContext().getInitParameter(fi.getString());
                            isPathSet = true;
                        }
                    }
                }

                if (isWritten) {
                    for (FileItem fileItem : stack) {
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
                            case "orderId": {
                                orderId = 0;
                                
                                try {
                                    orderId = Integer.parseInt(fileItem.getString());
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
                    
                    String action = null;
                    for (FileItem fileItem : stack) {
                        if (fileItem.getFieldName().equals("action")) {
                            action = fileItem.getString();
                            break;
                        }
                    }
                    
                    if (action != null) {
                        switch (action) {
                            case "upload-report": {
                                try {
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
                                        response.sendRedirect("viewbuilding.jsp?buildingId=" + buildingId + "&error=" + URLEncoder.encode(error, "UTF-8"));
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
