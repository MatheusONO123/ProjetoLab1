package br.com.locacao.dao;

import br.com.locacao.Util.ConnectionFactory;
import br.com.locacao.model.Sindico;
import java.sql.*;

public class SindicoDAO {

    public Sindico autenticar(String email, String senha) {
        String sql = "SELECT * FROM sindico WHERE email = ? AND senha = ?";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, senha);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Sindico s = new Sindico();
                s.setId(rs.getInt("id"));
                s.setNome(rs.getString("nome"));
                s.setEmail(rs.getString("email"));
                s.setSenha(rs.getString("senha"));
                return s;
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }
}