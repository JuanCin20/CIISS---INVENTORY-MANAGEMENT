var Table_Insumo;
var Selected_Row;

function Show_Suply_Image(input) {
  if (input.files) {
    var Reader = new FileReader();
    Reader.onload = function (event) {
      $("#Imagen_Insumo")
        .attr("src", event.target.result)
        .width(200)
        .height(195);
    };
    Reader.readAsDataURL(input.files[0]);
  }
}

/**
 * *jQuery.ajax({
 * *    url: "https://localhost:7050/Management/Management_Controller_Insumo_Listar",
 * *    type: "GET",
 * *    dataType: "json",
 * *    contentType: "application/json; charset=UTF-8",
 * *    success: function (data) {
 * *        console.log(data); // ? Good 'console.log'
 * *    }
 * *});
 */
$(document).ready(function () {
  Table_Insumo = $("#Table_Insumo").DataTable({
    fnDrawCallback: function () {
      // !
      $(document).ready(function () {
        $(".Pop_Trigger").popover({
          trigger: "hover focus",
          animation: true,
        });
      });
      // !
    },
    responsive: true,
    ordering: false,
    language: {
      url: "//cdn.datatables.net/plug-ins/2.1.8/i18n/es-MX.json",
    },
    ajax: {
      url: "https://localhost:7050/Management/Management_Controller_Insumo_Listar",
      type: "GET",
      dataType: "json",
    },
    columns: [
      { data: "iD_Insumo" },
      {
        data: null,
        render: function (data, type, row) {
          return (
            '<a tabindex="' +
            row.iD_Insumo +
            '" href="#" class="Pop_Trigger" data-bs-html="true" data-bs-custom-class="custom-popover" data-bs-container="body" data-bs-toggle="popover" data-bs-title="Información" data-bs-content="<p><b>Categoría:</b> ' +
            row.object_ID_Categoria_Insumo.nombre_Categoria_Insumo +
            "</p><p><b>Proveedor:</b> " +
            row.object_ID_Proveedor_Insumo.nombre_Proveedor_Insumo +
            "</p><p><b>Descripción:</b> " +
            row.descripcion_Insumo +
            '</p>">' +
            row.nombre_Insumo +
            "</a>"
          );
        },
      },
      { data: "unidad_Medida_Insumo" },
      { data: "precio_Insumo" },
      { data: "stock_Insumo" },
      {
        data: "fecha_Vencimiento_Insumo",
        render: function (fecha_Vencimiento_Insumo) {
          var fecha_Vencimiento_Insumo_SubString =
            fecha_Vencimiento_Insumo.substring(0, 10);
          return fecha_Vencimiento_Insumo_SubString;
        },
      },
      {
        data: "estado_Insumo",
        render: function (estado_Insumo) {
          if (estado_Insumo) {
            return '<span class="badge text-bg-success">Disponible</span>';
          } else {
            return '<span class="badge text-bg-danger">No Disponible</span>';
          }
        },
      },
      {
        defaultContent:
          '<button type="button" class="btn btn-primary btn-sm Edit_Button"><i class="fa-solid fa-pencil"></i></button>' +
          '<button type="button" class="btn btn-danger btn-sm ms-2 Delete_Button"><i class="fa-solid fa-trash"></i></button>',
        orderable: false,
        searchable: false,
        width: "90px",
      },
    ],
  });
});

jQuery.ajax({
  url: "https://localhost:7050/Management/Management_Controller_Categoria_Insumo_Listar",
  type: "GET",
  dataType: "json",
  contentType: "application/json; charset=UTF-8",
  success: function (data) {
    $("<option>")
      .attr({ value: "0", disabled: "true", selected: "true" })
      .text("Seleccionar")
      .appendTo("#Categoria_Insumo");
    $.each(data.data, function (index, item) {
      $("<option>")
        .attr({ value: item.iD_Categoria_Insumo })
        .text(item.nombre_Categoria_Insumo)
        .appendTo("#Categoria_Insumo");
    });
  },
});

jQuery.ajax({
  url: "https://localhost:7050/Management/Management_Controller_Proveedor_Insumo_Listar",
  type: "GET",
  dataType: "json",
  contentType: "application/json; charset=UTF-8",
  success: function (data) {
    $("<option>")
      .attr({ value: "0", disabled: "true", selected: "true" })
      .text("Seleccionar")
      .appendTo("#Proveedor_Insumo");
    $.each(data.data, function (index, item) {
      $("<option>")
        .attr({ value: item.iD_Proveedor_Insumo })
        .text(item.nombre_Proveedor_Insumo)
        .appendTo("#Proveedor_Insumo");
    });
  },
});

function Open_Form_Modal(data) {
  if (data == null) {
    $("#ID_Insumo").val(0);
    $("#Categoria_Insumo").val(0);
    $("#Proveedor_Insumo").val(0);
    $("#Nombre_Insumo").val("");
    $("#Descripcion_Insumo").val("");
    $("#Unidad_Medida_Insumo").val("");
    $("#Precio_Insumo").val("");
    $("#Stock_Insumo").val("");
    $("#Estado_Insumo").val(0);
    $("#Fecha_Vencimiento_Insumo").val("");
    $("#Imagen_Insumo").removeAttr("src");
    $("#Imagen_Insumo_Input").val("");
  } else {
    if (data != null) {
      var fecha_Vencimiento_Insumo_SubString =
        data.fecha_Vencimiento_Insumo.substring(0, 10);
      var Test_Date = ("0" + fecha_Vencimiento_Insumo_SubString).slice(-11); // ! "10/10/2024";
      var Day = Test_Date.substring(0, 2);
      var Month = Test_Date.substring(3, 5);
      var Year = Test_Date.substring(6, 10);
      var Final_Date = Year + "-" + Month + "-" + Day;
      $("#ID_Insumo").val(data.iD_Insumo);
      $("#Categoria_Insumo").val(
        data.object_ID_Categoria_Insumo.iD_Categoria_Insumo
      );
      $("#Proveedor_Insumo").val(
        data.object_ID_Proveedor_Insumo.iD_Proveedor_Insumo
      );
      $("#Nombre_Insumo").val(data.nombre_Insumo);
      $("#Descripcion_Insumo").val(data.descripcion_Insumo);
      $("#Unidad_Medida_Insumo").val(data.unidad_Medida_Insumo);
      $("#Precio_Insumo").val(data.precio_Insumo);
      $("#Stock_Insumo").val(data.stock_Insumo);
      $("#Estado_Insumo").val(
        data.estado_Insumo == true ? "Available" : "Not_Available"
      );
      $("#Fecha_Vencimiento_Insumo").val(Final_Date);
    }
  }
  $("#Form_Modal").modal("show");
}

function Selected_Row_Function(data) {
  // ? Obtener la Fila Actual
  var Selected_Row = $(data).parents("tr");
  // ? Compruebe si la Fila Actual es una Fila Secundaria
  if (Selected_Row.hasClass("child")) {
    // ? Si es así, Señale la Fila Anterior (It's "parent")
    Selected_Row = Selected_Row.prev();
  }
  return Selected_Row;
}

$("#Table_Insumo").on("click", ".Edit_Button", function () {
  Selected_Row = Selected_Row_Function(this);
  var data = Table_Insumo.row(Selected_Row).data();
  console.log(data); // ? Good 'console.log'
  Open_Form_Modal(data);
});

$("#Table_Insumo").on("click", ".Delete_Button", function () {
  Selected_Row = Selected_Row_Function(this);
  var data = Table_Insumo.row(Selected_Row).data();
  Swal.fire({
    title: "Confirmación",
    text: "¿Desea Eliminar el Insumo Seleccionado?",
    icon: "warning",
    showCancelButton: true,
    cancelButtonText: "Cancelar",
    cancelButtonColor: "#FF0000",
    confirmButtonText: "Eliminar",
    confirmButtonColor: "#3085D6",
  }).then((result) => {
    if (result.isConfirmed) {
      jQuery.ajax({
        url: "https://localhost:7050/Management/Management_Controller_Insumo_Eliminar",
        type: "DELETE",
        data: { ID_Insumo: data.iD_Insumo },
        success: function (data) {
          // debugger; // TODO: Punto de Depuración

          if (data.result) {
            Swal.fire({
              title: "Correcto",
              text: "El Insumo ha sido Eliminado",
              icon: "success",
            });
            Table_Insumo.row(Selected_Row).remove().draw();
          } else {
            Swal.fire({
              title: "Error",
              text: data.message,
              icon: "error",
            });
          }
        },
        error: function (error) {
          alert(error);
        },
      });
    }
  });
  // console.log(data); // ? Good 'console.log'
});

function Procesar() {
  var Estado_Insumo_Selection = $("#Estado_Insumo option:selected").text();
  var Categoria_Insumo_Selection = $(
    "#Categoria_Insumo option:selected"
  ).text();
  var Proveedor_Insumo_Selection = $(
    "#Proveedor_Insumo option:selected"
  ).text();

  var Selected_Image = $("#Imagen_Insumo_Input")[0].files[0];

  var Insumo = {
    iD_Insumo: $("#ID_Insumo").val(),
    object_ID_Categoria_Insumo: {
      iD_Categoria_Insumo: $("#Categoria_Insumo option:selected").val(),
      nombre_Categoria_Insumo: $("#Categoria_Insumo option:selected").text(),
    },
    object_ID_Proveedor_Insumo: {
      iD_Proveedor_Insumo: $("#Proveedor_Insumo option:selected").val(),
      nombre_Proveedor_Insumo: $("#Proveedor_Insumo option:selected").text(),
    },
    nombre_Insumo: $("#Nombre_Insumo").val(),
    descripcion_Insumo: $("#Descripcion_Insumo").val(),
    unidad_Medida_Insumo: $("#Unidad_Medida_Insumo").val(),
    precio_Insumo: $("#Precio_Insumo").val(),
    stock_Insumo: $("#Stock_Insumo").val(),
    estado_Insumo: $("#Estado_Insumo").val() == "Available" ? true : false,
    fecha_Vencimiento_Insumo: $("#Fecha_Vencimiento_Insumo").val(),
  };

  if (Estado_Insumo_Selection == "Seleccionar") {
    toastr.options = {
      closeButton: true,
      debug: false,
      newestOnTop: true,
      progressBar: true,
      positionClass: "toast-bottom-center",
      preventDuplicates: true,
      onclick: null,
      showDuration: "300",
      hideDuration: "1000",
      timeOut: "5000",
      extendedTimeOut: "1000",
      showEasing: "swing",
      hideEasing: "linear",
      showMethod: "fadeIn",
      hideMethod: "fadeOut",
    };
    toastr["warning"]("Campo Requerido: Estado del Insumo", "Advertencia:");
  } else {
    if (Categoria_Insumo_Selection == "Seleccionar") {
      toastr.options = {
        closeButton: true,
        debug: false,
        newestOnTop: true,
        progressBar: true,
        positionClass: "toast-bottom-center",
        preventDuplicates: true,
        onclick: null,
        showDuration: "300",
        hideDuration: "1000",
        timeOut: "5000",
        extendedTimeOut: "1000",
        showEasing: "swing",
        hideEasing: "linear",
        showMethod: "fadeIn",
        hideMethod: "fadeOut",
      };
      toastr["warning"](
        "Campo Requerido: Categoría del Insumo",
        "Advertencia:"
      );
    } else {
      if (Proveedor_Insumo_Selection == "Seleccionar") {
        toastr.options = {
          closeButton: true,
          debug: false,
          newestOnTop: true,
          progressBar: true,
          positionClass: "toast-bottom-center",
          preventDuplicates: true,
          onclick: null,
          showDuration: "300",
          hideDuration: "1000",
          timeOut: "5000",
          extendedTimeOut: "1000",
          showEasing: "swing",
          hideEasing: "linear",
          showMethod: "fadeIn",
          hideMethod: "fadeOut",
        };
        toastr["warning"](
          "Campo Requerido: Proveedor del Insumo",
          "Advertencia:"
        );
      } else {
        if ($("#ID_Insumo").val() == 0) {
          var Request = new FormData();
          Request.append("Obj_Class_Entity_Insumo", JSON.stringify(Insumo)); // !!!
          Request.append("Obj_IFormFile", Selected_Image);

          jQuery.ajax({
            url: "https://localhost:7050/Management/Management_Controller_Insumo_Registrar",
            type: "POST",
            data: Request,
            processData: false,
            contentType: false,
            success: function (data) {
              // debugger; // TODO: Punto de Depuración

              $(".modal-body").LoadingOverlay("hide");

              if (data.ID_Insumo_Generated != 0) {
                Insumo.iD_Insumo = data.ID_Insumo_Generated;
                Table_Insumo.row.add(Insumo).draw(false);
                $("#Form_Modal").modal("hide");
              } else {
                toastr.options = {
                  closeButton: true,
                  debug: false,
                  newestOnTop: true,
                  progressBar: true,
                  positionClass: "toast-bottom-center",
                  preventDuplicates: true,
                  onclick: null,
                  showDuration: "300",
                  hideDuration: "1000",
                  timeOut: "5000",
                  extendedTimeOut: "1000",
                  showEasing: "swing",
                  hideEasing: "linear",
                  showMethod: "fadeIn",
                  hideMethod: "fadeOut",
                };
                toastr["warning"](data.message, "Advertencia:");
              }
            },
            error: function (error) {
              $(".modal-body").LoadingOverlay("hide");
              alert(error);
            },
            beforeSend: function () {
              $(".modal-body").LoadingOverlay("show", {
                background: "rgba(0, 0, 0, 0.5)",
                image: "../img/clock-regular.svg",
                imageAnimation: "1.5s fadein",
                imageAutoResize: true,
                imageResizeFactor: 1,
                imageColor: "rgb(255, 205, 0)",
              });
            },
          });
        } else {
          if ($("#ID_Insumo").val() != 0) {
            var Request = new FormData();
            Request.append("Obj_Class_Entity_Insumo", JSON.stringify(Insumo)); // !!!
            Request.append("Obj_IFormFile", Selected_Image);

            jQuery.ajax({
              url: "https://localhost:7050/Management/Management_Controller_Insumo_Editar",
              type: "PUT",
              data: Request,
              processData: false,
              contentType: false,
              success: function (data) {
                // debugger; // TODO: Punto de Depuración

                $(".modal-body").LoadingOverlay("hide");

                if (data.Successful_Operation) {
                  Table_Insumo.row(Selected_Row).data(Insumo).draw(false);
                  Selected_Row = null;
                  $("#Form_Modal").modal("hide");
                } else {
                  toastr.options = {
                    closeButton: true,
                    debug: false,
                    newestOnTop: true,
                    progressBar: true,
                    positionClass: "toast-bottom-center",
                    preventDuplicates: true,
                    onclick: null,
                    showDuration: "300",
                    hideDuration: "1000",
                    timeOut: "5000",
                    extendedTimeOut: "1000",
                    showEasing: "swing",
                    hideEasing: "linear",
                    showMethod: "fadeIn",
                    hideMethod: "fadeOut",
                  };
                  toastr["warning"](data.message, "Advertencia:");
                }
              },
              error: function (error) {
                $(".modal-body").LoadingOverlay("hide");
                alert(error);
              },
              beforeSend: function () {
                $(".modal-body").LoadingOverlay("show", {
                  background: "rgba(0, 0, 0, 0.5)",
                  image: "../img/clock-regular.svg",
                  imageAnimation: "1.5s fadein",
                  imageAutoResize: true,
                  imageResizeFactor: 1,
                  imageColor: "rgb(255, 205, 0)",
                });
              },
            });
          }
        }
      }
    }
  }
}