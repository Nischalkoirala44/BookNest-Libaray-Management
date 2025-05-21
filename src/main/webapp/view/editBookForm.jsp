<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Book, dao.BookDAO" %>
<%@ page import="java.sql.SQLException" %>
<%
  String bookIdParam = request.getParameter("bookId");
  Book book = null;
  if (bookIdParam != null) {
    try {
      int bookId = Integer.parseInt(bookIdParam);
      BookDAO dao = new BookDAO();
      try {
        book = dao.getBookById(bookId);
      } catch (SQLException e) {
        throw new RuntimeException(e);
      }
    } catch (NumberFormatException e) {
      request.setAttribute("errorMessage", "Invalid book ID.");
    }
  } else {
    request.setAttribute("errorMessage", "Missing book ID.");
  }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Update Book</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f4;
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
      padding: 16px;
    }

    .container {
      width: 100%;
      max-width: 500px;
      background: white;
      padding: 24px;
      border-radius: 8px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }

    h2 {
      text-align: center;
      color: #333;
      margin-bottom: 24px;
      font-size: 1.5rem;
    }

    .error {
      color: #d32f2f;
      text-align: center;
      margin-bottom: 16px;
      font-size: 0.9rem;
    }

    .image-container {
      display: flex;
      justify-content: center;
      margin-bottom: 16px;
    }

    .book-img {
      max-width: 150px;
      height: auto;
      object-fit: cover;
      border-radius: 4px;
    }

    form {
      display: flex;
      flex-direction: column;
      gap: 16px;
    }

    label {
      font-size: 0.9rem;
      font-weight: bold;
      color: #333;
    }

    input[type="text"],
    input[type="number"],
    input[type="file"],
    select {
      width: 100%;
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 4px;
      font-size: 1rem;
      transition: border-color 0.2s;
    }

    input[type="text"]:focus,
    input[type="number"]:focus,
    input[type="file"]:focus,
    select:focus {
      outline: none;
      border-color: #2563eb;
      box-shadow: 0 0 0 2px rgba(37, 99, 235, 0.2);
    }

    input[type="submit"] {
      padding: 12px;
      background-color: #2563eb;
      color: white;
      border: none;
      border-radius: 4px;
      font-size: 1rem;
      cursor: pointer;
      transition: background-color 0.2s;
    }

    input[type="submit"]:hover {
      background-color: #1d4ed8;
    }

    @media (max-width: 640px) {
      .container {
        padding: 16px;
      }

      h2 {
        font-size: 1.25rem;
      }

      .book-img {
        max-width: 120px;
      }
    }
  </style>
</head>
<body>
<div class="container">
  <% if (request.getAttribute("errorMessage") != null) { %>
  <p class="error"><%= request.getAttribute("errorMessage") %></p>
  <% } else if (book != null) { %>
  <h2>Update Book</h2>
  <form action="${pageContext.request.contextPath}/updateBook" method="post" enctype="multipart/form-data">
    <div class="image-container">
      <img class="book-img" src="${pageContext.request.contextPath}/BookImageServlet?bookId=<%= book.getBookId() %>" alt="Book Cover">
    </div>
    <input type="hidden" name="bookId" value="<%= book.getBookId() %>"/>
    <div>
      <label for="title">Title</label>
      <input type="text" id="title" name="title" value="<%= book.getTitle() %>" required/>
    </div>
    <div>
      <label for="author">Author</label>
      <input type="text" id="author" name="author" value="<%= book.getAuthor() %>" required/>
    </div>
    <div>
      <label for="totalCopies">Total Copies</label>
      <input type="number" id="totalCopies" name="totalCopies" value="<%= book.getTotalCopies() %>" required/>
    </div>
    <div>
      <label for="category">Category</label>
      <select id="category" name="category" required>
        <option value="Fiction" <%= "Fiction".equals(book.getCategory()) ? "selected" : "" %>>Fiction</option>
        <option value="Non-Fiction" <%= "Non-Fiction".equals(book.getCategory()) ? "selected" : "" %>>Non-Fiction</option>
        <option value="Science" <%= "Science".equals(book.getCategory()) ? "selected" : "" %>>Science</option>
        <option value="History" <%= "History".equals(book.getCategory()) ? "selected" : "" %>>History</option>
        <option value="Biography" <%= "Biography".equals(book.getCategory()) ? "selected" : "" %>>Biography</option>
        <option value="Fantasy" <%= "Fantasy".equals(book.getCategory()) ? "selected" : "" %>>Fantasy</option>
      </select>
    </div>
    <div>
      <label for="bookImage">Book Image</label>
      <input type="file" id="bookImage" name="bookImage" accept="image/*"/>
    </div>
    <input type="submit" value="Update Book"/>
  </form>
  <% } else { %>
  <p class="error">Book not found.</p>
  <% } %>
</div>
</body>
</html>