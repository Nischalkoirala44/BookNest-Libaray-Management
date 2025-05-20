package dao;

import model.Review;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class ReviewDAO {


    // Save a new review to the database
    public boolean saveReview(Review review) {
        String sql = "INSERT INTO review (comment, userId, bookid) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, review.getComment());
            stmt.setInt(2, review.getUserId());
            stmt.setInt(3, review.getBookId());
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Review> getReviewsById(int bookId) {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT r.reviewId, r.comment, r.bookid, r.userId, u.name, u.profile_picture " +
                "FROM review r " +
                "JOIN users u ON r.userId = u.userId " +
                "JOIN book b ON r.bookid = b.bookid " +
                "WHERE r.bookid = ?";
        try (Connection conn = DBConnection.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, bookId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Review review = new Review();
                review.setReviewId(rs.getInt("reviewId"));
                review.setComment(rs.getString("comment"));
                review.setBookId(rs.getInt("bookid"));
                review.setUserId(rs.getInt("userId"));
                review.setName(rs.getString("name"));
                review.setProfilePicture(rs.getBytes("profile_picture"));
                reviews.add(review);
                System.out.println(review.getComment());
                System.out.println(Arrays.toString(review.getProfilePicture()));
                System.out.println(review.getName());
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reviews;
    }

    public byte[] getProfilePictureByReviewId(int reviewId) {
        String sql = "SELECT u.profile_picture " +
                "FROM review r " +
                "JOIN users u ON r.userId = u.userId " +
                "WHERE r.reviewId = ?";

        try (Connection conn = DBConnection.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, reviewId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getBytes("profile_picture");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

}