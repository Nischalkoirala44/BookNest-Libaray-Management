package dao;

import model.Book;
import model.Borrow;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BorrowDAO {

    private static final String INSERT_BORROW =
            "INSERT INTO borrows (userId, bookid, borrow_date, due_date) VALUES (?, ?, ?, ?)";

    private static final String SELECT_ACTIVE_BY_USER =
            "SELECT b.borrowId, b.userId, b.bookid, b.borrow_date, b.due_date, b.penalty, " +
                    "bk.title, bk.category, bk.author, bk.bookImage " +
                    "FROM borrows b " +
                    "JOIN book bk ON b.bookid = bk.bookid " +
                    "WHERE b.userId = ?";

    private static final String SELECT_PENALTY_NOTIFICATIONS =
            "SELECT borrowId, penalty FROM borrows WHERE userId = ? AND penalty > 0";

    public Borrow borrowBook(Borrow borrow) throws SQLException {
        System.out.println("BorrowDAO: Borrowing book for userId = " + borrow.getUserId() + ", bookId = " + borrow.getBookId());
        try (Connection conn = DBConnection.getDbConnection();
             PreparedStatement ps = conn.prepareStatement(INSERT_BORROW, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, borrow.getUserId());
            ps.setInt(2, borrow.getBookId());
            ps.setDate(3, borrow.getBorrowDate());
            ps.setDate(4, borrow.getDueDate());
            System.out.println("BorrowDAO: Executing insert borrow");
            ps.executeUpdate();
            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    borrow.setBorrowId(generatedKeys.getInt(1));
                    System.out.println("BorrowDAO: Borrow created, borrowId = " + borrow.getBorrowId());
                    decrementBookCopyIfAvailable(borrow.getBookId());
                } else {
                    throw new SQLException("Creating borrow failed.");
                }
            }
            return borrow;
        } catch (SQLException e) {
            System.err.println("BorrowDAO: SQLException in borrowBook - " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    public List<Borrow> getActiveBorrowsByUser(int userId) throws SQLException {
        System.out.println("DAO: Fetching borrowed books for userId = " + userId);
        List<Borrow> borrows = new ArrayList<>();
        try (Connection conn = DBConnection.getDbConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_ACTIVE_BY_USER)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Borrow borrow = new Borrow();
                    borrow.setBorrowId(rs.getInt("borrowId"));
                    borrow.setUserId(rs.getInt("userId"));
                    borrow.setBookId(rs.getInt("bookid"));
                    borrow.setBorrowDate(rs.getDate("borrow_date"));
                    borrow.setDueDate(rs.getDate("due_date"));
                    borrow.setPenalty(rs.getDouble("penalty"));

                    Book book = new Book();
                    book.setBookId(rs.getInt("bookid"));
                    book.setTitle(rs.getString("title"));
                    book.setCategory(rs.getString("category"));
                    book.setAuthor(rs.getString("author"));

                    borrow.setBook(book);
                    borrows.add(borrow);
                }
            }
        }
        return borrows;
    }

    public static void returnBook(Borrow borrow) {
        try {
            // Mark the book as returned or delete the borrow record
            Connection conn = DBConnection.getDbConnection();
            String sql = "DELETE FROM borrows WHERE borrowId = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, borrow.getBorrowId());
            stmt.executeUpdate();
            incrementBookCopy(borrow.getBookId());
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Borrow getBorrowById(int borrowId) throws SQLException {
        String sql = "SELECT b.borrowId, b.userId, b.bookid, b.borrow_date, b.due_date, b.penalty, " +
                "bk.title, bk.category, bk.author, bk.bookImage " +
                "FROM borrows b " +
                "JOIN book bk ON b.bookid = bk.bookid " +
                "WHERE b.borrowId = ?";

        try (Connection conn = DBConnection.getDbConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, borrowId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Borrow borrow = new Borrow();
                    borrow.setBorrowId(rs.getInt("borrowId"));
                    borrow.setUserId(rs.getInt("userId"));
                    borrow.setBookId(rs.getInt("bookid"));
                    borrow.setBorrowDate(rs.getDate("borrow_date"));
                    borrow.setDueDate(rs.getDate("due_date"));
                    borrow.setPenalty(rs.getDouble("penalty"));

                    Book book = new Book();
                    book.setBookId(rs.getInt("bookid"));
                    book.setTitle(rs.getString("title"));
                    book.setCategory(rs.getString("category"));
                    book.setAuthor(rs.getString("author"));

                    borrow.setBook(book);
                    return borrow;
                }
            }
        }
        return null;
    }

    private void decrementBookCopyIfAvailable(int bookId) throws SQLException {
        String sql = "UPDATE book SET totalCopies = totalCopies - 1 WHERE bookid = ? AND totalCopies > 0";

        try (Connection conn = DBConnection.getDbConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, bookId);
            int affectedRows = ps.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Cannot borrow book: No copies available.");
            }

            System.out.println("BorrowDAO: Decremented totalCopies for bookId = " + bookId);
        }
    }

    private static void incrementBookCopy(int bookId) throws SQLException {
        String sql = "UPDATE book SET totalCopies = totalCopies + 1 WHERE bookid = ?";

        try (Connection conn = DBConnection.getDbConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, bookId);
            int rowsAffected = ps.executeUpdate();

            if (rowsAffected == 0) {
                throw new SQLException("Failed to increase totalCopies: Book not found with id = " + bookId);
            }

            System.out.println("BorrowDAO: Incremented totalCopies for bookId = " + bookId);
        }
    }

    public void applyPenaltyForUser(int userId) {
        String sql = "UPDATE borrows SET penalty = 100 " +
                "WHERE userId = ? AND CURDATE() > due_date";

        try (Connection conn = DBConnection.getDbConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            int rowsAffected = ps.executeUpdate();
            System.out.println("Penalty applied to " + rowsAffected + " record(s) for userId = " + userId);

        } catch (SQLException e) {
            System.err.println("Error applying penalty for user: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public List<Borrow> getPenaltyNotifications(int userId) throws SQLException {
        List<Borrow> penalties = new ArrayList<>();
        try (Connection conn = DBConnection.getDbConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_PENALTY_NOTIFICATIONS)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Borrow borrow = new Borrow();
                    borrow.setBorrowId(rs.getInt("borrowId"));
                    borrow.setPenalty(rs.getDouble("penalty"));
                    penalties.add(borrow);
                }
            }
        }
        return penalties;
    }


    public List<Borrow> getAllDetailedBorrows() {
        List<Borrow> borrowList = new ArrayList<>();
        String sql = "SELECT b.borrowId, b.userId, b.bookid, b.borrow_date, b.due_date, " +
                "u.name, bk.title, bk.author, bk.category " +
                "FROM borrows b " +
                "JOIN users u ON b.userId = u.userId " +
                "JOIN book bk ON b.bookid = bk.bookid";

        try (Connection conn = DBConnection.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Borrow borrow = new Borrow();
                borrow.setBorrowId(rs.getInt("borrowId"));
                borrow.setUserId(rs.getInt("userId"));
                borrow.setBookId(rs.getInt("bookid"));
                borrow.setBorrowDate(rs.getDate("borrow_date"));
                borrow.setDueDate(rs.getDate("due_date"));
                borrow.setName(rs.getString("name"));

                Book book = new Book();
                book.setBookId(rs.getInt("bookid"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setCategory(rs.getString("category"));

                borrow.setBook(book);
                borrowList.add(borrow);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return borrowList;
    }
}
