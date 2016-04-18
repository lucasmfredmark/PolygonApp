package presentationLayer.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
                    if (request.getSession().getAttribute("user") != null) {
                        String name = request.getParameter("bname");
                        String address = request.getParameter("address");
                        String parcelNumber = request.getParameter("parcel");
                        int size = 0;
                        
                        try {
                            size = Integer.parseInt(request.getParameter("size"));
                        } catch (NumberFormatException ex) {
                        }
                        
                        User user = (User) request.getSession().getAttribute("user");
                        int userId = user.getUserId();

                        if (buildingController.addCustomerBuilding(name, address, parcelNumber, size, userId)) {
                            String message = "The building has been added to your overview.";
                            response.sendRedirect("buildings.jsp?success=" + URLEncoder.encode(message, "UTF-8"));
                        } else {
                            String message = "The building couldn't be added. Remember to fill out all fields.";
                            response.sendRedirect("addbuilding.jsp?error=" + URLEncoder.encode(message, "UTF-8"));
                        }
                    } else {
                        response.sendRedirect("index.jsp");
                    }
                    break;
                }
                case "delete": {
                    if (request.getSession().getAttribute("user") != null) {
                        int buildingId = 0;
                        
                        try {
                            buildingId = Integer.parseInt(request.getParameter("buildingId"));
                        } catch (NumberFormatException ex) {
                        }
                        
                        if (buildingController.deleteCustomerBuilding(buildingId)) {
                            String message = "The building has been deleted.";
                            response.sendRedirect("buildings.jsp?success=" + URLEncoder.encode(message, "UTF-8"));
                        } else {
                            String message = "The building couldn't be deleted because of an error.";
                            response.sendRedirect("buildings.jsp?error=" + URLEncoder.encode(message, "UTF-8"));
                        }
                    } else {
                        response.sendRedirect("index.jsp");
                    }
                    break;
                }
                case "edit": {
                    if (request.getSession().getAttribute("user") != null) {
                        String name = request.getParameter("bname");
                        String address = request.getParameter("address");
                        String parcelNumber = request.getParameter("parcel");
                        int size = 0;
                        
                        try {
                            size = Integer.parseInt(request.getParameter("size"));
                        } catch (NumberFormatException ex) {
                        }
                        
                        int buildingId = Integer.parseInt(request.getParameter("buildingId"));

                        if (buildingController.editCustomerBuilding(name, address, parcelNumber, size, buildingId)) {
                            String message = "Your changes has been saved to the building.";
                            response.sendRedirect("viewbuilding.jsp?buildingId=" + buildingId + "&success=" + URLEncoder.encode(message, "UTF-8"));
                        } else {
                            String message = "The building couldn't be updated. Remember to fill out all fields.";
                            response.sendRedirect("editbuilding.jsp?buildingId=" + buildingId + "&error=" + URLEncoder.encode(message, "UTF-8"));
                        }
                    } else {
                        response.sendRedirect("index.jsp");
                    }
                    break;
                }
                case "adddmg": {
                    if (request.getSession().getAttribute("user") != null) {
                        String dmgtitle = request.getParameter("dmgtitle");
                        String desc = request.getParameter("dmgdesc");
                        int buildingId = 0;
                        
                        try {
                            buildingId = Integer.parseInt(request.getParameter("buildingId"));
                        } catch (NumberFormatException ex) {
                        }
                        
                        if (buildingController.addDamage(dmgtitle, desc, buildingId)) {
                            String message = "Your changes has been saved to the building.";
                            response.sendRedirect("viewbuilding.jsp?buildingId=" + buildingId + "&success=" + URLEncoder.encode(message, "UTF-8"));
                        } else {
                            String message = "The damage couldn't be added to the building. Remember to fill out all fields.";
                            response.sendRedirect("adddamage.jsp?buildingId=" + buildingId + "&error=" + URLEncoder.encode(message, "UTF-8"));
                        }
                    } else {
                        response.sendRedirect("index.jsp");
                    }
                    break;
                }
                case "request-checkup": {
                    if (request.getSession().getAttribute("user") != null) {
                        int orderStatus = 0;
                        int serviceId = 1;
                        int buildingId = 0;
                        
                        try {
                            buildingId = Integer.parseInt(request.getParameter("buildingId"));
                        } catch (NumberFormatException ex) {
                        }
                        
                        User user = (User) request.getSession().getAttribute("user");
                        System.out.println("buildingId: " + buildingId + "User: " + user.getFullName());
                        
                        if (buildingController.requestCheckup(orderStatus, buildingId, user)) {
                            String message = "A check-up has been requested for your building. An employee will look into your case as soon as possible.";
                            response.sendRedirect("viewbuilding.jsp?buildingId=" + buildingId + "&success=" + URLEncoder.encode(message, "UTF-8"));
                        } else {
                            String message = "A check-up could not be requested for your building. Try again later.";
                            response.sendRedirect("viewbuilding.jsp?buildingId=" + buildingId + "&error=" + URLEncoder.encode(message, "UTF-8"));
                        }
                    } else {
                        response.sendRedirect("index.jsp");
                    }
                    break;
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
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
