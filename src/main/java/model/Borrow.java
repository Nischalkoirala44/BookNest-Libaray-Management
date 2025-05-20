package model;

import java.sql.Date;
import java.time.LocalDate;

public class Borrow {
    private int borrowId;
    private int userId;
    private int bookId;
    private java.sql.Date borrowDate;
    private java.sql.Date dueDate;
    private double penalty;
    private Book book;
    private String name;
    private String author;
    private String title;


    // Default constructor
    public Borrow() {
        LocalDate currentDate = LocalDate.now();
        this.borrowDate = Date.valueOf(currentDate);
        this.penalty = 0.0;
    }

    // Constructor with essential fields
    public Borrow(int borrowId, int userId, int bookId) {
        this();
        this.borrowId = borrowId;
        this.userId = userId;
        this.bookId = bookId;
    }

    // Full constructor (without returnDate)
    public Borrow(int borrowId, int userId, int bookId, java.sql.Date borrowDate,
                  java.sql.Date dueDate, double penalty) {
        this.borrowId = borrowId;
        this.userId = userId;
        this.bookId = bookId;
        this.borrowDate = borrowDate;
        this.dueDate = dueDate;
        this.penalty = penalty;
    }

    // Getter and Setter methods
    public int getBorrowId() {
        return borrowId;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setBorrowId(int borrowId) {
        this.borrowId = borrowId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public java.sql.Date getBorrowDate() {
        return borrowDate;
    }

    public void setBorrowDate(java.sql.Date borrowDate) {
        this.borrowDate = borrowDate;
    }

    public java.sql.Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(java.sql.Date dueDate) {
        this.dueDate = dueDate;
    }

    public double getPenalty() {
        return penalty;
    }

    public void setPenalty(double penalty) {
        this.penalty = penalty;
    }

    public Book getBook() {
        return book;
    }

    public void setBook(Book book) {
        this.book = book;
    }
}
