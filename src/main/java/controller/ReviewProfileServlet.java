package controller;

import dao.ReviewDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/ProfilePictureServlet")
public class ReviewProfileServlet extends HttpServlet {

    private ReviewDAO reviewDAO;

    @Override
    public void init() {
        reviewDAO = new ReviewDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String reviewIdStr = request.getParameter("reviewId");

        try {
            int reviewId = Integer.parseInt(reviewIdStr);
            byte[] imageData = reviewDAO.getProfilePictureByReviewId(reviewId);

            if (imageData != null && imageData.length > 0) {
                response.setContentType("image/jpeg");
                response.getOutputStream().write(imageData);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Profile picture not found");
            }

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid review ID");
        }
    }
}
