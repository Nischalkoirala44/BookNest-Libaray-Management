package controller;

import dao.BorrowDAO;
import  model.Borrow;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/borrow")
public class BorrowServlet extends HttpServlet {
    private BorrowDAO borrowDAO;

    @Override
    public void init() {
        borrowDAO = new BorrowDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            int bookId = Integer.parseInt(request.getParameter("bookId"));

            Borrow borrow = new Borrow();
            borrow.setUserId(userId);
            borrow.setBookId(bookId);
            borrow.setBorrowDate(Date.valueOf(LocalDate.now()));
            borrow.setDueDate(Date.valueOf(LocalDate.now().plusWeeks(2)));

            borrowDAO.borrowBook(borrow);

            request.setAttribute("message", "Book borrowed successfully!");
            response.setStatus(HttpServletResponse.SC_OK);

        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            request.setAttribute("error", "Invalid User Id and Book Id format");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        request.getRequestDispatcher("/view/browse.jsp").forward(request, response);
    }


}