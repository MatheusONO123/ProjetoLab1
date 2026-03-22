package br.com.locacao.controller;

import br.com.locacao.dao.ServicoDAO;
import br.com.locacao.model.Servico;
import br.com.locacao.model.Sindico;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/servico")
public class ServicoController extends HttpServlet {

    private final ServicoDAO dao = new ServicoDAO();

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
            res.sendRedirect(req.getContextPath() + "/servicos.jsp");
        }
    }

    private void cadastrar(HttpServletRequest req, HttpServletResponse res, Sindico sindico)
            throws IOException {
        Servico s = montarServico(req);
        s.setSindicoId(sindico.getId());
        dao.cadastrar(s);
        res.sendRedirect(req.getContextPath() + "/servicos.jsp?msg=cadastrado");
    }

    private void editar(HttpServletRequest req, HttpServletResponse res)
            throws IOException {
        Servico s = montarServico(req);
        s.setId(Integer.parseInt(req.getParameter("id")));
        dao.atualizar(s);
        res.sendRedirect(req.getContextPath() + "/servicos.jsp?msg=editado");
    }

    private void excluir(HttpServletRequest req, HttpServletResponse res)
            throws IOException {
        dao.excluir(Integer.parseInt(req.getParameter("id")));
        res.sendRedirect(req.getContextPath() + "/servicos.jsp?msg=excluido");
    }

    private Servico montarServico(HttpServletRequest req) {
        Servico s = new Servico();
        s.setNome(req.getParameter("nome"));
        s.setDescricao(req.getParameter("descricao"));
        String lq = req.getParameter("limiteQuantidade");
        s.setLimiteQuantidade(lq != null && !lq.isEmpty() ? Integer.parseInt(lq) : 0);
        s.setValorUnitario(Double.parseDouble(req.getParameter("valorUnitario").replace(",", ".")));
        return s;
    }
}