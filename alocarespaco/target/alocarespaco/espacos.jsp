<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, br.com.locacao.model.Espaco, br.com.locacao.dao.EspacoDAO" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Espaços - Alocação de Espaço</title>
    <link rel="stylesheet" href="css/estilo.css">
</head>
<body>

<%@ include file="menu.jsp" %>

<%
    EspacoDAO espacoDAO = new EspacoDAO();
    List<Espaco> espacos = espacoDAO.listarTodos();
    String msg = request.getParameter("msg");
    Espaco espacoEditar = null;
    String editId = request.getParameter("editar");
    if (editId != null) espacoEditar = espacoDAO.buscarPorId(Integer.parseInt(editId));
%>

<div class="conteudo">

    <div class="topbar">
        <div>
            <h1>&#127968; Espaços</h1>
            <p>Cadastro e gerenciamento de espaços do condomínio</p>
        </div>
    </div>

    <% if ("cadastrado".equals(msg)) { %>
        <div class="alerta alerta-sucesso">&#10003; Espaço cadastrado com sucesso!</div>
    <% } else if ("editado".equals(msg)) { %>
        <div class="alerta alerta-sucesso">&#10003; Espaço atualizado com sucesso!</div>
    <% } else if ("excluido".equals(msg)) { %>
        <div class="alerta alerta-sucesso">&#10003; Espaço excluído com sucesso!</div>
    <% } %>

    <div class="form-container" style="margin-bottom:28px; max-width:100%;">
        <h2 style="font-size:15px; color:#5b21b6; margin-bottom:20px;">
            <%= espacoEditar != null ? "&#9998; Editar Espaço" : "&#127968; Cadastrar Espaço" %>
        </h2>
        <form action="${pageContext.request.contextPath}/espaco" method="post">
            <input type="hidden" name="acao" value="<%= espacoEditar != null ? "editar" : "cadastrar" %>">
            <% if (espacoEditar != null) { %>
                <input type="hidden" name="id" value="<%= espacoEditar.getId() %>">
            <% } %>
            <div class="form-linha">
                <div class="form-grupo">
                    <label>Nome *</label>
                    <input type="text" name="nome" placeholder="Nome do espaço"
                           value="<%= espacoEditar != null ? espacoEditar.getNome() : "" %>" required>
                </div>
                <div class="form-grupo">
                    <label>Capacidade Máxima *</label>
                    <input type="number" name="capacidadeMaxima" placeholder="Número de pessoas" min="1"
                           value="<%= espacoEditar != null ? espacoEditar.getCapacidadeMaxima() : "" %>" required>
                </div>
            </div>
            <div class="form-linha">
                <div class="form-grupo">
                    <label>Valor por Hora (R$) *</label>
                    <input type="text" name="valorHora" placeholder="0,00"
                           value="<%= espacoEditar != null ? espacoEditar.getValorHora() : "" %>" required>
                </div>
                <div class="form-grupo">
                    <label>Status</label>
                    <select name="status">
                        <option value="disponivel" <%= espacoEditar != null && "disponivel".equals(espacoEditar.getStatus()) ? "selected" : "" %>>Disponível</option>
                        <option value="ocupado"    <%= espacoEditar != null && "ocupado".equals(espacoEditar.getStatus())    ? "selected" : "" %>>Ocupado</option>
                        <option value="manutencao" <%= espacoEditar != null && "manutencao".equals(espacoEditar.getStatus()) ? "selected" : "" %>>Manutenção</option>
                    </select>
                </div>
            </div>
            <div class="form-grupo">
                <label>Descrição</label>
                <textarea name="descricao" rows="3" placeholder="Descrição do espaço..."><%= espacoEditar != null ? espacoEditar.getDescricao() : "" %></textarea>
            </div>
            <div style="display:flex; gap:10px; margin-top:6px;">
                <button type="submit" class="btn btn-primario">&#128190; Salvar</button>
                <% if (espacoEditar != null) { %><a href="espacos.jsp" class="btn btn-outline">Cancelar</a><% } %>
            </div>
        </form>
    </div>

    <div class="tabela-container">
        <div class="tabela-header">
            <h2>Espaços cadastrados (<%= espacos.size() %>)</h2>
        </div>
        <table>
            <thead>
                <tr><th>#</th><th>Nome</th><th>Capacidade</th><th>Valor/Hora</th><th>Status</th><th>Ações</th></tr>
            </thead>
            <tbody>
                <% if (espacos.isEmpty()) { %>
                    <tr><td colspan="6" style="text-align:center;color:#aaa;padding:30px;">
                        Nenhum espaço cadastrado.
                    </td></tr>
                <% } else { for (Espaco e : espacos) {
                    String bc = "disponivel".equals(e.getStatus()) ? "badge-disponivel"
                              : "ocupado".equals(e.getStatus())    ? "badge-ocupado"
                                                                   : "badge-manutencao";
                %>
                    <tr>
                        <td style="color:#64748b;font-weight:600;">#<%= e.getId() %></td>
                        <td><strong><%= e.getNome() %></strong></td>
                        <td><%= e.getCapacidadeMaxima() %> pessoas</td>
                        <td>R$ <%= String.format("%.2f", e.getValorHora()) %></td>
                        <td><span class="badge <%= bc %>"><%= e.getStatus() %></span></td>
                        <td style="display:flex;gap:6px;flex-wrap:wrap;">
                            <a href="espacos.jsp?editar=<%= e.getId() %>"
                               class="btn btn-aviso btn-sm">&#9998; Editar</a>
                            <a href="${pageContext.request.contextPath}/espaco?acao=excluir&id=<%= e.getId() %>"
                               class="btn btn-perigo btn-sm"
                               onclick="return confirm('Excluir este espaço?')">&#128465; Excluir</a>
                        </td>
                    </tr>
                <% } } %>
            </tbody>
        </table>
    </div>

</div>
</body>
</html>