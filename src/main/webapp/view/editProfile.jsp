<%@ page import="model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Profile - Book Hive</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        :root {
            --primary-color: #ff7a65;
            --primary-hover: #e66b58;
            --secondary-color: #f8f8f8;
            --text-color: #333;
            --light-text: #888;
            --border-color: #ddd;
            --status-available-bg: hsl(8, 100%, 95%);
            --status-available-text: hsl(8, 80%, 40%);
            --status-borrowed-bg: hsl(8, 20%, 95%);
            --status-borrowed-text: hsl(8, 80%, 50%);
        }

        body {
            background-color: var(--secondary-color);
            color: var(--text-color);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        /* Main Content */
        .main-content {
            padding: 40px 0;
            width: 100%;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .page-title {
            margin-bottom: 30px;
            text-align: center;
        }

        .page-title h1 {
            font-size: 32px;
            color: var(--primary-color);
        }

        .page-title p {
            color: var(--light-text);
        }

        /* Form Styling */
        .edit-profile-form {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            padding: 30px;
            max-width: 600px;
            margin: 0 auto;
        }

        .profile-image-container {
            width: 128px;
            height: 128px;
            border-radius: 50%;
            overflow: hidden;
            margin: 0 auto 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
        }

        .profile-image-container img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 50%;
        }

        .profile-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .profile-image-fallback {
            width: 128px;
            height: 128px;
            background-color: var(--primary-color);
            color: white;
            font-size: 48px;
            display: flex;
            justify-content: center;
            align-items: center;
            border-radius: 50%;
        }

        .error-message {
            color: var(--status-borrowed-text);
            background-color: var(--status-borrowed-bg);
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
        }

        .success-message {
            color: #2e7d32;
            background-color: #e8f5e9;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-weight: 500;
            color: var(--light-text);
            margin-bottom: 8px;
        }

        .form-group input[type="text"],
        .form-group input[type="email"],
        .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid var(--border-color);
            border-radius: 5px;
            font-size: 16px;
            color: var(--text-color);
        }

        .form-group textarea {
            resize: vertical;
        }

        .form-group input[type="file"] {
            padding: 5px 0;
        }

        .submit-btn {
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 5px;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.3s;
            display: block;
            width: 100%;
            text-align: center;
        }

        .submit-btn:hover {
            background-color: var(--primary-hover);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .edit-profile-form {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    // Add a cache-busting parameter (current timestamp)
    String cacheBuster = String.valueOf(System.currentTimeMillis());
%>

<!-- Main Content -->
<div class="main-content">
    <div class="container">
        <div class="page-title">
            <h1>Edit Profile</h1>
            <p>Update your personal information</p>
        </div>

        <div class="edit-profile-form">
            <% if (request.getAttribute("error") != null) { %>
            <div class="error-message"><%= request.getAttribute("error") %></div>
            <% } %>
            <% if (request.getAttribute("success") != null) { %>
            <div class="success-message"><%= request.getAttribute("success") %></div>
            <% } %>

            <form action="${pageContext.request.contextPath}/updateUser" method="post" enctype="multipart/form-data" id="editProfileForm">
                <div class="profile-image-container">
                    <% if (user != null && user.getProfilePicture() != null && user.getProfilePicture().length > 0) { %>
                    <img src='${pageContext.request.contextPath}/ProfileImageServlet?userId=<%= user.getUserId() %>' alt='Profile Image' />
                    <% } else if (user != null) { %>
                    <%= user.getName().charAt(0) %>
                    <% } else { %>
                    G
                    <% } %>
                </div>

                <div class="form-group">
                    <label for="name">Name:</label>
                    <input type="text" id="name" name="name" value="<%= user.getName() %>" required>
                </div>

                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" value="<%= user.getEmail() %>" required>
                </div>

                <div class="form-group">
                    <label for="bio">Bio:</label>
                    <textarea id="bio" name="bio" rows="4" cols="40"><%= user.getBio() != null ? user.getBio() : "" %></textarea>
                </div>

                <div class="form-group">
                    <label for="address">Address:</label>
                    <input type="text" id="address" name="address" value="<%= user.getAddress() != null ? user.getAddress() : "" %>">
                </div>

                <div class="form-group">
                    <label for="profileImage">Upload Profile Image:</label>
                    <input type="file" id="profileImage" name="profileImage" accept="image/*">
                </div>

                <button type="submit" class="submit-btn">Update Profile</button>
            </form>
        </div>
    </div>
</div>

<script>
    // Optional: Preview the uploaded image before form submission
    const profileImageInput = document.getElementById('profileImage');
    const profileImage = document.getElementById('profileImage');
    const profileImageFallback = document.getElementById('profileImageFallback');

    if (profileImageInput) {
        profileImageInput.addEventListener('change', function(event) {
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    if (profileImage) {
                        profileImage.src = e.target.result;
                        profileImage.style.display = 'block';
                    }
                    if (profileImageFallback) {
                        profileImageFallback.style.display = 'none';
                    }
                };
                reader.readAsDataURL(file);
            }
        });
    }
</script>
</body>
</html>