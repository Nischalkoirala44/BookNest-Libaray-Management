<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<footer class="footer">
    <div class="footer-container">
        <div class="footer-bottom">
            <p>© <%= new java.util.Date().getYear() + 1900 %> Book Nest. All rights reserved.</p>
        </div>
    </div>
</footer>

<style>
    .footer {
        background-color: #ff7a65;
        color: #fff;
        padding: 20px 0;
        text-align: center;
        width: 100%;
    }

    .footer-container {
        max-width: 1200px;
        margin: 0 auto;
    }

    .footer-bottom p {
        margin: 0;
        font-size: 14px;
        opacity: 0;
        animation: fadeIn 1s ease-in forwards;
    }

    @keyframes fadeIn {
        from {
            opacity: 0;
            transform: translateY(10px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
</style>