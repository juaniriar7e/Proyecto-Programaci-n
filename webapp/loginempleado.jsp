<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%
    // Obtener los parámetros del formulario
    String email = request.getParameter("email");
    String contrasena = request.getParameter("password");

    // Inicializando variables
    Connection conexion = null;
    PreparedStatement orden = null;
    ResultSet resultado = null;

    try {
        // Cargar el driver de Oracle
        Class.forName("oracle.jdbc.driver.OracleDriver");

        // Establecer la conexión con la base de datos Oracle
        String jdbcUrl = "jdbc:oracle:thin:@localhost:1521:xe";
        String username = "martin1"; // se ingresa el nombre del usuario de tu base de datos oracle 
        String password = "1234"; // se ingresa la contraseña de tu usuario 
        conexion = DriverManager.getConnection(jdbcUrl, username, password);

        // SQL para verificar las credenciales
        String verificacion_sql = "SELECT * FROM regisempleado WHERE EMAIL = ? AND CONTRASENA = ?";
        orden = conexion.prepareStatement(verificacion_sql);
        orden.setString(1, email);
        orden.setString(2, contrasena);
        resultado = orden.executeQuery();

        if (resultado.next()) {
            // Usuario autenticado con éxito
            out.println("<h2>Inicio de sesión exitoso. Bienvenido " + resultado.getString("nombre") + "!</h2>");
        } else {
            // Credenciales incorrectas
            out.println("<h2>Correo o contraseña incorrectos. Por favor, intente nuevamente.</h2>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h2>Hubo un error en el inicio de sesión. Por favor, intente nuevamente.</h2>");
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        // Cerrar la conexión
        if (resultado != null) 
            try { 
                resultado.close(); 
            } catch (SQLException ignore) {}
        if (orden != null) 
            try { 
                orden.close(); 
            } catch (SQLException ignore) {}
        if (conexion != null) 
            try { 
                conexion.close(); 
            } catch (SQLException ignore) {}
    }
%>

