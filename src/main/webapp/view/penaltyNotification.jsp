<%@ page import="java.util.List, model.Borrow" %>
<%@ include file="nav-bar.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Penalty Notifications</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            min-height: 100vh;
            padding: 16px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        h2 {
            color: #333;
            font-size: 1.5rem;
            text-align: center;
            margin: 24px 0;
        }

        .container {
            width: 100%;
            max-width: 600px;
            background: white;
            padding: 24px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            margin-bottom: 24px;
        }

        .message {
            padding: 12px;
            border: 1px solid #ffcccc;
            border-radius: 4px;
            background-color: #fff5f5;
            color: #d32f2f;
            font-size: 0.95rem;
            margin-bottom: 16px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .message::before {
            content: "⚠";
            font-size: 1.2rem;
        }

        .no-penalties {
            text-align: center;
            color: #555;
            font-size: 1rem;
            padding: 16px;
            background-color: #f9f9f9;
            border-radius: 4px;
        }

        @media (max-width: 640px) {
            .container {
                padding: 16px;
            }

            h2 {
                font-size: 1.25rem;
            }

            .message {
                font-size: 0.9rem;
            }

            .no-penalties {
                font-size: 0.95rem;
            }
        }
    </style>
</head>
<body>
<h2>Penalty Notifications</h2>
<div class="container">
    <%
        List penalties = (List) request.getAttribute("penalties");
        if (penalties == null || penalties.isEmpty()) {
    %>
    <p class="no-penalties">No penalties have been applied yet.</p>
    <%
    } else {
        for (Object obj : penalties) {
            Borrow borrow = (Borrow) obj;
    %>
    <p class="message">You have been fined Rs. <%= borrow.getPenalty() %> for not returning the book on time.</p>
    <%
            }
        }
    %>
</div>
</body>
</html>