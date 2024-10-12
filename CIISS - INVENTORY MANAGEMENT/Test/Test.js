// $(document).ready(function () {
//   $(".Button_Pop")
//     .popover({ trigger: "manual", html: true, animation: true })
//     .on("mouseenter", function () {
//       var _this = this;
//       $(this).popover("show");
//       $(".popover").on("mouseleave", function () {
//         $(_this).popover("hide");
//       });
//     })
//     .on("mouseleave", function () {
//       var _this = this;
//       setTimeout(function () {
//         if (!$(".popover:hover").length) {
//           $(_this).popover("hide");
//         }
//       }, 300);
//     });
// });

// $(document).ready(function () {
//   $("[data-bs-toggle='popover']").popover();
// });

// $(document).ready(function () {
//   $(".Button_Pop").popover({
//     trigger: "hover focus",
//     animation: true,
//   });
// });

// const popoverTriggerList = document.querySelectorAll(
//   "[data-bs-toggle='popover']"
// );
// const popoverList = [...popoverTriggerList].map(
//   (popoverTriggerEl) => new bootstrap.Popover(popoverTriggerEl)
// );

// const popover = new bootstrap.Popover(".Button_Pop", {
//   trigger: "hover focus",
//   animation: true,
// });
