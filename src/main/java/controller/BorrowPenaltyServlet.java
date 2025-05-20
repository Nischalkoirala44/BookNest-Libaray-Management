package controller;

import dao.BorrowDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;


@WebServlet("/applyPenalty")
public class BorrowPenaltyServlet extends HttpServlet {

    private BorrowDAO borrowDAO = new BorrowDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userIdParam = request.getParameter("userId");
        if (userIdParam == null || userIdParam.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Missing userId parameter");
            return;
        }

        try {
            int userId = Integer.parseInt(userIdParam);
            borrowDAO.applyPenaltyForUser(userId);

            // Redirect back to the referring page to stay on current page
            String referer = request.getHeader("Referer");
            if (referer != null) {
                response.sendRedirect(referer);
            } else {
                // fallback redirect to default page if referer is missing
                response.sendRedirect(request.getContextPath() + "/applyPenalty");
            }
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Invalid userId parameter");
        }
    }

}
