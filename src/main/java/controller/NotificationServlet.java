package controller;

import dao.BorrowDAO;
import model.Borrow;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/NotificationServlet")
public class NotificationServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");
        BorrowDAO borrowDAO = new BorrowDAO();
        List<Borrow> penalties;
        try {
            penalties = borrowDAO.getPenaltyNotifications(userId);
            System.out.println(userId);
            System.out.println(penalties);
        } catch (SQLException e) {
            throw new ServletException("Database error fetching penalties", e);
        }

        request.setAttribute("penalties", penalties);
        request.getRequestDispatcher("view/penaltyNotification.jsp").forward(request, response);
    }
}