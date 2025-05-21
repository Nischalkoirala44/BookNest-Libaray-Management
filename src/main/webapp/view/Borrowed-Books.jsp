<%--
  Created by IntelliJ IDEA.
  User: Nischal Koirala
  Date: 5/6/2025
  Time: 7:28 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.User, model.Borrow, model.Book, java.util.List" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Borrowed Books</title>
    <style>
        :root {
            --primary-color: #ff7a65;
            --primary-hover: #e66b58;
            --secondary-color: #f8f8f8;
            --text-color: #333;
            --light-text: #666;
            --border-color: #ddd;
            --status-available-bg: hsl(8, 100%, 95%);
            --status-available-text: hsl(8, 80%, 40%);
            --status-borrowed-bg: hsl(8, 20%, 95%);
            --status-borrowed-text: hsl(8, 80%, 50%);
            --background-gradient: linear-gradient(135deg, #f5f5e8 0%, #e8d9c1 100%);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', Arial, sans-serif;
        }

        body {
            background: var(--background-gradient);
            color: var(--text-color);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            position: relative;
            overflow-x: hidden;
        }

        /* Background Animation (from home.jsp) */
        .background-books {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            pointer-events: none;
        }

        .book-particle {
            position: absolute;
            font-size: 2rem;
            opacity: 0.15;
            animation: float 20s infinite linear;
        }

        @keyframes float {
            0% {
                transform: translateY(0) rotate(0deg);
                opacity: 0;
            }
            10% {
                opacity: 0.15;
            }
            90% {
                opacity: 0.15;
            }
            100% {
                transform: translateY(100vh) rotate(360deg);
                opacity: 0;
            }
        }

        /* Navbar Styles (from nav-bar.jsp) */
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

        .nav-links a.active {
            color: var(--primary-color);
            font-weight: bold;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: var(--primary-color);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }

        .user-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%;
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

        /* Main Content (from Borrowed-Books.jsp) */
        .main-content {
            flex: 1;
            padding: 2rem;
            max-width: 1200px;
            margin: 0 auto;
            width: 100%;
        }

        .section-title {
            color: #1a1a1a;
            margin-bottom: 25px;
            font-size: 1.8rem;
            border-bottom: 2px solid var(--primary-color);
            padding-bottom: 10px;
            font-weight: 600;
        }

        .book-list {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .book-list-item {
            display: flex;
            padding: 15px;
            border-bottom: 1px solid var(--border-color);
            align-items: center;
        }

        .book-list-item:last-child {
            border-bottom: none;
        }

        .book-list-cover {
            width: 80px;
            height: 110px;
            margin-right: 15px;
            flex-shrink: 0;
            border-radius: 4px;
            overflow: hidden;
            background-color: #f0f0f0;
        }

        .book-list-cover img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .book-list-info {
            flex: 1;
        }

        .book-list-title {
            font-weight: bold;
            font-size: 1.1rem;
            margin-bottom: 5px;
            color: #333;
        }

        .book-list-author, .book-list-category, .book-list-date {
            font-size: 14px;
            color: var(--light-text);
            margin-bottom: 3px;
        }

        .book-list-actions {
            display: flex;
            align-items: center;
            margin-left: 15px;
        }

        .book-list-actions button {
            background-color: #e53935;
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.2s ease;
        }

        .book-list-actions button:hover {
            background-color: #c62828;
        }

        .info-message {
            background-color: #fce4ec;
            padding: 20px;
            border-left: 4px solid #f06292;
            color: #555;
            border-radius: 6px;
            font-size: 1rem;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
            margin-top: 20px;
        }

        /* Responsive Design */
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

            .nav-links a {
                padding: 8px;
            }

            .nav-links a.active {
                color: var(--primary-color);
                font-weight: bold;
                border-bottom: 2px solid var(--primary-color);
            }

            .hamburger {
                display: block;
            }

            .user-profile {
                display: none;
            }

            .dropdown-menu {
                width: 150px;
            }

            .book-list-item {
                flex-direction: column;
                align-items: flex-start;
            }

            .book-list-cover {
                margin-bottom: 10px;
            }

            .book-list-actions {
                margin-left: 0;
                margin-top: 10px;
            }
        }

        @media (max-width: 480px) {
            .profile-details {
                grid-template-columns: 1fr;
            }

            .book-list-cover {
                width: 60px;
                height: 80px;
            }

            .book-list-actions button {
                width: 100%;
            }
        }
    </style>
</head>
<body>
<!-- Background Animation (from home.jsp) -->
<div class="background-books">
    <div class="book-particle" style="left: 15%; animation-delay: 0s;">📖</div>
    <div class="book-particle" style="left: 35%; animation-delay: 3s;">📘</div>
    <div class="book-particle" style="left: 55%; animation-delay: 6s;">📙</div>
    <div class="book-particle" style="left: 75%; animation-delay: 9s;">📕</div>
    <div class="book-particle" style="left: 95%; animation-delay: 12s;">📗</div>
</div>

<!-- Navigation Bar -->
<%@ include file="nav-bar.jsp" %>

<!-- Main Content -->
<div class="main-content">
    <section class="borrowed-books">
        <h2 class="section-title">Borrowed Books</h2>
        <%
            List<Borrow> borrowedBooks = (List<Borrow>) request.getAttribute("borrowedBooks");
            if (borrowedBooks != null && !borrowedBooks.isEmpty()) {
        %>
        <div class="book-list">
            <%
                for (Borrow borrow : borrowedBooks) {
                    Book book = borrow.getBook();
                    if (book != null) {
                        String title = book.getTitle() != null ? book.getTitle().replaceAll("[<>\"&]", "") : "Untitled";
                        String author = book.getAuthor() != null ? book.getAuthor().replaceAll("[<>\"&]", "") : "Unknown";
                        String category = book.getCategory() != null ? book.getCategory().replaceAll("[<>\"&]", "") : "Uncategorized";
            %>
            <div class="book-list-item">
                <div class="book-list-cover">
                    <img src="${pageContext.request.contextPath}/BookImageServlet?bookId=<%= book.getBookId() %>" alt="<%= title %>">
                </div>
                <div class="book-list-info">
                    <div class="book-list-title"><%= title %></div>
                    <div class="book-list-author">Author: <%= author %></div>
                    <div class="book-list-category">Category: <%= category %></div>
                    <div class="book-list-date">Borrowed On: <%= borrow.getBorrowDate() %> | Due: <%= borrow.getDueDate() %></div>
                </div>
                <div class="book-list-actions">
                    <form action="return-book" method="post">
                        <input type="hidden" name="borrowId" value="<%= borrow.getBorrowId() %>" />
                        <button type="submit">Return</button>
                    </form>
                </div>
            </div>
            <%
                    }
                }
            %>
        </div>
        <%
        } else {
        %>
        <div class="info-message">No borrowed books to display.</div>
        <%
            }
        %>
    </section>
</div>

<%@ include file="footer.jsp" %>

<script>
    // Navbar JavaScript
    const currentUrl = window.location.href;
    const navLinks = document.querySelectorAll('#navbar a');

    navLinks.forEach(link => {
        const href = link.getAttribute('href');
        // Check for 'view-borrowed' in the URL to highlight 'My Books'
        if (currentUrl.includes('view-borrowed') && href.includes('view-borrowed')) {
            link.classList.add('active');
        } else if (currentUrl.includes(href) && !currentUrl.includes('view-borrowed')) {
            link.classList.add('active');
        }
    });

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

    const hamburger = document.querySelector('.hamburger');
    const navLinksContainer = document.querySelector('.nav-links');
    if (hamburger && navLinksContainer) {
        hamburger.addEventListener('click', function() {
            const isActive = navLinksContainer.classList.toggle('active');
            hamburger.setAttribute('aria-expanded', isActive);
            hamburger.textContent = isActive ? '×' : '☰';
        });
    }

    document.addEventListener('click', function(event) {
        if (navLinksContainer && hamburger && !navLinksContainer.contains(event.target) && !hamburger.contains(event.target)) {
            navLinksContainer.classList.remove('active');
            hamburger.setAttribute('aria-expanded', 'false');
            hamburger.textContent = '☰';
        }
    });

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