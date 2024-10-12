var Table_Proveedor_Insumo;
var Selected_Row;

/**
 * *jQuery.ajax({
 * *    url: "https://localhost:7050/Management/Management_Controller_Proveedor_Insumo_Listar",
 * *    type: "GET",
 * *    dataType: "json",
 * *    contentType: "application/json; charset=UTF-8",
 * *    success: function (data) {
 * *        console.log(data); // ? Good 'console.log'
 * *    }
 * *});
 */
$(document).ready(function () {
  Table_Proveedor_Insumo = $("#Table_Proveedor_Insumo").DataTable({
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
      url: "https://localhost:7050/Management/Management_Controller_Proveedor_Insumo_Listar",
      type: "GET",
      dataType: "json",
    },
    columns: [
      { data: "iD_Proveedor_Insumo" },
      {
        data: null,
        render: function (data, type, row) {
          return (
            '<a tabindex="' +
            row.iD_Proveedor_Insumo +
            '" href="#" class="Pop_Trigger" data-bs-html="true" data-bs-custom-class="custom-popover" data-bs-container="body" data-bs-toggle="popover" data-bs-title="Información" data-bs-content="<p><b>Teléfono:</b> ' +
            row.telefono_Proveedor_Insumo +
            "</p><p><b>E-Mail:</b> " +
            row.e_Mail_Proveedor_Insumo +
            "</p><p><b>Dirección:</b> " +
            row.direccion_Proveedor_Insumo +
            '</p>">' +
            row.nombre_Proveedor_Insumo +
            "</a>"
          );
        },
      },
      {
        data: "estado_Proveedor_Insumo",
        render: function (estado_Proveedor_Insumo) {
          if (estado_Proveedor_Insumo) {
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

function Open_Form_Modal(data) {
  if (data == null) {
    $("#ID_Proveedor_Insumo").val(0);
    $("#Nombre_Proveedor_Insumo").val("");
    $("#Telefono_Proveedor_Insumo").val("");
    $("#E_Mail_Proveedor_Insumo").val("");
    $("#Direccion_Proveedor_Insumo").val("");
    $("#Estado_Proveedor_Insumo").val(0);
  } else {
    if (data != null) {
      $("#ID_Proveedor_Insumo").val(data.iD_Proveedor_Insumo);
      $("#Nombre_Proveedor_Insumo").val(data.nombre_Proveedor_Insumo);
      $("#Telefono_Proveedor_Insumo").val(data.telefono_Proveedor_Insumo);
      $("#E_Mail_Proveedor_Insumo").val(data.e_Mail_Proveedor_Insumo);
      $("#Direccion_Proveedor_Insumo").val(data.direccion_Proveedor_Insumo);
      $("#Estado_Proveedor_Insumo").val(
        data.estado_Proveedor_Insumo == true ? "Available" : "Not_Available"
      );
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

$("#Table_Proveedor_Insumo").on("click", ".Edit_Button", function () {
  Selected_Row = Selected_Row_Function(this);
  var data = Table_Proveedor_Insumo.row(Selected_Row).data();
  // console.log(data); // ? Good 'console.log'
  Open_Form_Modal(data);
});

$("#Table_Proveedor_Insumo").on("click", ".Delete_Button", function () {
  Selected_Row = Selected_Row_Function(this);
  var data = Table_Proveedor_Insumo.row(Selected_Row).data();
  Swal.fire({
    title: "Confirmación",
    text: "¿Desea Eliminar al Proveedor Seleccionado?",
    icon: "warning",
    showCancelButton: true,
    cancelButtonText: "Cancelar",
    cancelButtonColor: "#FF0000",
    confirmButtonText: "Eliminar",
    confirmButtonColor: "#3085D6",
  }).then((result) => {
    if (result.isConfirmed) {
      jQuery.ajax({
        url: "https://localhost:7050/Management/Management_Controller_Proveedor_Insumo_Eliminar",
        type: "DELETE",
        data: { ID_Proveedor_Insumo: data.iD_Proveedor_Insumo },
        success: function (data) {
          // debugger; // TODO: Punto de Depuración

          if (data.result) {
            Swal.fire({
              title: "Correcto",
              text: "El Proveedor ha sido Eliminado",
              icon: "success",
            });
            Table_Proveedor_Insumo.row(Selected_Row).remove().draw();
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
  var Estado_Proveedor_Insumo_Selection = $(
    "#Estado_Proveedor_Insumo option:selected"
  ).text();

  var Proveedor = {
    iD_Proveedor_Insumo: $("#ID_Proveedor_Insumo").val(),
    nombre_Proveedor_Insumo: $("#Nombre_Proveedor_Insumo").val(),
    telefono_Proveedor_Insumo: $("#Telefono_Proveedor_Insumo").val(),
    e_Mail_Proveedor_Insumo: $("#E_Mail_Proveedor_Insumo").val(),
    direccion_Proveedor_Insumo: $("#Direccion_Proveedor_Insumo").val(),
    estado_Proveedor_Insumo:
      $("#Estado_Proveedor_Insumo").val() == "Available" ? true : false,
  };

  if (Estado_Proveedor_Insumo_Selection == "Seleccionar") {
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
      "Campo Requerido: Estado del Proveedor del Insumo",
      "Advertencia:"
    );
  } else {
    if ($("#ID_Proveedor_Insumo").val() == 0) {
      jQuery.ajax({
        url: "https://localhost:7050/Management/Management_Controller_Proveedor_Insumo_Registrar",
        type: "POST",
        data: { Obj_Class_Entity_Proveedor_Insumo: Proveedor },
        success: function (data) {
          // debugger; // TODO: Punto de Depuración

          $(".modal-body").LoadingOverlay("hide");

          if (data.result != 0) {
            Proveedor.iD_Proveedor_Insumo = data.result;
            Table_Proveedor_Insumo.row.add(Proveedor).draw(false);
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
      if ($("#ID_Proveedor_Insumo").val() != 0) {
        jQuery.ajax({
          url: "https://localhost:7050/Management/Management_Controller_Proveedor_Insumo_Editar",
          type: "PUT",
          data: { Obj_Class_Entity_Proveedor_Insumo: Proveedor },
          success: function (data) {
            // debugger; // TODO: Punto de Depuración

            $(".modal-body").LoadingOverlay("hide");

            if (data.result) {
              Table_Proveedor_Insumo.row(Selected_Row)
                .data(Proveedor)
                .draw(false);
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