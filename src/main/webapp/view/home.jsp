<%@ include file="nav-bar.jsp" %>
<%@ page import="model.Book" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.BookDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Book Shelf</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', Arial, sans-serif;
        }

        :root {
            --primary-color: #ff7a65;
            --secondary-color: #f8f8f8;
            --text-color: #333;
            --light-text: #666;
            --border-color: #ddd;
            --background-gradient: linear-gradient(135deg, #f5f5e8 0%, #e8d9c1 100%);
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

        /* Background Animation */
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

        /* Hero Section */
        .hero {
            padding: 4rem 2rem;
            background: var(--primary-color);
            color: #fff;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
            border-radius: 0 0 20px 20px;
        }

        .hero .container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            align-items: center;
            gap: 2rem;
        }

        .hero-text {
            flex: 1;
        }

        .hero-text h2 {
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 0.5rem;
            font-family: 'Georgia', serif;
        }

        .hero-text h1 {
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 1rem;
            font-family: 'Georgia', serif;
        }

        .hero-text p {
            font-size: 1.2rem;
            margin-bottom: 1.5rem;
            line-height: 1.6;
            max-width: 500px;
        }

        .cta-btn {
            display: inline-flex;
            background-color: #fff;
            color: var(--primary-color);
            padding: 0.75rem 1.5rem;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            font-size: 1rem;
            transition: background-color 0.3s, color 0.3s, transform 0.2s;
        }

        .cta-btn:hover {
            background-color: #e66a56;
            color: #fff;
            transform: translateY(-2px);
        }

        .hero-image {
            flex: 1;
            text-align: center;
        }

        .hero-image img {
            max-width: 100%;
            height: auto;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        /* Main Content */
        .main-content {
            flex: 1;
            padding: 2rem;
            max-width: 1200px;
            margin: 0 auto;
            width: 100%;
        }

        /* Section Titles */
        .section-title {
            font-size: 1.8rem;
            margin-bottom: 1.5rem;
            position: relative;
            display: inline-block;
            padding-bottom: 0.5rem;
            font-weight: 600;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 80px;
            height: 3px;
            background-color: var(--primary-color);
            border-radius: 2px;
        }

        /* Books Grid */
        .books-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 1.5rem;
            margin-bottom: 3rem;
        }

        .book-card {
            background-color: #fff;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
            display: flex;
            flex-direction: column;
        }

        .book-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15);
        }

        .book-cover {
            height: 240px;
            background-color: var(--secondary-color);
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .book-cover img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s;
        }

        .book-card:hover .book-cover img {
            transform: scale(1.03);
        }

        .book-info {
            padding: 1rem;
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        .category {
            display: inline-block;
            background-color: var(--secondary-color);
            color: var(--light-text);
            padding: 0.3rem 0.8rem;
            border-radius: 12px;
            font-size: 0.85rem;
            margin-bottom: 0.75rem;
        }

        .book-info h3 {
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
            line-height: 1.4;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .book-info p {
            color: var(--light-text);
            font-size: 0.9rem;
            margin-bottom: 1rem;
        }

        .status {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: auto;
            margin-bottom: 0.5rem;
        }

        .status-badge {
            padding: 0.4rem 0.8rem;
            border-radius: 12px;
            font-size: 0.85rem;
            font-weight: 500;
        }

        .available {
            background-color: #e6f7e6;
            color: #2e7d32;
        }

        .borrowed {
            background-color: #ffebee;
            color: #c62828;
        }

        .borrow-btn:hover {
            background-color: #e66a56;
        }

        .disabled-btn {
            background-color: #ccc;
            cursor: not-allowed;
        }

        .disabled-btn:hover {
            background-color: #ccc;
        }

        /* Review Section */
        .review-section {
            text-align: center;
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .hero .container {
                flex-direction: column;
                text-align: center;
            }

            .hero-text {
                margin-bottom: 1.5rem;
            }

            .hero-text h1, .hero-text h2 {
                font-size: 2rem;
            }

            .hero-text p {
                font-size: 1rem;
            }

            .hero-image img {
                max-width: 80%;
                margin: 0 auto;
            }
        }

        @media (max-width: 768px) {
            .hero {
                padding: 3rem 1.5rem;
            }

            .main-content {
                padding: 1.5rem;
            }

            .books-grid {
                grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
                gap: 1rem;
            }

            .book-cover {
                height: 200px;
            }
        }

        @media (max-width: 480px) {
            .hero-text h1, .hero-text h2 {
                font-size: 1.8rem;
            }

            .hero-text p {
                font-size: 0.9rem;
            }

            .books-grid {
                grid-template-columns: 1fr;
            }

            .status {
                flex-direction: column;
                align-items: flex-start;
                gap: 0.75rem;
            }
        }
    </style>
</head>
<body>
<!-- Background Animation -->
<div class="background-books">
    <div class="book-particle" style="left: 15%; animation-delay: 0s;">📖</div>
    <div class="book-particle" style="left: 35%; animation-delay: 3s;">📘</div>
    <div class="book-particle" style="left: 55%; animation-delay: 6s;">📙</div>
    <div class="book-particle" style="left: 75%; animation-delay: 9s;">📕</div>
    <div class="book-particle" style="left: 95%; animation-delay: 12s;">📗</div>
</div>

<!-- Merged Hero Section -->
<section class="hero">
    <div class="container">
        <div class="hero-text">
            <% if (session.getAttribute("user") != null) { %>
            <h2>Welcome <%= ((model.User) session.getAttribute("user")).getName() %>!</h2>
            <% } else { %>
            <h2>Welcome Guest!</h2>
            <% } %>
            <h1>Find Your Next Great Read</h1>
            <p>Explore our vast collection of books across various genres and borrow them with just a few clicks.</p>
            <% if (session.getAttribute("user") == null) { %>
            <a href="../view/login.jsp" class="cta-btn">Sign Up</a>
            <% } else { %>
            <a href="../view/browse.jsp" class="cta-btn">Browse Books</a>
            <% } %>
        </div>
        <div class="hero-image">
            <img src="../assets/library-cover.jpg" alt="Library with books">
        </div>
    </div>
</section>

<!-- Main Content -->
<div class="main-content">
    <!-- Featured Books Section -->
    <section class="featured-books">
        <h2 class="section-title">Featured Books</h2>
        <div class="books-grid">
            <%
                List<Book> books = (List<Book>) request.getAttribute("books");
                if (books == null || books.isEmpty()) {
                    BookDAO bookDAO = new BookDAO();
                    try {
                        books = bookDAO.getAllBooks();
                    } catch (Exception e) {
                        System.out.println("Error: " + e.getMessage().replaceAll("[<>\"&]", ""));
                    }
                }
                if (books != null && !books.isEmpty()) {
                    for (Book book : books) {
                        if (book != null) {
                            String title = book.getTitle() != null ? book.getTitle().replaceAll("[<>\"&]", "") : "Untitled";
                            String author = book.getAuthor() != null ? book.getAuthor().replaceAll("[<>\"&]", "") : "Unknown";
                            String category = book.getCategory() != null ? book.getCategory().replaceAll("[<>\"&]", "") : "Uncategorized";
                            boolean isAvailable = book.getTotalCopies() > 0;
            %>
            <div class="book-card">
                <div class="book-cover">
                    <img src="${pageContext.request.contextPath}/BookImageServlet?bookId=<%= book.getBookId() %>" alt="<%= title %>">
                </div>
                <div class="book-info">
                    <span class="category"><%= category %></span>
                    <h3><%= title %></h3>
                    <p>Author: <%= author %></p>
                    <div class="status">
                            <span class="status-badge <%= isAvailable ? "available" : "borrowed" %>">
                                <%= isAvailable ? "Available" : "Borrowed" %>
                            </span>
                    </div>
                </div>
            </div>
            <%
                    }
                }
            } else {
            %>
            <p>No books found.</p>
            <%
                }
            %>
        </div>
    </section>
</div>

<%@ include file="./footer.jsp" %>
</body>
</html>