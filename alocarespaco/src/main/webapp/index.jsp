<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="br.com.locacao.model.Sindico, br.com.locacao.dao.*" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Alocação de Espaço</title>
    <link rel="stylesheet" href="css/estilo.css">
</head>
<body>

<%@ include file="menu.jsp" %>

<%
    String msgSessao  = (String) session.getAttribute("sucesso");
    String erroSessao = (String) session.getAttribute("erro");
    session.removeAttribute("sucesso");
    session.removeAttribute("erro");

    int totalClientes = new ClienteDAO().contar();
    int totalEspacos  = new EspacoDAO().contar();
    int totalReservas = new ReservaDAO().contar();
    int totalServicos = new ServicoDAO().contar();
%>

<div class="conteudo">

    <div class="topbar">
        <div>
            <h1>Dashboard</h1>
            <p>
                Bem-vindo(a), <strong><%= sindico.getNome() %></strong> &mdash;
                <span class="topbar-badge sindico">&#128081; Síndico</span>
            </p>
        </div>
    </div>

    <% if (msgSessao != null && !msgSessao.isEmpty()) { %>
        <div class="alerta alerta-sucesso">&#10003; <%= msgSessao %></div>
    <% } %>
    <% if (erroSessao != null && !erroSessao.isEmpty()) { %>
        <div class="alerta alerta-erro">&#10007; <%= erroSessao %></div>
    <% } %>

    <div class="card-boas-vindas">
        <h2>&#127968; Painel de Administração</h2>
        <p>Gerencie clientes, espaços, serviços e reservas do condomínio.</p>
        <div style="display:flex; gap:12px; flex-wrap:wrap;">
            <a href="reservas.jsp" class="btn btn-ciano">&#128197; Ver Reservas</a>
            <a href="clientes.jsp" class="btn" style="background:rgba(255,255,255,0.2);color:#fff;">
                &#128100; Ver Clientes
            </a>
        </div>
    </div>

    <div class="cards-grid">
        <div class="card-stat azul">
            <h3>Clientes</h3>
            <div class="valor"><%= totalClientes %></div>
        </div>
        <div class="card-stat ciano">
            <h3>Espaços</h3>
            <div class="valor"><%= totalEspacos %></div>
        </div>
        <div class="card-stat verde">
            <h3>Reservas</h3>
            <div class="valor"><%= totalReservas %></div>
        </div>
        <div class="card-stat laranja">
            <h3>Serviços</h3>
            <div class="valor"><%= totalServicos %></div>
        </div>
    </div>

    <div class="tabela-container" style="padding: 24px;">
        <h2 style="font-size:15px; color:#5b21b6; margin-bottom:16px;">&#9889; Ações Rápidas</h2>
        <div style="display:flex; gap:12px; flex-wrap:wrap;">
            <a href="clientes.jsp"  class="btn btn-primario">&#128100; Cadastrar Cliente</a>
            <a href="espacos.jsp"   class="btn btn-ciano">&#127968; Gerenciar Espaços</a>
            <a href="reservas.jsp"  class="btn btn-aviso">&#128197; Nova Reserva</a>
            <a href="servicos.jsp"  class="btn btn-sucesso">&#128296; Gerenciar Serviços</a>
        </div>
    </div>

</div>
</body>
</html>