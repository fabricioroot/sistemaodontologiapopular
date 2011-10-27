package web.servlet;

import dao.HibernateUtil;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Fabricio P. Reis
 */
public class logoutServlet extends HttpServlet {

    public logoutServlet() {
        super();
    }

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getSession().invalidate();
        req.getRequestDispatcher("/").forward(req, resp);
        try {
            HibernateUtil.fechaSessao();
        } catch (Exception e) {
            System.out.println("Falha ao tentar fechar sessao com banco de dados em logout. Exception: " + e.getMessage());
        }
    }
}
