package br.com.locacao.dao;

import br.com.locacao.Util.ConnectionFactory;
import br.com.locacao.model.Espaco;
import java.sql.*;
import java.util.*;

public class EspacoDAO {

    public void cadastrar(Espaco e) {
        String sql = "INSERT INTO espaco (sindico_id, nome, descricao, capacidade_maxima, valor_hora, status) VALUES (?,?,?,?,?,?)";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, e.getSindicoId());
            ps.setString(2, e.getNome());
            ps.setString(3, e.getDescricao());
            ps.setInt(4, e.getCapacidadeMaxima());
            ps.setDouble(5, e.getValorHora());
            ps.setString(6, e.getStatus());
            ps.executeUpdate();
        } catch (SQLException ex) { ex.printStackTrace(); }
    }

    public void atualizar(Espaco e) {
        String sql = "UPDATE espaco SET nome=?, descricao=?, capacidade_maxima=?, valor_hora=?, status=? WHERE id=?";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, e.getNome());
            ps.setString(2, e.getDescricao());
            ps.setInt(3, e.getCapacidadeMaxima());
            ps.setDouble(4, e.getValorHora());
            ps.setString(5, e.getStatus());
            ps.setInt(6, e.getId());
            ps.executeUpdate();
        } catch (SQLException ex) { ex.printStackTrace(); }
    }

    public void excluir(int id) {
        String sql = "DELETE FROM espaco WHERE id = ?";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public Espaco buscarPorId(int id) {
        String sql = "SELECT * FROM espaco WHERE id = ?";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapear(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public List<Espaco> listarTodos() {
        List<Espaco> lista = new ArrayList<>();
        String sql = "SELECT * FROM espaco ORDER BY nome";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) lista.add(mapear(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return lista;
    }

    public List<Espaco> listarDisponiveis() {
        List<Espaco> lista = new ArrayList<>();
        String sql = "SELECT * FROM espaco WHERE status = 'disponivel' ORDER BY nome";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) lista.add(mapear(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return lista;
    }

    public int contar() {
        String sql = "SELECT COUNT(*) FROM espaco";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    private Espaco mapear(ResultSet rs) throws SQLException {
        Espaco e = new Espaco();
        e.setId(rs.getInt("id"));
        e.setSindicoId(rs.getInt("sindico_id"));
        e.setNome(rs.getString("nome"));
        e.setDescricao(rs.getString("descricao"));
        e.setCapacidadeMaxima(rs.getInt("capacidade_maxima"));
        e.setValorHora(rs.getDouble("valor_hora"));
        e.setStatus(rs.getString("status"));
        return e;
    }
}