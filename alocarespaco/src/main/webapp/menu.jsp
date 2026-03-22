<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="br.com.locacao.model.Sindico" %>
<%
    Sindico sindico = (Sindico) session.getAttribute("sindico");
    if (sindico == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    String paginaAtual = request.getRequestURI();
    String inicial = sindico.getNome() != null && !sindico.getNome().isEmpty()
            ? String.valueOf(sindico.getNome().charAt(0)).toUpperCase() : "S";
%>

<div class="sidebar">

    <div class="sidebar-logo">
        <h2>&#127970; Alocação</h2>
        <span>de Espaço</span>
        <div class="user-chip">
            <div class="avatar"><%= inicial %></div>
            <div class="info">
                <div class="nome"><%= sindico.getNome() %></div>
                <div class="tipo">&#128081; Síndico</div>
            </div>
        </div>
    </div>

    <nav>
        <a href="index.jsp" class="<%= paginaAtual.contains("index") ? "ativo" : "" %>">
            <span class="icone">&#128200;</span> Dashboard
        </a>

        <div class="sidebar-divider">Cadastros</div>
        <a href="clientes.jsp" class="<%= paginaAtual.contains("cliente") ? "ativo" : "" %>">
            <span class="icone">&#128100;</span> Clientes
        </a>
        <a href="espacos.jsp" class="<%= paginaAtual.contains("espaco") ? "ativo" : "" %>">
            <span class="icone">&#127968;</span> Espaços
        </a>
        <a href="servicos.jsp" class="<%= paginaAtual.contains("servico") ? "ativo" : "" %>">
            <span class="icone">&#128296;</span> Serviços
        </a>

        <div class="sidebar-divider">Operações</div>
        <a href="reservas.jsp" class="<%= paginaAtual.contains("reserva") ? "ativo" : "" %>">
            <span class="icone">&#128197;</span> Reservas
        </a>
        <a href="listagem.jsp" class="<%= paginaAtual.contains("listagem") ? "ativo" : "" %>">
            <span class="icone">&#128203;</span> Listagem Geral
        </a>
    </nav>

    <div class="sidebar-footer">
        <a href="<%= request.getContextPath() %>/logout">
            <span>&#128682;</span> Sair
        </a>
    </div>

</div>