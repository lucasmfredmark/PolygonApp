/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package presentationLayer.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import serviceLayer.controllers.SupportController;
import serviceLayer.entities.User;
import serviceLayer.exceptions.SupportException;

/**
 *
 * @author xboxm
 */
@WebServlet(name = "SupportServlet", urlPatterns = {"/SupportServlet"})
public class SupportServlet extends HttpServlet {

    private String error;
    private String message;

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
            String action = request.getParameter("action");
            SupportController sc = new SupportController();

            switch (action) {
                case "create": {
                    String title = request.getParameter("title");
                    String text = request.getParameter("text");
                    User user = (User) request.getSession().getAttribute("user");
                    int userId = user.getUserId();
                    
                    System.out.println(title + "" + text);
                    try {
                        System.out.println("Before create ticket");
                        sc.createTicket(title, text, userId);
                        System.out.println("Create ticket");
                        message = "Your ticket was succesfully created";
                        response.sendRedirect("support.jsp?message=" + URLEncoder.encode(message, "UTF-8"));
                    } catch (SupportException ex) {
                        error = ex.getMessage();
                        response.sendRedirect("support.jsp?error=" + URLEncoder.encode(error, "UTF-8"));
                    }
                    break;
                }
                case "edit": {
                    try {
                        int ticketId = Integer.parseInt(request.getParameter("ticketId"));
                        String text = request.getParameter("text");
                        sc.editTicket(text, ticketId);
                        message = "Your ticket was succesfully edited";
                        response.sendRedirect("support.jsp?message=" + URLEncoder.encode(message, "UTF-8"));
                    } catch (SupportException ex) {
                        error = ex.getMessage();
                        response.sendRedirect("support.jsp?error=" + URLEncoder.encode(error, "UTF-8"));
                    }
                    break;
                }
                
                case "answer": {
                
                    try {
                        int ticketId = Integer.parseInt(request.getParameter("ticketId"));
                        String text = request.getParameter("answer");
                        sc.answerTicket(ticketId, text);
                        message = "You have answered ticket: " + ticketId + " successfully";
                        response.sendRedirect("/PolygonApp/admin/support.jsp?message=" + URLEncoder.encode(message, "UTF-8"));
                    } catch (SupportException ex) {
                        error = ex.getMessage();
                        response.sendRedirect("/PolygonApp/admin/support.jsp?error=" + URLEncoder.encode(error, "UTF-8"));
                    }
                    break;
                }
                
                case "close": {
                    try {
                       int ticketId = Integer.parseInt(request.getParameter("ticketId"));
                       sc.closeTicket(ticketId);
                        System.out.println(ticketId);
                       message = "You have closed ticket with id: " + ticketId + " successfully";
                       response.sendRedirect("/PolygonApp/admin/support.jsp?message=" + URLEncoder.encode(message, "UTF-8"));
                    } catch (SupportException ex) {
                        error = ex.getMessage();
                        response.sendRedirect("/PolygonApp/admin/support.jsp?error=" + URLEncoder.encode(error, "UTF-8"));
                    }
                    break;
                }
                default: {
                    response.sendRedirect("support.jsp?message=" + URLEncoder.encode(message, "UTF-8"));
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
