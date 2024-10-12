using CIISS___INVENTORY_MANAGEMENT.Models;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
using ENTITY___LAYER;
using BUSINESS___LAYER;

namespace CIISS___INVENTORY_MANAGEMENT.Controllers
{
    public class StaffController : Controller
    {
        private readonly ILogger<StaffController> _logger;

        public StaffController(ILogger<StaffController> logger)
        {
            _logger = logger;
        }

        public IActionResult User()
        {
            return View();
        }

        //+++++++++++++++++++++++Http_Request_Methods_Usuario+++++++++++++++++++++++//
        #region Http_Request_Methods_Usuario
        [HttpGet]
        public JsonResult Staff_Controller_Usuario_Listar()
        {
            object data;

            data = new Class_Business_Usuario().Class_Business_Usuario_Listar();

            return Json(new { data = data });
        }

        [HttpPost]
        public JsonResult Staff_Controller_Usuario_Registrar(Class_Entity_Usuario Obj_Class_Entity_Usuario)
        {
            object result;
            string message = string.Empty;

            result = new Class_Business_Usuario().Class_Business_Usuario_Registrar(Obj_Class_Entity_Usuario, out message);

            return Json(new { result = result, message = message });
        }

        [HttpPut]
        public JsonResult Staff_Controller_Usuario_Editar(Class_Entity_Usuario Obj_Class_Entity_Usuario)
        {
            object result;
            string message = string.Empty;

            result = new Class_Business_Usuario().Class_Business_Usuario_Editar(Obj_Class_Entity_Usuario, out message);

            return Json(new { result = result, message = message });
        }

        [HttpDelete]
        public JsonResult Staff_Controller_Usuario_Eliminar(int ID_Usuario)
        {
            bool result = false;
            string message = string.Empty;

            result = new Class_Business_Usuario().Class_Business_Usuario_Eliminar(ID_Usuario, out message);

            return Json(new { result = result, message = message });
        }
        #endregion

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}