package br.com.locacao.controller;

import br.com.locacao.dao.ClienteDAO;
import br.com.locacao.model.Cliente;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/cadastro-cliente")
public class CadastroClienteController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.getRequestDispatcher("/cadastro-cliente.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String nome            = req.getParameter("nome");
        String cpf             = req.getParameter("cpf");
        String email           = req.getParameter("email");
        String telefone        = req.getParameter("telefone");
        String endereco        = req.getParameter("endereco");
        String senha           = req.getParameter("senha");
        String confirmarSenha  = req.getParameter("confirmarSenha");

        // Validações
        if (nome == null || nome.trim().isEmpty()) {
            req.setAttribute("erro", "Nome é obrigatório!");
            req.getRequestDispatcher("/cadastro-cliente.jsp").forward(req, res); return;
        }
        if (cpf == null || cpf.trim().isEmpty()) {
            req.setAttribute("erro", "CPF é obrigatório!");
            req.getRequestDispatcher("/cadastro-cliente.jsp").forward(req, res); return;
        }
        if (email == null || email.trim().isEmpty()) {
            req.setAttribute("erro", "E-mail é obrigatório!");
            req.getRequestDispatcher("/cadastro-cliente.jsp").forward(req, res); return;
        }
        if (senha == null || senha.length() < 6) {
            req.setAttribute("erro", "Senha deve ter no mínimo 6 caracteres!");
            req.getRequestDispatcher("/cadastro-cliente.jsp").forward(req, res); return;
        }
        if (!senha.equals(confirmarSenha)) {
            req.setAttribute("erro", "As senhas não coincidem!");
            req.getRequestDispatcher("/cadastro-cliente.jsp").forward(req, res); return;
        }

        ClienteDAO dao = new ClienteDAO();

        if (dao.emailExiste(email.trim())) {
            req.setAttribute("erro", "Este e-mail já está cadastrado!");
            req.getRequestDispatcher("/cadastro-cliente.jsp").forward(req, res); return;
        }

        // sindico_id = 1 pois há apenas 1 síndico no sistema
        Cliente c = new Cliente();
        c.setSindicoId(1);
        c.setNome(nome.trim());
        c.setCpf(cpf.trim());
        c.setEmail(email.trim());
        c.setTelefone(telefone != null ? telefone.trim() : "");
        c.setEndereco(endereco != null ? endereco.trim() : "");
        c.setSenha(senha);

        dao.cadastrar(c);

        HttpSession session = req.getSession();
        session.setAttribute("sucesso", "Cadastro realizado com sucesso! Faça login.");
        res.sendRedirect(req.getContextPath() + "/login.jsp");
    }
}