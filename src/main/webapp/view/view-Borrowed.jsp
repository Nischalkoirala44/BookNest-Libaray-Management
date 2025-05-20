<%@ page import="java.util.List" %>
<%@ page import="model.Borrow" %>
<%@ page import="model.Book" %>
<%@ include file="nav-bar.jsp" %>
<!DOCTYPE html>
<html lang="en">
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        padding: 20px;
        margin: 0;
        color: #333;
        line-height: 1.6;
    }

    h2 {
        color: #1a1a1a;
        margin-bottom: 25px;
        font-size: 1.8rem;
        border-bottom: 2px solid #2196F3;
        padding-bottom: 10px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        background-color: #fff;
        box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
        border-radius: 6px;
        overflow: hidden;
    }

    thead {
        background-color: #2196F3;
        color: black;
        font-weight: 600;
    }

    thead:hover{
        background-color: #2196F3;
    }

    th {
        padding: 15px;
        text-align: left;
        font-weight: 600;
    }

    td {
        padding: 15px;
        border-bottom: 1px solid #eee;
        vertical-align: middle;
    }

    tr:last-child td {
        border-bottom: none;
    }

    .book-image {
        width: 80px;
        height: 110px;
        object-fit: cover;
        border-radius: 4px;
        border: 1px solid #ddd;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    .book-title {
        font-weight: 600;
        color: #1a1a1a;
        font-size: 1.1rem;
    }

    .return-button {
        padding: 8px 16px;
        background-color: #e53935;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 14px;
        font-weight: 500;
        transition: background-color 0.2s ease, transform 0.1s ease;
        box-shadow: 0 2px 4px rgba(229, 57, 53, 0.2);
    }

    .return-button:hover {
        background-color: #c62828;
    }

    .return-button:focus {
        outline: none;
        box-shadow: 0 0 0 3px rgba(229, 57, 53, 0.3);
    }

    .return-button:active {
        transform: scale(0.98);
    }

    .info-message {
        background-color: #fce4ec;
        padding: 20px;
        border-left: 4px solid #f06292;
        color: #555;
        border-radius: 6px;
        font-size: 1rem;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
        margin-top: 20px;
    }

    /* Responsive adjustments */
    @media (max-width: 768px) {
        table, thead, tbody, th, td, tr {
            display: block;
        }

        thead tr {
            position: absolute;
            top: -9999px;
            left: -9999px;
        }

        tr {
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 6px;
            overflow: hidden;
        }

        td {
            border: none;
            border-bottom: 1px solid #eee;
            position: relative;
            padding-left: 50%;
            text-align: right;
        }

        td:before {
            position: absolute;
            top: 15px;
            left: 15px;
            width: 45%;
            padding-right: 10px;
            white-space: nowrap;
            text-align: left;
            font-weight: bold;
            content: attr(data-label);
        }

        td:last-child {
            text-align: center;
            padding-left: 15px;
        }

        .book-image {
            margin: 0 auto;
            display: block;
        }
    }
</style>
<head>
    <title>My Borrowed Books</title>
</head>
<body>

<h2>Borrowed Books</h2>

<%
    List<Borrow> borrowedBooks = (List<Borrow>) request.getAttribute("borrowedBooks");
    if (borrowedBooks != null && !borrowedBooks.isEmpty()) {
%>
<table>
    <thead>
    <tr>
        <th>Cover</th>
        <th>Title</th>
        <th>Author</th>
        <th>Category</th>
        <th>Borrowed On</th>
        <th>Due Date</th>
        <th>Action</th>
    </tr>
    </thead>
    <tbody>
    <%
        for (Borrow borrow : borrowedBooks) {
            Book book = borrow.getBook();
    %>
    <tr>
        <td data-label="Cover">
            <img src="${pageContext.request.contextPath}/BookImageServlet?bookId=<%= book.getBookId() %>" alt="Book cover" class="book-image">
        </td>
        <td data-label="Title" class="book-title"><%= book.getTitle() %></td>
        <td data-label="Author"><%= book.getAuthor() %></td>
        <td data-label="Category"><%= book.getCategory() %></td>
        <td data-label="Borrowed On"><%= borrow.getBorrowDate() %></td>
        <td data-label="Due Date"><%= borrow.getDueDate() %></td>
        <td data-label="Action">
            <form action="return-book" method="post">
                <input type="hidden" name="borrowId" value="<%= borrow.getBorrowId() %>" />
                <button type="submit" class="return-button">Return</button>
            </form>
        </td>
    </tr>
    <%
        }
    %>
    </tbody>
</table>
<%
} else {
%>
<div class="info-message">No borrowed books to display.</div>
<%
    }
%>

</body>
</html>