package model;

public class Notification {

    private int notificationId;
    private String message;
    private String createdAt;

    public Notification() {

    }

    public Notification(int notificationId, String message, String createdAt) {
        this.notificationId = notificationId;
        this.message = message;
        this.createdAt = createdAt;
    }
    public int getNotificationId() {
        return notificationId;
    }
    public void setNotificationId(int notificationId) {
        this.notificationId = notificationId;
    }
    public String getMessage() {
        return message;
    }
    public void setMessage(String message) {
        this.message = message;
    }
    public String getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }
}
