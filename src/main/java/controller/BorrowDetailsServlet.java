package controller;

import dao.BorrowDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Borrow;

import java.io.IOException;
import java.util.List;

@WebServlet("/issuedBooks")
public class BorrowDetailsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BorrowDAO dao = new BorrowDAO();
        List<Borrow> borrows = dao.getAllDetailedBorrows();
        request.setAttribute("borrowList", borrows);
        request.getRequestDispatcher("/view/issued.jsp").forward(request, response);
    }
}
