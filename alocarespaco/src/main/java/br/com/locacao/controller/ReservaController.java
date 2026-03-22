package br.com.locacao.controller;

import br.com.locacao.dao.*;
import br.com.locacao.model.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/reserva")
public class ReservaController extends HttpServlet {

    private final ReservaDAO dao = new ReservaDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        Sindico sindico = (session != null) ? (Sindico) session.getAttribute("sindico") : null;
        Cliente cliente = (session != null) ? (Cliente) session.getAttribute("cliente") : null;

        if (sindico == null && cliente == null) {
            res.sendRedirect(req.getContextPath() + "/login.jsp"); return;
        }

        String acao = req.getParameter("acao");

        if ("cadastrar".equals(acao)) {
            cadastrar(req, res, sindico, cliente);
        } else if ("confirmar".equals(acao) && sindico != null) {
            dao.atualizarStatus(Integer.parseInt(req.getParameter("id")), "confirmada");
            res.sendRedirect(req.getContextPath() + "/reservas.jsp?msg=confirmado");
        } else if ("cancelar".equals(acao)) {
            dao.atualizarStatus(Integer.parseInt(req.getParameter("id")), "cancelada");
            res.sendRedirect(req.getContextPath() +
                (sindico != null ? "/reservas.jsp?msg=cancelado" : "/area-cliente.jsp?msg=cancelado"));
        } else if ("excluir".equals(acao) && sindico != null) {
            dao.excluir(Integer.parseInt(req.getParameter("id")));
            res.sendRedirect(req.getContextPath() + "/reservas.jsp?msg=excluido");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        doPost(req, res);
    }

    private void cadastrar(HttpServletRequest req, HttpServletResponse res,
                           Sindico sindico, Cliente cliente) throws IOException {
        try {
            int    espacoId = Integer.parseInt(req.getParameter("espacoId"));
            String data     = req.getParameter("dataEvento");
            String inicio   = req.getParameter("horarioInicio");
            String fim      = req.getParameter("horarioFim");

            if (!dao.verificarDisponibilidade(espacoId, data, inicio, fim)) {
                req.getSession().setAttribute("erro", "Espaço indisponível neste horário!");
                res.sendRedirect(req.getContextPath() +
                    (sindico != null ? "/reservas.jsp" : "/area-cliente.jsp"));
                return;
            }

            Reserva r = new Reserva();
            r.setSindicoId(sindico != null ? sindico.getId() : 1);
            r.setClienteId(sindico != null
                ? Integer.parseInt(req.getParameter("clienteId"))
                : cliente.getId());
            r.setEspacoId(espacoId);
            r.setDataEvento(data);
            r.setHorarioInicio(inicio);
            r.setHorarioFim(fim);
            String nc = req.getParameter("numConvidados");
            r.setNumConvidados(nc != null && !nc.isEmpty() ? Integer.parseInt(nc) : 0);
            r.setDecoracao("on".equals(req.getParameter("decoracao")));
            String vt = req.getParameter("valorTotal");
            r.setValorTotal(vt != null && !vt.isEmpty()
                ? Double.parseDouble(vt.replace(",", ".")) : 0);
            r.setStatus("pendente");

            int reservaId = dao.cadastrar(r);

            // Itens de serviço — só síndico adiciona
            if (sindico != null && reservaId > 0) {
                String[] servicoIds = req.getParameterValues("servicoId");
                String[] quantidades = req.getParameterValues("quantidade");
                if (servicoIds != null) {
                    ServicoDAO sDao = new ServicoDAO();
                    ItensReservaDAO itemDao = new ItensReservaDAO();
                    for (int i = 0; i < servicoIds.length; i++) {
                        int qtd = Integer.parseInt(quantidades[i]);
                        if (qtd > 0) {
                            int sId = Integer.parseInt(servicoIds[i]);
                            Servico sv = sDao.buscarPorId(sId);
                            ItensReserva item = new ItensReserva();
                            item.setSindicoId(sindico.getId());
                            item.setReservaId(reservaId);
                            item.setServicoId(sId);
                            item.setQuantidade(qtd);
                            item.setValorUnitario(sv.getValorUnitario());
                            itemDao.cadastrar(item);
                        }
                    }
                }
            }

            res.sendRedirect(req.getContextPath() +
                (sindico != null ? "/reservas.jsp?msg=cadastrado" : "/area-cliente.jsp?msg=cadastrado"));

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect(req.getContextPath() + "/reservas.jsp?msg=erro");
        }
    }
}