/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controlador;

import Modelo.Compras;
import Modelo.ComprasDAO;
import Modelo.DetalleCompra;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.annotation.WebServlet;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "sr_cCompras", urlPatterns = {"/sr_cCompras"})
public class sr_cCompras extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Obtener la acción directamente desde los parámetros
        String action = request.getParameter("action");

        // Verificar si la acción está presente
        if (action == null || action.isEmpty()) {
            // Redirigir a una página de error o al registro de compras si no hay acción
            response.sendRedirect("Registro_compra.jsp");
            return;
        }

        switch (action) {
            case "agregar":
            case "actualizar":
            case "eliminar":
                handleCompraAction(request, response, action);
                break;
            default:
                response.sendRedirect("Registro_compra.jsp");
                break;
        }
    }

    private void handleCompraAction(HttpServletRequest request, HttpServletResponse response, String action) 
            throws ServletException, IOException {
        ComprasDAO comprasDAO = new ComprasDAO();

        // Obtener los parámetros de compra
        String idProveedorStr = request.getParameter("txt_id_proveedor");
        String fechaOrden = request.getParameter("txt_fecha_orden");
        String fechaIngreso = request.getParameter("txt_fecha_ingreso");
        String idCompraStr = request.getParameter("txt_id_compra");

        // Validar que los campos requeridos no estén vacíos
        if (idProveedorStr == null || idProveedorStr.isEmpty() || 
            fechaOrden == null || fechaOrden.isEmpty() || 
            fechaIngreso == null || fechaIngreso.isEmpty() || 
            (action.equals("actualizar") && (idCompraStr == null || idCompraStr.isEmpty()))) {
            
            request.getRequestDispatcher("Registro_compras.jsp").forward(request, response);
            return;
        }

        int idProveedor;
        int idCompra = -1;

        try {
            idProveedor = Integer.parseInt(idProveedorStr);
            
            Compras nuevaCompra;

            switch (action) {
                case "agregar":
                    Compras comprasInstance = new Compras();
                    int nuevoNumeroOrdenCompra = comprasInstance.obtenerUltimoNum() + 1;

                    nuevaCompra = new Compras(nuevoNumeroOrdenCompra, nuevoNumeroOrdenCompra, idProveedor, fechaOrden, fechaIngreso);
                    
                    List<DetalleCompra> detalles = obtenerDetallesDesdeFormulario(request);
                    
                    comprasDAO.agregarCompraYDetalles(nuevaCompra, detalles); 
                    
                    response.sendRedirect("Registro_compras.jsp");
                    break;

                case "actualizar":
                    idCompra = Integer.parseInt(idCompraStr);
                    
                    Compras compraExistente = comprasDAO.obtenerCompraPorId(idCompra); 
                    
                    if (compraExistente != null) {
                        nuevaCompra = new Compras(idCompra, compraExistente.getNo_orden_compra(), idProveedor, fechaOrden, fechaIngreso);
                        
                        List<DetalleCompra> detallesActualizados = obtenerDetallesDesdeFormulario(request); 
                        
                        comprasDAO.actualizarCompraYDetalles(nuevaCompra, detallesActualizados); 
                        
                        response.sendRedirect("Registro_compras.jsp");
                    } else {
                        response.getWriter().println("<h1>No se encontró la compra</h1>");
                        request.getRequestDispatcher("Registro_compras.jsp").forward(request, response);
                    }
                    break;

                case "eliminar":
                    idCompra = Integer.parseInt(idCompraStr); 
                    
                    if (comprasDAO.eliminarCompraYDetalles(idCompra)) { 
                        response.sendRedirect("Registro_compras.jsp");
                    } else {
                        response.getWriter().println("<h1>No se pudo eliminar la compra</h1>");
                        request.getRequestDispatcher("Registro_compras.jsp").forward(request, response);
                    }
                    
                    break;

                default:
                    response.sendRedirect("Registro_compras.jsp");
                    break;
            }

        } catch (NumberFormatException e) { 
            response.sendRedirect("Registro_compras.jsp"); 
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

    private List<DetalleCompra> obtenerDetallesDesdeFormulario(HttpServletRequest request) {
        List<DetalleCompra> detalles = new ArrayList<>();
        
        String[] idProductos = request.getParameterValues("id_producto[]");
        String[] cantidades = request.getParameterValues("cantidad[]");
        String[] precios = request.getParameterValues("precio_costo_unitario[]");

        for (int i = 0; i < idProductos.length; i++) {
            DetalleCompra detalle = new DetalleCompra();
            detalle.setId_producto(Integer.parseInt(idProductos[i]));
            detalle.setCantidad(Integer.parseInt(cantidades[i]));
            detalle.setPrecio_costo_unitario(Double.parseDouble(precios[i]));
            detalles.add(detalle);
        }
        
        return detalles;
    }
}