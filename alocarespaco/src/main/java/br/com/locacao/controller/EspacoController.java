package br.com.locacao.controller;

import br.com.locacao.dao.EspacoDAO;
import br.com.locacao.model.Espaco;
import br.com.locacao.model.Sindico;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/espaco")
public class EspacoController extends HttpServlet {

    private final EspacoDAO dao = new EspacoDAO();

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
            res.sendRedirect(req.getContextPath() + "/espacos.jsp");
        }
    }

    private void cadastrar(HttpServletRequest req, HttpServletResponse res, Sindico sindico)
            throws IOException {
        Espaco e = montarEspaco(req);
        e.setSindicoId(sindico.getId());
        dao.cadastrar(e);
        res.sendRedirect(req.getContextPath() + "/espacos.jsp?msg=cadastrado");
    }

    private void editar(HttpServletRequest req, HttpServletResponse res)
            throws IOException {
        Espaco e = montarEspaco(req);
        e.setId(Integer.parseInt(req.getParameter("id")));
        dao.atualizar(e);
        res.sendRedirect(req.getContextPath() + "/espacos.jsp?msg=editado");
    }

    private void excluir(HttpServletRequest req, HttpServletResponse res)
            throws IOException {
        dao.excluir(Integer.parseInt(req.getParameter("id")));
        res.sendRedirect(req.getContextPath() + "/espacos.jsp?msg=excluido");
    }

    private Espaco montarEspaco(HttpServletRequest req) {
        Espaco e = new Espaco();
        e.setNome(req.getParameter("nome"));
        e.setDescricao(req.getParameter("descricao"));
        e.setCapacidadeMaxima(Integer.parseInt(req.getParameter("capacidadeMaxima")));
        e.setValorHora(Double.parseDouble(req.getParameter("valorHora").replace(",", ".")));
        e.setStatus(req.getParameter("status"));
        return e;
    }
}