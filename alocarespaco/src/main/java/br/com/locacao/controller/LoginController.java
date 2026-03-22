package br.com.locacao.controller;

import br.com.locacao.dao.SindicoDAO;
import br.com.locacao.dao.ClienteDAO;
import br.com.locacao.model.Sindico;
import br.com.locacao.model.Cliente;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(urlPatterns = {"/login", "/logout"})
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        if ("/logout".equals(req.getServletPath())) {
            HttpSession s = req.getSession(false);
            if (s != null) s.invalidate();
            res.sendRedirect(req.getContextPath() + "/login.jsp");
        } else {
            req.getRequestDispatcher("/login.jsp").forward(req, res);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String email = req.getParameter("email");
        String senha = req.getParameter("senha");
        if (email == null || email.trim().isEmpty() || senha == null || senha.trim().isEmpty()) {
            req.setAttribute("erro", "E-mail e senha sao obrigatorios!");
            req.getRequestDispatcher("/login.jsp").forward(req, res);
            return;
        }
        Sindico sindico = new SindicoDAO().autenticar(email.trim(), senha);
        if (sindico != null) {
            HttpSession session = req.getSession();
            session.setAttribute("sindico", sindico);
            session.setAttribute("tipoPerfil", "SINDICO");
            session.setAttribute("perfilNome", sindico.getNome());
            res.sendRedirect(req.getContextPath() + "/index.jsp");
            return;
        }
        Cliente cliente = new ClienteDAO().autenticar(email.trim(), senha);
        if (cliente != null) {
            HttpSession session = req.getSession();
            session.setAttribute("cliente", cliente);
            session.setAttribute("tipoPerfil", "CLIENTE");
            session.setAttribute("perfilNome", cliente.getNome());
            res.sendRedirect(req.getContextPath() + "/area-cliente.jsp");
            return;
        }
        req.setAttribute("erro", "E-mail ou senha incorretos!");
        req.getRequestDispatcher("/login.jsp").forward(req, res);
    }
}
