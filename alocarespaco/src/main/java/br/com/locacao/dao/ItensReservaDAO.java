package br.com.locacao.dao;

import br.com.locacao.Util.ConnectionFactory;
import br.com.locacao.model.ItensReserva;
import java.sql.*;
import java.util.*;

public class ItensReservaDAO {

    public void cadastrar(ItensReserva item) {
        String sql = "INSERT INTO itens_reserva (sindico_id, reserva_id, servico_id, quantidade, valor_unitario) VALUES (?,?,?,?,?)";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, item.getSindicoId());
            ps.setInt(2, item.getReservaId());
            ps.setInt(3, item.getServicoId());
            ps.setInt(4, item.getQuantidade());
            ps.setDouble(5, item.getValorUnitario());
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public void excluirPorReserva(int reservaId) {
        String sql = "DELETE FROM itens_reserva WHERE reserva_id = ?";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, reservaId);
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public List<ItensReserva> listarPorReserva(int reservaId) {
        List<ItensReserva> lista = new ArrayList<>();
        String sql = "SELECT ir.*, s.nome AS servico_nome FROM itens_reserva ir " +
                     "JOIN servico s ON ir.servico_id = s.id WHERE ir.reserva_id = ?";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, reservaId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ItensReserva item = new ItensReserva();
                item.setId(rs.getInt("id"));
                item.setSindicoId(rs.getInt("sindico_id"));
                item.setReservaId(rs.getInt("reserva_id"));
                item.setServicoId(rs.getInt("servico_id"));
                item.setServicoNome(rs.getString("servico_nome"));
                item.setQuantidade(rs.getInt("quantidade"));
                item.setValorUnitario(rs.getDouble("valor_unitario"));
                lista.add(item);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return lista;
    }
}