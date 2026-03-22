<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, br.com.locacao.model.Servico, br.com.locacao.dao.ServicoDAO" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Serviços - Alocação de Espaço</title>
    <link rel="stylesheet" href="css/estilo.css">
</head>
<body>

<%@ include file="menu.jsp" %>

<%
    ServicoDAO servicoDAO = new ServicoDAO();
    List<Servico> servicos = servicoDAO.listarTodos();
    String msg = request.getParameter("msg");
    Servico servicoEditar = null;
    String editId = request.getParameter("editar");
    if (editId != null) servicoEditar = servicoDAO.buscarPorId(Integer.parseInt(editId));
%>

<div class="conteudo">

    <div class="topbar">
        <div>
            <h1>&#128296; Serviços</h1>
            <p>Cadastro e gerenciamento de serviços adicionais</p>
        </div>
    </div>

    <% if ("cadastrado".equals(msg)) { %>
        <div class="alerta alerta-sucesso">&#10003; Serviço cadastrado com sucesso!</div>
    <% } else if ("editado".equals(msg)) { %>
        <div class="alerta alerta-sucesso">&#10003; Serviço atualizado com sucesso!</div>
    <% } else if ("excluido".equals(msg)) { %>
        <div class="alerta alerta-sucesso">&#10003; Serviço excluído com sucesso!</div>
    <% } %>

    <div class="form-container" style="margin-bottom:28px; max-width:100%;">
        <h2 style="font-size:15px; color:#5b21b6; margin-bottom:20px;">
            <%= servicoEditar != null ? "&#9998; Editar Serviço" : "&#128296; Cadastrar Serviço" %>
        </h2>
        <form action="${pageContext.request.contextPath}/servico" method="post">
            <input type="hidden" name="acao" value="<%= servicoEditar != null ? "editar" : "cadastrar" %>">
            <% if (servicoEditar != null) { %>
                <input type="hidden" name="id" value="<%= servicoEditar.getId() %>">
            <% } %>
            <div class="form-linha">
                <div class="form-grupo">
                    <label>Nome *</label>
                    <input type="text" name="nome" placeholder="Nome do serviço"
                           value="<%= servicoEditar != null ? servicoEditar.getNome() : "" %>" required>
                </div>
                <div class="form-grupo">
                    <label>Valor Unitário (R$) *</label>
                    <input type="text" name="valorUnitario" placeholder="0,00"
                           value="<%= servicoEditar != null ? servicoEditar.getValorUnitario() : "" %>" required>
                </div>
            </div>
            <div class="form-linha">
                <div class="form-grupo">
                    <label>Limite de Quantidade</label>
                    <input type="number" name="limiteQuantidade" min="0" placeholder="0"
                           value="<%= servicoEditar != null ? servicoEditar.getLimiteQuantidade() : "0" %>">
                </div>
                <div class="form-grupo">
                    <label>Descrição</label>
                    <input type="text" name="descricao" placeholder="Descrição do serviço"
                           value="<%= servicoEditar != null && servicoEditar.getDescricao() != null ? servicoEditar.getDescricao() : "" %>">
                </div>
            </div>
            <div style="display:flex; gap:10px; margin-top:6px;">
                <button type="submit" class="btn btn-primario">&#128190; Salvar</button>
                <% if (servicoEditar != null) { %>
                    <a href="servicos.jsp" class="btn btn-outline">Cancelar</a>
                <% } %>
            </div>
        </form>
    </div>

    <div class="tabela-container">
        <div class="tabela-header">
            <h2>Serviços cadastrados (<%= servicos.size() %>)</h2>
        </div>
        <table>
            <thead>
                <tr><th>#</th><th>Nome</th><th>Descrição</th><th>Limite</th><th>Valor Unit.</th><th>Ações</th></tr>
            </thead>
            <tbody>
                <% if (servicos.isEmpty()) { %>
                    <tr><td colspan="6" style="text-align:center;color:#aaa;padding:30px;">
                        Nenhum serviço cadastrado.
                    </td></tr>
                <% } else { for (Servico s : servicos) { %>
                    <tr>
                        <td style="color:#64748b;font-weight:600;">#<%= s.getId() %></td>
                        <td><strong><%= s.getNome() %></strong></td>
                        <td><%= s.getDescricao() != null ? s.getDescricao() : "-" %></td>
                        <td><%= s.getLimiteQuantidade() %></td>
                        <td>R$ <%= String.format("%.2f", s.getValorUnitario()) %></td>
                        <td style="display:flex;gap:6px;flex-wrap:wrap;">
                            <a href="servicos.jsp?editar=<%= s.getId() %>"
                               class="btn btn-aviso btn-sm">&#9998; Editar</a>
                            <a href="${pageContext.request.contextPath}/servico?acao=excluir&id=<%= s.getId() %>"
                               class="btn btn-perigo btn-sm"
                               onclick="return confirm('Excluir este serviço?')">&#128465; Excluir</a>
                        </td>
                    </tr>
                <% } } %>
            </tbody>
        </table>
    </div>

</div>
</body>
</html>