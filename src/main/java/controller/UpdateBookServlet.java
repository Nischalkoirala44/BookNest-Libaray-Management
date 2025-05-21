package controller;

import dao.BookDAO;
import jakarta.servlet.annotation.MultipartConfig;
import model.Book;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;

@WebServlet("/updateBook")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1MB
        maxFileSize = 1024 * 1024 * 5,  // 5MB
        maxRequestSize = 1024 * 1024 * 10) // 10MB
public class UpdateBookServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {
        System.out.println("UpdateBookServlet initialized");
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int bookId = Integer.parseInt(request.getParameter("bookId"));
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        int totalCopies = Integer.parseInt(request.getParameter("totalCopies"));
        String category = request.getParameter("category");

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
            book.setBookImage(bookImage);
        }

        BookDAO bookDAO = new BookDAO();
        try {
            boolean success = (bookImage != null)
                    ? bookDAO.updateBook(book)
                    : bookDAO.updateBookWithoutImage(book);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/view/adminPanel.jsp");
                System.out.println("Book updated successfully");
            } else {
                request.setAttribute("errorMessage", "Failed to update book.");
                request.getRequestDispatcher("editBookForm.jsp").forward(request, response);
                System.out.println("Failed to Update book");
            }
        } catch (SQLException e) {
            throw new ServletException("DB error: " + e.getMessage(), e);
        }
    }

}
