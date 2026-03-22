package br.com.locacao.controller;

import br.com.locacao.dao.ClienteDAO;
import br.com.locacao.model.Cliente;
import br.com.locacao.model.Sindico;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/cliente")
public class ClienteController extends HttpServlet {

    private final ClienteDAO dao = new ClienteDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        Sindico sindico = (session != null) ? (Sindico) session.getAttribute("sindico") : null;
        if (sindico == null) { res.sendRedirect(req.getContextPath() + "/login.jsp"); return; }

        String acao = req.getParameter("acao");
        if ("cadastrar".equals(acao)) {
            cadastrar(req, res, sindico);
        } else if ("editar".equals(acao)) {
            editar(req, res);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        Sindico sindico = (session != null) ? (Sindico) session.getAttribute("sindico") : null;
        if (sindico == null) { res.sendRedirect(req.getContextPath() + "/login.jsp"); return; }

        String acao = req.getParameter("acao");
        if ("excluir".equals(acao)) {
            excluir(req, res);
        } else {
            res.sendRedirect(req.getContextPath() + "/clientes.jsp");
        }
    }

    private void cadastrar(HttpServletRequest req, HttpServletResponse res, Sindico sindico)
            throws IOException {
        if (dao.emailExiste(req.getParameter("email").trim())) {
            req.getSession().setAttribute("erro", "E-mail já cadastrado!");
            res.sendRedirect(req.getContextPath() + "/clientes.jsp"); return;
        }
        Cliente c = montarCliente(req);
        c.setSindicoId(sindico.getId());
        c.setSenha(req.getParameter("senha"));
        dao.cadastrar(c);
        res.sendRedirect(req.getContextPath() + "/clientes.jsp?msg=cadastrado");
    }

    private void editar(HttpServletRequest req, HttpServletResponse res)
            throws IOException {
        Cliente c = montarCliente(req);
        c.setId(Integer.parseInt(req.getParameter("id")));
        dao.atualizar(c);
        res.sendRedirect(req.getContextPath() + "/clientes.jsp?msg=editado");
    }

    private void excluir(HttpServletRequest req, HttpServletResponse res)
            throws IOException {
        dao.excluir(Integer.parseInt(req.getParameter("id")));
        res.sendRedirect(req.getContextPath() + "/clientes.jsp?msg=excluido");
    }

    private Cliente montarCliente(HttpServletRequest req) {
        Cliente c = new Cliente();
        c.setNome(req.getParameter("nome"));
        c.setCpf(req.getParameter("cpf"));
        c.setEmail(req.getParameter("email"));
        c.setTelefone(req.getParameter("telefone"));
        c.setEndereco(req.getParameter("endereco"));
        return c;
    }
}