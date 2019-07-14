package com.movie2.util;

import java.sql.*;

public class dataUtil {
    private static final String DRIVER = "com.mysql.jdbc.Driver";
    private static final String URL = "jdbc:mysql://localhost:3306/test?useUnicode=true&characterEncoding=utf-8";
    private static final String USER = "root";
    private static final String PASSWORD = "123";

    private static Connection connection;
    private static PreparedStatement reparedStatement;
    private static ResultSet resultSet;

    public static Connection getConnct() throws SQLException {
        try {
            Class.forName(DRIVER);
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        return connection;

    }

    public static void getClose(Connection c, Statement s, ResultSet r)
            throws SQLException {
        if (c != null) {
            c.close();
        }
        if (s != null) {
            s.close();
        }
        if (r != null) {
            r.close();
        }

    }

}
