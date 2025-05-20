package controller;

import dao.BookDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import model.Book;

@WebServlet("/ViewBookServlet")
public class ViewBookServlet extends HttpServlet {

    private BookDAO bookDAO;

    @Override
    public void init() {
        bookDAO = new BookDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Book> books = bookDAO.getAllBooks();
            for (Book book : books) {
                System.err.println("Book: ID=" + book.getBookId() + ", Title=" + book.getTitle());
            }
            request.setAttribute("books", books);
            request.getRequestDispatcher("view/viewBook.jsp").forward(request, response);
        } catch (SQLException e) {
            System.err.println("Database error in ViewBookServlet: " + e.getMessage());
            throw new ServletException("Cannot load books: " + e.getMessage(), e);
        }
    }
}