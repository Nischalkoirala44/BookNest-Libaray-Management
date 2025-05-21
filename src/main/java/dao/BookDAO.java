package dao;

import model.Book;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BookDAO {

    private static final String INSERT_BOOK =
            "INSERT INTO book(title, author, totalcopies, category, bookImage) VALUES (?,?,?,?,?)";

    private static final String SELECT_BOOK =
            "SELECT bookid, title, author, totalcopies, category FROM book";

    private static final String SELECT_BOOK_IMAGE =
            "SELECT bookImage FROM book WHERE bookid = ?";

    private static final String SEARCH_BY_TITLE =
            "SELECT bookid, title, author, totalcopies, category FROM book WHERE title LIKE ?";

    public void insertBook(Book book) throws SQLException {
        try (Connection conn = DBConnection.getDbConnection();
             PreparedStatement ps = conn.prepareStatement(INSERT_BOOK, PreparedStatement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, book.getTitle());
            ps.setString(2, book.getAuthor());
            ps.setInt(3, book.getTotalCopies());
            ps.setString(4, book.getCategory());
            ps.setBlob(5, book.getBookImage());
            ps.executeUpdate();
            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    book.setBookId(generatedKeys.getInt(1));
                }
            }
        } catch (SQLException e) {
            throw new SQLException("Error inserting book: " + e.getMessage(), e);
        }
    }

    public List<Book> getAllBooks() throws SQLException {
        List<Book> books = new ArrayList<>();
        try (Connection conn = DBConnection.getDbConnection();

             PreparedStatement ps = conn.prepareStatement(SELECT_BOOK);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Book book = new Book();
                book.setBookId(rs.getInt("bookid"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setTotalCopies(rs.getInt("totalcopies"));
                book.setCategory(rs.getString("category"));
                books.add(book);
            }
        } catch (SQLException e) {
            throw new SQLException("Error fetching books: " + e.getMessage(), e);
        }
        return books;
    }

    public Book getBookById(int bookId) throws SQLException {
        String sql = "SELECT bookid, title, author, totalcopies, category FROM book WHERE bookid = ?";
        try (Connection conn = DBConnection.getDbConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Book book = new Book();
                    book.setBookId(rs.getInt("bookid"));
                    book.setTitle(rs.getString("title"));
                    book.setAuthor(rs.getString("author"));
                    book.setTotalCopies(rs.getInt("totalcopies"));
                    book.setCategory(rs.getString("category"));
                    return book;
                }
            }
        } catch (SQLException e) {
            throw new SQLException("Error fetching book by ID: " + e.getMessage(), e);
        }
        return null;
    }

    // New search methods
    public List<Book> searchByTitle(String title) throws SQLException {
        List<Book> books = new ArrayList<>();
        try (Connection conn = DBConnection.getDbConnection();
             PreparedStatement ps = conn.prepareStatement(SEARCH_BY_TITLE)) {
            ps.setString(1, "%" + title + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Book book = new Book();
                    book.setBookId(rs.getInt("bookid"));
                    book.setTitle(rs.getString("title"));
                    book.setAuthor(rs.getString("author"));
                    book.setTotalCopies(rs.getInt("totalcopies"));
                    book.setCategory(rs.getString("category"));
                    books.add(book);
                }
            }
        } catch (SQLException e) {
            throw new SQLException("Error searching books by title: " + e.getMessage(), e);
        }
        return books;
    }

    public boolean updateBook(Book book) throws SQLException {
        String sql = "UPDATE book SET title = ?, author = ?, totalcopies = ?, category = ?, bookImage = ? WHERE bookid = ?";
        try (Connection conn = DBConnection.getDbConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, book.getTitle());
            ps.setString(2, book.getAuthor());
            ps.setInt(3, book.getTotalCopies());
            ps.setString(4, book.getCategory());
            ps.setBlob(5, book.getBookImage());  // If you want to allow updating image
            ps.setInt(6, book.getBookId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new SQLException("Error updating book: " + e.getMessage(), e);
        }
    }

    public boolean updateBookWithoutImage(Book book) throws SQLException {
        String sql = "UPDATE book SET title = ?, author = ?, totalcopies = ?, category = ? WHERE bookid = ?";
        try (Connection conn = DBConnection.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, book.getTitle());
            stmt.setString(2, book.getAuthor());
            stmt.setInt(3, book.getTotalCopies());
            stmt.setString(4, book.getCategory());
            stmt.setInt(5, book.getBookId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new SQLException("Error updating book without image: " + e.getMessage(), e);
        }
    }


    public byte[] getBookImage(int bookId) throws SQLException {
        try (Connection conn = DBConnection.getDbConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_BOOK_IMAGE)) {
            ps.setInt(1, bookId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    java.sql.Blob blob = rs.getBlob("bookImage");
                    if (blob != null) {
                        System.out.println("blob exists: " + blob.length() + " bytes long.");
                        return blob.getBytes(1, (int) blob.length());
                    }
                }
                return null;
            }
        } catch (SQLException e) {
            throw new SQLException("Error fetching book image: " + e.getMessage(), e);
        }
    }

    public boolean deleteBook(int bookId) {
        String deleteReviewsSql = "DELETE FROM review WHERE bookid = ?";
        String deleteBorrowsSql = "DELETE FROM borrows WHERE bookid = ?";
        String deleteBookSql = "DELETE FROM book WHERE bookid = ?";

        try (Connection conn = DBConnection.getDbConnection()) {
            conn.setAutoCommit(false); // start transaction

            try (PreparedStatement psReviews = conn.prepareStatement(deleteReviewsSql);
                 PreparedStatement psBorrows = conn.prepareStatement(deleteBorrowsSql);
                 PreparedStatement psBook = conn.prepareStatement(deleteBookSql)) {

                // Delete from review
                psReviews.setInt(1, bookId);
                psReviews.executeUpdate();

                // Delete from borrows
                psBorrows.setInt(1, bookId);
                psBorrows.executeUpdate();

                // Delete from book
                psBook.setInt(1, bookId);
                int rowsAffected = psBook.executeUpdate();

                conn.commit();
                return rowsAffected > 0;

            } catch (SQLException e) {
                conn.rollback();
                e.printStackTrace();
                return false;
            } finally {
                conn.setAutoCommit(true);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}