package controller;

import dao.BookDAO;
import model.Book;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;

@WebServlet("/updateBook")
public class UpdateBookServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int bookId = Integer.parseInt(request.getParameter("bookId"));
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        int totalCopies = Integer.parseInt(request.getParameter("totalCopies"));
        String category = request.getParameter("category");

        // Get image as InputStream (if uploaded)
        InputStream bookImage = null;
        Part filePart = request.getPart("bookImage");
        if (filePart != null && filePart.getSize() > 0) {
            bookImage = filePart.getInputStream();
        }

        Book book = new Book();
        book.setBookId(bookId);
        book.setTitle(title);
        book.setAuthor(author);
        book.setTotalCopies(totalCopies);
        book.setCategory(category);
        if (bookImage != null) {
            book.setBookImage(bookImage); // assumes Book uses InputStream for image
        }

        BookDAO bookDAO = new BookDAO();
        try {
            boolean success = (bookImage != null)
                    ? bookDAO.updateBook(book)
                    : bookDAO.updateBookWithoutImage(book);  // you must create this method if needed

            if (success) {
                response.sendRedirect("books.jsp"); // redirect to book listing page
            } else {
                request.setAttribute("errorMessage", "Failed to update book.");
                request.getRequestDispatcher("update-book.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException("DB error: " + e.getMessage(), e);
        }
    }
}
