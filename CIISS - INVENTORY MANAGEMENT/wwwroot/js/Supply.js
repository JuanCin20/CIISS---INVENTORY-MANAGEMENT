var Table_Insumo;
var Selected_Row;

function Show_Supply_Image(input) {
  if (input.files) {
    var Reader = new FileReader();
    Reader.onload = function (event) {
      $("#Imagen_Insumo").attr("src", event.target.result);
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
      // ? url: "@Url.Action('Management_Controller_Insumo_Listar', 'Management')",
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
        data: null,
        render: function (data, type, row) {
          return (
            '<img style="width: 60px; height: 60px;" src="../../Supply_Images/' +
            row.nombre_Imagen_Insumo +
            '" alt="Image_Error" class="border rounded img-fluid">'
          );
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
  // ? url: "@Url.Action('Management_Controller_Categoria_Insumo_Listar', 'Management')",
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
  // ? url: "@Url.Action('Management_Controller_Proveedor_Insumo_Listar', 'Management')",
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
    $("#Categoria_Insumo").removeClass("is-valid");
    $("#Categoria_Insumo").removeClass("is-invalid");
    $("#Proveedor_Insumo").removeClass("is-valid");
    $("#Proveedor_Insumo").removeClass("is-invalid");
    $("#Nombre_Insumo").removeClass("is-valid");
    $("#Nombre_Insumo").removeClass("is-invalid");
    $("#Descripcion_Insumo").removeClass("is-valid");
    $("#Descripcion_Insumo").removeClass("is-invalid");
    $("#Unidad_Medida_Insumo").removeClass("is-valid");
    $("#Unidad_Medida_Insumo").removeClass("is-invalid");
    $("#Precio_Insumo").removeClass("is-valid");
    $("#Precio_Insumo").removeClass("is-invalid");
    $("#Stock_Insumo").removeClass("is-valid");
    $("#Stock_Insumo").removeClass("is-invalid");
    $("#Estado_Insumo").removeClass("is-valid");
    $("#Estado_Insumo").removeClass("is-invalid");
    $("#Fecha_Vencimiento_Insumo").removeClass("is-valid");
    $("#Fecha_Vencimiento_Insumo").removeClass("is-invalid");
    $("#Imagen_Insumo_Input").removeClass("is-valid");
    $("#Imagen_Insumo_Input").removeClass("is-invalid");
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
  } else {
    if (data != null) {
      $("#Categoria_Insumo").removeClass("is-valid");
      $("#Categoria_Insumo").removeClass("is-invalid");
      $("#Proveedor_Insumo").removeClass("is-valid");
      $("#Proveedor_Insumo").removeClass("is-invalid");
      $("#Nombre_Insumo").removeClass("is-valid");
      $("#Nombre_Insumo").removeClass("is-invalid");
      $("#Descripcion_Insumo").removeClass("is-valid");
      $("#Descripcion_Insumo").removeClass("is-invalid");
      $("#Unidad_Medida_Insumo").removeClass("is-valid");
      $("#Unidad_Medida_Insumo").removeClass("is-invalid");
      $("#Precio_Insumo").removeClass("is-valid");
      $("#Precio_Insumo").removeClass("is-invalid");
      $("#Stock_Insumo").removeClass("is-valid");
      $("#Stock_Insumo").removeClass("is-invalid");
      $("#Estado_Insumo").removeClass("is-valid");
      $("#Estado_Insumo").removeClass("is-invalid");
      $("#Fecha_Vencimiento_Insumo").removeClass("is-valid");
      $("#Fecha_Vencimiento_Insumo").removeClass("is-invalid");
      $("#Imagen_Insumo_Input").removeClass("is-valid");
      $("#Imagen_Insumo_Input").removeClass("is-invalid");
      var fecha_Vencimiento_Insumo_SubString =
        data.fecha_Vencimiento_Insumo.substring(0, 10);
      if ($.trim(fecha_Vencimiento_Insumo_SubString).length == 10) {
        var Day = fecha_Vencimiento_Insumo_SubString.substring(0, 2);
        var Month = fecha_Vencimiento_Insumo_SubString.substring(3, 5);
        var Year = fecha_Vencimiento_Insumo_SubString.substring(6, 10);
        var Final_Date = Year + "-" + Month + "-" + Day;
      } else {
        if ($.trim(fecha_Vencimiento_Insumo_SubString).length == 9) {
          var Day = "0" + fecha_Vencimiento_Insumo_SubString.substring(0, 1);
          var Month = fecha_Vencimiento_Insumo_SubString.substring(2, 4);
          var Year = fecha_Vencimiento_Insumo_SubString.substring(5, 9);
          var Final_Date = Year + "-" + Month + "-" + Day;
        }
      }
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
  // console.log(data); // ? Good 'console.log'
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
        // ? url: "@Url.Action('Management_Controller_Insumo_Eliminar', 'Management')",
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

jQuery.validator.addMethod("Valid_Nombre_Insumo", function (value, element) {
  return (
    this.optional(element) ||
    /([a-zA-Z',.-]+( [a-zA-Z',.-]+)*){2,30}/.test(value)
  );
});

jQuery.validator.addMethod(
  "Valid_Unidad_Medida_Insumo",
  function (value, element) {
    return (
      this.optional(element) ||
      /([a-zA-Z',.-]+( [a-zA-Z',.-]+)*){2,30}/.test(value)
    );
  }
);

jQuery.validator.addMethod(
  "Valid_Descripcion_Insumo",
  function (value, element) {
    return (
      this.optional(element) ||
      /([a-zA-Z',.-]+( [a-zA-Z',.-]+)*){2,30}/.test(value)
    );
  }
);

$(document).ready(function () {
  $("#Form_Supply").validate({
    rules: {
      Estado_Insumo: {
        required: true,
      },
      Nombre_Insumo: {
        required: true,
        Valid_Nombre_Insumo: true,
      },
      Categoria_Insumo: {
        required: true,
      },
      Proveedor_Insumo: {
        required: true,
      },
      Unidad_Medida_Insumo: {
        required: true,
        Valid_Unidad_Medida_Insumo: true,
      },
      Precio_Insumo: {
        required: true,
        number: true,
      },
      Stock_Insumo: {
        required: true,
        number: true,
      },
      Fecha_Vencimiento_Insumo: {
        required: true,
      },
      Imagen_Insumo_Input: {
        required: true,
      },
      Descripcion_Insumo: {
        required: true,
        Valid_Descripcion_Insumo: true,
      },
    },
    messages: {
      Estado_Insumo: {
        required: "Campo Requerido: Estado del Insumo",
      },
      Nombre_Insumo: {
        required: "Campo Requerido: Nombre de Insumo",
        Valid_Nombre_Insumo: "Campo Requerido: Nombre de Insumo",
      },
      Categoria_Insumo: {
        required: "Campo Requerido: Categoría del Insumo",
      },
      Proveedor_Insumo: {
        required: "Campo Requerido: Proveedor del Insummo",
      },
      Unidad_Medida_Insumo: {
        required: "Campo Requerido: Unidad de Medida del Insumo",
        Valid_Unidad_Medida_Insumo:
          "Campo Requerido: Unidad de Medida del Insumo",
      },
      Precio_Insumo: {
        required: "Campo Requerido: Precio del Insumo",
        number: "Ingrese un Precio Válido",
      },
      Stock_Insumo: {
        required: "Campo Requerido: Stock del Insumo",
        number: "Ingrese un Stock Válido",
      },
      Fecha_Vencimiento_Insumo: {
        required: "Campo Requerido: Fecha de Vencimiento del Insumo",
      },
      Imagen_Insumo_Input: {
        required: "Campo Requerido: Imagen del Insumo",
      },
      Descripcion_Insumo: {
        required: "Campo Requerido: Descripción del Insumo",
        Valid_Descripcion_Insumo: "Campo Requerido: Descripción del Insumo",
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
  if (!$("#Form_Supply").valid()) {
    return;
  } else {
    var Imagen_Insumo_Input = $("#Imagen_Insumo_Input")[0].files[0];

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
      nombre_Insumo: $.trim($("#Nombre_Insumo").val()),
      descripcion_Insumo: $.trim($("#Descripcion_Insumo").val()),
      unidad_Medida_Insumo: $.trim($("#Unidad_Medida_Insumo").val()),
      precio_Insumo: $("#Precio_Insumo").val(),
      precio_Insumo_String: $("#Precio_Insumo").val(),
      stock_Insumo: $("#Stock_Insumo").val(),
      estado_Insumo: $("#Estado_Insumo").val() == "Available" ? true : false,
      fecha_Vencimiento_Insumo: $("#Fecha_Vencimiento_Insumo").val(),
    };

    if ($("#ID_Insumo").val() == 0) {
      var Request = new FormData();
      Request.append("Obj_Class_Entity_Insumo", JSON.stringify(Insumo));
      Request.append("Obj_IFormFile", Imagen_Insumo_Input);

      jQuery.ajax({
        // ? url: "@Url.Action('Management_Controller_Insumo_Registrar', 'Management')",
        url: "https://localhost:7050/Management/Management_Controller_Insumo_Registrar",
        type: "POST",
        data: Request,
        processData: false,
        contentType: false,
        success: function (data) {
          // debugger; // TODO: Punto de Depuración

          $(".modal-body").LoadingOverlay("hide");

          if (data.iD_Auto_Generated != 0) {
            Insumo.iD_Insumo = data.iD_Auto_Generated;
            Table_Insumo.row.add(Insumo).draw(false);
            $("#Form_Modal").modal("hide");
            // !!!
            window.location.reload();
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
      if ($("#ID_Insumo").val() != 0) {
        var Request = new FormData();
        Request.append("Obj_Class_Entity_Insumo", JSON.stringify(Insumo));
        Request.append("Obj_IFormFile", Imagen_Insumo_Input);

        jQuery.ajax({
          // ? url: "@Url.Action('Management_Controller_Insumo_Editar', 'Management')",
          url: "https://localhost:7050/Management/Management_Controller_Insumo_Editar",
          type: "PUT",
          data: Request,
          processData: false,
          contentType: false,
          success: function (data) {
            // debugger; // TODO: Punto de Depuración

            $(".modal-body").LoadingOverlay("hide");

            if (data.successful_operation) {
              Table_Insumo.row(Selected_Row).data(Insumo).draw(false);
              Selected_Row = null;
              $("#Form_Modal").modal("hide");
              // !!!
              window.location.reload();
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