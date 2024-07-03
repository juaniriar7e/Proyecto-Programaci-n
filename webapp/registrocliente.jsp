<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Registro Cliente</title>
</head>
<body>
    <main>
        <div class="registro-container">
            <div class="registro-box">
                <%
                    // Obtener los parámetros del formulario
                    String nombre = request.getParameter("nombre");
                    String segundo_nombre = request.getParameter("segnombre");
                    String apellido = request.getParameter("apellido");
                    String segundo_apellido = request.getParameter("segapellido");
                    String contrasena = request.getParameter("contrasena");
                    String email = request.getParameter("email");

                    // Inicializando variables
                    Connection conexion = null;
                    PreparedStatement orden = null;

                    try {
                        // Cargar el driver de Oracle
                        Class.forName("oracle.jdbc.driver.OracleDriver");

                        // Establecer la conexión con la base de datos Oracle
                        String jdbcUrl = "jdbc:oracle:thin:@localhost:1521:xe";
                        String username = "martin1"; // se ingresa el nombre de el usuario de tu base de datos oracle 
                        String password = "1234"; // se ingresa la contraseña de tu usuario 
                        conexion = DriverManager.getConnection(jdbcUrl, username, password);

                        // SQL para insertar los datos
                        String orden_sql = "INSERT INTO regiscliente (NOMBRE, SEGUNDO_NOMBRE, APELLIDO, SEGUNDO_APELLIDO, CONTRASENA, EMAIL) VALUES (?, ?, ?, ?, ?, ?)";

                        // Preparar la declaración
                        orden = conexion.prepareStatement(orden_sql);

                        // Crear los valores
                        orden.setString(1, nombre);
                        if (segundo_nombre == null || segundo_nombre.isEmpty()) {
                            orden.setNull(2, Types.VARCHAR);
                        } else {
                            orden.setString(2, segundo_nombre);
                        }
                        orden.setString(3, apellido);
                        if (segundo_apellido == null || segundo_apellido.isEmpty()) {
                            orden.setNull(4, Types.VARCHAR);
                        } else {
                            orden.setString(4, segundo_apellido);
                        }
                        orden.setString(5, contrasena);
                        orden.setString(6, email);

                        // Ejecutar la inserción
                        int filasInsertadas = orden.executeUpdate();

                        // Mostrar mensaje de éxito o error
                        if (filasInsertadas > 0) {
                            out.println("<h2>REGISTRO EXITOSO</h2>");
                            out.println("<img src='realizado.gif' height='100px' width='100px'>");
                        } else {
                            out.println("<h2>Hubo un error en el registro. Por favor, intente nuevamente.</h2>");
                            out.println("<img src='error.gif' height='100px' width='100px'>");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<h2>Hubo un error en el registro. Por favor, intente nuevamente.</h2>");
                        out.println("<p>Error: " + e.getMessage() + "</p>");
                        out.println("<img src='error.gif' height='100px' width='100px'>");
                    } finally {
                        // Cerrar la conexión
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
            </div>
        </div>
    </main>
</body>
</html>


