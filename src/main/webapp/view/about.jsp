<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - BookNest Library Management System</title>
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

        .container {
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 15px;
        }

        /* Header styles */
        header {
            background-color: #fff;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
            padding: 1rem 0;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            display: flex;
            align-items: center;
        }

        .logo h1 {
            font-size: 1.8rem;
            font-weight: 600;
        }

        .logo h1 span:first-child {
            color: #ff7b6b; /* Coral color for "Book" */
        }

        .logo h1 span:last-child {
            color: #333; /* Dark color for "Nest" */
        }

        nav ul {
            display: flex;
            list-style: none;
        }

        nav ul li {
            margin-left: 1.5rem;
        }

        nav ul li a {
            text-decoration: none;
            color: #666;
            font-weight: 500;
            transition: color 0.3s;
            font-size: 0.95rem;
        }

        nav ul li a:hover {
            color: #ff7b6b; /* Coral color on hover */
        }

        nav ul li a.active {
            color: #ff7b6b;
        }

        .auth-buttons {
            display: flex;
            gap: 10px;
        }

        .auth-buttons a {
            text-decoration: none;
            padding: 8px 16px;
            border-radius: 4px;
            font-weight: 500;
            font-size: 0.95rem;
        }

        .login-btn {
            color: #ff7b6b;
        }

        .register-btn {
            background-color: #ff7b6b;
            color: white;
        }

        /* Hero section */
        .hero-banner {
            position: relative;
            height: 400px;
            background-image: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('../assets/banner.jpg');
            background-size: cover;
            background-position: center;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            margin-bottom: 3rem;
        }

        .hero-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.4);
            z-index: 1;
        }

        .hero-content {
            position: relative;
            z-index: 2;
            max-width: 800px;
            padding: 0 1rem;
        }

        .hero-content h1 {
            font-size: 3rem;
            margin-bottom: 1rem;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
        }

        .hero-content p {
            font-size: 1.2rem;
            margin-bottom: 1.5rem;
            text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.5);
        }

        /* Main content styles */
        main {
            padding: 2rem 0;
        }

        .page-header {
            text-align: center;
            margin-bottom: 3rem;
        }

        .page-header h1 {
            font-size: 2.5rem;
            color: #333;
            margin-bottom: 0.5rem;
        }

        .page-header p {
            color: #666;
            font-size: 1.2rem;
        }

        /* About section styles */
        .about-section {
            margin-bottom: 3rem;
            background-color: #fff;
            border-radius: 8px;
            padding: 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .about-section h2 {
            color: #333;
            font-size: 1.8rem;
            margin-bottom: 1.5rem;
            position: relative;
            padding-bottom: 0.5rem;
        }

        .about-section h2::after {
            content: "";
            position: absolute;
            bottom: 0;
            left: 0;
            width: 40px;
            height: 3px;
            background-color: #ff7b6b; /* Coral accent */
        }

        .about-with-image {
            display: flex;
            align-items: center;
            gap: 2rem;
            flex-wrap: wrap;
        }

        .about-text {
            flex: 1;
            min-width: 300px;
        }

        .about-image {
            flex: 1;
            min-width: 300px;
        }

        .about-image img {
            width: 100%;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        /* User benefits section */
        .user-benefits {
            display: flex;
            flex-wrap: wrap;
            gap: 2rem;
            margin: 2rem 0;
        }

        .benefit-column {
            flex: 1;
            min-width: 300px;
            background-color: #fff;
            border-radius: 8px;
            padding: 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            position: relative;
            overflow: hidden;
        }

        .benefit-column::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background-color: #ff7b6b; /* Coral top border */
        }

        .benefit-column h3 {
            color: #333;
            margin-bottom: 1rem;
            font-size: 1.4rem;
        }

        .benefit-column ul li {
            margin-bottom: 0.5rem;
            position: relative;
            padding-left: 1.5rem;
        }

        .benefit-column ul li::before {
            content: "•";
            color: #ff7b6b; /* Coral bullet points */
            position: absolute;
            left: 0;
            font-size: 1.2rem;
        }

        .benefit-image {
            margin-top: 1.5rem;
            border-radius: 8px;
            overflow: hidden;
        }

        .benefit-image img {
            width: 100%;
            height: auto;
            display: block;
            transition: transform 0.3s;
        }

        .benefit-image img:hover {
            transform: scale(1.03);
        }

        /* Features section */
        .why-choose {
            text-align: center;
            margin: 4rem 0;
            padding: 3rem;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .why-choose h2 {
            font-size: 2.2rem;
            color: #333;
            margin-bottom: 1rem;
        }

        .why-choose p {
            color: #666;
            margin-bottom: 3rem;
            max-width: 700px;
            margin-left: auto;
            margin-right: auto;
        }

        .feature-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 2rem;
        }

        .feature-card {
            background-color: #fff;
            border-radius: 8px;
            padding: 2rem;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            transition: transform 0.3s, box-shadow 0.3s;
            border: 1px solid #f0f0f0;
        }

        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .feature-icon {
            width: 80px;
            height: 80px;
            margin: 0 auto 1.5rem;
            background-color: #fff8f7; /* Very light coral background */
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 15px;
        }

        .feature-icon img {
            max-width: 100%;
            max-height: 100%;
        }

        .feature-card h3 {
            color: #333;
            margin-bottom: 1rem;
            font-size: 1.4rem;
        }

        .feature-card p {
            color: #666;
        }

        /* Mission box */
        .mission-box {
            background-color: #fff;
            border-left: 4px solid #ff7b6b; /* Coral left border */
            padding: 2rem;
            margin: 3rem 0;
            border-radius: 0 8px 8px 0;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            position: relative;
            overflow: hidden;
        }

        .mission-box::before {
            content: "";
            position: absolute;
            top: 0;
            right: 0;
            bottom: 0;
            width: 40%;
            background-image: url('images/mission-bg.jpg');
            background-size: cover;
            background-position: center;
            opacity: 0.1;
            z-index: 0;
        }

        .mission-box h2 {
            color: #333;
            margin-bottom: 1rem;
            font-size: 1.8rem;
            position: relative;
            z-index: 1;
        }

        .mission-box p {
            position: relative;
            z-index: 1;
        }

        /* Team section */
        .team-section {
            text-align: center;
            margin: 4rem 0;
        }

        .team-section h2 {
            font-size: 2.2rem;
            color: #333;
            margin-bottom: 2rem;
        }

        .team-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 2rem;
        }

        .team-member {
            background-color: #fff;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            transition: transform 0.3s;
        }

        .team-member:hover {
            transform: translateY(-5px);
        }

        .team-photo {
            height: 250px;
            overflow: hidden;
        }

        .team-photo img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s;
        }

        .team-member:hover .team-photo img {
            transform: scale(1.05);
        }

        .team-info {
            padding: 1.5rem;
        }

        .team-info h3 {
            color: #333;
            margin-bottom: 0.5rem;
        }

        .team-info p {
            color: #ff7b6b; /* Coral text for position */
            margin-bottom: 1rem;
            font-weight: 500;
        }

        .team-bio {
            color: #666;
            font-size: 0.9rem;
        }

        /* Footer styles */
        footer {
            background-color: #333;
            color: #fff;
            padding: 3rem 0 1rem;
            margin-top: 4rem;
        }

        .footer-content {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            margin-bottom: 2rem;
        }

        .footer-section {
            flex: 1;
            min-width: 250px;
            margin-bottom: 1.5rem;
        }

        .footer-section h3 {
            color: #ff7b6b; /* Coral headings */
            margin-bottom: 1rem;
            font-size: 1.2rem;
        }

        .footer-section ul {
            list-style: none;
            padding: 0;
        }

        .footer-section ul li {
            margin-bottom: 0.5rem;
        }

        .footer-section ul li a {
            color: #ccc;
            text-decoration: none;
            transition: color 0.3s;
        }

        .footer-section ul li a:hover {
            color: #ff7b6b; /* Coral on hover */
        }

        .footer-bottom {
            text-align: center;
            padding-top: 1.5rem;
            border-top: 1px solid #444;
            color: #aaa;
            font-size: 0.9rem;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .header-content {
                flex-direction: column;
                text-align: center;
            }

            nav ul {
                margin-top: 1rem;
                flex-wrap: wrap;
                justify-content: center;
            }

            nav ul li {
                margin: 0.5rem;
            }

            .about-with-image {
                flex-direction: column;
            }

            .hero-banner {
                height: 300px;
            }

            .hero-content h1 {
                font-size: 2.2rem;
            }

            .footer-section {
                flex: 100%;
                text-align: center;
            }
        }

        /* New Contact Section Styles */
        .contact-section {
            margin: 5rem 0;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            overflow: hidden;
        }

        .contact-container {
            display: flex;
            flex-wrap: wrap;
        }

        .contact-image {
            flex: 1;
            min-width: 300px;
            position: relative;
            overflow: hidden;
            height: 400px;
        }

        .contact-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s;
        }

        .contact-section:hover .contact-image img {
            transform: scale(1.05);
        }

        .contact-content {
            flex: 1;
            min-width: 300px;
            padding: 3rem;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .contact-content h2 {
            color: #333;
            font-size: 2rem;
            margin-bottom: 1rem;
            position: relative;
            padding-bottom: 0.5rem;
        }

        .contact-content h2::after {
            content: "";
            position: absolute;
            bottom: 0;
            left: 0;
            width: 40px;
            height: 3px;
            background-color: #ff7b6b; /* Coral accent */
        }

        .contact-content p {
            color: #666;
            margin-bottom: 1.5rem;
            font-size: 1.1rem;
        }

        .contact-info {
            margin-bottom: 2rem;
        }

        .contact-info-item {
            display: flex;
            align-items: center;
            margin-bottom: 1rem;
        }

        .contact-icon {
            width: 40px;
            height: 40px;
            background-color: #fff8f7; /* Very light coral background */
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 1rem;
        }

        .contact-icon img {
            width: 20px;
            height: 20px;
        }

        .contact-text {
            color: #333;
        }

        .contact-buttons {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .email-button {
            display: inline-flex;
            align-items: center;
            background-color: #ff7b6b;
            color: white;
            padding: 0.8rem 2rem;
            border-radius: 4px;
            text-decoration: none;
            font-weight: 500;
            transition: background-color 0.3s, transform 0.2s;
            border: none;
            cursor: pointer;
            font-size: 1rem;
        }

        .email-button:hover {
            background-color: #e56a5a;
            transform: translateY(-2px);
        }

        .email-button img {
            width: 20px;
            height: 20px;
            margin-right: 10px;
            filter: brightness(0) invert(1);
        }

        .alt-contact {
            display: inline-flex;
            align-items: center;
            background-color: transparent;
            color: #ff7b6b;
            padding: 0.8rem 2rem;
            border-radius: 4px;
            text-decoration: none;
            font-weight: 500;
            transition: background-color 0.3s;
            border: 1px solid #ff7b6b;
        }

        .alt-contact:hover {
            background-color: #fff8f7;
        }

        .alt-contact img {
            width: 20px;
            height: 20px;
            margin-right: 10px;
        }

        .contact-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(rgba(0,0,0,0), rgba(0,0,0,0.6));
            display: flex;
            align-items: flex-end;
            padding: 2rem;
            color: white;
        }

        .contact-overlay h3 {
            font-size: 1.8rem;
            margin-bottom: 0.5rem;
            text-shadow: 1px 1px 3px rgba(0,0,0,0.5);
        }

        .contact-overlay p {
            font-size: 1.1rem;
            text-shadow: 1px 1px 3px rgba(0,0,0,0.5);
        }

        /* Responsive adjustments for contact section */
        @media (max-width: 768px) {
            .contact-image {
                height: 250px;
            }

            .contact-content {
                padding: 2rem;
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
    </style>
</head>
<body>
<!-- Header -->
<header>
    <div class="container">
        <nav class="navbar">
            <a href="#" class="logo">Book<span>Nest</span></a>
            <ul class="nav-links">
                <li><a href="../index.jsp">Home</a></li>
                <li><a href="./about.jsp" class="active">About</a></li>
            </ul>
            <div class="auth-buttons">
                <a href="./login.jsp" class="login-btn">Login</a>
                <a href="./register.jsp" class="register-btn">Register</a>
            </div>
        </nav>
    </div>
</header>

<!-- Hero Banner with Background Image -->
<section class="hero-banner">
    <div class="hero-overlay"></div>
    <div class="hero-content">
        <h1>About BookNest</h1>
        <p>Transforming library management for the digital age</p>
    </div>
</section>

<main class="container">
    <section class="about-section">
        <h2>Our Story</h2>
        <div class="about-with-image">
            <div class="about-text">
                <p>BookNest is a web-based Library Management System designed to modernize and streamline the interaction between students and library resources, as well as simplify the administrative tasks of managing a library. In many educational institutions, library systems are still heavily reliant on manual or semi-digital operations, which can lead to inefficiencies such as lost books, delays in book tracking, mismanaged borrowing records, and a generally disorganized environment.</p>

                <p>BookNest seeks to address these issues by providing a centralized, automated, and user-friendly platform that ensures both students and administrators can perform their respective tasks more effectively and efficiently.</p>
            </div>
            <div class="about-image">
                <img src="../assets/digital.png" alt="Modern library with students using digital resources">
            </div>
        </div>
    </section>

    <!-- New Contact Us Section -->
    <section class="contact-section">
        <div class="contact-container">
            <div class="contact-image">
                <img src="../assets/Contact.jpg" alt="BookNest Help Desk">
                <div class="contact-overlay">
                    <div>
                        <h3>We're Here to Help</h3>
                        <p>Our team is ready to assist you with any questions</p>
                    </div>
                </div>
            </div>
            <div class="contact-content">
                <h2>Contact Us</h2>
                <p>Have questions about BookNest? We'd love to hear from you. Reach out to our team for assistance with implementation, features, or any other inquiries.</p>

                <div class="contact-info">
                    <div class="contact-info-item">
                        <div class="contact-icon">
                            <img src="../assets/email.png" alt="Email Icon">
                        </div>
                        <div class="contact-text">
                            Booknest123@gmail.com
                        </div>
                    </div>
                    <div class="contact-info-item">
                        <div class="contact-icon">
                            <img src="../assets/contactIcon.png" alt="Phone Icon">
                        </div>
                        <div class="contact-text">
                            9812345678
                        </div>
                    </div>
                    <div class="contact-info-item">
                        <div class="contact-icon">
                            <img src="../assets/Location.png" alt="Location Icon">
                        </div>
                        <div class="contact-text">
                            Sundar Dulari, Nepal
                        </div>
                    </div>
                </div>

                <div class="contact-buttons">
                    <a href="mailto:abishanacharya202@gmail.com" class="email-button" data-aos="zoom-in" data-aos-delay="600">Send an Email</a>



                </div>
            </div>
        </div>
    </section>

    <section class="about-section">
        <h2>Who We Serve</h2>

        <div class="user-benefits">
            <div class="benefit-column">
                <h3>For Students</h3>
                <p>BookNest serves as a convenient digital gateway to your campus library. It allows you to:</p>
                <ul>
                    <li>Browse the complete catalog of books</li>
                    <li>Filter and search based on your interests</li>
                    <li>Borrow books within defined borrowing limits</li>
                    <li>Return them with proper tracking</li>
                    <li>Review and rate books you've read</li>
                    <li>Engage with the library community</li>
                </ul>
                <p>Our intuitive interface design ensures that even users with minimal technical expertise can navigate and perform operations with ease.</p>
                <div class="benefit-image">
                    <img src="../assets/student%20library.jpg" alt="Students using BookNest in a library">
                </div>
            </div>

            <div class="benefit-column">
                <h3>For Administrators</h3>
                <p>BookNest offers a powerful toolset for managing your library:</p>
                <ul>
                    <li>Manage book inventories efficiently</li>
                    <li>Track which books are currently loaned out</li>
                    <li>Monitor due dates automatically</li>
                    <li>Manage penalties for late returns</li>
                    <li>Add new books and update existing records</li>
                    <li>Generate insights based on borrowing history</li>
                </ul>
                <p>The role-based access control system ensures that users can only access functionalities appropriate to their roles, improving both security and workflow.</p>
                <div class="benefit-image">
                    <img src="../assets/dashboard.png" alt="Librarian using BookNest dashboard">
                </div>
            </div>
        </div>
    </section>

    <section class="why-choose">
        <h2>Why Choose BookNest</h2>
        <p>Discover the features that make your reading experience seamless</p>

        <div class="feature-grid">
            <div class="feature-card">
                <div class="feature-icon">
                    <img src="../assets/userManagement.png" alt="User Management Icon">
                </div>
                <h3>User Management</h3>
                <p>Secure login and registration with role-based access control, ensuring users can only access appropriate functionalities based on their role.</p>
            </div>

            <div class="feature-card">
                <div class="feature-icon">
                    <img src="../assets/BookManage.png" alt="Book Management Icon">
                </div>
                <h3>Book Management</h3>
                <p>Comprehensive tools for adding, updating, and removing book records, with detailed information and availability status tracking.</p>
            </div>

            <div class="feature-card">
                <div class="feature-icon">
                    <img src="../assets/BorrowReturn.png" alt="Borrow & Return Icon">
                </div>
                <h3>Borrow & Return</h3>
                <p>Streamlined processes for borrowing and returning books, with automatic tracking of due dates and late return penalties.</p>
            </div>

            <div class="feature-card">
                <div class="feature-icon">
                    <img src="../assets/univebookhistory.jpg" alt="History Tracking Icon">
                </div>
                <h3>History Tracking</h3>
                <p>Complete borrowing and returning record keeping for both students to track their reading and administrators to monitor trends.</p>
            </div>

            <div class="feature-card">
                <div class="feature-icon">
                    <img src="../assets/Book%20Review.png" alt="Book Reviews Icon">
                </div>
                <h3>Book Reviews</h3>
                <p>Interactive rating and review system that allows students to share their thoughts on books and help others make informed choices.</p>
            </div>

            <div class="feature-card">
                <div class="feature-icon">
                    <img src="../assets/filter.png" alt="Search & Filter Icon">
                </div>
                <h3>Search & Filter</h3>
                <p>Advanced search capabilities allowing users to quickly find books by title, author, category, or other criteria.</p>
            </div>
        </div>
    </section>

    <section class="about-section">
        <div class="mission-box">
            <h2>Our Mission</h2>
            <p>BookNest is not just a digital library system, it also is a step toward modernizing academic libraries by making them smarter, more accessible, and more engaging. Through automation, smart data handling, and an interactive user interface, BookNest aligns with the growing demand for efficient and tech-driven solutions in the education sector.</p>

            <p>We aim to transform libraries from static repositories of books into dynamic digital services that promote accountability, encourage reading, and enhance user satisfaction.</p>
        </div>
    </section>

</main>

<!-- Footer -->
<footer>
    <div class="container">
        <div class="footer-bottom">
            <p>© 2025 BookNest Library Management System. All rights reserved.</p>
        </div>
    </div>

</body>
</html>