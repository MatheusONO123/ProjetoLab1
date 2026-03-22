package br.com.locacao.filter;

import br.com.locacao.model.Sindico;
import br.com.locacao.model.Cliente;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);
        String path = req.getRequestURI();
        String contextPath = req.getContextPath();
        boolean publica = path.endsWith("login.jsp") || path.endsWith("cadastro-cliente.jsp") || path.contains("/login") || path.contains("/logout") || path.contains("/cadastro-cliente") || path.contains("/css/") || path.contains("/js/") || path.contains("/images/") || path.contains("/assets/");
        Sindico sindico = (session != null) ? (Sindico) session.getAttribute("sindico") : null;
        Cliente cliente = (session != null) ? (Cliente) session.getAttribute("cliente") : null;
        boolean logado = sindico != null || cliente != null;
        if (publica || logado) {
            chain.doFilter(request, response);
        } else {
            req.getSession().setAttribute("erro", "Voce precisa fazer login para acessar esta pagina!");
            res.sendRedirect(contextPath + "/login.jsp");
        }
    }

    @Override public void init(FilterConfig filterConfig) throws ServletException {}
    @Override public void destroy() {}
}
