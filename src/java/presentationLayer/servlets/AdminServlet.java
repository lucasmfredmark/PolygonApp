/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package presentationLayer.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import serviceLayer.controllers.BuildingController;
import serviceLayer.exceptions.BuildingException;

/**
 *
 * @author HazemSaeid
 */
@WebServlet(name = "AdminServlet", urlPatterns = {"/AdminServlet"})
public class AdminServlet extends HttpServlet {

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
            throws ServletException, IOException, SQLException, BuildingException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action").toLowerCase();
        BuildingController bc = new BuildingController();
        try (PrintWriter out = response.getWriter()) {
            switch (action) {
                case "uploaddoc": {

                }
                case "uploadrep": {

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

                        if (bc.editCustomerBuilding(name, address, parcelNumber, size, buildingId)) {
                            String message = "Your changes has been saved to the building.";
                            response.sendRedirect("buildings.jsp?success=" + URLEncoder.encode(message, "UTF-8"));
                        } else {
                            String message = "The building couldn't be updated. Remember to fill out all fields.";
                            response.sendRedirect("editbuilding.jsp?buildingId=" + buildingId + "&error=" + URLEncoder.encode(message, "UTF-8"));
                        }
                    } else {
                        response.sendRedirect("admin/adminIndex.jsp");
                    }
                    break;
                }

            }
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
        } catch (SQLException | BuildingException ex) {
            Logger.getLogger(AdminServlet.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (SQLException | BuildingException ex) {
            Logger.getLogger(AdminServlet.class.getName()).log(Level.SEVERE, null, ex);
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
