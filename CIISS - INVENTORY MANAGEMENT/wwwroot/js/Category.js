var Table_Categoria_Insumo;
var Selected_Row;

/**
 * *jQuery.ajax({
 * *    url: "https://localhost:7050/Management/Management_Controller_Categoria_Insumo_Listar",
 * *    type: "GET",
 * *    dataType: "json",
 * *    contentType: "application/json; charset=UTF-8",
 * *    success: function (data) {
 * *        console.log(data); // ? Good 'console.log'
 * *    }
 * *});
 */
$(document).ready(function () {
  Table_Categoria_Insumo = $("#Table_Categoria_Insumo").DataTable({
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
      // ? url: "@Url.Action("Management_Controller_Categoria_Insumo_Listar", "Management")",
      url: "https://localhost:7050/Management/Management_Controller_Categoria_Insumo_Listar",
      type: "GET",
      dataType: "json",
    },
    columns: [
      { data: "iD_Categoria_Insumo" },
      {
        data: null,
        render: function (data, type, row) {
          return (
            '<a tabindex="' +
            row.iD_Categoria_Insumo +
            '" href="#" class="Pop_Trigger" data-bs-custom-class="custom-popover" data-bs-container="body" data-bs-toggle="popover" data-bs-title="Descripción" data-bs-content="' +
            row.descripcion_Categoria_Insumo +
            '">' +
            row.nombre_Categoria_Insumo +
            "</a>"
          );
        },
      },
      {
        data: "estado_Categoria_Insumo",
        render: function (estado_Categoria_Insumo) {
          if (estado_Categoria_Insumo) {
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
    $("#Nombre_Categoria_Insumo").removeClass("is-valid");
    $("#Nombre_Categoria_Insumo").removeClass("is-invalid");
    $("#Descripcion_Categoria_Insumo").removeClass("is-valid");
    $("#Descripcion_Categoria_Insumo").removeClass("is-invalid");
    $("#Estado_Categoria_Insumo").removeClass("is-valid");
    $("#Estado_Categoria_Insumo").removeClass("is-invalid");
    $("#ID_Categoria_Insumo").val(0);
    $("#Nombre_Categoria_Insumo").val("");
    $("#Descripcion_Categoria_Insumo").val("");
    $("#Estado_Categoria_Insumo").val(0);
  } else {
    if (data != null) {
      $("#Nombre_Categoria_Insumo").removeClass("is-valid");
      $("#Nombre_Categoria_Insumo").removeClass("is-invalid");
      $("#Descripcion_Categoria_Insumo").removeClass("is-valid");
      $("#Descripcion_Categoria_Insumo").removeClass("is-invalid");
      $("#Estado_Categoria_Insumo").removeClass("is-valid");
      $("#Estado_Categoria_Insumo").removeClass("is-invalid");
      $("#ID_Categoria_Insumo").val(data.iD_Categoria_Insumo);
      $("#Nombre_Categoria_Insumo").val(data.nombre_Categoria_Insumo);
      $("#Descripcion_Categoria_Insumo").val(data.descripcion_Categoria_Insumo);
      $("#Estado_Categoria_Insumo").val(
        data.estado_Categoria_Insumo == true ? "Available" : "Not_Available"
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

$("#Table_Categoria_Insumo").on("click", ".Edit_Button", function () {
  Selected_Row = Selected_Row_Function(this);
  var data = Table_Categoria_Insumo.row(Selected_Row).data();
  // console.log(data); // ? Good 'console.log'
  Open_Form_Modal(data);
});

$("#Table_Categoria_Insumo").on("click", ".Delete_Button", function () {
  Selected_Row = Selected_Row_Function(this);
  var data = Table_Categoria_Insumo.row(Selected_Row).data();
  Swal.fire({
    title: "Confirmación",
    text: "¿Desea Eliminar la Categoría Seleccionada?",
    icon: "warning",
    showCancelButton: true,
    cancelButtonText: "Cancelar",
    cancelButtonColor: "#FF0000",
    confirmButtonText: "Eliminar",
    confirmButtonColor: "#3085D6",
  }).then((result) => {
    if (result.isConfirmed) {
      jQuery.ajax({
        // ? url: "@Url.Action("Management_Controller_Categoria_Insumo_Eliminar", "Management")",
        url: "https://localhost:7050/Management/Management_Controller_Categoria_Insumo_Eliminar",
        type: "DELETE",
        data: { ID_Categoria_Insumo: data.iD_Categoria_Insumo },
        success: function (data) {
          // debugger; // TODO: Punto de Depuración

          if (data.result) {
            Swal.fire({
              title: "Correcto",
              text: "La Categoría ha sido Eliminada",
              icon: "success",
            });
            Table_Categoria_Insumo.row(Selected_Row).remove().draw();
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

jQuery.validator.addMethod(
  "Valid_Nombre_Categoria_Insumo",
  function (value, element) {
    return (
      this.optional(element) ||
      /([a-zA-Z',.-]+( [a-zA-Z',.-]+)*){2,30}/.test(value)
    );
  }
);

jQuery.validator.addMethod(
  "Valid_Descripcion_Categoria_Insumo",
  function (value, element) {
    return (
      this.optional(element) ||
      /([a-zA-Z',.-]+( [a-zA-Z',.-]+)*){2,30}/.test(value)
    );
  }
);

$(document).ready(function () {
  $("#Form_Category").validate({
    rules: {
      Estado_Categoria_Insumo: {
        required: true,
      },
      Nombre_Categoria_Insumo: {
        required: true,
        Valid_Nombre_Categoria_Insumo: true,
      },
      Descripcion_Categoria_Insumo: {
        required: true,
        Valid_Descripcion_Categoria_Insumo: true,
      },
    },
    messages: {
      Estado_Categoria_Insumo: {
        required: "Campo Requerido: Estado de la Categoría del Insumo",
      },
      Nombre_Categoria_Insumo: {
        required: "Campo Requerido: Nombre de la Categoría del Insumo",
        Valid_Nombre_Categoria_Insumo:
          "Campo Requerido: Nombre de la Categoría del Insumo",
      },
      Descripcion_Categoria_Insumo: {
        required: "Campo Requerido: Descripción de la Categoría del Insumo",
        Valid_Descripcion_Categoria_Insumo:
          "Campo Requerido: Descripción de la Categoría del Insumo",
      },
    },
    errorElement: "em",
    errorPlacement: function (error, element) {
      // Add the "invalid-feedback" class to the error element
      error.addClass("invalid-feedback");

      if (element.prop("type") === "checkbox") {
        error.insertAfter(element.next("label"));
      } else {
        error.insertAfter(element);
      }
    },
    highlight: function (element, errorClass, validClass) {
      $(element).addClass("is-invalid").removeClass("is-valid");
    },
    unhighlight: function (element, errorClass, validClass) {
      $(element).addClass("is-valid").removeClass("is-invalid");
    },
  });
});

$.validator.setDefaults({
  submitHandler: function () {
    console.log("Ok!");
  },
});

function Procesar() {
  if (!$("#Form_Category").valid()) {
    return;
  } else {
    var Categoria = {
      iD_Categoria_Insumo: $("#ID_Categoria_Insumo").val(),
      nombre_Categoria_Insumo: $.trim($("#Nombre_Categoria_Insumo").val()),
      descripcion_Categoria_Insumo: $.trim(
        $("#Descripcion_Categoria_Insumo").val()
      ),
      estado_Categoria_Insumo:
        $("#Estado_Categoria_Insumo").val() == "Available" ? true : false,
    };

    if ($("#ID_Categoria_Insumo").val() == 0) {
      jQuery.ajax({
        // ? url: "@Url.Action("Management_Controller_Categoria_Insumo_Registrar", "Management")",
        url: "https://localhost:7050/Management/Management_Controller_Categoria_Insumo_Registrar",
        type: "POST",
        data: { Obj_Class_Entity_Categoria_Insumo: Categoria },
        success: function (data) {
          // debugger; // TODO: Punto de Depuración

          $(".modal-body").LoadingOverlay("hide");

          if (data.result != 0) {
            Categoria.iD_Categoria_Insumo = data.result;
            Table_Categoria_Insumo.row.add(Categoria).draw(false);
            $("#Form_Modal").modal("hide");
            toastr.options = {
              closeButton: true,
              debug: false,
              newestOnTop: true,
              progressBar: true,
              positionClass: "toast-bottom-center",
              preventDuplicates: false,
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
            toastr["success"]("La Categoría ha sido Registrada", "Éxito:");
          } else {
            toastr.options = {
              closeButton: true,
              debug: false,
              newestOnTop: true,
              progressBar: true,
              positionClass: "toast-bottom-center",
              preventDuplicates: false,
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
            toastr["error"](data.message, "Error:");
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
      if ($("#ID_Categoria_Insumo").val() != 0) {
        jQuery.ajax({
          // ? url: "@Url.Action("Management_Controller_Categoria_Insumo_Editar", "Management")",
          url: "https://localhost:7050/Management/Management_Controller_Categoria_Insumo_Editar",
          type: "PUT",
          data: { Obj_Class_Entity_Categoria_Insumo: Categoria },
          success: function (data) {
            // debugger; // TODO: Punto de Depuración

            $(".modal-body").LoadingOverlay("hide");

            if (data.result) {
              Table_Categoria_Insumo.row(Selected_Row)
                .data(Categoria)
                .draw(false);
              Selected_Row = null;
              $("#Form_Modal").modal("hide");
              toastr.options = {
                closeButton: true,
                debug: false,
                newestOnTop: true,
                progressBar: true,
                positionClass: "toast-bottom-center",
                preventDuplicates: false,
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
              toastr["info"]("La Categoría ha sido Modificada", "Información:");
            } else {
              toastr.options = {
                closeButton: true,
                debug: false,
                newestOnTop: true,
                progressBar: true,
                positionClass: "toast-bottom-center",
                preventDuplicates: false,
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
              toastr["error"](data.message, "Error:");
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