package controller;

import dao.ReviewDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Review;

import java.io.IOException;
import java.util.List;

@WebServlet("/ReviewServlet")
public class ReviewServlet extends HttpServlet {

    private ReviewDAO reviewDAO;

    @Override
    public void init() {
        reviewDAO = new ReviewDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String bookIdParam = req.getParameter("bookId");
        String showModal = req.getParameter("showModal");

        if (bookIdParam != null) {
            try {
                int bookId = Integer.parseInt(bookIdParam);
                List<Review> reviews = reviewDAO.getReviewsById(bookId);
                req.setAttribute("reviews", reviews);
                req.setAttribute("bookId", bookId);
                req.setAttribute("showModal", showModal != null && showModal.equals("true"));
                req.getRequestDispatcher("/view/browse.jsp").forward(req, resp);
            } catch (NumberFormatException e) {
                req.setAttribute("error", "Invalid book ID format.");
                req.getRequestDispatcher("/view/browse.jsp").forward(req, resp);
            }
        } else {
            req.setAttribute("error", "Missing 'bookId' parameter.");
            req.getRequestDispatcher("/view/browse.jsp").forward(req, resp);
        }
    }
}