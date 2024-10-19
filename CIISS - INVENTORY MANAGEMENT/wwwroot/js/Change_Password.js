$(document).ready(function () {
    $("#Form_Change_Password").validate({
        rules: {
            Password_Usuario: {
                required: true,
                minlength: 5,
            },
            Password_Usuario_01: {
                required: true,
                minlength: 5,
            },
            Password_Usuario_02: {
                required: true,
                minlength: 5,
                equalTo: "#Password_Usuario_01",
            },
        },
        messages: {
            Password_Usuario: {
                required: "Campo Requerido: Contraseña del Usuario",
                minlength:
                    "La Contraseña del Usuario debe Contener un Mínimo de 5 Caracteres",
            },
            Password_Usuario_01: {
                required: "Campo Requerido: Nueva Contraseña del Usuario",
                minlength: "La Nueva Contraseña del Usuario debe Contener un Mínimo de 5 Caracteres",
            },
            Password_Usuario_02: {
                required: "Campo Requerido: Nueva Contraseña del Usuario",
                minlength: "La Nueva Contraseña del Usuario debe Contener un Mínimo de 5 Caracteres",
                equalTo: "Las Nuevas Contraseñas Deben Coindicir",
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