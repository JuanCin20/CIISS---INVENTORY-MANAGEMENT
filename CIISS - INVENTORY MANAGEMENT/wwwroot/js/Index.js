jQuery.ajax({
  // ? url: "@Url.Action("","")",
  url: "https://localhost:7050/Home/Home_Controller_See_Dashboard",
  type: "GET",
  dataType: "json",
  contentType: "application/json; charset=UTF-8",
  success: function (data) {
    var Object = data.result;
    $("#Value_01").text(Object.cantidad_Movimiento_Inventario);
    $("#Value_02").text(Object.tabla_Categoria_Insumo);
    $("#Value_03").text(Object.tabla_Proveedor_Insumo);
    $("#Value_04").text(Object.tabla_Insumo);
  },
});