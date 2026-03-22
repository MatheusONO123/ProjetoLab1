<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, br.com.locacao.model.*, br.com.locacao.dao.*" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Minha Área - Alocação de Espaço</title>
    <link rel="stylesheet" href="css/estilo.css">
</head>
<body>

<%@ include file="menu-cliente.jsp" %>

<%
    List<Espaco>  espacos        = new EspacoDAO().listarTodos();
    List<Reserva> minhasReservas = new ReservaDAO().listarPorCliente(cliente.getId());
    String msg        = request.getParameter("msg");
    String erroSessao = (String) session.getAttribute("erro");
    session.removeAttribute("erro");
%>

<div class="conteudo">

    <div class="topbar">
        <div>
            <h1>Minha Área</h1>
            <p>Bem-vindo(a), <strong><%= cliente.getNome() %></strong> &mdash;
               <span class="topbar-badge cliente">&#128100; Cliente</span></p>
        </div>
    </div>

    <% if ("cadastrado".equals(msg)) { %>
        <div class="alerta alerta-sucesso">&#10003; Reserva solicitada com sucesso!</div>
    <% } %>
    <% if ("cancelado".equals(msg)) { %>
        <div class="alerta alerta-sucesso">&#10003; Reserva cancelada com sucesso.</div>
    <% } %>
    <% if (erroSessao != null) { %>
        <div class="alerta alerta-erro">&#10007; <%= erroSessao %></div>
    <% } %>

    <%-- VERIFICAR DISPONIBILIDADE E RESERVAR --%>
    <div class="disponibilidade-form" id="reservar">
        <h2 style="font-size:15px; color:#5b21b6; margin-bottom:18px;">
            &#128269; Verificar Disponibilidade e Solicitar Reserva
        </h2>
        <form action="${pageContext.request.contextPath}/reserva" method="post">
            <input type="hidden" name="acao" value="cadastrar">
            <div class="form-linha">
                <div class="form-grupo">
                    <label>Espaço *</label>
                    <select name="espacoId" id="selEspaco" required onchange="verificarDisp()">
                        <option value="">Selecione um espaço</option>
                        <% for (Espaco e : espacos) { %>
                        <option value="<%= e.getId() %>">
                            <%= e.getNome() %> (cap: <%= e.getCapacidadeMaxima() %> pessoas)
                            — <span class="badge badge-<%= e.getStatus() %>"><%= e.getStatus() %></span>
                        </option>
                        <% } %>
                    </select>
                </div>
                <div class="form-grupo">
                    <label>Data do Evento *</label>
                    <input type="date" name="dataEvento" id="selData" required onchange="verificarDisp()">
                </div>
            </div>
            <div class="form-linha">
                <div class="form-grupo">
                    <label>Horário Início *</label>
                    <input type="time" name="horarioInicio" id="selInicio" required onchange="verificarDisp()">
                </div>
                <div class="form-grupo">
                    <label>Horário Fim *</label>
                    <input type="time" name="horarioFim" id="selFim" required onchange="verificarDisp()">
                </div>
            </div>

            <div id="resultadoDisp" class="disponibilidade-resultado"></div>

            <div class="form-linha" style="margin-top:10px;">
                <div class="form-grupo">
                    <label>Nº de Convidados</label>
                    <input type="number" name="numConvidados" min="1" placeholder="Ex: 30">
                </div>
                <div class="form-grupo" style="display:flex; align-items:center; gap:10px; padding-top:28px;">
                    <input type="checkbox" name="decoracao" id="decoracao"
                           style="width:17px; height:17px; accent-color:#7c3aed;">
                    <label for="decoracao" style="margin:0; cursor:pointer;">Solicitar decoração</label>
                </div>
            </div>

            <button type="submit" id="btnReservar" class="btn btn-primario" disabled style="margin-top:6px;">
                &#128197; Solicitar Reserva
            </button>
        </form>
    </div>

    <%-- MINHAS RESERVAS --%>
    <div class="tabela-container" id="minhas">
        <div class="tabela-header">
            <h2>&#128203; Minhas Reservas (<%= minhasReservas.size() %>)</h2>
        </div>
        <table>
            <thead>
                <tr>
                    <th>#</th><th>Espaço</th><th>Data</th>
                    <th>Início</th><th>Fim</th><th>Status</th><th>Ação</th>
                </tr>
            </thead>
            <tbody>
                <% if (minhasReservas.isEmpty()) { %>
                    <tr><td colspan="7" style="text-align:center; color:#aaa; padding:30px;">
                        Nenhuma reserva encontrada.
                    </td></tr>
                <% } else { for (Reserva r : minhasReservas) {
                    String bc = "confirmada".equals(r.getStatus()) ? "badge-confirmada"
                              : "cancelada".equals(r.getStatus())  ? "badge-cancelada"
                                                                   : "badge-pendente";
                %>
                    <tr>
                        <td style="color:#64748b; font-weight:600;">#<%= r.getId() %></td>
                        <td><strong><%= r.getEspacoNome() %></strong></td>
                        <td><%= r.getDataEvento() %></td>
                        <td><%= r.getHorarioInicio() %></td>
                        <td><%= r.getHorarioFim() %></td>
                        <td><span class="badge <%= bc %>"><%= r.getStatus() %></span></td>
                        <td>
                            <% if ("pendente".equals(r.getStatus())) { %>
                            <form action="${pageContext.request.contextPath}/reserva"
                                  method="post" style="display:inline;">
                                <input type="hidden" name="acao" value="cancelar">
                                <input type="hidden" name="id"   value="<%= r.getId() %>">
                                <button type="submit" class="btn btn-perigo btn-sm"
                                        onclick="return confirm('Cancelar esta reserva?')">
                                    &#10007; Cancelar
                                </button>
                            </form>
                            <% } else { %>
                                <span style="color:#aaa; font-size:12px;">—</span>
                            <% } %>
                        </td>
                    </tr>
                <% } } %>
            </tbody>
        </table>
    </div>

</div>

<script>
function verificarDisp() {
    var espacoId = document.getElementById('selEspaco').value;
    var data     = document.getElementById('selData').value;
    var inicio   = document.getElementById('selInicio').value;
    var fim      = document.getElementById('selFim').value;
    var res      = document.getElementById('resultadoDisp');
    var btn      = document.getElementById('btnReservar');

    if (!espacoId || !data || !inicio || !fim) {
        res.style.display = 'none';
        btn.disabled = true;
        return;
    }

    fetch('${pageContext.request.contextPath}/verificar-disponibilidade'
        + '?espacoId=' + espacoId
        + '&dataEvento=' + data
        + '&horarioInicio=' + inicio
        + '&horarioFim=' + fim)
    .then(function(r) { return r.json(); })
    .then(function(d) {
        res.style.display = 'block';
        if (d.disponivel) {
            res.className = 'disponibilidade-resultado disponivel-sim';
            res.innerHTML = '&#10003; Espaço disponível neste horário! Você pode solicitar a reserva.';
            btn.disabled = false;
        } else {
            res.className = 'disponibilidade-resultado disponivel-nao';
            res.innerHTML = '&#10007; Espaço já reservado neste horário. Escolha outro horário ou data.';
            btn.disabled = true;
        }
    })
    .catch(function() {
        res.style.display = 'none';
        btn.disabled = false;
    });
}
</script>
</body>
</html>