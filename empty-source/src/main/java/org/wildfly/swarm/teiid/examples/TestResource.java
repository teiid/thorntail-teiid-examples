package org.wildfly.swarm.teiid.examples;

import static org.wildfly.swarm.teiid.examples.TestResource.JDBCUtils.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;

@Path("/")
public class TestResource {
    
    private static final String JDBC_DRIVER = "org.teiid.jdbc.TeiidDriver";
    private static final String JDBC_URL = "jdbc:teiid:Portfolio@mm://localhost:31000;version=1";
    private static final String JDBC_USER = "teiidUser";
    private static final String JDBC_PASS = "password1!";
    
    @GET
    @Produces("text/plain")
    public String test() throws Exception{
        Connection conn = getDriverConnection(JDBC_DRIVER, JDBC_URL, JDBC_USER, JDBC_PASS);
        String sql = "SELECT * FROM SYSADMIN.MatViews";
        return execute(conn, sql, true);       
    }
    
    public static class JDBCUtils {
        
        public static Connection getDriverConnection(String driver, String url, String user, String pass) throws Exception {
            Class.forName(driver);
            return DriverManager.getConnection(url, user, pass); 
        }

        public static void close(Connection conn) throws SQLException {
            close(null, null, conn);
        }
        
        public static void close(Statement stmt) throws SQLException {
            close(null, stmt, null);
        }
        
        public static void close(ResultSet rs) throws SQLException {
            close(rs, null, null);
        }
        
        public static void close(Statement stmt, Connection conn) throws SQLException {
            close(null, stmt, conn);
        }
        
        public static void close(ResultSet rs, Statement stmt) throws SQLException {
            close(rs, stmt, null);
        }
        
        public static void close(ResultSet rs, Statement stmt, Connection conn) throws SQLException {
          
            if (null != rs) {
                rs.close();
                rs = null;
            }
            
            if(null != stmt) {
                stmt.close();
                stmt = null;
            }
            
            if(null != conn) {
                conn.close();
                conn = null;
            }
        }
        
        public static String execute(Connection connection, String sql, boolean closeConn) throws Exception {
            
            StringBuffer sb = new StringBuffer();
            sb.append("SQL: " + sql + "\n");
            
            Statement stmt = null;
            ResultSet rs = null;
            
            try {
                stmt = connection.createStatement();
                boolean hasResults = stmt.execute(sql);
                if (hasResults) {
                    rs = stmt.getResultSet();
                    ResultSetMetaData metadata = rs.getMetaData();
                    int columns = metadata.getColumnCount();
                    for (int row = 1; rs.next(); row++) {
                        sb.append(row + ": ");
                        for (int i = 0; i < columns; i++) {
                            if (i > 0) {
                                sb.append(", ");
                            }
                            sb.append(rs.getObject(i+1));
                        }
                        sb.append("\n");
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                close(rs, stmt);
                if(closeConn)
                    close(connection);
            }    
            sb.append("\n");
            return sb.toString();
        }

        public static String executeQuery(Connection conn, String sql) throws SQLException {
            
            StringBuffer sb = new StringBuffer();
            sb.append("Query SQL: " + sql + "\n");

            Statement stmt = null;
            ResultSet rs = null;
            
            try {
                stmt = conn.createStatement();
                rs = stmt.executeQuery(sql);
                ResultSetMetaData metadata = rs.getMetaData();
                int columns = metadata.getColumnCount();
                for (int row = 1; rs.next(); row++) {
                    sb.append(row + ": ");
                    for (int i = 0; i < columns; i++) {
                        if (i > 0) {
                            sb.append(",");
                        }
                        sb.append(rs.getString(i+1));
                    }
                    sb.append("\n");
                }
            } finally {
                close(rs, stmt);
            }
            
            sb.append("\n");
            return sb.toString();
        }

        public static boolean executeUpdate(Connection conn, String sql) throws SQLException {
                
            Statement stmt = null;
            try {
                stmt = conn.createStatement();
                stmt.executeUpdate(sql);
            } finally {
                close(stmt);
            }
            return true ;
        }
        

    }

}

