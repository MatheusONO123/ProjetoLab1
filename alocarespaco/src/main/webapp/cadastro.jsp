<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String erro = (String) request.getAttribute("erro");
%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastro - Sistema de Alocação</title>

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

        .cadastro-container {
            background: #ffffff;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(139, 92, 246, 0.3);
            width: 100%;
            max-width: 480px;
            padding: 50px 40px;
            position: relative;
            overflow: hidden;
        }

        .cadastro-container::before {
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

        .error-message {
            background-color: #fef2f2;
            color: #991b1b;
            padding: 14px 18px;
            border-radius: 12px;
            margin-bottom: 24px;
            border-left: 4px solid #ef4444;
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

        .form-group { margin-bottom: 22px; }

        .form-group label {
            display: block;
            color: #374151;
            font-weight: 600;
            margin-bottom: 10px;
            font-size: 14px;
        }

        .form-group input[type="text"],
        .form-group input[type="email"],
        .form-group input[type="password"] {
            width: 100%;
            padding: 14px 16px;
            border: 2px solid #e5e7eb;
            border-radius: 12px;
            font-size: 15px;
            transition: all 0.3s ease;
            font-family: inherit;
            background: #fafafa;
        }

        .form-group input:focus {
            outline: none;
            border-color: #8B5CF6;
            background: #ffffff;
            box-shadow: 0 0 0 4px rgba(139, 92, 246, 0.1);
        }

        .form-linha {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 14px;
        }

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

        .btn-cadastrar {
            background: linear-gradient(135deg, #06B6D4 0%, #0891B2 100%);
            color: white;
            box-shadow: 0 4px 12px rgba(6, 182, 212, 0.4);
        }

        .btn-cadastrar:hover {
            background: linear-gradient(135deg, #0891B2 0%, #0e7490 100%);
            box-shadow: 0 6px 20px rgba(6, 182, 212, 0.5);
            transform: translateY(-2px);
        }

        .btn-voltar {
            background: linear-gradient(135deg, #8B5CF6 0%, #7C3AED 100%);
            color: white;
            box-shadow: 0 4px 12px rgba(139, 92, 246, 0.4);
        }

        .btn-voltar:hover {
            background: linear-gradient(135deg, #7C3AED 0%, #6D28D9 100%);
            box-shadow: 0 6px 20px rgba(139, 92, 246, 0.5);
            transform: translateY(-2px);
        }

        @media (max-width: 480px) {
            .cadastro-container { padding: 40px 30px; }
            .buttons, .form-linha { grid-template-columns: 1fr; }
            .logo h1 { font-size: 30px; }
        }
    </style>
</head>
<body>
    <div class="cadastro-container">

        <div class="logo">
            <h1>&#128100; Cadastro</h1>
            <p>Crie sua conta de cliente</p>
        </div>

        <div class="divider"></div>

        <% if (erro != null && !erro.isEmpty()) { %>
            <div class="error-message">
                <span>&#10007;</span>
                <span><%= erro %></span>
            </div>
        <% } %>

        <form method="POST" action="${pageContext.request.contextPath}/cadastro-cliente">

            <div class="form-group">
                <label for="nome">&#128100; Nome Completo *</label>
                <input type="text" id="nome" name="nome"
                       placeholder="Seu nome completo" required autofocus>
            </div>

            <div class="form-linha">
                <div class="form-group">
                    <label for="cpf">&#128196; CPF *</label>
                    <input type="text" id="cpf" name="cpf"
                           placeholder="000.000.000-00" required maxlength="14">
                </div>
                <div class="form-group">
                    <label for="telefone">&#128222; Telefone</label>
                    <input type="text" id="telefone" name="telefone"
                           placeholder="(71) 99999-9999">
                </div>
            </div>

            <div class="form-group">
                <label for="email">&#9993; E-mail *</label>
                <input type="email" id="email" name="email"
                       placeholder="seu@email.com" required>
            </div>

            <div class="form-group">
                <label for="endereco">&#127968; Endereço</label>
                <input type="text" id="endereco" name="endereco"
                       placeholder="Rua, número, bairro">
            </div>

            <div class="form-group">
                <label for="senha">&#128274; Senha *</label>
                <input type="password" id="senha" name="senha"
                       placeholder="Mínimo 6 caracteres" required minlength="6">
            </div>

            <div class="form-group">
                <label for="confirmarSenha">&#128274; Confirmar Senha *</label>
                <input type="password" id="confirmarSenha" name="confirmarSenha"
                       placeholder="Digite a senha novamente" required minlength="6">
            </div>

            <div class="buttons">
                <button type="submit" class="btn btn-cadastrar">Cadastrar</button>
                <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-voltar">
                    Voltar
                </a>
            </div>

        </form>
    </div>

    <script>
        document.querySelector('form').addEventListener('submit', function(e) {
            var s  = document.getElementById('senha').value;
            var cs = document.getElementById('confirmarSenha').value;
            if (s !== cs) {
                e.preventDefault();
                alert('As senhas não coincidem!');
            }
        });
    </script>
</body>
</html>