import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.sql.*;

@WebServlet("/loginfetch")
public class LoginFetch extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        String uname = request.getParameter("username");
        String pwd = request.getParameter("password");
        response.setContentType("text/html");

        PrintWriter out = response.getWriter();
        try {
            if (processForm(uname, pwd) == 1) {
                out.println("Login Successful");
                response.addCookie(new Cookie("username", uname));
                response.sendRedirect("homepage.jsp");
            } else {
                out.println("Login Failed");
                response.sendRedirect("login.jsp");
            }
        } catch (ClassNotFoundException | SQLException e) {
            out.println("Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    private int processForm(String uname, String pwd) throws ClassNotFoundException, SQLException {
        String dbUrl = "jdbc:mysql://localhost:3306/shopapp";
        String dbDriver = "com.mysql.cj.jdbc.Driver";
        String email = uname;
        String password = pwd;

        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;
        try {
            Class.forName(dbDriver);
            connection = DriverManager.getConnection(dbUrl, "test", "test");
            statement = connection.createStatement();

            String query = "SELECT * FROM login WHERE email = '" + email + "' AND password = '" + password + "'";
            resultSet = statement.executeQuery(query);
            if (resultSet.next()) {
                return 1;
            } else {
                return 0;
            }
        } finally {
            if (resultSet != null) {
                resultSet.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (connection != null) {
                connection.close();
            }
        }
    }
}