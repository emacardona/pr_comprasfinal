<%-- 
    Document   : Registro_compra
    Created on : 13/10/2024, 10:33:01 p. m.
    Author     : DELL
--%>
<%@page import="Modelo.Compras"%>
<%@page import="Modelo.Proveedor"%>
<%@page import="Modelo.Marca"%>
<%@page import="java.util.HashMap"%>
<%@page import="javax.swing.table.DefaultTableModel"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">

    </head>
    <body>
        <br>
        <h1 style="text-align: center;">Mantenimiento Compras</h1>
        
        
        

<div class="d-flex justify-content-center">
    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modal_nueva_compra">
        Compra Nueva
    </button>
</div>
<br>

        
<div class="modal fade" id="modal_nueva_compra" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Nueva Compra</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <div class="modal-body">
                <form action="sr_cCompras?menu=Nueva_compra" method="post">
                    <!-- ID de Compra -->
                    
                        <div class="form-group mb-3">
                            <label for="txt_id_compra"><b>Código de Compra:</b></label>
                            <input type="text" name="txt_id_compra" id="txt_id_compra" class="form-control" value="" readonly>
                        </div>
                        <div class="form-group mb-3">
                            <label for="txt_noc"><b>Orden de Compra:</b></label>
                            <input type="text" name="txt_noc" id="txt_noc" class="form-control" value="" readonly>
                        </div>
                    

                    <!-- Proveedor -->
                    <div class="form-group mb-3">
                            <label for="txt_id_proveedor"><b>Proveedor: </b><a href="Registro_proveedor.jsp">Ir a proveedores</a></label> 
                            <select name="txt_id_proveedor" id="txt_id_proveedor" class="form-control" required>
                                <% 
                                    Proveedor proveedor = new Proveedor();
                                    DefaultTableModel tablaProveedores = proveedor.leer();
                                    for (int t = 0; t < tablaProveedores.getRowCount(); t++) {
                                        out.println("<option value='" + tablaProveedores.getValueAt(t, 0) + "'>" + tablaProveedores.getValueAt(t, 1) + "</option>");
                                    }
                                %>
                            </select>
                        </div>
                        <div class="form-group mb-3">
                            <label for="txt_fecha_orden"><b>Fecha de Orden:</b></label>
                            <input type="date" name="txt_fecha_orden" id="txt_fecha_orden" class="form-control" required>
                        </div>
                    

                    <!-- Fecha de Ingreso -->
                    <div class="form-group mb-3">
                            <label for="txt_fecha_ingreso"><b>Fecha de Ingreso:</b></label>
                            <input type="datetime-local" name="txt_fecha_ingreso" id="txt_fecha_ingreso" class="form-control" required>
                        </div>
                    

                    <!-- Detalles de Productos -->
                    <h5>Detalle de la Compra:</h5>
                    <div id="detalles_productos">
                        <!-- Aquí se agregarán dinámicamente los productos -->
                        <div class='row mb-3 producto-row'>
                            <div class='col-md-4'>
                                <label for='id_producto'><b>Producto:</b></label>
                                <select name='id_producto[]' class='form-control' id='selectProductos' required>
                                    <% 
                                        Marca marca = new Marca();
                                        DefaultTableModel tablaProductos = marca.leer();
                                        for (int t = 0; t < tablaProductos.getRowCount(); t++) {
                                            out.println("<option value='" + tablaProductos.getValueAt(t, 0) + "'>" + tablaProductos.getValueAt(t, 1) + "</option>");
                                        }
                                    %>
                                </select>
                            </div>
                            <div class='col-md-4'>
                                <label for='cantidad'><b>Cantidad:</b></label>
                                <input type='number' name='cantidad[]' min='1' class='form-control' id='txt_cantidad' required/>
                            </div>
                            <div class='col-md-4'>
                                <label for='precio_unitario'><b>Precio Unitario:</b></label>
                                <input type='number' step='.01' name='precio_costo_unitario[]' class='form-control' id='txt_precio_unitario' required/>
                            </div>
                        </div>
                    </div>

                    <!-- Acciones -->
                    <div class='row mt-3'>
    <div class='col-md-4'>
        <button name='action' value='agregar' class='btn btn-success w-100' style="border-radius: 25px; transition: background-color 0.3s, transform 0.3s;" onmouseover="this.style.backgroundColor='#28a745'; this.style.transform='scale(1.05)';" onmouseout="this.style.backgroundColor=''; this.style.transform='scale(1)';">
            <i class="bi bi-plus-circle"></i> Agregar
        </button>
    </div>
    <div class='col-md-4'>
        <button name='action' value='actualizar' class='btn btn-warning w-100' style="border-radius: 25px; transition: background-color 0.3s, transform 0.3s;" onmouseover="this.style.backgroundColor='#ffc107'; this.style.transform='scale(1.05)';" onmouseout="this.style.backgroundColor=''; this.style.transform='scale(1)';">
            <i class="bi bi-pencil"></i> Modificar
        </button>
    </div>
    <div class='col-md-4'>
        <button name='action' value='eliminar'
                onclick='javascript:if(!confirm("¿Desea Eliminar?"))return false'
                class='btn btn-danger w-100' style="border-radius: 25px; transition: background-color 0.3s, transform 0.3s;" onmouseover="this.style.backgroundColor='#dc3545'; this.style.transform='scale(1.05)';" onmouseout="this.style.backgroundColor=''; this.style.transform='scale(1)';">
            <i class="bi bi-trash"></i> Eliminar
        </button>
    </div>
</div>

                </form>
            </div>
            <div class='modal-footer'>
                <button type='button' class='btn btn-secondary' data-bs-dismiss='modal'>Cerrar</button>
            </div>
        </div>
    </div>
</div>
                                
<div class="table-responsive" style="max-height: 300px; overflow-y: auto;">
    <table class="table table-striped table-hover">
        <thead style="position: sticky; top: 0; background-color: white; z-index: 1;">
            <tr>
                <th>ID Compra</th>
                <th>Número de Orden</th>
                <th>Proveedor</th>
                <th>Fecha de Orden</th>
                <th>Fecha de Ingreso</th>
                <th>Producto</th>
                <th>Cantidad</th>
                <th>Precio Unitario</th>
            </tr>
        </thead>
        <tbody id="tbl_compras">
            <%
                Compras compras = new Compras();
                DefaultTableModel tablaCompras = compras.leer();
                for (int t = 0; t < tablaCompras.getRowCount(); t++) {
                    out.println("<tr data-id='" + tablaCompras.getValueAt(t, 0) + "' data-id_p='" + tablaCompras.getValueAt(t, 5) + "' data-id_producto='" + tablaCompras.getValueAt(t, 6) + "'>");
                    out.println("<td>" + tablaCompras.getValueAt(t, 0) + "</td>"); // ID Compra
                    out.println("<td>" + tablaCompras.getValueAt(t, 1) + "</td>"); // Número de Orden
                    out.println("<td>" + tablaCompras.getValueAt(t, 4) + "</td>"); // Proveedor
                    out.println("<td>" + tablaCompras.getValueAt(t, 2) + "</td>"); // Fecha de Orden
                    out.println("<td>" + tablaCompras.getValueAt(t, 3) + "</td>"); // Fecha de Ingreso
                    out.println("<td>" + tablaCompras.getValueAt(t, 7) + "</td>"); // Producto
                    out.println("<td>" + tablaCompras.getValueAt(t, 8) + "</td>"); // Cantidad
                    out.println("<td>" + tablaCompras.getValueAt(t, 9) + "</td>"); // Precio Unitario
                    
                    out.println("</tr>");
                }
            %>
        </tbody>
    </table>
</div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
        <script>
            
                function limpiar() {    
             $("#txt_noc").val('');    
             $("#txt_fecha_orden").val('');    
             $("#txt_fecha_ingreso").val('');    
             $("#txt_id_proveedor").val(1);
         }

         $('#tbl_compras').on('click', 'tr', function (event) {
             var target, id_compra, numeroOrden, id_proveedor, fechaOrden, fechaIngreso, producto, cantidad, precio_costo_unitario;    
             target = $(this);

             id_compra = target.data('id'); 
             numeroOrden = target.find("td").eq(1).html();
             id_proveedor = target.data('id_p'); 
             fechaOrden = target.find("td").eq(3).html();
             fechaIngreso = target.find("td").eq(4).html();
             producto = target.data('id_producto');
             cantidad = target.find("td").eq(6).html();
             precio_costo_unitario = target.find("td").eq(7).html();

             $("#txt_id_compra").val(id_compra);
             $("#txt_noc").val(numeroOrden);
             $("#txt_id_proveedor").val(id_proveedor); 
             $("#txt_fecha_orden").val(fechaOrden);
             $("#txt_fecha_ingreso").val(fechaIngreso);
             $("#selectProductos").val(producto); 
             $("#txt_cantidad").val(cantidad);
             $("#txt_precio_unitario").val(precio_costo_unitario);

             $("#modal_nueva_compra").modal('show');

         });
                 </script>
             </body>
         </html>
