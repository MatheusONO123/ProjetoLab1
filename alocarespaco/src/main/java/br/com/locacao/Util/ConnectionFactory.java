package br.com.locacao.Util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionFactory {

    private static final String URL     = "jdbc:mysql://localhost:3306/sistema_locacao?useSSL=false&serverTimezone=UTC";
    private static final String USUARIO = "root";
    private static final String SENHA   = "matheus";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USUARIO, SENHA);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver MySQL não encontrado: " + e.getMessage());
        }
    }
}