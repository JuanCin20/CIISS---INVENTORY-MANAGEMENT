$(document).ready(function () {
  $("#Initial_Fecha_Movimiento_Inventario")
    .datepicker({ dateFormat: "dd/mm/yy" })
    .datepicker("setDate", new Date());
  $("#Final_Fecha_Movimiento_Inventario")
    .datepicker({ dateFormat: "dd/mm/yy" })
    .datepicker("setDate", new Date());

  jQuery.ajax({
    // ? url: "@Url.Action("Home_Controller_Dashboard_Card","Home")",
    url: "https://localhost:7050/Home/Home_Controller_Dashboard_Card",
    type: "GET",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    success: function (data) {
      var Object = data.result;
      $("#Tabla_Movimiento_Inventario").text(
        Object.tabla_Movimiento_Inventario
      );
      $("#Tabla_Categoria_Insumo").text(Object.tabla_Categoria_Insumo);
      $("#Tabla_Proveedor_Insumo").text(Object.tabla_Proveedor_Insumo);
      $("#Tabla_Insumo").text(Object.tabla_Insumo);
    },
  });

  // ? var Url = "@Url.Action("Home_Controller_Dashboard_Listar","Home")";
  var Url =
    "https://localhost:7050/Home/Home_Controller_Dashboard_Listar" +
    "?Initial_Fecha_Movimiento_Inventario=" +
    $("#Initial_Fecha_Movimiento_Inventario").val() +
    "&Final_Fecha_Movimiento_Inventario=" +
    $("#Final_Fecha_Movimiento_Inventario").val() +
    "&ID_Movimiento_Inventario=" +
    $("#ID_Movimiento_Inventario").val();

  Table = $("#Table").DataTable({
    responsive: true,
    ordering: false,
    language: {
      url: "//cdn.datatables.net/plug-ins/2.1.8/i18n/es-MX.json",
    },
    ajax: {
      url: Url,
      type: "GET",
      dataType: "json",
    },
    columns: [
      { data: "iD_Movimiento_Inventario" },
      { data: "tipo_Movimiento_Inventario" },
      { data: "nombre_Insumo" },
      { data: "cantidad_Movimiento_Inventario" },
      { data: "precio_Insumo" },
      { data: "total_Transaction" },
      { data: "fecha_Movimiento_Inventario" },
      { data: "usuario_Transaction" },
    ],
  });

  $("#Search_Button").on("click", function () {
    var New_Url =
      "https://localhost:7050/Home/Home_Controller_Dashboard_Listar" +
      "?Initial_Fecha_Movimiento_Inventario=" +
      $("#Initial_Fecha_Movimiento_Inventario").val() +
      "&Final_Fecha_Movimiento_Inventario=" +
      $("#Final_Fecha_Movimiento_Inventario").val() +
      "&ID_Movimiento_Inventario=" +
      $("#ID_Movimiento_Inventario").val();

    Table.ajax.url(New_Url).load();
  });
});