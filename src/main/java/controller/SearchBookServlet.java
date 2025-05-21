package controller;

import dao.BookDAO;
import model.Book;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/SearchBookServlet")
public class SearchBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookDAO bookDAO;

    public void init() {
        bookDAO = new BookDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("SearchBookServlet called");

        try{
            String searchTerm = request.getParameter("searchTerm");
            String author = request.getParameter("author");
            String category = request.getParameter("category");


            List<Book> books = null;


            // Step 1: Initial Search

            if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                // General search by title if search term exists
                books = bookDAO.searchByTitle(searchTerm);
            } else {
                // Get all books if no specific search
                books = bookDAO.getAllBooks();
            }



            // Step 2: Filter by category
            if (category != null && !category.equals("all") && !category.trim().isEmpty()) {
                books = books.stream()
                        .filter(book -> book.getCategory().equalsIgnoreCase(category))
                        .collect(Collectors.toList());
            }

            // Step 4: Forward to JSP
            request.setAttribute("books", books);
            request.getRequestDispatcher("/view/browse.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();    // In case of error, set the error message and forward to the same page
            request.setAttribute("errorMessage", "Error searching books: " + e.getMessage());
            request.getRequestDispatcher("/view/browse.jsp").forward(request, response);
        }
    }
}
