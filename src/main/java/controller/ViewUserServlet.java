package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.User;

@WebServlet("/ViewUserServlet")
public class ViewUserServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public  void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected  void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        try {
            List<User> users = userDAO.getAllUsers();
            request.setAttribute("users", users);
            request.getRequestDispatcher("view/users.jsp").forward(request, response);
        } catch (RuntimeException e) {
            throw new RuntimeException(e);
        }
    }
}