package controller;

import dao.BookDAO;
import dao.UserDAO;
import dao.BorrowDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/admin-dashboard")
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Get DAOs
            BookDAO bookDAO = new BookDAO();
            UserDAO userDAO = new UserDAO();
            BorrowDAO borrowDAO = new BorrowDAO();

            // Fetch dashboard statistics
            int totalUsers = userDAO.getAllUsers().size();
            int totalBooks = bookDAO.getAllBooks().size();
            int currentlyBorrowed = borrowDAO.getAllDetailedBorrows().size();
            int totalBorrows = borrowDAO.getAllDetailedBorrows().size();

            // Set attributes for the JSP
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalBooks", totalBooks);
            request.setAttribute("currentlyBorrowed", currentlyBorrowed);
            request.setAttribute("totalBorrows", totalBorrows);

            // Forward to the dashboard JSP
            request.getRequestDispatcher("/view/adminPanel.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error loading dashboard: " + e.getMessage());
            request.getRequestDispatcher("/view/adminPanel.jsp").forward(request, response);
        }
    }
}