<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="br.com.locacao.model.Sindico, br.com.locacao.model.Cliente" %>

<%
    if (session.getAttribute("sindico") != null) { response.sendRedirect("index.jsp"); return; }
    if (session.getAttribute("cliente") != null) { response.sendRedirect("area-cliente.jsp"); return; }

    String erro    = (String) request.getAttribute("erro");
    String erroSes = (String) session.getAttribute("erro");
    String sucesso  = (String) session.getAttribute("sucesso");
    if (erro == null) erro = erroSes;
    session.removeAttribute("erro");
    session.removeAttribute("sucesso");
%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Sistema de Alocação</title>

    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #8B5CF6 0%, #06B6D4 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .login-container {
            background: #ffffff;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(139, 92, 246, 0.3);
            width: 100%;
            max-width: 420px;
            padding: 50px 40px;
            position: relative;
            overflow: hidden;
        }

        .login-container::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 5px;
            background: linear-gradient(90deg, #8B5CF6 0%, #06B6D4 100%);
        }

        .logo { text-align: center; margin-bottom: 40px; }

        .logo h1 {
            background: linear-gradient(135deg, #8B5CF6 0%, #06B6D4 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-size: 36px;
            margin-bottom: 8px;
            font-weight: 800;
        }

        .logo p { color: #6b7280; font-size: 15px; font-weight: 500; }

        .divider {
            height: 2px;
            background: linear-gradient(90deg, transparent 0%, #e5e7eb 20%, #e5e7eb 80%, transparent 100%);
            margin: 30px 0;
        }

        .error-message, .success-message {
            padding: 14px 18px;
            border-radius: 12px;
            margin-bottom: 24px;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 10px;
            font-weight: 500;
            animation: slideDown 0.3s ease;
        }

        @keyframes slideDown {
            from { opacity: 0; transform: translateY(-10px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        .error-message   { background-color: #fef2f2; color: #991b1b; border-left: 4px solid #ef4444; }
        .success-message { background-color: #f0fdf4; color: #166534; border-left: 4px solid #22c55e; }

        .form-group { margin-bottom: 24px; }

        .form-group label {
            display: block;
            color: #374151;
            font-weight: 600;
            margin-bottom: 10px;
            font-size: 14px;
        }

        .input-wrapper { position: relative; }

        .input-wrapper input {
            width: 100%;
            padding: 14px 16px;
            border: 2px solid #e5e7eb;
            border-radius: 12px;
            font-size: 15px;
            transition: all 0.3s ease;
            font-family: inherit;
            background: #fafafa;
        }

        .input-wrapper input:focus {
            outline: none;
            border-color: #8B5CF6;
            background: #ffffff;
            box-shadow: 0 0 0 4px rgba(139, 92, 246, 0.1);
        }

        .input-wrapper input::placeholder { color: #9ca3af; }

        .buttons {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 14px;
            margin-top: 30px;
        }

        button, .btn {
            padding: 14px 20px;
            border: none;
            border-radius: 12px;
            font-size: 15px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            font-family: inherit;
            text-decoration: none;
            text-align: center;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .btn-login {
            background: linear-gradient(135deg, #8B5CF6 0%, #7C3AED 100%);
            color: white;
            box-shadow: 0 4px 12px rgba(139, 92, 246, 0.4);
        }

        .btn-login:hover {
            background: linear-gradient(135deg, #7C3AED 0%, #6D28D9 100%);
            box-shadow: 0 6px 20px rgba(139, 92, 246, 0.5);
            transform: translateY(-2px);
        }

        .btn-register {
            background: linear-gradient(135deg, #06B6D4 0%, #0891B2 100%);
            color: white;
            box-shadow: 0 4px 12px rgba(6, 182, 212, 0.4);
        }

        .btn-register:hover {
            background: linear-gradient(135deg, #0891B2 0%, #0e7490 100%);
            box-shadow: 0 6px 20px rgba(6, 182, 212, 0.5);
            transform: translateY(-2px);
        }

        .footer {
            text-align: center;
            margin-top: 30px;
            padding-top: 25px;
            border-top: 1px solid #e5e7eb;
        }

        .footer p { color: #6b7280; font-size: 13px; margin-bottom: 8px; }
        .footer strong { color: #374151; font-weight: 600; }

        .footer .credentials {
            background: #f9fafb;
            padding: 12px;
            border-radius: 8px;
            margin-top: 10px;
            border: 1px solid #e5e7eb;
        }

        @media (max-width: 480px) {
            .login-container { padding: 40px 30px; }
            .buttons { grid-template-columns: 1fr; }
            .logo h1 { font-size: 30px; }
        }
    </style>
</head>
<body>
    <div class="login-container">

        <div class="logo">
            <h1>&#127968; Alocação</h1>
            <p>Sistema de Gerenciamento de Espaços</p>
        </div>

        <div class="divider"></div>

        <% if (erro != null && !erro.isEmpty()) { %>
            <div class="error-message">
                <span>&#10007;</span>
                <span><%= erro %></span>
            </div>
        <% } %>

        <% if (sucesso != null && !sucesso.isEmpty()) { %>
            <div class="success-message">
                <span>&#10003;</span>
                <span><%= sucesso %></span>
            </div>
        <% } %>

        <form method="POST" action="${pageContext.request.contextPath}/login">
            <div class="form-group">
                <label for="email">&#9993; E-mail</label>
                <div class="input-wrapper">
                    <input type="email" id="email" name="email"
                           placeholder="seu@email.com" required autofocus>
                </div>
            </div>

            <div class="form-group">
                <label for="senha">&#128274; Senha</label>
                <div class="input-wrapper">
                    <input type="password" id="senha" name="senha"
                           placeholder="••••••••" required minlength="6">
                </div>
            </div>

            <div class="buttons">
                <button type="submit" class="btn btn-login">Entrar</button>
                <a href="${pageContext.request.contextPath}/cadastro-cliente" class="btn btn-register">
                    Cadastrar
                </a>
            </div>
        </form>

        <div class="footer">
            <p>Credenciais de teste:</p>
            <div class="credentials">
                <p><strong>Síndico:</strong> sindico@email.com / 123456</p>
                <p><strong>Cliente:</strong> joao@email.com / 123456</p>
            </div>
        </div>

    </div>
</body>
</html>