package presentationLayer.servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
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
 * @author lucas
 */
@WebServlet(name = "BuildingServlet", urlPatterns = {"/BuildingServlet"})
public class BuildingServlet extends HttpServlet {

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
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String action = request.getParameter("action").toLowerCase();
            BuildingController buildingController = new BuildingController();

            switch (action) {
                case "add": {
                    String name = request.getParameter("bname");
                    String address = request.getParameter("address");
                    String parcelNumber = request.getParameter("parcel");
                    int size = Integer.parseInt(request.getParameter("size"));

                    User user = (User) request.getSession().getAttribute("user");
                    int userId = user.getId();

                    if (buildingController.addBuilding(name, address, parcelNumber, size, userId)) {
                        String message = "The building has been added to your overview.";
                        response.sendRedirect("buildings.jsp?success=" + URLEncoder.encode(message, "UTF-8"));
                    } else {
                        String message = "The building couldn't be added. Remember to fill out all fields.";
                        response.sendRedirect("addbuilding.jsp?error=" + URLEncoder.encode(message, "UTF-8"));
                    }
                    break;
                }
                case "delete": {
                    int buildingId = Integer.parseInt(request.getParameter("buildingId"));

                    if (buildingController.deleteBuilding(buildingId)) {
                        String message = "The building has been deleted.";
                        response.sendRedirect("buildings.jsp?success=" + URLEncoder.encode(message, "UTF-8"));
                    } else {
                        String message = "The building couldn't be deleted because of an error.";
                        response.sendRedirect("buildings.jsp?error=" + URLEncoder.encode(message, "UTF-8"));
                    }
                    break;
                }
                case "edit": {
                    String name = request.getParameter("bname");
                    String address = request.getParameter("address");
                    String parcelNumber = request.getParameter("parcel");
                    int size = Integer.parseInt(request.getParameter("size"));

                    int buildingId = Integer.parseInt(request.getParameter("buildingId"));

                    if (buildingController.editBuilding(name, address, parcelNumber, size, buildingId)) {
                        String message = "Your changes has been saved to the building.";
                        response.sendRedirect("buildings.jsp?success=" + URLEncoder.encode(message, "UTF-8"));
                    } else {
                        String message = "The building couldn't be updated. Remember to fill out all fields.";
                        response.sendRedirect("editbuilding.jsp?buildingId=" + buildingId + "&error=" + URLEncoder.encode(message, "UTF-8"));
                    }
                }
                case "upload": {
                    // Apache commons file upload section -->
                    // Check that we have a file upload request
                    boolean isMultipart = ServletFileUpload.isMultipartContent(request);

                    // Create a factory for disk-based file items
                    DiskFileItemFactory factory = new DiskFileItemFactory();

                    // Configure a repository (to ensure a secure temp location is used)
                    ServletContext servletContext = this.getServletConfig().getServletContext();
                    File repository = (File) servletContext.getAttribute("javax.servlet.context.tempdir");
                    factory.setRepository(repository);

                    // Create a new file upload handler
                    ServletFileUpload upload = new ServletFileUpload(factory);

                    // Parse the request
                    List<FileItem> items = upload.parseRequest(request);
                    System.out.println("Number of items: " + items.size());
                }

            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (FileUploadException ex) {
            Logger.getLogger(BuildingServlet.class.getName()).log(Level.SEVERE, null, ex);
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
