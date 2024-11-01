<%@page import="Modelo.marcas"%>
<%@page import="Modelo.Marca"%> 
<%@page import="javax.swing.table.DefaultTableModel"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>  
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Productos</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
</head>
<body>
    <a href="Registro_compras.jsp">Ir a mantenimiento de Compras</a>
    <h1 style="text-align: center;">Registro de Productos</h1>
    <div class="container">
        <form action="sr_producto" method="post" class="form-group" enctype="multipart/form-data">
            <label for="lbl_id"><b>ID:</b></label>
            <input type="text" name="txt_id" id="txt_id" class="form-control" value="0" readonly>

            <label for="lbl_producto"><b>Producto:</b></label>
            <input type="text" name="txt_producto" id="txt_producto" class="form-control" placeholder="Ejemplo: Producto" required>

            <label for="lbl_marca"><b>Marca:</b></label>
            <select name="drop_marca" id="drop_marca" class="form-control"> 
                <% 
                marcas marcas = new marcas();
                HashMap<String, String> drop = marcas.drop_Marca();
                for(String i: drop.keySet()){
                    out.println("<option value='" + i + "'> "+drop.get(i)+" </option>");
                }
                %>
            </select>

            <label for="lbl_descripcion"><b>Descripcion:</b></label>
            <input type="text" name="txt_descripcion" id="txt_descripcion" class="form-control" placeholder="Ejemplo: Descripcion" required>

            <label for="lbl_imagen"><b>Imagen:</b></label>          
            <input type="file" name="txt_imagen" id="txt_imagen" class="form-control" accept="image/*" onchange="previewImage()">
            <img id="img_preview" src="#" alt="Vista previa" style="display: none; width: 100px; height: auto; margin-top: 20px;"/>
            
            <!-- Botón para descargar la imagen -->
            <button type="button" id="btn_descargar" onclick="descargarImagen()" class="btn btn-info" style="margin-top: 10px; display: none;">Descargar</button>

            <input type="hidden" name="current_image_path" id="current_image_path">
             
            <br></br> 
            <label for="lbl_precio_costo"><b>Precio Costo:</b></label>
            <input type="number" name="txt_precio_costo" id="txt_precio_costo" class="form-control" placeholder="Ejemplo: 500.00" required>

            <label for="lbl_precio_venta"><b>Precio Venta:</b></label>
            <input type="number" name="txt_precio_venta" id="txt_precio_venta" class="form-control" placeholder="Ejemplo: 650.00" required>

            <label for="lbl_existencia"><b>Existencia:</b></label>
            <input type="number" name="txt_existencia" id="txt_existencia" class="form-control" required>

            <label for="lbl_fecha_ingreso"><b>Fecha Ingreso:</b></label>
            <input type="datetime-local" name="txt_fecha_ingreso" id="txt_fecha_ingreso" class="form-control" required>
            
            <br>
            <button type="submit" name="btn_agregar" id="btn_agregar" value="agregar" class="btn btn-primary">Agregar</button>
            <button type="submit" name="btn_modificar" id="btn_modificar" value="modificar" class="btn btn-success">Modificar</button>
            <button type="submit" name="btn_eliminar" id="btn_eliminar" value="eliminar" class="btn btn-warning">Eliminar</button>
            <button type="button" onclick="limpiarPantalla()" class="btn btn-secondary">Limpiar</button>
        </form>
    </div> 

    <!-- Tabla de productos -->
    <div class="container">
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Producto</th>
                    <th>Descripción</th>
                    <th>Imagen</th>
                    <th>Precio Costo</th>
                    <th>Precio Venta</th>
                    <th>Existencia</th>
                    <th>Fecha Ingreso</th>
                    <th>Marca</th>
                </tr>
            </thead>
            <tbody id="tbl_productos">
                <%
                Marca marca = new Marca();
                DefaultTableModel tabla = marca.leer();
                for (int t = 0; t < tabla.getRowCount(); t++) {
                    out.println("<tr data-id='" + tabla.getValueAt(t, 0) + "' data-id_Marca='" + tabla.getValueAt(t, 2) + "'>");
                    out.println("<td>" + tabla.getValueAt(t, 1) + "</td>"); 
                    out.println("<td>" + tabla.getValueAt(t, 3) + "</td>"); 
                    out.println("<td><img src='" + tabla.getValueAt(t, 4) + "' alt='Imagen' style='width: 100px; height: auto;'/></td>"); // Imagen
                    out.println("<td>" + tabla.getValueAt(t, 5) + "</td>"); 
                    out.println("<td>" + tabla.getValueAt(t, 6) + "</td>"); 
                    out.println("<td>" + tabla.getValueAt(t, 7) + "</td>"); 
                    out.println("<td>" + tabla.getValueAt(t, 8) + "</td>"); 
                    out.println("<td>" + tabla.getValueAt(t, 9) + "</td>"); 
                    out.println("</tr>");
                }
                %>
            </tbody>
        </table>
    </div> 
            
            

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>

    <script type="text/javascript">
        function previewImage() {
            var file = document.getElementById("txt_imagen").files[0];
            var reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById("img_preview").src = e.target.result;
                document.getElementById("img_preview").style.display = "block";
                document.getElementById("btn_descargar").style.display = "inline"; // Muestra el botón de descarga
            };
            reader.readAsDataURL(file);
        }
         
        // Función para descargar la imagen
        function descargarImagen() {
            var imgSrc = document.getElementById("img_preview").src;
            if (imgSrc !== "#") {
                var link = document.createElement("a");
                link.href = imgSrc;
                link.download = "imagen_producto.jpg"; // Nombre predeterminado para el archivo
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
            } else {
                alert("No hay imagen seleccionada para descargar.");
            } 
        }

        $('#tbl_productos').on('click', 'tr', function() { 
    var id = $(this).data('id');
    var id_Marca = $(this).data('id_marca'); 
    var producto = $(this).find("td").eq(0).html();
    var descripcion = $(this).find("td").eq(1).html();
    var imagen = $(this).find("td").eq(2).find("img").attr("src");
    var precio_costo = $(this).find("td").eq(3).html();
    var precio_venta = $(this).find("td").eq(4).html();
    var existencia = $(this).find("td").eq(5).html();
    var fecha_ingreso = $(this).find("td").eq(6).html();

    $('#txt_id').val(id);
    $('#drop_marca').val(id_Marca);
    $('#txt_producto').val(producto);
    $('#txt_descripcion').val(descripcion);
    $('#current_image_path').val(imagen); // Guardar la ruta de la imagen
    $('#img_preview').attr("src", imagen).show(); // Mostrar la vista previa
    $('#txt_precio_costo').val(precio_costo);
    $('#txt_precio_venta').val(precio_venta);
    $('#txt_existencia').val(existencia);
    $('#txt_fecha_ingreso').val(fecha_ingreso);
    $('#btn_descargar').show(); // Mostrar el botón de descarga
});

        function limpiarPantalla() {
            $('#txt_id').val(0);
            $('#drop_marca').val("");
            $('#txt_producto').val("");
            $('#txt_descripcion').val("");
            $('#txt_imagen').val("");
            $('#img_preview').hide();
            $('#txt_precio_costo').val("");
            $('#txt_precio_venta').val("");
            $('#txt_existencia').val("");
            $('#txt_fecha_ingreso').val("");
            $('#btn_descargar').hide(); // Oculta el botón de descarga
        }
    </script>
</body>
</html>



