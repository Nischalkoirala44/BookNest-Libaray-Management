<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BookHive Admin Dashboard</title>
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
            background: linear-gradient(to right, #f9f9f9, #e6f0ff);
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
        }

        .main h1 {
            margin-bottom: 20px;
            color: #333;
        }

        .cards {
            display: flex;
            gap: 20px;
            margin-bottom: 30px;
            flex-wrap: wrap;
        }

        .card {
            flex: 1;
            min-width: 220px;
            background: linear-gradient(to top right, #ff6a00, #ee0979);
            color: white;
            padding: 20px;
            border-radius: 12px;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .card:hover {
            transform: scale(1.03);
            box-shadow: 0 10px 20px rgba(0,0,0,0.15);
        }

        .card h3 {
            margin-bottom: 10px;
            font-size: 1.2em;
        }

        .card p {
            font-size: 1.5em;
            font-weight: bold;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0,0,0,0.05);
        }

        th, td {
            padding: 14px 20px;
            text-align: left;
            border-bottom: 1px solid #eaeaea;
        }

        th {
            background-color: #4e54c8;
            color: white;
        }

        tr:hover {
            background-color: #f0f4ff;
        }
        .sidebar .active {
            background-color: rgba(255, 255, 255, 0.2);
        }
    </style>
</head>
<body>
<div class="sidebar">
    <h2>📚 BookNest</h2>
    <a href="${pageContext.request.contextPath}/view/adminPanel.jsp" class="active">Dashboard</a>
    <a href="${pageContext.request.contextPath}/view/books.jsp">Books</a>
    <a href="${pageContext.request.contextPath}/view/users.jsp">Users</a>
    <a href="${pageContext.request.contextPath}/issuedBooks">History</a>
    <a href="${pageContext.request.contextPath}/view/register.jsp">Logout</a>
</div>

<div class="main">
    <h1>Admin Dashboard</h1>

    <div class="cards">
        <div class="card">
            <h3>Total Books</h3>
            <p>850</p>
        </div>
        <div class="card" style="background: linear-gradient(to top right, #00c6ff, #0072ff);">
            <h3>Total Users</h3>
            <p>342</p>
        </div>
        <div class="card" style="background: linear-gradient(to top right, #36d1dc, #5b86e5);">
            <h3>Books Issued</h3>
            <p>120</p>
        </div>
    </div>

    <h2>Recently Added Books</h2>
    <table>
        <tr>
            <th>Title</th>
            <th>Author</th>
            <th>Category</th>
            <th>Date Added</th>
        </tr>
        <tr>
            <td>Learn JavaScript</td>
            <td>Mark Twain</td>
            <td>Programming</td>
            <td>April 15, 2025</td>
        </tr>
        <tr>
            <td>Mastering CSS</td>
            <td>Jane Doe</td>
            <td>Web Design</td>
            <td>April 12, 2025</td>
        </tr>
        <tr>
            <td>Database Systems</td>
            <td>John Smith</td>
            <td>Technology</td>
            <td>April 10, 2025</td>
        </tr>
    </table>
</div>
</body>
</html>