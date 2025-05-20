<%@ page import="java.util.List, model.Borrow" %>
<%@ include file="nav-bar.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Penalty Notifications</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        h2 {
            text-align: center;
            color: #333;
            margin-top: 20px;
        }
        .message {
            width: 50%;
            margin: 10px auto;
            padding: 15px;
            border: 1px solid #ffcccc;
            border-radius: 5px;
            background-color: #fff;
            color: #d8000c;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .no-penalties {
            text-align: center;
            color: #555;
            font-size: 18px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
<h2>Penalty Notifications</h2>
<%
    List penalties = (List) request.getAttribute("penalties");
    if (penalties == null || penalties.isEmpty()) {
%>
<p class="no-penalties">No penalties found.</p>
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

<%@ include file="./footer.jsp" %>
</body>
</html>