jQuery.validator.addMethod("Valid_E_Mail_Usuario", function (value, element) {
    return (
        this.optional(element) || /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/.test(value)
    );
});

$(document).ready(function () {
    $("#Form_Reset_Password").validate({
        rules: {
            E_Mail_Usuario: {
                required: true,
                Valid_E_Mail_Usuario: true,
            },
        },
        messages: {
            E_Mail_Usuario: {
                required: "Campo Requerido: Correo Electrónico del Usuario",
                Valid_E_Mail_Usuario: "Ingrese un Correo Electrónico Válido",
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