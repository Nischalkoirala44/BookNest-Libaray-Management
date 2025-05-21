package controller;

import dao.BorrowDAO;
import model.Borrow;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/borrowed-home")
public class HomeServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        System.out.println("User ID: " + userId);
        BorrowDAO borrowDAO = new BorrowDAO();

        try {
            List<Borrow> borrowedBooks = borrowDAO.getActiveBorrowsByUser(userId);
            request.setAttribute("borrowedBooks", borrowedBooks);
            request.getRequestDispatcher("view/home.jsp").forward(request, response);
            System.out.println("Borrowed books count: " + borrowedBooks.size());


        } catch (SQLException e) {
            throw new ServletException("Unable to fetch borrowed books", e);
        }
    }
}
