package model;

public class Review {
    private int reviewId;
    private String comment;
    private int bookId;
    private int userId;
    private byte[] profilePicture;
    private String name;

    // Getters and setters
    public int getReviewId() { return reviewId; }
    public void setReviewId(int reviewId) { this.reviewId = reviewId; }

    // Getters and setters
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public byte[] getProfilePicture() { return profilePicture; }
    public void setProfilePicture(byte[] profilePicture) { this.profilePicture = profilePicture; }

    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }

    public int getBookId() { return bookId; }
    public void setBookId(int bookId) { this.bookId = bookId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
}
