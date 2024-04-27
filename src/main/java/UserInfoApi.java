import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.sql.*;

@WebServlet("/userinfoapi")
public class UserInfoApi extends HttpServlet{
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String email = request.getParameter("email");
        if (email == null) {
            response.sendError(400, "Email is required");
            return;
        }
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        Connection con = null;
        Statement stmt = null;
        int id = 0;
        int count = 0;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/shopapp","test","test");
            stmt = con.createStatement();
            String Query = "SELECT id FROM login where email = '"+email+"'";
            ResultSet rs = stmt.executeQuery(Query);
            while(rs.next()){
                id = rs.getInt("id");
            }
            Query = "SELECT COUNT(*) from usercart"+id;
            rs = stmt.executeQuery(Query);
            while(rs.next()){
                count = rs.getInt("COUNT(*)");
            }
            out.println("{\"id\":\""+id+"\", \"count\":\""+count+"\"}");
        } catch (Exception e) {
            out.println(e);
        } finally {
            try {
                stmt.close();
                con.close();
            } catch (Exception e) {
                out.println(e);
            }
        }
    }
}