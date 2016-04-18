/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package presentationLayer.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import serviceLayer.controllers.UserController;
import serviceLayer.entities.User;
import serviceLayer.exceptions.UserException;

/**
 *
 * @author lucas
 */
@WebServlet(name = "UserServlet", urlPatterns = {"/UserServlet"})
public class UserServlet extends HttpServlet {

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
            throws ServletException, IOException, UserException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String action = request.getParameter("action");
            UserController userController = new UserController();

            switch (action) {
                case "login": {
                    if (request.getSession().getAttribute("user") == null) {
                        String email = request.getParameter("e-mail");
                        String password = request.getParameter("userpass");
                        User user = userController.loginUser(email, password);

                        if (user != null) {
                            request.getSession().setAttribute("user", user);
                            
                            if (user.getUserType().equals(User.userType.ADMIN)) {
                                response.sendRedirect("admin/index.jsp");
                                break;
                            }
                            
                            response.sendRedirect("buildings.jsp");
                            break;
                        } else {
                            String message = "The user doesn\'t exist, or you typed the wrong password.";
                            response.sendRedirect("index.jsp?error=" + URLEncoder.encode(message, "UTF-8"));
                        }
                    } else {
                        response.sendRedirect("buildings.jsp");
                    }
                    break;
                }
                case "register": {
                    if (request.getSession().getAttribute("user") == null) {
                        String email = request.getParameter("e-mail");
                        String fullname = request.getParameter("fullname");
                        String password = request.getParameter("userpass");

                        if (userController.registerUser(email, fullname, password)) {
                            String message = "Your account has successfully been created. You can now log in.";
                            response.sendRedirect("index.jsp?success=" + URLEncoder.encode(message, "UTF-8"));
                        } else {
                            String message = "The user already exists, or another error happened.";
                            response.sendRedirect("register.jsp?error=" + URLEncoder.encode(message, "UTF-8"));
                        }
                    } else {
                        response.sendRedirect("buildings.jsp");
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
        } catch (UserException ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (UserException ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
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
