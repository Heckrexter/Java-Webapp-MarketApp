import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.sql.*;
@WebServlet("/addtocart")
public class AddToCart extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        Cookie c[] = request.getCookies();
        boolean flag = false;
        String uname = "";
        for (int i = 0; i < c.length; i++) {
            if (c[i].getName().equals("username")) {
                uname = c[i].getValue();
                flag = true;
                break;
            }
        }
        if (!flag) {
            response.sendRedirect("login.jsp");
            return;
        }
        if (request.getParameter("pid") == null || request.getParameter("quantity") == null) {
            response.sendError(400, "Product ID and Quantity are required");
            response.sendRedirect("homepage.jsp");;
        }
        int pid = Integer.parseInt(request.getParameter("pid"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        int id = 0;
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/shopapp", "test", "test");
            stmt = con.createStatement();
            String Query = "SELECT id FROM login where email = '"+uname+"'";
            rs = stmt.executeQuery(Query);
            while(rs.next()){
                id = rs.getInt("id");
            }
            Query = "INSERT INTO usercart"+id+" (pid, quantity) VALUES("+pid+","+quantity+")";
            stmt.executeUpdate(Query);
            
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            response.sendRedirect("cart.jsp");
            try {
                stmt.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            
        }
    }
}