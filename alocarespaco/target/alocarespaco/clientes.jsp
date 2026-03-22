<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, br.com.locacao.model.Cliente, br.com.locacao.dao.ClienteDAO" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Clientes - Alocação de Espaço</title>
    <link rel="stylesheet" href="css/estilo.css">
</head>
<body>

<%@ include file="menu.jsp" %>

<%
    ClienteDAO clienteDAO = new ClienteDAO();
    List<Cliente> clientes = clienteDAO.listarTodos();
    String msg = request.getParameter("msg");
    String erroSessao = (String) session.getAttribute("erro");
    session.removeAttribute("erro");

    Cliente clienteEditar = null;
    String editId = request.getParameter("editar");
    if (editId != null) clienteEditar = clienteDAO.buscarPorId(Integer.parseInt(editId));
%>

<div class="conteudo">

    <div class="topbar">
        <div>
            <h1>&#128100; Clientes</h1>
            <p>Cadastro e gerenciamento de clientes</p>
        </div>
    </div>

    <% if ("cadastrado".equals(msg)) { %>
        <div class="alerta alerta-sucesso">&#10003; Cliente cadastrado com sucesso!</div>
    <% } else if ("editado".equals(msg)) { %>
        <div class="alerta alerta-sucesso">&#10003; Cliente atualizado com sucesso!</div>
    <% } else if ("excluido".equals(msg)) { %>
        <div class="alerta alerta-sucesso">&#10003; Cliente excluído com sucesso!</div>
    <% } %>
    <% if (erroSessao != null) { %>
        <div class="alerta alerta-erro">&#10007; <%= erroSessao %></div>
    <% } %>

    <div class="form-container" style="margin-bottom:28px; max-width:100%;">
        <h2 style="font-size:15px; color:#5b21b6; margin-bottom:20px;">
            <%= clienteEditar != null ? "&#9998; Editar Cliente" : "&#128100; Cadastrar Cliente" %>
        </h2>
        <form action="${pageContext.request.contextPath}/cliente" method="post">
            <input type="hidden" name="acao" value="<%= clienteEditar != null ? "editar" : "cadastrar" %>">
            <% if (clienteEditar != null) { %>
                <input type="hidden" name="id" value="<%= clienteEditar.getId() %>">
            <% } %>
            <div class="form-linha">
                <div class="form-grupo">
                    <label>Nome *</label>
                    <input type="text" name="nome" placeholder="Nome completo"
                           value="<%= clienteEditar != null ? clienteEditar.getNome() : "" %>" required>
                </div>
                <div class="form-grupo">
                    <label>CPF *</label>
                    <input type="text" name="cpf" placeholder="000.000.000-00"
                           value="<%= clienteEditar != null ? clienteEditar.getCpf() : "" %>" required>
                </div>
            </div>
            <div class="form-linha">
                <div class="form-grupo">
                    <label>E-mail *</label>
                    <input type="email" name="email" placeholder="email@exemplo.com"
                           value="<%= clienteEditar != null ? clienteEditar.getEmail() : "" %>" required>
                </div>
                <div class="form-grupo">
                    <label>Telefone</label>
                    <input type="text" name="telefone" placeholder="(00) 00000-0000"
                           value="<%= clienteEditar != null ? clienteEditar.getTelefone() : "" %>">
                </div>
            </div>
            <div class="form-grupo">
                <label>Endereço</label>
                <input type="text" name="endereco" placeholder="Rua, número, bairro"
                       value="<%= clienteEditar != null ? clienteEditar.getEndereco() : "" %>">
            </div>
            <% if (clienteEditar == null) { %>
            <div class="form-grupo">
                <label>Senha *</label>
                <input type="password" name="senha" placeholder="Mínimo 6 caracteres"
                       required minlength="6">
            </div>
            <% } %>
            <div style="display:flex; gap:10px; margin-top:6px;">
                <button type="submit" class="btn btn-primario">&#128190; Salvar</button>
                <% if (clienteEditar != null) { %>
                    <a href="clientes.jsp" class="btn btn-outline">Cancelar</a>
                <% } %>
            </div>
        </form>
    </div>

    <div class="tabela-container">
        <div class="tabela-header">
            <h2>Clientes cadastrados (<%= clientes.size() %>)</h2>
        </div>
        <table>
            <thead>
                <tr><th>#</th><th>Nome</th><th>CPF</th><th>E-mail</th><th>Telefone</th><th>Ações</th></tr>
            </thead>
            <tbody>
                <% if (clientes.isEmpty()) { %>
                    <tr><td colspan="6" style="text-align:center;color:#aaa;padding:30px;">
                        Nenhum cliente cadastrado.
                    </td></tr>
                <% } else { for (Cliente c : clientes) { %>
                    <tr>
                        <td style="color:#64748b;font-weight:600;">#<%= c.getId() %></td>
                        <td><strong><%= c.getNome() %></strong></td>
                        <td><%= c.getCpf() %></td>
                        <td><%= c.getEmail() != null ? c.getEmail() : "-" %></td>
                        <td><%= c.getTelefone() != null ? c.getTelefone() : "-" %></td>
                        <td style="display:flex;gap:6px;flex-wrap:wrap;">
                            <a href="clientes.jsp?editar=<%= c.getId() %>"
                               class="btn btn-aviso btn-sm">&#9998; Editar</a>
                            <a href="${pageContext.request.contextPath}/cliente?acao=excluir&id=<%= c.getId() %>"
                               class="btn btn-perigo btn-sm"
                               onclick="return confirm('Excluir este cliente?')">&#128465; Excluir</a>
                        </td>
                    </tr>
                <% } } %>
            </tbody>
        </table>
    </div>

</div>
</body>
</html>