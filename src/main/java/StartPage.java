import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/")
public class StartPage extends HttpServlet{
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        out.println("<h1>Welcome to the Start Page</h1>");
        out.println("</body></html>");
        Cookie c[] = request.getCookies();
        boolean flag = false;
        // print coookies
        out.println("reading cookies");
        if (c != null) {
            for (int i = 0; i < c.length; i++) {
                out.println(c[i].getName() + " : " + c[i].getValue());
            }
            out.println("checking for username cookie");
            for (int i = 0; i < c.length; i++) {
                out.print("ping");
                if (c[i].getName().equals("username")) {
                    flag = true;
                    break;
                }
            }
            out.println("checking for username cookie");
            if (flag) {
                out.println("Welcome " + c[0].getValue() + " to the homepage");
                response.sendRedirect("homepage.jsp");
            } else {
                out.println("You are not logged in");
                response.sendRedirect("login.jsp");
            }
        } else {
            out.println("You are not logged in");
            response.sendRedirect("login.jsp");
        }
    }
}
