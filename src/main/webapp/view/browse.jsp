<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.BookDAO,model.Book,model.User,java.util.List,java.util.Objects" %>
<%@ page import="model.Review" %>
<%@ include file="nav-bar.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Nest</title>
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
        }

        .main-content {
            padding: 40px 0;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .page-title {
            margin-bottom: 30px;
        }

        .page-title h1 {
            font-size: 32px;
            color: var(--primary-color);
        }

        .page-title p {
            color: var(--light-text);
        }

        .search-filter-container {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            padding: 20px;
            margin-bottom: 30px;
        }

        .search-bar {
            display: flex;
            margin-bottom: 20px;
        }

        .search-input {
            flex: 1;
            padding: 12px 15px;
            border: 1px solid var(--border-color);
            border-radius: 5px 0 0 5px;
            font-size: 16px;
        }

        .search-btn {
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 0 20px;
            border-radius: 0 5px 5px 0;
            cursor: pointer;
            font-weight: 600;
            transition: background-color 0.3s;
        }

        .search-btn:hover {
            background-color: var(--primary-hover);
        }

        .filters {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
        }

        .filter-group {
            flex: 1;
            min-width: 200px;
        }

        .filter-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--light-text);
        }

        .filter-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid var(--border-color);
            border-radius: 5px;
            background-color: white;
            font-size: 16px;
        }

        .books-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 25px;
        }

        .book-card {
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .book-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .book-cover {
            height: 250px;
            background-color: #f0f0f0;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--light-text);
        }

        .book-cover img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }


        .book-info {
            padding: 20px;
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        .book-info h3 {
            font-size: 18px;
            margin-bottom: 10px;
        }

        .book-info p {
            font-size: 14px;
            color: var(--light-text);
            margin-bottom: 15px;
        }

        .book-info .category {
            display: inline-block;
            background-color: var(--secondary-color);
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            color: var(--light-text);
            margin-bottom: 15px;
        }

        .status {
            margin-top: auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .status-badge {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }

        .available {
            background-color: var(--status-available-bg);
            color: var(--status-available-text);
        }

        .borrowed {
            background-color: var(--status-borrowed-bg);
            color: var(--status-borrowed-text);
        }

        .borrow-btn {
            display: inline-block;
            background-color: var(--primary-color);
            color: white;
            padding: 8px 15px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: background-color 0.3s;
            border: none;
            cursor: pointer;
        }

        .disabled-btn {
            background-color: #ccc;
            cursor: not-allowed;
        }

        .borrow-btn:hover:not(.disabled-btn) {
            background-color: var(--primary-hover);
        }

        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 40px;
        }

        .pagination-btn {
            display: inline-block;
            padding: 8px 12px;
            margin: 0 5px;
            border-radius: 5px;
            background-color: white;
            border: 1px solid var(--border-color);
            color: var(--text-color);
            text-decoration: none;
            transition: all 0.3s;
        }

        .pagination-btn.disabled {
            color: #6c757d;
            cursor: not-allowed;
            text-decoration: none;
        }

        .pagination-btn:hover:not(.disabled) {
            background-color: var(--secondary-color);
        }

        .pagination-btn.active {
            background-color: var(--primary-color);
            color: white;
            border-color: var(--primary-color);
        }

        /* Review Section Styles */
        .review-section {
            margin-top: 15px;
            display: flex;
            gap: 10px;
        }

        .review-toggle-btn, .view-reviews-btn {
            display: inline-block;
            color: white;
            padding: 8px 15px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .review-toggle-btn {
            background-color: #2196F3;
        }

        .review-toggle-btn:hover {
            background-color: #1976D2;
        }

        .view-reviews-btn {
            background-color: #FF9800;
        }

        .view-reviews-btn:hover {
            background-color: #F57C00;
        }

        .review-form {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .review-form textarea {
            width: 100%;
            height: 100px;
            padding: 10px;
            border: 1px solid var(--border-color);
            border-radius: 5px;
            font-size: 14px;
            resize: vertical;
        }

        .submit-review-btn {
            background-color: #4CAF50;
            color: white;
            padding: 8px 15px;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            font-size: 14px;
            align-self: flex-start;
            transition: background-color 0.3s;
        }

        .submit-review-btn:hover {
            background-color: #388E3C;
        }

        /* Reviews Modal Styles */
        .review-item {
            border-bottom: 1px solid var(--border-color);
            padding: 10px 0;
        }

        .review-item:last-child {
            border-bottom: none;
        }

        .review-author {
            font-weight: bold;
            font-size: 14px;
            margin-bottom: 5px;
            color: var(--text-color);
        }

        .review-comment {
            font-size: 14px;
            color: var(--text-color);
        }

        .no-reviews {
            font-size: 14px;
            color: var(--light-text);
            text-align: center;
            padding: 20px;
        }

        /* Success Message */
        .success-message {
            display: none;
            position: fixed;
            top: 20px;
            right: 20px;
            background-color: #4CAF50;
            color: white;
            padding: 15px;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
            z-index: 1001;
            animation: slideIn 0.5s ease-in-out, fadeOut 0.5s ease-in-out 2.5s;
        }

        @keyframes slideIn {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

        @keyframes fadeOut {
            from {
                opacity: 1;
            }
            to {
                opacity: 0;
                display: none;
            }
        }

        @media (max-width: 768px) {
            .books-grid {
                grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
            }

            .book-cover {
                height: 200px;
            }
        }

        .footer {
            background-color: white;
            box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.1);
            padding: 30px 0;
            margin-top: auto;
        }

        .footer-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .footer-content {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 30px;
        }

        .footer-section h3 {
            font-size: 18px;
            margin-bottom: 15px;
            position: relative;
            padding-bottom: 10px;
        }

        .footer-section h3::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 30px;
            height: 2px;
            background-color: var(--primary-color);
        }

        .footer-links {
            list-style: none;
        }

        .footer-links li {
            margin-bottom: 10px;
        }

        .footer-links a {
            text-decoration: none;
            color: var(--text-color);
            transition: color 0.3s;
        }

        .footer-links a:hover {
            color: var(--primary-color);
        }

        .footer-bottom {
            text-align: center;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid var(--border-color);
            color: var(--light-text);
            font-size: 14px;
        }
    </style>
</head>
<body>
<!-- Main Content -->
<div class="main-content">
    <div class="container">
        <div class="page-title">
            <h1>Books Catalog</h1>
            <p>Browse through our collection of books</p>
        </div>

        <!-- Search and Filter -->
        <form action="${pageContext.request.contextPath}/SearchBookServlet" method="get" class="search-filter-container">
            <div class="search-bar">
                <input type="text" class="search-input" name="searchTerm" id="searchInput"
                       placeholder="Search by books by title..."
                       value="<%= request.getParameter("searchTerm") != null ? request.getParameter("searchTerm").replaceAll("[<>\"&]", "") : "" %>">
                <button type="submit" class="search-btn" id="searchBtn">Search</button>
            </div>

            <div class="filters">
                <!-- Category Filter -->
                <div class="filter-group">
                    <label for="categoryFilter">Category</label>
                    <select id="categoryFilter" name="category">
                        <option value="all" ${empty param.category or param.category eq 'all' ? 'selected' : ''}>All Categories</option>
                        <option value="fiction" ${param.category eq 'fiction' ? 'selected' : ''}>Fiction</option>
                        <option value="non-fiction" ${param.category eq 'non-fiction' ? 'selected' : ''}>Non-Fiction</option>
                        <option value="science" ${param.category eq 'science' ? 'selected' : ''}>Science</option>
                        <option value="history" ${param.category eq 'history' ? 'selected' : ''}>History</option>
                        <option value="biography" ${param.category eq 'biography' ? 'selected' : ''}>Biography</option>
                        <option value="self-help" ${param.category eq 'self-help' ? 'selected' : ''}>Self-Help</option>
                        <option value="fantasy" ${param.category eq 'fantasy' ? 'selected' : ''}>Fantasy</option>
                        <option value="mystery" ${param.category eq 'mystery' ? 'selected' : ''}>Mystery</option>
                        <option value="romance" ${param.category eq 'romance' ? 'selected' : ''}>Romance</option>
                        <option value="science-fiction" ${param.category eq 'science-fiction' ? 'selected' : ''}>Science Fiction</option>
                        <option value="academic" ${param.category eq 'academic' ? 'selected' : ''}>Academic</option>
                    </select>
                </div>


            </div>
        </form>

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
                        <form method="post" action="${pageContext.request.contextPath}/borrow" style="display: inline;">
                            <input type="hidden" name="bookId" value="<%= book.getBookId() %>">
                            <input type="hidden" name="userId" value="<%= user.getUserId() %>">
                            <button type="submit" class="borrow-btn <%= isAvailable ? "" : "disabled-btn" %>"
                                    <%= isAvailable ? "" : "disabled" %>>
                                Borrow
                            </button>
                        </form>
                    </div>
                    <div class="review-section">
                        <button type="button" class="review-toggle-btn" onclick="toggleReviewForm(<%= book.getBookId() %>, <%= user.getUserId() %>)">
                            Write Review
                        </button>
                        <form method="get" action="${pageContext.request.contextPath}/ReviewServlet" style="display: inline;">
                            <input type="hidden" name="bookId" value="<%= book.getBookId() %>">
                            <input type="hidden" name="showModal" value="true">
                            <button type="submit" class="view-reviews-btn">View Reviews</button>
                        </form>
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

        <!-- Pagination -->
        <div class="pagination" id="pagination">
        </div>
    </div>
</div>

<!-- Review Form Modal -->
<div class="modal" id="reviewModal">
    <div class="modal-content">
        <div class="modal-header">
            <h2 class="modal-title">Write a Review</h2>
            <button class="modal-close" onclick="closeReviewModal()">×</button>
        </div>
        <div class="modal-body">
            <form id="reviewForm" method="post" action="${pageContext.request.contextPath}/submit-book-review" onsubmit="logFormSubmission()">
                <input type="hidden" name="bookId" id="reviewBookId">
                <input type="hidden" name="userId" id="reviewUserId">
                <div class="review-form">
                    <textarea name="comment" id="reviewComment" placeholder="Write your review here..." required></textarea>
                    <button type="submit" class="submit-review-btn">Submit Review</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Reviews Modal -->
<div class="modal <%= request.getAttribute("showModal") != null && (Boolean)request.getAttribute("showModal") ? "active" : "" %>" id="reviewsModal">
    <div class="modal-content">
        <div class="modal-header">
            <h2 class="modal-title">Book Reviews</h2>
            <form method="get" action="${pageContext.request.contextPath}/view/browse.jsp">
                <button type="submit" class="modal-close">×</button>
            </form>
        </div>
        <div class="modal-body" id="reviewsContent">
            <%
                List<model.Review> reviews = (List<model.Review>) request.getAttribute("reviews");
                if (reviews != null && !reviews.isEmpty()) {
                    for (model.Review review : reviews) {
            %>
            <div class="review-item">
                <div style="display: flex; gap: 12px; align-items: center;">
                    <img src='${pageContext.request.contextPath}/ProfilePictureServlet?reviewId=<%= review.getReviewId() %>' alt='Profile Image' style="height: 50px; width: 50px; border-radius: 50%;" />
                    <div class="review-author"><%= review.getName() != null ? review.getName().replaceAll("[<>\"&]", "") : "" %></div>
                </div>
                <div class="review-comment" style="margin-top: 12px;"><%= review.getComment() != null ? review.getComment().replaceAll("[<>\"&]", "") : "" %></div>
            </div>
            <%
                }
            } else {
            %>
            <p class="no-reviews">No reviews found for this book.</p>
            <%
                }
            %>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="footer">
    <div class="footer-container">
        <div class="footer-content">
            <div class="footer-section">
                <h3>About Us</h3>
                <ul class="footer-links">
                    <li><a href="#">Our Story</a></li>
                    <li><a href="#">Team</a></li>
                    <li><a href="#">Careers</a></li>
                    <li><a href="#">Press</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>Resources</h3>
                <ul class="footer-links">
                    <li><a href="#">Help Center</a></li>
                    <li><a href="#">FAQs</a></li>
                    <li><a href="#">Community Guidelines</a></li>
                    <li><a href="#">Tutorials</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>Legal</h3>
                <ul class="footer-links">
                    <li><a href="#">Terms of Service</a></li>
                    <li><a href="#">Privacy Policy</a></li>
                    <li><a href="#">Cookie Policy</a></li>
                    <li><a href="#">Copyright</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>Contact</h3>
                <ul class="footer-links">
                    <li><a href="#">Email Us</a></li>
                    <li><a href="#">Support</a></li>
                    <li><a href="#">Feedback</a></li>
                    <li><a href="#">Report an Issue</a></li>
                </ul>
            </div>
        </div>
        <div class="footer-bottom">
            <p>© 2025 Book Nest. All rights reserved.</p>
        </div>
    </div>
</footer>

<!-- JavaScript for Modals and Logging -->
<script>
    function toggleReviewForm(bookId, userId) {
        console.log('Opening review form for bookId: ' + bookId + ', userId: ' + userId);
        document.getElementById('reviewBookId').value = bookId;
        document.getElementById('reviewUserId').value = userId;
        document.getElementById('reviewComment').value = '';
        document.getElementById('reviewModal').classList.add('active');
    }

    function closeReviewModal() {
        document.getElementById('reviewModal').classList.remove('active');
    }

    function logFormSubmission() {
        const form = document.getElementById('reviewForm');
        const bookId = form.querySelector('#reviewBookId').value;
        const userId = form.querySelector('#reviewUserId').value;
        const comment = form.querySelector('#reviewComment').value;
        console.log('Submitting review form for bookId: ' + bookId +
            ', userId: ' + userId +
            ', comment: ' + (comment ? comment.substring(0, 50) + '...' : 'empty'));
    }

    function viewReviews(bookId) {
        console.log('Opening reviews for bookId: ' + bookId);
        const reviewsModal = document.getElementById('reviewsModal');
        const reviewsContent = document.getElementById('reviewsContent');

        // Show the modal
        reviewsModal.classList.add('active');

        // Fetch reviews via AJAX
        fetchReviews(bookId, reviewsContent);
    }

    function closeReviewsModal() {
        document.getElementById('reviewsModal').classList.remove('active');
    }

    // Function to handle search
    function searchBooks() {
        document.querySelector('form.search-filter-container').submit();
        const url = "/SearchBookServlet?searchTerm=&searchType=all&category=&author=&sort=";
        console.log("Navigating to:", url);
        window.location.href = url;
    }

    // Initialize page
    const searchInput = document.getElementById('searchInput');
    if (searchInput) {
        searchInput.addEventListener('keyup', function(e) {
            if (e.key === 'Enter') {
                e.preventDefault();
                submitSearch();
            }
        });
    }
</script>
</body>
</html>