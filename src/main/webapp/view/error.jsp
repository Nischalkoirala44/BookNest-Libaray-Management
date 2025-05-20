<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; padding: 20px; color: #333; text-align: center; }
        .error-message { background-color: #fce4ec; padding: 20px; border-left: 4px solid #f06292; color: #555; border-radius: 6px; max-width: 600px; margin: 50px auto; }
        a { color: #2196F3; text-decoration: none; }
        a:hover { text-decoration: underline; }
    </style>
</head>
<body>
<div class="error-message">
    <h2>Error</h2>
    <p><%= request.getAttribute("error") != null ? request.getAttribute("error") : "An unexpected error occurred." %></p>
    <p><a href="${pageContext.request.contextPath}/browse">Return to Book Catalog</a></p>
</div>
</body>
</html>