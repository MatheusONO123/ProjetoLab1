package br.com.locacao.dao;

import br.com.locacao.Util.ConnectionFactory;
import br.com.locacao.model.Reserva;
import java.sql.*;
import java.util.*;

public class ReservaDAO {

    public boolean verificarDisponibilidade(int espacoId, String dataEvento, String horarioInicio, String horarioFim) {
        String sql = "SELECT COUNT(*) FROM reserva " +
                     "WHERE espaco_id = ? AND data_evento = ? AND status != 'cancelada' " +
                     "AND (horario_inicio < ? AND horario_fim > ?)";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, espacoId);
            ps.setString(2, dataEvento);
            ps.setString(3, horarioFim);
            ps.setString(4, horarioInicio);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1) == 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    public int cadastrar(Reserva r) {
        String sql = "INSERT INTO reserva (sindico_id, cliente_id, espaco_id, data_evento, " +
                     "horario_inicio, horario_fim, num_convidados, decoracao, valor_total, status) " +
                     "VALUES (?,?,?,?,?,?,?,?,?,?)";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, r.getSindicoId());
            ps.setInt(2, r.getClienteId());
            ps.setInt(3, r.getEspacoId());
            ps.setString(4, r.getDataEvento());
            ps.setString(5, r.getHorarioInicio());
            ps.setString(6, r.getHorarioFim());
            ps.setInt(7, r.getNumConvidados());
            ps.setBoolean(8, r.isDecoracao());
            ps.setDouble(9, r.getValorTotal());
            ps.setString(10, r.getStatus());
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return -1;
    }

    public void atualizarStatus(int id, String status) {
        String sql = "UPDATE reserva SET status = ? WHERE id = ?";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, id);
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public void excluir(int id) {
        String sql = "DELETE FROM reserva WHERE id = ?";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public List<Reserva> listarTodas() {
        List<Reserva> lista = new ArrayList<>();
        String sql = "SELECT r.*, c.nome AS cliente_nome, e.nome AS espaco_nome " +
                     "FROM reserva r " +
                     "JOIN cliente c ON r.cliente_id = c.id " +
                     "JOIN espaco e ON r.espaco_id = e.id " +
                     "ORDER BY r.data_evento DESC, r.horario_inicio DESC";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) lista.add(mapear(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return lista;
    }

    public List<Reserva> listarPorCliente(int clienteId) {
        List<Reserva> lista = new ArrayList<>();
        String sql = "SELECT r.*, c.nome AS cliente_nome, e.nome AS espaco_nome " +
                     "FROM reserva r " +
                     "JOIN cliente c ON r.cliente_id = c.id " +
                     "JOIN espaco e ON r.espaco_id = e.id " +
                     "WHERE r.cliente_id = ? ORDER BY r.data_evento DESC";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, clienteId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) lista.add(mapear(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return lista;
    }

    public int contar() {
        String sql = "SELECT COUNT(*) FROM reserva";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    private Reserva mapear(ResultSet rs) throws SQLException {
        Reserva r = new Reserva();
        r.setId(rs.getInt("id"));
        r.setSindicoId(rs.getInt("sindico_id"));
        r.setClienteId(rs.getInt("cliente_id"));
        r.setClienteNome(rs.getString("cliente_nome"));
        r.setEspacoId(rs.getInt("espaco_id"));
        r.setEspacoNome(rs.getString("espaco_nome"));
        r.setDataEvento(rs.getString("data_evento"));
        r.setHorarioInicio(rs.getString("horario_inicio"));
        r.setHorarioFim(rs.getString("horario_fim"));
        r.setNumConvidados(rs.getInt("num_convidados"));
        r.setDecoracao(rs.getBoolean("decoracao"));
        r.setValorTotal(rs.getDouble("valor_total"));
        r.setStatus(rs.getString("status"));
        return r;
    }
}
