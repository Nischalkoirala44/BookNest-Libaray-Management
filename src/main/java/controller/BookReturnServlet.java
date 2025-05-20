package controller;

import dao.BorrowDAO;
import model.Borrow;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/return-book")
public class BookReturnServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int borrowId = Integer.parseInt(request.getParameter("borrowId"));

        BorrowDAO borrowDAO = new BorrowDAO();

        try {
            Borrow borrow = borrowDAO.getBorrowById(borrowId);

            if (borrow != null) {
                BorrowDAO.returnBook(borrow);
                System.out.println("Book returned successfully for borrowId = " + borrowId);
            } else {
                System.out.println("Borrow not found for ID = " + borrowId);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Redirect to borrowed books page after return
        response.sendRedirect("view/home.jsp");
    }
}
