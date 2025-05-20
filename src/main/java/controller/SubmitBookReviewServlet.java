package controller;

import dao.ReviewDAO;
import model.Review;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.logging.Logger;

@WebServlet("/submit-book-review")
public class SubmitBookReviewServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(SubmitBookReviewServlet.class.getName());
    private ReviewDAO reviewDAO;

    @Override
    public void init() throws ServletException {
        LOGGER.info("Initializing SubmitBookReviewServlet");
        reviewDAO = new ReviewDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        LOGGER.info("Received POST request to /submit-book-review");

        // Check session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            LOGGER.warning("No active session or userId not found. Redirecting to login.jsp");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        LOGGER.info("Session valid, userId in session: " + session.getAttribute("userId"));

        // Get parameters
        String bookId = request.getParameter("bookId");
        String userId = request.getParameter("userId");
        String comment = request.getParameter("comment");
        LOGGER.info("Parameters - bookId: " + bookId + ", userId: " + userId + ", comment: " +
                (comment != null ? comment.substring(0, Math.min(comment.length(), 50)) + "..." : "null"));

        // Validate inputs
        if (bookId == null || bookId.trim().isEmpty() ||
                userId == null || userId.trim().isEmpty() ||
                comment == null || comment.trim().isEmpty()) {
            String errorMsg = "Missing required parameters: bookId=" + bookId + ", userId=" + userId + ", comment=" +
                    (comment == null ? "null" : "empty");
            LOGGER.warning(errorMsg + ". Forwarding to /error.jsp");
            request.setAttribute("error", "Review comment, book ID, or user ID is missing.");
            try {
                request.getRequestDispatcher("/error.jsp").forward(request, response);
            } catch (Exception e) {
                LOGGER.severe("Failed to forward to /error.jsp: " + e.getMessage());
                throw new ServletException("Error forwarding to error.jsp", e);
            }
            return;
        }

        try {
            // Parse parameters
            int bookIdInt = Integer.parseInt(bookId);
            int userIdInt = Integer.parseInt(userId);
            LOGGER.info("Parsed parameters - bookId: " + bookIdInt + ", userId: " + userIdInt);

            // Create Review object
            Review review = new Review();
            review.setComment(comment);
            review.setUserId(userIdInt);
            review.setBookId(bookIdInt);

            // Save review
            LOGGER.info("Attempting to save review for bookId=" + bookIdInt);
            boolean success = reviewDAO.saveReview(review);
            if (success) {
                LOGGER.info("Review saved successfully for bookId=" + bookIdInt);
                response.sendRedirect(request.getContextPath() + "/view/browse.jsp");
            } else {
                String errorMsg = "Failed to save review to database.";
                LOGGER.warning(errorMsg + ". Forwarding to /error.jsp");
                request.setAttribute("error", errorMsg);
                try {
                    request.getRequestDispatcher("/view/error.jsp").forward(request, response);
                } catch (Exception e) {
                    LOGGER.severe("Failed to forward to /error.jsp: " + e.getMessage());
                    throw new ServletException("Error forwarding to error.jsp", e);
                }
            }
        } catch (NumberFormatException e) {
            String errorMsg = "Invalid format for bookId or userId: bookId=" + bookId + ", userId=" + userId;
            LOGGER.warning(errorMsg + ". Forwarding to /error.jsp");
            request.setAttribute("error", "Invalid book ID or user ID format.");
            try {
                request.getRequestDispatcher("/error.jsp").forward(request, response);
            } catch (Exception ex) {
                LOGGER.severe("Failed to forward to /error.jsp: " + ex.getMessage());
                throw new ServletException("Error forwarding to error.jsp", ex);
            }
        } catch (Exception e) {
            String errorMsg = "Unexpected error while saving review.";
            LOGGER.severe(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while saving the review.");
            try {
                request.getRequestDispatcher("/error.jsp").forward(request, response);
            } catch (Exception ex) {
                LOGGER.severe("Failed to forward to /error.jsp: " + ex.getMessage());
                throw new ServletException("Error forwarding to error.jsp", ex);
            }
        }
    }
}