package controller;

import dao.UserDAO;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Validate inputs
        if (email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "Email and password are required.");
            request.getRequestDispatcher("view/login.jsp").forward(request, response);
            return;
        }

        User loginAttempt = new User();
        loginAttempt.setEmail(email);
        loginAttempt.setPassword(password);

        try {
            User authenticatedUser = UserDAO.loginUser(loginAttempt);
            if (authenticatedUser != null) {

                HttpSession session = request.getSession();
                session.setAttribute("user", authenticatedUser);
                session.setAttribute("userId", authenticatedUser.getUserId());
                System.out.println("userid=" + authenticatedUser.getUserId());

                // Redirect based on role
                if (authenticatedUser.getRole() == User.Role.admin) {
                    response.sendRedirect(request.getContextPath() + "/view/adminPanel.jsp");
                } else {
                    response.sendRedirect(request.getContextPath() + "/view/home.jsp");
                }
            } else {
                request.setAttribute("error", "Invalid email or password.");
                request.getRequestDispatcher("view/login.jsp").forward(request, response);
            }
        } catch (RuntimeException e) {
            System.err.println("LoginServlet: Exception during login: " + e.getMessage()); // Debugging
            e.printStackTrace();
            request.setAttribute("error", "Login failed: " + e.getMessage());
            request.getRequestDispatcher("view/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("view/login.jsp").forward(request, response);
    }
}
