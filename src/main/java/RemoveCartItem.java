import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.sql.*;

@WebServlet("/removefromcart")
public class RemoveCartItem extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
            int pid = Integer.parseInt(request.getParameter("pid"));
            int id = Integer.parseInt(request.getParameter("id"));
            if (pid == 0) {
                response.sendError(400, "Valid product ID is required");
                return;
            } else if (id == 0) {
                response.sendError(400, "Valid user ID is required");
                return;
            }
            Connection con = null;
            Statement stmt = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/shopapp","test","test");
                stmt = con.createStatement();
                String Query = "DELETE FROM usercart"+id+" WHERE pid = '"+pid+"'";
                stmt.executeUpdate(Query);
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    stmt.close();
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            response.sendRedirect("cart.jsp");
        }
}