package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;

import dao.BookDAO;
import model.Book;

@WebServlet("/AddBookServlet")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5)
public class AddBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookDAO bookDAO;

    public void init() {
        bookDAO = new BookDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String totalCopiesStr = request.getParameter("totalCopies");
        String category = request.getParameter("category");
        Part filePart = request.getPart("bookImage");
        InputStream bookImage = null;

        if (filePart != null && filePart.getSize() > 0) {
            bookImage = filePart.getInputStream();
        }

        try {
            int totalCopies = Integer.parseInt(totalCopiesStr);
            Book newBook = new Book(title, author, totalCopies, category, bookImage);
            bookDAO.insertBook(newBook);
            response.sendRedirect(request.getContextPath() + "/view/books.jsp");

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid number format.");
            request.getRequestDispatcher("/view/books.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Failed to add book: " + e.getMessage());
            request.getRequestDispatcher("/view/books.jsp").forward(request, response);

        } finally {
            if (bookImage != null) {
                bookImage.close();
            }
        }
    }
}
