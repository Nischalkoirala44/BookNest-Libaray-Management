package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.User;
import util.DBConnection;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/updateUser")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1MB
        maxFileSize = 1024 * 1024 * 5,  // 5MB
        maxRequestSize = 1024 * 1024 * 10) // 10MB
public class UpdateProfileServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get the user object from session
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Get the updated profile information from the request
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String bio = request.getParameter("bio");
        String address = request.getParameter("address");
        byte[] image = user.getProfilePicture();

        // Handle profile image upload (if present)
        Part filePart = request.getPart("profileImage");
        if (filePart != null && filePart.getSize() > 0) {
            try (InputStream inputStream = filePart.getInputStream()) {
                image = inputStream.readAllBytes();
            }
        }

        // Update the user object with the new profile data
        user.setName(name);
        user.setEmail(email);
        user.setBio(bio);
        user.setAddress(address);
        if (image != null) {
            user.setProfilePicture(image);
        }

        // Update the user data in the database
        try (Connection conn = DBConnection.getDbConnection()) {
            String sql = "UPDATE users SET name = ?, email = ?, bio = ?, address = ?, profile_picture = ? WHERE userId = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, name);
                stmt.setString(2, email);
                stmt.setString(3, bio);
                stmt.setString(4, address);
                if (image != null) {
                    stmt.setBytes(5, image);
                } else {
                    stmt.setNull(5, java.sql.Types.BLOB);
                }
                stmt.setInt(6, user.getUserId());

                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected == 0) {
                    throw new SQLException("No user found with userId: " + user.getUserId());
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to update profile: " + e.getMessage());
            request.getRequestDispatcher("view/editProfile.jsp").forward(request, response);
            return;
        }

        // After updating, update the session with the latest user object
        request.getSession().setAttribute("user", user);

        // Redirect the user back to their profile page (display updated info)
        response.sendRedirect(request.getContextPath() + "/view/home.jsp");
    }
}
