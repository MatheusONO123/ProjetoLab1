<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="br.com.locacao.model.Cliente" %>
<%
    Cliente cliente = (Cliente) session.getAttribute("cliente");
    if (cliente == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    String paginaAtual = request.getRequestURI();
    String inicial = cliente.getNome() != null && !cliente.getNome().isEmpty()
            ? String.valueOf(cliente.getNome().charAt(0)).toUpperCase() : "C";
%>

<div class="sidebar">

    <div class="sidebar-logo">
        <h2>&#127970; Alocação</h2>
        <span>de Espaço</span>
        <div class="user-chip">
            <div class="avatar"><%= inicial %></div>
            <div class="info">
                <div class="nome"><%= cliente.getNome() %></div>
                <div class="tipo">&#128100; Cliente</div>
            </div>
        </div>
    </div>

    <nav>
        <a href="area-cliente.jsp" class="<%= paginaAtual.contains("area-cliente") ? "ativo" : "" %>">
            <span class="icone">&#128200;</span> Minha Área
        </a>
        <div class="sidebar-divider">Reservas</div>
        <a href="area-cliente.jsp#reservar" class="">
            <span class="icone">&#128197;</span> Fazer Reserva
        </a>
        <a href="area-cliente.jsp#minhas" class="">
            <span class="icone">&#128203;</span> Minhas Reservas
        </a>
    </nav>

    <div class="sidebar-footer">
        <a href="<%= request.getContextPath() %>/logout">
            <span>&#128682;</span> Sair
        </a>
    </div>

</div>