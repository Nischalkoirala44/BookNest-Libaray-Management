<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Registration</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

    <style>
        body {
            margin: 0;
            padding: 0;
            height: 100vh;
            background: linear-gradient(135deg, #bc854e, #e8c888);
            font-family: 'Poppins', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        form {
            background-color: #ffffff;
            border-radius: 20px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            padding: 30px 40px;
            width: 100%;
            max-width: 400px;
            box-sizing: border-box;
        }

        h2 {
            text-align: center;
            font-weight: 600;
            color: #333;
            margin-bottom: 20px;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"],
        input[type="file"],
        select {
            width: 100%;
            padding: 12px 15px;
            margin: 10px 0;
            border: none;
            border-radius: 12px;
            background: #f0f0f3;
            box-shadow: inset 2px 2px 5px #ffe4c3,
            inset -2px -2px 5px #ffffff;
            box-sizing: border-box;
            font-size: 14px;
            transition: all 0.2s ease;
        }

        input:focus,
        select:focus {
            outline: none;
            box-shadow: 0 0 0 3px rgb(188, 133, 78);
            background: #ffffff;
        }

        button[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: #eccdab;
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            margin-top: 10px;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        button[type="submit"]:hover {
            background-color: #bc854e;
            transform: scale(1.03);
        }

        .error {
            text-align: center;
            font-size: 14px;
            color: #c9a17e;
            margin-top: 10px;
        }

        .success {
            text-align: center;
            font-size: 14px;
            color: #bc854e;
            margin-top: 10px;
        }

        a {
            color: #c9a17e;
            text-decoration: none;
            font-weight: 500;
            transition: text-decoration 0.3s ease;
        }

        a:hover {
            text-decoration: underline;
        }

        p {
            text-align: center;
            font-size: 14px;
            margin-top: 15px;
            color: #333;
        }

        @media (max-width: 480px) {
            form {
                padding: 25px;
            }

            input,
            select,
            button {
                font-size: 13px;
            }
        }
    </style>
</head>
<body>

<form method="post" action="${pageContext.request.contextPath}/register" enctype="multipart/form-data">

    <h2>Create An Account</h2>

    <input type="text" name="name" placeholder="Full Name" required />

    <input type="email" name="email" placeholder="Email" required />

    <input type="password" name="password" placeholder="Password" required />

    <select name="role">
        <option value="user">User</option>
        <option value="admin">Admin</option>
    </select>

    <input type="file" name="profilePicture" accept="image/*" />

    <button type="submit">Register</button>

    <p class="error">${error}</p>

    <p class="success">
        <% if (request.getParameter("registerSuccess") != null) { %>
        Registration successful! You can now <a href="login.jsp">log in</a>.
        <% } %>
    </p>

    <p>
        Already have an account?
        <a href="${pageContext.request.contextPath}/view/login.jsp">Login here</a>.
    </p>
</form>

</body>
</html>