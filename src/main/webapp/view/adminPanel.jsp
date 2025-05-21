<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.BookDAO,model.Book,java.util.List,dao.UserDAO,dao.BorrowDAO,model.Borrow,java.util.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - BookNest</title>
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

        .sidebar a:hover, .sidebar .active {
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

        .dashboard-stats {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-bottom: 40px;
        }

        .stat-card {
            flex: 1;
            min-width: 200px;
            background-color: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            display: flex;
            align-items: center;
            transition: transform 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-icon {
            font-size: 2.5rem;
            margin-right: 15px;
            color: #4e54c8;
        }

        .stat-info h3 {
            font-size: 1.8rem;
            color: #333;
            margin-bottom: 5px;
        }

        .stat-info p {
            color: #666;
        }

        .section-title {
            margin: 30px 0 20px;
            color: #333;
            border-bottom: 2px solid #4e54c8;
            padding-bottom: 10px;
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

        .error {
            color: #e74c3c;
            background-color: #fce4e4;
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<div class="sidebar">
    <h2>📚 BookNest</h2>
    <a href="${pageContext.request.contextPath}/admin-dashboard" class="active">Dashboard</a>
    <a href="${pageContext.request.contextPath}/view/books.jsp">Books</a>
    <a href="${pageContext.request.contextPath}/view/users.jsp">Users</a>
    <a href="${pageContext.request.contextPath}/issuedBooks">History</a>
    <a href="${pageContext.request.contextPath}/view/register.jsp">Logout</a>
</div>

<div class="main">
    <h1>📊 Admin Dashboard</h1>
    <% if (request.getAttribute("errorMessage") != null) { %>
    <p class="error"><%= request.getAttribute("errorMessage") %></p>
    <% } %>
    
    <!-- Dashboard Statistics -->
    <div class="dashboard-stats">
        <%
            // If coming directly to the page, calculate stats here
            Integer totalUsers = (Integer) request.getAttribute("totalUsers");
            Integer totalBooks = (Integer) request.getAttribute("totalBooks");
            Integer currentlyBorrowed = (Integer) request.getAttribute("currentlyBorrowed");
            Integer totalBorrows = (Integer) request.getAttribute("totalBorrows");
            
            // If attributes are null (direct access to JSP), calculate them
            if (totalUsers == null || totalBooks == null || currentlyBorrowed == null || totalBorrows == null) {
                try {
                    BookDAO bookDAO = new BookDAO();
                    UserDAO userDAO = new UserDAO();
                    BorrowDAO borrowDAO = new BorrowDAO();
                    
                    totalUsers = userDAO.getAllUsers().size();
                    totalBooks = bookDAO.getAllBooks().size();
                    currentlyBorrowed = borrowDAO.getAllDetailedBorrows().size();
                    totalBorrows = borrowDAO.getAllDetailedBorrows().size();
                } catch (Exception e) {
                    out.println("Error calculating statistics: " + e.getMessage());
                    totalUsers = 0;
                    totalBooks = 0;
                    currentlyBorrowed = 0;
                    totalBorrows = 0;
                }
            }
        %>
        <div class="stat-card">
            <div class="stat-icon">👥</div>
            <div class="stat-info">
                <h3><%= totalUsers %></h3>
                <p>Total Users</p>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">📚</div>
            <div class="stat-info">
                <h3><%= totalBooks %></h3>
                <p>Total Books</p>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">📖</div>
            <div class="stat-info">
                <h3><%= currentlyBorrowed %></h3>
                <p>Currently Borrowed</p>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">📝</div>
            <div class="stat-info">
                <h3><%= totalBorrows %></h3>
                <p>Total Borrows</p>
            </div>
        </div>
    </div>
    
    <h2 class="section-title">📚 Book Management</h2>
    <div class="stat-card" style="cursor: pointer;" onclick="window.location.href='${pageContext.request.contextPath}/view/books.jsp'">
        <div class="stat-icon">📚</div>
        <div class="stat-info">
            <h3>Manage Books</h3>
            <p>Add, edit, or delete books from the library</p>
        </div>
    </div>

    <!-- Recent Activity Section -->
    <h2 class="section-title">Recent Activity</h2>
    <table>
        <tr>
            <th>User</th>
            <th>Book</th>
            <th>Action</th>
            <th>Date</th>
        </tr>
        <%
            try {
                BorrowDAO borrowDAO = new BorrowDAO();
                List<Borrow> recentActivity = borrowDAO.getAllDetailedBorrows();
                
                // Sort by borrow date (most recent first) if possible
                if (recentActivity != null && !recentActivity.isEmpty()) {
                    Collections.sort(recentActivity, new Comparator<Borrow>() {
                        public int compare(Borrow b1, Borrow b2) {
                            if (b1.getBorrowDate() == null || b2.getBorrowDate() == null) {
                                return 0;
                            }
                            return b2.getBorrowDate().compareTo(b1.getBorrowDate());
                        }
                    });
                    
                    // Limit to 5 items
                    int displayLimit = Math.min(recentActivity.size(), 5);
                    for (int i = 0; i < displayLimit; i++) {
                        Borrow borrow = recentActivity.get(i);
        %>
        <tr>
            <td><%= borrow.getName() != null ? borrow.getName() : "Unknown" %></td>
            <td><%= borrow.getBook() != null && borrow.getBook().getTitle() != null ? borrow.getBook().getTitle() : "Unknown" %></td>
            <td>Borrowed</td>
            <td><%= borrow.getBorrowDate() != null ? borrow.getBorrowDate() : "Unknown" %></td>
        </tr>
        <%
                    }
                } else {
        %>
        <tr>
            <td colspan="4">No recent activity found.</td>
        </tr>
        <%
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='4'>Error loading recent activity: " + e.getMessage() + "</td></tr>");
            }
        %>
    </table>
</div>
</body>
</html>
