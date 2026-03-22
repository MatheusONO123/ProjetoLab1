package br.com.locacao.controller;

import br.com.locacao.dao.ReservaDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/verificar-disponibilidade")
public class DisponibilidadeController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        res.setContentType("application/json;charset=UTF-8");
        try {
            int    espacoId = Integer.parseInt(req.getParameter("espacoId"));
            String data     = req.getParameter("dataEvento");
            String inicio   = req.getParameter("horarioInicio");
            String fim      = req.getParameter("horarioFim");
            boolean disp = new ReservaDAO().verificarDisponibilidade(espacoId, data, inicio, fim);
            res.getWriter().write("{\"disponivel\":" + disp + "}");
        } catch (Exception e) {
            res.getWriter().write("{\"disponivel\":false}");
        }
    }
}