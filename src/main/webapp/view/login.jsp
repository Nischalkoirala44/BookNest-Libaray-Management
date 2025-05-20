<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Login</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #eccdab, #c9a17e);
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }

        .container {
            background: #eccdab;
            padding: 2.5rem;
            border-radius: 16px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }

        h2 {
            margin-bottom: 1.5rem;
            color: #333;
        }

        form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        input[type="email"],
        input[type="password"] {
            padding: 0.75rem 1rem;
            margin: 0.5rem 0;
            width: 100%;
            border: none;
            border-radius: 12px;
            background: #f0f0f3;
            box-shadow: inset 2px 2px 5px #eccdab,
            inset -2px -2px 5px #ffffff;
            font-size: 1rem;
        }

        input[type="email"]:focus,
        input[type="password"]:focus {
            outline: none;
            box-shadow: 0 0 0 3px rgb(188, 133, 78);
            background: #ffffff;
        }

        button {
            margin-top: 1rem;
            padding: 0.75rem;
            width: 100%;
            border: none;
            border-radius: 12px;
            background-color: #bc854e;
            color: white;
            font-size: 1rem;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        button:hover {
            background-color: #a96f3c;
            transform: scale(1.03);
        }

        .loading {
            display: none;
            color: #c9a17e;
            font-size: 0.9rem;
            margin-top: 1rem;
        }

        .success {
            color: #bc854e;
            font-size: 0.9rem;
            margin-top: 0.5rem;
        }

        .error {
            color: red;
            font-size: 0.9rem;
            margin-top: 0.5rem;
        }

        .register-link {
            margin-top: 1rem;
            font-size: 0.9rem;
        }

        .register-link a {
            color: #8b5e34;
            font-weight: bold;
            text-decoration: none;
        }

        .register-link a:hover {
            color: #bc854e;
        }

        @media (max-width: 480px) {
            .container {
                padding: 1.5rem;
            }

            input,
            button {
                font-size: 0.95rem;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Login</h2>
    <form id="loginForm" method="post" action="${pageContext.request.contextPath}/login">
        <input type="email" name="email" placeholder="Email" required />
        <input type="password" name="password" placeholder="Password" required />
        <button type="submit" id="submitButton">Login</button>

        <p class="loading" id="loadingMessage">Processing...</p>
        <p class="success">
            <% if (request.getParameter("registerSuccess") != null) { %>
            Registration successful! Please login below.
            <% } %>
        </p>
        <p class="error">${error}</p>
    </form>
    <p class="register-link">
        Don't have an account? <a href="${pageContext.request.contextPath}/view/register.jsp">Register here</a>.
    </p>
</div>

<script>
    document.getElementById('loginForm').addEventListener('submit', function(e) {
        const emailInput = document.querySelector('input[name="email"]');
        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailPattern.test(emailInput.value)) {
            e.preventDefault();
            alert('Please enter a valid email address.');
            return;
        }
        // Show loading message
        document.getElementById('loadingMessage').style.display = 'block';
        document.getElementById('submitButton').disabled = true;
    });
</script>
</body>
</html>
