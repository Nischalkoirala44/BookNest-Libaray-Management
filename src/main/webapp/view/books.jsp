<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.BookDAO,model.Book,java.util.List" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Books - BookNest</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            display: flex;
            height: 100vh;
            background: linear-gradient(to right, #eef2f3, #e6f0ff);
        }

        .sidebar {
            width: 220px;
            background: linear-gradient(to bottom, #4e54c8, #8f94fb);
            color: white;
            padding: 20px;
            display: flex;
            flex-direction: column;
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
        }

        .sidebar h2 {
            margin-bottom: 30px;
            text-align: center;
        }

        .sidebar a {
            color: white;
            text-decoration: none;
            margin: 10px 0;
            padding: 10px;
            border-radius: 8px;
            transition: background 0.3s;
        }

        .sidebar a:hover {
            background-color: rgba(255, 255, 255, 0.2);
        }

        .main {
            flex: 1;
            padding: 30px;
            background-color: #f2f6ff;
            overflow-y: auto;
        }

        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }

        .book-form {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-bottom: 40px;
            justify-content: space-between;
        }

        .book-form input, .book-form select {
            flex: 1;
            padding: 12px 14px;
            border: 1px solid #ccc;
            border-radius: 8px;
            outline: none;
            transition: border 0.3s;
        }

        .book-form input:focus {
            border-color: #4e54c8;
        }

        .book-form button {
            padding: 12px 20px;
            background: linear-gradient(to right, #4e54c8, #8f94fb);
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.3s, transform 0.2s;
        }

        .book-form button:hover {
            background: linear-gradient(to right, #8f94fb, #4e54c8);
            transform: scale(1.05);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }

        th, td {
            padding: 14px 18px;
            text-align: left;
            border-bottom: 1px solid #f0f0f0;
        }

        th {
            background-color: #4e54c8;
            color: white;
        }

        tr:hover {
            background-color: #f7f9ff;
        }

        .actions button {
            margin-right: 8px;
            padding: 6px 10px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            color: white;
            transition: all 0.3s;
            width: 80px;
            margin-top: 1px;
        }

        .edit-btn {
            background-color: #36d1dc;
        }

        .edit-btn:hover {
            background-color: #2bb6c4;
        }

        .delete-btn {
            background-color: #ff6a6a;
        }

        .delete-btn:hover {
            background-color: #e65c5c;
        }

        .sidebar .active {
            background-color: rgba(255, 255, 255, 0.2);
        }

        td img {
            max-width: 100px;
            max-height: 100px;
            object-fit: cover;
            border-radius: 8px;
        }
    </style>
</head>
<body>
<div class="sidebar">
    <h2>📚 BookNest</h2>
    <a href="${pageContext.request.contextPath}/admin-dashboard">Dashboard</a>
    <a href="${pageContext.request.contextPath}/view/books.jsp" class="active">Books</a>
    <a href="${pageContext.request.contextPath}/view/users.jsp">Users</a>
    <a href="${pageContext.request.contextPath}/issuedBooks">History</a>
    <a href="${pageContext.request.contextPath}/view/register.jsp">Logout</a>
</div>

<div class="main">
    <h1>📚 Manage Books</h1>
    <% if (request.getAttribute("errorMessage") != null) { %>
    <p class="error"><%= request.getAttribute("errorMessage") %></p>
    <% } %>

    <form class="book-form" action="${pageContext.request.contextPath}/AddBookServlet" method="post" enctype="multipart/form-data">
        <input type="text" name="title" placeholder="Book Title" required>
        <input type="text" name="author" placeholder="Author" required>
        <input type="number" name="totalCopies" placeholder="Total Copies" min="1" required>
        <select id="category" name="category" required>
            <option value="Fiction">Fiction</option>
            <option value="Non-Fiction">Non-Fiction</option>
            <option value="Science">Science</option>
            <option value="History">History</option>
            <option value="Biography">Biography</option>
            <option value="Fantasy">Fantasy</option>
        </select>
        <input type="file" id="bookImage" name="bookImage" accept="image/*">
        <button type="submit" value="Add Book">Add Book</button>
    </form>

    <table>
        <tr>
            <th>Image</th>
            <th>Title</th>
            <th>Author</th>
            <th>Total Copies</th>
            <th>Category</th>
            <th>Actions</th>
        </tr>
        <%
            BookDAO bookDAO = new BookDAO();
            try {
                List<Book> books = bookDAO.getAllBooks();
                for (Book book : books) {
        %>
        <tr>
            <td><img src="${pageContext.request.contextPath}/BookImageServlet?bookId=<%= book.getBookId() %>" alt="<%= book.getTitle() %>"></td>
            <td><%= book.getTitle() %></td>
            <td><%= book.getAuthor() %></td>
            <td><%= book.getTotalCopies() %></td>
            <td><%= book.getCategory() %></td>
            <td class="actions">
                <button class="edit-btn"><a href="editBookForm.jsp?bookId=<%= book.getBookId()%>" style="color: white; text-decoration: none">Edit</a></button>
                <form action="${pageContext.request.contextPath}/deleteBook" method="post">
                    <input type="hidden" name="bookId" value="<%= book.getBookId() %>" />
                    <button style="background-color: #ff6a6a;" type="submit" onclick="return confirm('Are you sure you want to delete this book?');">
                        Delete
                    </button>
                </form>
            </td>
        </tr>
        <%
                }
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            }
        %>
    </table>
</div>
</body>
</html>