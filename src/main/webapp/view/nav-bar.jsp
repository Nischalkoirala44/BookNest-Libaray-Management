<%--
  Created by IntelliJ IDEA.
  User: Nischal Koirala
  Date: 5/6/2025
  Time: 7:28 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.User" %>

<html>
<style>
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

    .navbar {
        background-color: white;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        padding: 15px 0;
        position: sticky;
        top: 0;
        z-index: 100;
    }

    .nav-container {
        max-width: 1200px;
        margin: 0 auto;
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 0 20px;
    }

    .logo {
        display: flex;
        align-items: center;
    }

    .logo h1 {
        font-size: 24px;
        color: var(--text-color);
    }

    .logo span {
        color: var(--primary-color);
    }

    .nav-links {
        display: flex;
        list-style: none;
        align-items: center;
    }

    .nav-links li {
        margin-left: 30px;
    }

    .nav-links a {
        text-decoration: none;
        color: var(--text-color);
        font-weight: 500;
        transition: color 0.3s;
    }

    .nav-links a:hover {
        color: var(--primary-color);
    }

    .nav-links .active {
        color: var(--primary-color);
    }


    .user-avatar img {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        object-fit: cover;
    }

    .user-name {
        font-weight: 500;
    }

    .user-profile {
        display: flex;
        align-items: center;
        cursor: pointer;
        position: relative;
        gap: 6px;
    }

    .dropdown-menu {
        position: absolute;
        top: 100%;
        right: 0;
        background-color: white;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        border-radius: 8px;
        width: 200px;
        display: none;
        z-index: 101;
    }

    .dropdown-menu.active {
        display: block;
    }

    .dropdown-menu ul {
        list-style: none;
        padding: 10px 0;
    }

    .dropdown-menu li {
        padding: 10px 20px;
    }

    .dropdown-menu a {
        text-decoration: none;
        color: var(--text-color);
        display: block;
    }

    .dropdown-menu a:hover {
        color: var(--primary-color);
    }

    .dropdown-menu .logout {
        border-top: 1px solid var(--border-color);
        margin-top: 5px;
    }

    .hamburger {
        display: none;
        font-size: 24px;
        background: none;
        border: none;
        color: var(--text-color);
        cursor: pointer;
    }

    .modal {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
        display: flex;
        align-items: center;
        justify-content: center;
        z-index: 1000;
        opacity: 0;
        visibility: hidden;
        transition: opacity 0.3s, visibility 0.3s;
    }

    .modal.active {
        opacity: 1;
        visibility: visible;
    }

    .modal-content {
        background-color: white;
        border-radius: 8px;
        width: 90%;
        max-width: 500px;
        max-height: 90vh;
        overflow-y: auto;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
    }

    .modal-header {
        padding: 15px 20px;
        border-bottom: 1px solid var(--border-color);
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .modal-title {
        font-size: 20px;
        font-weight: bold;
    }

    .modal-close {
        background: none;
        border: none;
        font-size: 24px;
        cursor: pointer;
        color: var(--light-text);
    }

    .modal-body {
        padding: 20px;
    }

    .modal-footer {
        padding: 15px 20px;
        border-top: 1px solid var(--border-color);
        display: flex;
        justify-content: flex-end;
    }

    .modal-footer button {
        padding: 8px 15px;
        border-radius: 4px;
        cursor: pointer;
        font-size: 14px;
        margin-left: 10px;
    }

    .modal-footer button a {
        text-decoration: none;
        color: white;
    }

    .btn-secondary {
        background-color: #f0f0f0;
        color: var(--text-color);
        border: 1px solid var(--border-color);
    }

    .btn-primary {
        background-color: var(--primary-color);
        color: white;
        border: none;
    }

    .profile-details {
        display: grid;
        grid-template-columns: 1fr 2fr;
        gap: 15px;
    }

    .profile-avatar {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        background-color: var(--primary-color);
        color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 36px;
        font-weight: bold;
        margin: 0 auto;
        overflow: hidden;
    }

    .profile-avatar img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        border-radius: 50%;
    }

    .profile-info {
        margin-top: 20px;
    }

    .profile-info-item {
        margin-bottom: 15px;
    }

    .profile-info-label {
        font-weight: bold;
        margin-bottom: 5px;
        color: var(--light-text);
        font-size: 14px;
    }

    .profile-info-value {
        font-size: 16px;
    }

    @media (max-width: 768px) {
        .nav-links {
            display: none;
            flex-direction: column;
            position: absolute;
            top: 100%;
            left: 0;
            width: 100%;
            background-color: white;
            padding: 20px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .nav-links.active {
            display: flex;
        }

        .nav-links li {
            margin: 10px 0;
        }

        .nav-links li.active a {
            color: blue;
            font-weight: bold;
            border-bottom: 2px solid blue;
        }

        .nav-links a {
            text-decoration: none;
            color: black;
            padding: 8px;
        }

        .nav-links a.active {
            color: blue;
            font-weight: bold;
            border-bottom: 2px solid blue;
        }


        .hamburger {
            display: block;
        }

        .profile-details {
            grid-template-columns: 1fr;
        }

        .dropdown-menu {
            width: 150px;
        }
    }

</style>
<head>
    <title>Title</title>
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar">
    <div class="nav-container">
        <div class="logo">
            <h1><span>Book</span> Nest</h1>
        </div>
        <% model.User buser = (model.User) session.getAttribute("user"); %>
        <button class="hamburger" aria-label="Toggle navigation" aria-expanded="false">☰</button>
        <%
            String uri = request.getRequestURI();
        %>

        <ul class="nav-links" id="navbar">
            <li><a href="${pageContext.request.contextPath}/view/home.jsp">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/view/browse.jsp">Browse</a></li>
            <li><a href="${pageContext.request.contextPath}/view-borrowed?userId=<%= buser.getUserId() %>">My Books</a></li>
        </ul>


        <div class="user-actions">
            <div class="user-profile" id="userProfileToggle" aria-haspopup="true" aria-expanded="false">
                <% User user = (User) session.getAttribute("user"); %>
                <div class="user-avatar">
                    <% if (user != null && user.getProfilePicture() != null && user.getProfilePicture().length > 0) { %>
                    <img src='${pageContext.request.contextPath}/ProfileImageServlet?userId=<%= user.getUserId() %>' alt='Profile Image' />
                    <% } else if (user != null) { %>
                    <%= user.getName().charAt(0) %>
                    <% } else { %>
                    G
                    <% } %>
                </div>
                <div class="user-name"><%= user != null && user.getName() != null ? user.getName() : "Guest" %></div>
                <div class="dropdown-menu" id="userDropdown">
                    <ul>
                        <li><a href="#" id="viewProfileBtn">View Profile</a></li>
                        <li><a href='${pageContext.request.contextPath}/view-borrowed?userId=<%= buser.getUserId() %>'>My Books</a></li>
                        <li><a href="${pageContext.request.contextPath}/NotificationServlet?userId=<%= buser.getUserId() %>">Notification</a></li>
                        <li class="logout"><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</nav>

<!-- Profile Modal -->
<div class="modal" id="profileModal" role="dialog" aria-modal="true">
    <div class="modal-content">
        <div class="modal-header">
            <h2 class="modal-title">Profile</h2>
            <button class="modal-close" aria-label="Close profile modal">×</button>
        </div>
        <div class="modal-body">
            <div class="profile-details">
                <% if (user != null) { %>
                <div class="profile-avatar">
                    <% if (user != null && user.getProfilePicture() != null && user.getProfilePicture().length > 0) { %>
                    <img src='${pageContext.request.contextPath}/ProfileImageServlet?userId=<%= user.getUserId() %>' alt='Profile Image' />
                    <% } else if (user != null) { %>
                    <%= user.getName().charAt(0) %>
                    <% } else { %>
                    G
                    <% } %>
                </div>
                <div class="profile-info">
                    <div class="profile-info-item">
                        <div class="profile-info-label">Name</div>
                        <div class="profile-info-value"><%= user.getName() != null ? user.getName().replaceAll("[<>\"&]", "") : "N/A" %></div>
                    </div>
                    <div class="profile-info-item">
                        <div class="profile-info-label">Email</div>
                        <div class="profile-info-value"><%= user.getEmail() != null ? user.getEmail().replaceAll("[<>\"&]", "") : "N/A" %></div>
                    </div>
                    <div class="profile-info-item">
                        <div class="profile-info-label">Bio</div>
                        <div class="profile-info-value"><%= user.getBio() != null ? user.getBio().replaceAll("[<>\"&]", "") : "No bio provided" %></div>
                    </div>
                    <div class="profile-info-item">
                        <div class="profile-info-label">Address</div>
                        <div class="profile-info-value"><%= user.getAddress() != null ? user.getAddress().replaceAll("[<>\"&]", "") : "No address provided" %></div>
                    </div>
                </div>
                <% } else { %>
                <div class="profile-info">
                    <div class="profile-info-item">
                        <div class="profile-info-value">Please log in to view profile details.</div>
                    </div>
                </div>
                <% } %>
            </div>
        </div>
        <div class="modal-footer">
            <button class="btn-secondary modal-close-btn">Close</button>
            <% if (user != null) { %>
            <button class="btn-primary"><a href="editProfile.jsp">Edit Profile</a></button>
            <% } %>
        </div>
    </div>
</div>

<script>

    const currentUrl = window.location.href;
    const navLink = document.querySelectorAll('#navbar a');

    navLink.forEach(link => {
        if (currentUrl.includes(link.getAttribute('href'))) {
            link.classList.add('active');
        }
    });
    // User Profile Dropdown Toggle
    const userProfileToggle = document.getElementById('userProfileToggle');
    const userDropdown = document.getElementById('userDropdown');
    if (userProfileToggle && userDropdown) {
        userProfileToggle.addEventListener('click', function(event) {
            event.stopPropagation();
            const isActive = userDropdown.classList.toggle('active');
            userProfileToggle.setAttribute('aria-expanded', isActive);
        });
    }

    document.addEventListener('click', function(event) {
        if (userDropdown && !userProfileToggle.contains(event.target) && !userDropdown.contains(event.target)) {
            userDropdown.classList.remove('active');
            userProfileToggle.setAttribute('aria-expanded', 'false');
        }
    });

    // Hamburger Menu Toggle
    const hamburger = document.querySelector('.hamburger');
    const navLinks = document.querySelector('.nav-links');
    if (hamburger && navLinks) {
        hamburger.addEventListener('click', function() {
            const isActive = navLinks.classList.toggle('active');
            hamburger.setAttribute('aria-expanded', isActive);
            hamburger.textContent = isActive ? '×' : '☰';
        });
    }

    document.addEventListener('click', function(event) {
        if (navLinks && hamburger && !navLinks.contains(event.target) && !hamburger.contains(event.target)) {
            navLinks.classList.remove('active');
            hamburger.setAttribute('aria-expanded', 'false');
            hamburger.textContent = '☰';
        }
    });

    // Modal Functionality
    const profileModal = document.getElementById('profileModal');
    const viewProfileBtn = document.getElementById('viewProfileBtn');
    const modalCloseBtns = document.querySelectorAll('.modal-close, .modal-close-btn');

    if (viewProfileBtn) {
        viewProfileBtn.addEventListener('click', function(e) {
            e.preventDefault();
            profileModal.classList.add('active');
            userDropdown.classList.remove('active');
        });
    }

    modalCloseBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            profileModal.classList.remove('active');
        });
    });

    profileModal.addEventListener('click', function(e) {
        if (e.target === this) {
            this.classList.remove('active');
        }
    });
</script>

</body>
</html>
