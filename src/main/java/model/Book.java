package model;

import java.io.InputStream;

public class Book {

    private int bookId;
    private String title;
    private String author;
    private int totalCopies;
    private String category;
    private InputStream bookImage;

    public Book() {
    }

    public Book(String title, String author, int totalCopies, String category, InputStream bookImage) {
        this.title = title;
        this.author = author;
        this.totalCopies = totalCopies;
        this.category = category;
        this.bookImage = bookImage;
    }

    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public int getTotalCopies() {
        return totalCopies;
    }

    public void setTotalCopies(int totalCopies) {
        this.totalCopies = totalCopies;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public InputStream getBookImage() {
        return bookImage;
    }

    public void setBookImage(InputStream bookImage) {
        this.bookImage = bookImage;
    }
}