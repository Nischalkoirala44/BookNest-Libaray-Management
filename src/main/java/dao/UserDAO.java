package dao;

import model.User;
import util.DBConnection;
import util.PasswordUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    private static final String INSERT_USER =
            "INSERT INTO users(name, email, password, role, profile_picture, bio, address) VALUES(?, ?, ?, ?, ?, ?, ?)";
    private static final String SELECT_USER_BY_EMAIL =
            "SELECT userId, name, email, password, role, profile_picture, bio, address FROM users WHERE email = ?";
    private static final String SELECT_USER_BY_ID =
            "SELECT userId, name, email, password, role, profile_picture, bio, address FROM users WHERE userId = ?";

    private  static final String SELECT_USER =
            "SELECT * FROM users";

    public static int registerUser(User user) {
        String sql = "INSERT INTO users (name, email, password, role, profile_picture, bio, address) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, user.getName());
            stmt.setString(2, user.getEmail());
            String hashedPassword = PasswordUtil.hashPassword(user.getPassword());
            stmt.setString(3, hashedPassword);
            stmt.setString(4, user.getRole().toString());
            stmt.setBytes(5, user.getProfilePicture());
            stmt.setString(6, user.getBio());
            stmt.setString(7, user.getAddress());

            int affectedRows = stmt.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }

        } catch (SQLIntegrityConstraintViolationException e) {
            if (e.getErrorCode() == 1062) {
                System.out.println("Email already exists: " + user.getEmail());
                return -1;
            } else {
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return -1;
    }

    public static User loginUser(User loginAttempt) {
        try (Connection conn = DBConnection.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_USER_BY_EMAIL)) {

            stmt.setString(1, loginAttempt.getEmail());
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("userId"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setRole(User.Role.valueOf(rs.getString("role")));
                user.setProfilePicture(rs.getBytes("profile_picture"));
                // Decrypt bio and address
                user.setBio(rs.getString("bio"));
                user.setAddress(rs.getString("address"));

                if (PasswordUtil.verifyPassword(loginAttempt.getPassword(), user.getPassword())) {
                    return user;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Database error during login", e);
        } catch (Exception e) {
            throw new RuntimeException("Error during login",e);
        }
        return null;
    }

    public static User getUserById(int userId) {
        try (Connection conn = DBConnection.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_USER_BY_ID)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("userId"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setRole(User.Role.valueOf(rs.getString("role")));
                user.setProfilePicture(rs.getBytes("profile_picture"));
                user.setBio(rs.getString("bio"));
                user.setAddress(rs.getString("address"));
                return user;
            }
        } catch (SQLException e) {
            throw new RuntimeException("Database error fetching user", e);
        }
        return null;
    }

    public static List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        try (Connection conn = DBConnection.getDbConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_USER);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("userid"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setAddress(rs.getString("address"));
                user.setBio(rs.getString("bio"));
                String roleStr = rs.getString("role");
                if (roleStr != null) {
                    user.setRole(User.Role.valueOf(roleStr.toLowerCase()));
                }

                user.setProfilePicture(rs.getBytes("profile_picture"));

                users.add(user);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Database error fetching users", e);
        }
        return users;
    }

    public byte[] getProfilePicture(int userId) throws  SQLException{
        try (Connection conn = DBConnection.getDbConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_USER_BY_ID)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    java.sql.Blob blob = rs.getBlob("profile_picture");
                    if (blob != null) {
                        System.out.println("blob exists: " + blob.length() + " bytes long.");
                        return blob.getBytes(1, (int) blob.length());
                    }
                }
                return null;
            }
        } catch (SQLException e) {
            throw new SQLException("Error fetching profile picture: " + e.getMessage(), e);
        }
    }
}
