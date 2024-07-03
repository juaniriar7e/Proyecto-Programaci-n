<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%
    // Obtener los parámetros del formulario
    String nombre = request.getParameter("nombre");
    String segundo_nombre = request.getParameter("segundo_nombre");
    String apellido = request.getParameter("apellido");
    String segundo_apellido = request.getParameter("segundo_apellido");
    String contrasena = request.getParameter("contraseña");
    String email = request.getParameter("email");
    String fecha_nacimiento = request.getParameter("fecha_nacimiento");
    String cargo = request.getParameter("cargo");
    String codigo_libreria = request.getParameter("codigo_libreria");

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

        // SQL para verificar si el email ya existe
        String verificacion_sql = "SELECT COUNT(*) FROM regisempleado WHERE EMAIL = ?";
        orden = conexion.prepareStatement(verificacion_sql);
        orden.setString(1, email);
        resultado = orden.executeQuery();
        resultado.next();
        int cuenta = resultado.getInt(1);

        if (cuenta > 0) {
            out.println("<h2>El correo ya está registrado. Por favor, use otro correo.</h2>");
            out.println("<img src='error.gif' height='100px' width='100px'>");
        } else {
            // SQL para insertar los datos
            String orden_sql = "INSERT INTO regisempleado (NOMBRE, SEGUNDO_NOMBRE, APELLIDO, SEGUNDO_APELLIDO, CONTRASENA, EMAIL, FECHA_NACIMIENTO, CARGO, CODIGO_LIBRERIA) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

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
            orden.setDate(7, java.sql.Date.valueOf(fecha_nacimiento));
            orden.setString(8, cargo);
            if (codigo_libreria == null || codigo_libreria.isEmpty()) {
                orden.setNull(9, Types.VARCHAR);
            } else {
                orden.setString(9, codigo_libreria);
            }

            // Ejecutar la inserción
            int filasInsertadas = orden.executeUpdate();

            // Mostrar mensaje de éxito o error
            if (filasInsertadas > 0) {
                out.println("<h2>REGISTRO EXITOSO</h2>");
            } else {
                out.println("<h2>Hubo un error en el registro. Por favor, intente nuevamente.</h2>");          
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h2>Hubo un error en el registro. Por favor, intente nuevamente.</h2>");
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

