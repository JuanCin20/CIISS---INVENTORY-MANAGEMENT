var Table_Usuario;
var Selected_Row;

function Show_User_Image(input) {
  if (input.files) {
    var Reader = new FileReader();
    Reader.onload = function (event) {
      $("#Imagen_Usuario").attr("src", event.target.result);
    };
    Reader.readAsDataURL(input.files[0]);
  }
}

/**
 * *jQuery.ajax({
 * *    url: "https://localhost:7050/Staff/Staff_Controller_Usuario_Listar",
 * *    type: "GET",
 * *    dataType: "json",
 * *    contentType: "application/json; charset=UTF-8",
 * *    success: function (data) {
 * *        console.log(data); // ? Good 'console.log'
 * *    }
 * *});
 */
Table_Usuario = $("#Table_Usuario").DataTable({
  responsive: true,
  ordering: false,
  language: {
    url: "//cdn.datatables.net/plug-ins/2.1.8/i18n/es-MX.json",
  },
  ajax: {
    url: "https://localhost:7050/Staff/Staff_Controller_Usuario_Listar",
    type: "GET",
    dataType: "json",
  },
  columns: [
    { data: "iD_Usuario" },
    // ! {"data": "object_ID_Tipo_Usuario.nombre_Tipo_Usuario"},
    {
      data: "object_ID_Tipo_Usuario.nombre_Tipo_Usuario",
      render: function (nombre_Tipo_Usuario) {
        if (nombre_Tipo_Usuario == "Administrador") {
          return '<span class="badge text-bg-success">Administrador</span>';
        } else {
          if (nombre_Tipo_Usuario == "Empleado") {
            return '<span class="badge text-bg-danger">Empleado</span>';
          }
        }
      },
    },
    { data: "nombre_Usuario" },
    { data: "apellido_Usuario" },
    { data: "e_Mail_Usuario" },
    {
      data: null,
      render: function (data, type, row) {
        return (
          '<img style="width: 60px; height: 60px;" src="../../User_Images/' +
          row.nombre_Imagen_Usuario +
          '" alt="Image_Error" class="border rounded img-fluid">'
        );
      },
    },
    {
      defaultContent:
        '<button type="button" class="btn btn-primary btn-sm Edit_Button"><i class="fa-solid fa-pencil"></i></button>' +
        '<button type="button" class="btn btn-danger btn-sm ms-2 Delete_Button"><i class="fa-solid fa-trash"></i></i></button>',
      orderable: false,
      searchable: false,
      width: "90px",
    },
  ],
});

function Open_Form_Modal(data) {
  if (data == null) {
    $("#ID_Usuario").val(0);
    $("#Nombre_Usuario").val("");
    $("#Apellido_Usuario").val("");
    $("#E_Mail_Usuario").val("");
    $("#Rol_Usuario").val(0);
    $("#Imagen_Usuario").val("");
  } else {
    if (data != null) {
      $("#ID_Usuario").val(data.iD_Usuario);
      $("#Nombre_Usuario").val(data.nombre_Usuario);
      $("#Apellido_Usuario").val(data.apellido_Usuario);
      $("#E_Mail_Usuario").val(data.e_Mail_Usuario);
      $("#Rol_Usuario").val(
        data.object_ID_Tipo_Usuario.nombre_Tipo_Usuario == "Administrador"
          ? "Administrador"
          : "Empleado"
      );
      $("#Imagen_Usuario").val(data.imagen_Usuario);
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

$("#Table_Usuario").on("click", ".Edit_Button", function () {
  Selected_Row = Selected_Row_Function(this);
  var data = Table_Usuario.row(Selected_Row).data();
  // console.log(data); // ? Good 'console.log'
  Open_Form_Modal(data);
});

$("#Table_Usuario").on("click", ".Delete_Button", function () {
  Selected_Row = Selected_Row_Function(this);
  var data = Table_Usuario.row(Selected_Row).data();
  Swal.fire({
    title: "Confirmación",
    text: "¿Desea Eliminar al Usuario Seleccionado?",
    icon: "warning",
    showCancelButton: true,
    cancelButtonText: "Cancelar",
    cancelButtonColor: "#FF0000",
    confirmButtonText: "Eliminar",
    confirmButtonColor: "#3085D6",
  }).then((result) => {
    if (result.isConfirmed) {
      jQuery.ajax({
        url: "https://localhost:7050/Staff/Staff_Controller_Usuario_Eliminar",
        type: "DELETE",
        data: { ID_Usuario: data.iD_Usuario },
        success: function (data) {
          // debugger; // TODO: Punto de Depuración

          if (data.result) {
            Swal.fire({
              title: "Correcto",
              text: "El Usuario ha sido Eliminado",
              icon: "success",
            });
            Table_Usuario.row(Selected_Row).remove().draw();
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
  var Selected_Image = $("#Imagen_Usuario_Input")[0].files[0];

  var Usuario = {
    iD_Usuario: $("#ID_Usuario").val(),
    nombre_Usuario: $("#Nombre_Usuario").val(),
    apellido_Usuario: $("#Apellido_Usuario").val(),
    e_Mail_Usuario: $("#E_Mail_Usuario").val(),
    object_ID_Tipo_Usuario: {
      id_Tipo_Usuario: $("#Rol_Usuario").val() == "Administrador" ? 1 : 2,
      nombre_Tipo_Usuario: $("#Rol_Usuario").val(),
    },
    imagen_Usuario: $("#Imagen_Usuario").val(),
  };

  if ($("#ID_Usuario").val() == 0) {
    var Request = new FormData();
    Request.append("Obj_Class_Entity_Usuario", JSON.stringify(Usuario));
    Request.append("Obj_IFormFile", Selected_Image);

    jQuery.ajax({
      url: "https://localhost:7050/Staff/Staff_Controller_Usuario_Registrar",
      type: "POST",
      data: Request,
      processData: false,
      contentType: false,
      success: function (data) {
        debugger; // TODO: Punto de Depuración

        $(".modal-body").LoadingOverlay("hide");

        if (data.iD_Auto_Generated != 0) {
          Usuario.iD_Usuario = data.iD_Auto_Generated;
          Table_Usuario.row.add(Usuario).draw(false);
          $("#Form_Modal").modal("hide");
          window.location.reload(); // ?
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
    if ($("#ID_Usuario").val() != 0) {
      var Request = new FormData();
      Request.append("Obj_Class_Entity_Usuario", JSON.stringify(Usuario));
      Request.append("Obj_IFormFile", Selected_Image);

      jQuery.ajax({
        url: "https://localhost:7050/Staff/Staff_Controller_Usuario_Editar",
        type: "PUT",
        data: Request,
        processData: false,
        contentType: false,
        success: function (data) {
          // debugger; // TODO: Punto de Depuración

          $(".modal-body").LoadingOverlay("hide");

          if (data.successful_operation) {
            Table_Usuario.row(Selected_Row).data(Usuario).draw(false);
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