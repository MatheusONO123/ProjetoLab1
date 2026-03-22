<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, br.com.locacao.model.*, br.com.locacao.dao.*" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Reservas - Alocação de Espaço</title>
    <link rel="stylesheet" href="css/estilo.css">
</head>
<body>

<%@ include file="menu.jsp" %>

<%
    ReservaDAO reservaDAO = new ReservaDAO();
    ClienteDAO clienteDAO = new ClienteDAO();
    EspacoDAO  espacoDAO  = new EspacoDAO();
    ServicoDAO servicoDAO = new ServicoDAO();
    List<Reserva> reservas = reservaDAO.listarTodas();
    List<Cliente> clientes = clienteDAO.listarTodos();
    List<Espaco>  espacos  = espacoDAO.listarTodos();
    List<Servico> servicos = servicoDAO.listarTodos();
    String msg = request.getParameter("msg");
    String erroSessao = (String) session.getAttribute("erro");
    session.removeAttribute("erro");
%>

<div class="conteudo">

    <div class="topbar">
        <div>
            <h1>&#128197; Reservas</h1>
            <p>Gerenciamento completo de reservas</p>
        </div>
    </div>

    <% if ("cadastrado".equals(msg))  { %><div class="alerta alerta-sucesso">&#10003; Reserva cadastrada com sucesso!</div><% } %>
    <% if ("confirmado".equals(msg))  { %><div class="alerta alerta-sucesso">&#10003; Reserva confirmada!</div><% } %>
    <% if ("cancelado".equals(msg))   { %><div class="alerta alerta-sucesso">&#10003; Reserva cancelada.</div><% } %>
    <% if ("excluido".equals(msg))    { %><div class="alerta alerta-sucesso">&#10003; Reserva excluída.</div><% } %>
    <% if ("erro".equals(msg))        { %><div class="alerta alerta-erro">&#10007; Erro ao salvar. Verifique os dados.</div><% } %>
    <% if (erroSessao != null)         { %><div class="alerta alerta-erro">&#10007; <%= erroSessao %></div><% } %>

    <div class="form-container" style="margin-bottom:28px; max-width:100%;">
        <h2 style="font-size:15px; color:#5b21b6; margin-bottom:20px;">&#128197; Nova Reserva</h2>
        <form action="${pageContext.request.contextPath}/reserva" method="post">
            <input type="hidden" name="acao" value="cadastrar">
            <div class="form-linha">
                <div class="form-grupo">
                    <label>Cliente *</label>
                    <select name="clienteId" required>
                        <option value="">Selecione um cliente</option>
                        <% for (Cliente c : clientes) { %>
                            <option value="<%= c.getId() %>"><%= c.getNome() %></option>
                        <% } %>
                    </select>
                </div>
                <div class="form-grupo">
                    <label>Espaço *</label>
                    <select name="espacoId" required>
                        <option value="">Selecione um espaço</option>
                        <% for (Espaco e : espacos) { %>
                            <option value="<%= e.getId() %>">
                                <%= e.getNome() %> — R$ <%= String.format("%.2f", e.getValorHora()) %>/h
                            </option>
                        <% } %>
                    </select>
                </div>
            </div>
            <div class="form-linha">
                <div class="form-grupo">
                    <label>Data do Evento *</label>
                    <input type="date" name="dataEvento" required>
                </div>
                <div class="form-grupo">
                    <label>Nº de Convidados</label>
                    <input type="number" name="numConvidados" min="0" value="0">
                </div>
            </div>
            <div class="form-linha">
                <div class="form-grupo">
                    <label>Horário Início *</label>
                    <input type="time" name="horarioInicio" required>
                </div>
                <div class="form-grupo">
                    <label>Horário Fim *</label>
                    <input type="time" name="horarioFim" required>
                </div>
            </div>
            <div class="form-linha">
                <div class="form-grupo">
                    <label>Valor Total (R$)</label>
                    <input type="text" name="valorTotal" placeholder="0,00">
                </div>
                <div class="form-grupo" style="display:flex;align-items:center;gap:10px;padding-top:28px;">
                    <input type="checkbox" name="decoracao" id="decoracao"
                           style="width:17px;height:17px;accent-color:#7c3aed;">
                    <label for="decoracao" style="margin:0;cursor:pointer;">Decoração</label>
                </div>
            </div>

            <% if (!servicos.isEmpty()) { %>
            <div class="form-grupo">
                <label>Serviços Adicionais</label>
                <div style="display:grid;grid-template-columns:repeat(auto-fill,minmax(240px,1fr));gap:10px;">
                    <% for (Servico s : servicos) { %>
                    <div style="background:#f5f3ff;border-radius:8px;padding:12px;
                                display:flex;justify-content:space-between;align-items:center;">
                        <div>
                            <strong style="font-size:13px;"><%= s.getNome() %></strong><br>
                            <small style="color:#64748b;">R$ <%= String.format("%.2f", s.getValorUnitario()) %> un.</small>
                        </div>
                        <div style="display:flex;align-items:center;gap:6px;">
                            <input type="hidden" name="servicoId" value="<%= s.getId() %>">
                            <input type="number" name="quantidade" min="0"
                                   max="<%= s.getLimiteQuantidade() %>" value="0"
                                   style="width:60px;padding:5px;border:1.5px solid #e0d9f7;
                                          border-radius:6px;text-align:center;">
                        </div>
                    </div>
                    <% } %>
                </div>
            </div>
            <% } %>

            <button type="submit" class="btn btn-primario" style="margin-top:6px;">
                &#128190; Salvar Reserva
            </button>
        </form>
    </div>

    <div class="tabela-container">
        <div class="tabela-header">
            <h2>Reservas (<%= reservas.size() %>)</h2>
        </div>
        <table>
            <thead>
                <tr>
                    <th>#</th><th>Cliente</th><th>Espaço</th>
                    <th>Data</th><th>Início</th><th>Fim</th>
                    <th>Valor</th><th>Status</th><th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <% if (reservas.isEmpty()) { %>
                    <tr><td colspan="9" style="text-align:center;color:#aaa;padding:30px;">
                        Nenhuma reserva cadastrada.
                    </td></tr>
                <% } else { for (Reserva r : reservas) {
                    String bc = "confirmada".equals(r.getStatus()) ? "badge-confirmada"
                              : "cancelada".equals(r.getStatus())  ? "badge-cancelada"
                                                                   : "badge-pendente";
                %>
                    <tr>
                        <td style="color:#64748b;font-weight:600;">#<%= r.getId() %></td>
                        <td><strong><%= r.getClienteNome() %></strong></td>
                        <td><%= r.getEspacoNome() %></td>
                        <td><%= r.getDataEvento() %></td>
                        <td><%= r.getHorarioInicio() %></td>
                        <td><%= r.getHorarioFim() %></td>
                        <td>R$ <%= String.format("%.2f", r.getValorTotal()) %></td>
                        <td><span class="badge <%= bc %>"><%= r.getStatus() %></span></td>
                        <td style="display:flex;gap:5px;flex-wrap:wrap;">
                            <% if ("pendente".equals(r.getStatus())) { %>
                            <form action="${pageContext.request.contextPath}/reserva" method="post" style="display:inline;">
                                <input type="hidden" name="acao" value="confirmar">
                                <input type="hidden" name="id"   value="<%= r.getId() %>">
                                <button type="submit" class="btn btn-sucesso btn-sm">&#10003;</button>
                            </form>
                            <% } %>
                            <% if (!"cancelada".equals(r.getStatus())) { %>
                            <form action="${pageContext.request.contextPath}/reserva" method="post" style="display:inline;">
                                <input type="hidden" name="acao" value="cancelar">
                                <input type="hidden" name="id"   value="<%= r.getId() %>">
                                <button type="submit" class="btn btn-perigo btn-sm">&#10007;</button>
                            </form>
                            <% } %>
                            <form action="${pageContext.request.contextPath}/reserva" method="post" style="display:inline;">
                                <input type="hidden" name="acao" value="excluir">
                                <input type="hidden" name="id"   value="<%= r.getId() %>">
                                <button type="submit" class="btn btn-outline btn-sm"
                                        onclick="return confirm('Excluir esta reserva?')">&#128465;</button>
                            </form>
                        </td>
                    </tr>
                <% } } %>
            </tbody>
        </table>
    </div>

</div>
</body>
</html>