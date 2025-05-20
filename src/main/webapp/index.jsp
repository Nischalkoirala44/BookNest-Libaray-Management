<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BookNest - Discover Your Next Read</title>
    <style>
        /* Color Variables */
        :root {
            --primary-color: #ff7a65;
            --secondary-color: #f8f8f8;
            --text-color: #333;
            --light-text: #888;
            --border-color: #ddd;
        }

        /* Global Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
        }

        body {
            background: linear-gradient(135deg, #f5f5e8 0%, #e8d9c1 100%);
            color: var(--text-color);
            line-height: 1.5;
            overflow-x: hidden;
            position: relative;
        }

        /* Background Pattern and Animation */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" viewBox="0 0 40 40"><rect x="10" y="5" width="5" height="30" fill="%23d3c7a5" opacity="0.3"/><rect x="20" y="5" width="5" height="30" fill="%23d3c7a5" opacity="0.3"/><rect x="30" y="5" width="5" height="30" fill="%23d3c7a5" opacity="0.3"/></svg>') repeat;
            opacity: 0.2;
            z-index: -1;
        }

        .background-books {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: -1;
        }

        .book-particle {
            position: absolute;
            font-size: 24px;
            color: #d3c7a5;
            opacity: 0.4;
            animation: drift 15s infinite linear;
        }

        @keyframes drift {
            0% {
                transform: translateY(100vh) translateX(0);
                opacity: 0.4;
            }
            50% {
                opacity: 0.6;
            }
            100% {
                transform: translateY(-100vh) translateX(20px);
                opacity: 0.4;
            }
        }

        .container {
            width: 100%;
            max-width: 1280px;
            margin: 0 auto;
            padding: 0 24px;
        }

        /* Header */
        header {
            background-color: #ffffff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 16px 0;
        }

        .logo {
            font-size: 24px;
            font-weight: 700;
            color: var(--primary-color);
            text-decoration: none;
            letter-spacing: -0.5px;
        }

        .logo span {
            color: var(--text-color);
        }

        .nav-links {
            display: flex;
            list-style: none;
            align-items: center;
        }

        .nav-links li {
            margin: 0 16px;
        }

        .nav-links a {
            text-decoration: none;
            color: var(--light-text);
            font-size: 16px;
            font-weight: 500;
            transition: color 0.2s;
        }

        .nav-links a:hover {
            color: var(--primary-color);
        }

        .auth-buttons a {
            margin-left: 16px;
            text-decoration: none;
            font-size: 16px;
            font-weight: 500;
        }

        .login-btn {
            color: var(--primary-color);
            padding: 8px 16px;
            border-radius: 6px;
            transition: background-color 0.2s, transform 0.2s;
        }

        .login-btn:hover {
            background-color: var(--secondary-color);
            transform: scale(1.05);
        }

        .register-btn {
            background-color: var(--primary-color);
            color: white;
            padding: 8px 16px;
            border-radius: 6px;
            transition: background-color 0.2s, transform 0.2s;
        }

        .register-btn:hover {
            background-color: #e66a56;
            transform: scale(1.05);
        }

        /* Hero Section */
        .hero {
            padding: 100px 0;
            position: relative;
            overflow: hidden;
        }

        .hero-content {
            display: flex;
            align-items: center;
            gap: 48px;
            animation: fadeInUp 1s ease-out;
        }

        .hero-text {
            flex: 1;
        }

        .hero-text h1 {
            font-size: 48px;
            font-weight: 800;
            color: var(--text-color);
            margin-bottom: 16px;
            line-height: 1.2;
            font-family: 'Georgia', serif;
        }

        .hero-text p {
            font-size: 18px;
            color: var(--light-text);
            margin-bottom: 24px;
            max-width: 500px;
        }

        .cta-btn {
            display: inline-flex;
            background-color: var(--primary-color);
            color: white;
            padding: 12px 24px;
            text-decoration: none;
            border-radius: 6px;
            font-weight: 600;
            font-size: 16px;
            transition: background-color 0.2s, transform 0.2s;
            animation: pulse 2s infinite;
        }

        .cta-btn:hover {
            background-color: #e66a56;
            transform: translateY(-2px);
        }

        .hero-image {
            flex: 1;
        }

        .hero-image img {
            max-width: 100%;
            height: auto;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
            animation: float 6s ease-in-out infinite;
        }

        /* Features Section */
        .features {
            padding: 80px 0;
            background-color: rgba(255, 255, 255, 0.8);
            border-radius: 12px;
            margin: 0 24px;
        }

        .section-title {
            text-align: center;
            margin-bottom: 48px;
        }

        .section-title h2 {
            font-size: 32px;
            font-weight: 800;
            color: var(--text-color);
            margin-bottom: 12px;
            font-family: 'Georgia', serif;
        }

        .section-title p {
            font-size: 16px;
            color: var(--light-text);
            max-width: 600px;
            margin: 0 auto;
        }

        .feature-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 24px;
        }

        .feature-card {
            background-color: #ffffff;
            border-radius: 12px;
            padding: 24px;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .feature-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 12px 20px rgba(0, 0, 0, 0.15);
        }

        .feature-icon {
            font-size: 40px;
            color: var(--primary-color);
            margin-bottom: 16px;
        }

        .feature-card h3 {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 8px;
            color: var(--text-color);
        }

        .feature-card p {
            font-size: 14px;
            color: var(--light-text);
        }

        /* Footer */
        footer {
            background-color: var(--text-color);
            color: #f9fafb;
            padding: 24px 0;
            text-align: center;
        }

        .footer-bottom p {
            font-size: 12px;
            color: var(--light-text);
        }

        /* Animations */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes pulse {
            0% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.05);
            }
            100% {
                transform: scale(1);
            }
        }

        @keyframes float {
            0% {
                transform: translateY(0);
            }
            50% {
                transform: translateY(-10px);
            }
            100% {
                transform: translateY(0);
            }
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .hero-content {
                flex-direction: column;
                text-align: center;
            }

            .hero-text {
                margin-bottom: 32px;
            }

            .hero-text h1 {
                font-size: 36px;
            }

            .hero-text p {
                font-size: 16px;
            }

            .hero-image img {
                max-width: 80%;
                margin: 0 auto;
            }
        }

        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                gap: 16px;
            }

            .nav-links {
                margin: 16px 0;
                flex-wrap: wrap;
                justify-content: center;
                gap: 12px;
            }

            .nav-links li {
                margin: 8px 12px;
            }

            .auth-buttons {
                display: flex;
                gap: 12px;
            }

            .feature-cards {
                grid-template-columns: 1fr;
            }

            .hero {
                padding: 60px 0;
            }

            .section-title h2 {
                font-size: 28px;
            }
        }

        @media (max-width: 480px) {
            .container {
                padding: 0 16px;
            }

            .logo {
                font-size: 20px;
            }

            .nav-links a,
            .auth-buttons a {
                font-size: 14px;
            }

            .auth-buttons a {
                padding: 6px 12px;
            }

            .hero-text h1 {
                font-size: 28px;
            }

            .cta-btn {
                padding: 10px 20px;
                font-size: 14px;
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

<!-- Header -->
<header>
    <div class="container">
        <nav class="navbar">
            <a href="index.jsp" class="logo">Book<span>Nest</span></a>
            <ul class="nav-links">
                <li><a href="#">Home</a></li>
                <li><a href="view/about.jsp">About</a></li>
                <li><a href="view/contact.jsp">Contact</a></li>
            </ul>
            <div class="auth-buttons">
                <a href="view/login.jsp" class="login-btn">Login</a>
                <a href="view/register.jsp" class="register-btn">Register</a>
            </div>
        </nav>
    </div>
</header>

<!-- Hero Section -->
<section class="hero">
    <div class="container">
        <div class="hero-content">
            <div class="hero-text">
                <h1>Find Your Next Great Read</h1>
                <p>Explore thousands of books across all genres. Log in to start your reading journey!</p>
                <% if (session.getAttribute("user") == null) { %>
                <a href="view/login.jsp" class="cta-btn">Browse Books</a>
                <% } else { %>
                <a href="view/books.jsp" class="cta-btn">Browse Books</a>
                <% } %>
            </div>
            <div class="hero-image">
                <img src="assets/library-cover.jpg" alt="Library with books">
            </div>
        </div>
    </div>
</section>

<!-- Features Section -->
<section class="features">
    <div class="container">
        <div class="section-title">
            <h2>Why Choose BookNest</h2>
            <p>Discover the features that make your reading experience seamless</p>
        </div>
        <div class="feature-cards">
            <div class="feature-card">
                <div class="feature-icon">📚</div>
                <h3>Extensive Library</h3>
                <p>Browse thousands of books across all genres in one place.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">🔍</div>
                <h3>Smart Search</h3>
                <p>Quickly find books with our powerful search and filters.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">📱</div>
                <h3>Your Account</h3>
                <p>Track borrowed books and manage your reading history.</p>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer>
    <div class="container">
        <div class="footer-bottom">
            <p>© 2025 BookNest Library Management System. All rights reserved.</p>
        </div>
    </div>
</footer>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        console.log('BookNest Landing Page initialized');
    });
</script>
</body>
</html>