package controller;

import dao.BookDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/deleteBook")
public class DeleteBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookDAO bookDAO;

    @Override
    public void init() throws ServletException {
        bookDAO = new BookDAO(); // Initialize DAO (or use DI if you have it)
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bookIdStr = request.getParameter("bookId");

        if (bookIdStr == null || bookIdStr.isEmpty()) {
            request.setAttribute("errorMessage", "Book ID is missing.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }

        try {
            int bookId = Integer.parseInt(bookIdStr);

            boolean deleted = bookDAO.deleteBook(bookId);
            if (deleted) {
                response.sendRedirect(request.getContextPath() + "/view/adminPanel.jsp");
            } else {
                // Forward to error page
                request.setAttribute("errorMessage", "No book found with the given ID or deletion failed.");
                request.getRequestDispatcher("/view/error.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid book ID format.");
            request.getRequestDispatcher("/view/error.jsp").forward(request, response);
        }
    }
}
