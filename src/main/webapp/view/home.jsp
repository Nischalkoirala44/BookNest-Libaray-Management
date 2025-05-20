<%@ include file="nav-bar.jsp" %>
<%@ page import="model.Borrow" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Borrow" %>
<%@ page import="model.Book" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.BookDAO,model.Book,java.util.List" %>

<!DOCTYPE html>
<html lang="en">
<head>
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
            --light-text: #888;
            --border-color: #ddd;
        }

        body {
            background: linear-gradient(135deg, #f5f5e8 0%, #e8d9c1 100%);
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
            font-size: 2.5rem;
            opacity: 0.1;
            animation: float 15s infinite linear;
            top: -50px;
        }

        @keyframes float {
            0% {
                transform: translateY(0) rotate(0deg);
                opacity: 0;
            }
            10% {
                opacity: 0.1;
            }
            90% {
                opacity: 0.1;
            }
            100% {
                transform: translateY(100vh) rotate(360deg);
                opacity: 0;
            }
        }

        /* Hero Section */
        .hero {
            padding: 4rem 2rem;
            text-align: center;
            background: #ff7a65;
            backdrop-filter: blur(10px);
            margin-bottom: 2rem;
            border-radius: 0 0 30px 30px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
        }

        .hero h2 {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            color: #f0f0f0;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.1);
        }

        .hero p {
            font-size: 1.2rem;
            max-width: 700px;
            margin: 0 auto;
            color: #f0f0f0;
        }

        /* Main Content */
        .main-content {
            flex: 1;
            padding: 0 2rem 4rem;
            max-width: 1400px;
            margin: 0 auto;
            width: 100%;
        }

        /* Section Titles */
        .section-title {
            font-size: 2rem;
            margin-bottom: 2rem;
            position: relative;
            display: inline-block;
            padding-bottom: 0.5rem;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100px;
            height: 3px;
            background-color: var(--primary-color);
            border-radius: 3px;
        }

        /* Books Grid */
        .books-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 2rem;
        }

        /* Book Card */
        .book-card {
            background-color: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            display: flex;
            flex-direction: column;
            height: 100%;
        }

        .book-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        .book-cover {
            height: 250px;
            overflow: hidden;
            position: relative;
        }

        .book-cover img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }

        .book-card:hover .book-cover img {
            transform: scale(1.05);
        }

        .book-info {
            padding: 1.5rem;
            display: flex;
            flex-direction: column;
            flex: 1;
        }

        .category {
            display: inline-block;
            background-color: #f0f0f0;
            color: var(--light-text);
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.8rem;
            margin-bottom: 0.8rem;
        }

        .book-info h3 {
            font-size: 1.2rem;
            margin-bottom: 0.5rem;
            line-height: 1.4;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .book-info p {
            color: var(--light-text);
            margin-bottom: 1rem;
            font-size: 0.9rem;
        }

        /* Status and Buttons */
        .status {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: auto;
            margin-bottom: 1rem;
        }

        .status-badge {
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.8rem;
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

        .borrow-btn {
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 0.5rem 1.2rem;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 500;
            transition: background-color 0.2s ease;
        }

        .borrow-btn:hover {
            background-color: #e86a55;
        }

        .disabled-btn {
            background-color: #cccccc;
            cursor: not-allowed;
        }

        .disabled-btn:hover {
            background-color: #cccccc;
        }

        /* Review Section */
        .review-section {
            margin-top: 1rem;
            text-align: center;
        }

        .view-reviews-btn {
            background-color: transparent;
            color: var(--primary-color);
            border: 1px solid var(--primary-color);
            padding: 0.5rem 1rem;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.2s ease;
            width: 100%;
        }

        .view-reviews-btn:hover {
            background-color: var(--primary-color);
            color: white;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .hero {
                padding: 3rem 1rem;
            }

            .hero h2 {
                font-size: 2rem;
            }

            .main-content {
                padding: 0 1rem 3rem;
            }

            .books-grid {
                grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
                gap: 1.5rem;
            }

            .book-cover {
                height: 200px;
            }
        }

        @media (max-width: 480px) {
            .hero h2 {
                font-size: 1.8rem;
            }

            .hero p {
                font-size: 1rem;
            }

            .books-grid {
                grid-template-columns: 1fr;
            }

            .status {
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
            }

            .borrow-btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
<!-- Background Animation -->
<div class="background-books">
    <div class="book-particle" style="left: 10%; animation-delay: 0s;">📖</div>
    <div class="book-particle" style="left: 30%; animation-delay: 2s;">📘</div>
    <div class="book-particle" style="left: 50%; animation-delay: 4s;">📙</div>
    <div class="book-particle" style="left: 70%; animation-delay: 6s;">📕</div>
    <div class="book-particle" style="left: 90%; animation-delay: 8s;">📗</div>
</div>

<!-- Hero Section -->
<section class="hero">
    <% if (user != null) { %>
    <h2>Welcome <%= user.getName() %>!</h2>
    <% } else { %>
    <h2>Welcome Guest!</h2>
    <% } %>
    <h2>Discover Your Next Favorite Book</h2>
    <p>Explore our vast collection of books across various genres and borrow them with just a few clicks.</p>
</section>

<!-- Main Content -->
<div class="main-content">
    <!-- Featured Books Section -->
    <section class="featured-books">
        <h2 class="section-title">Featured Books</h2>
        <!-- Books Grid -->
        <div class="books-grid" id="booksGrid">
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
                if (books != null) {
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