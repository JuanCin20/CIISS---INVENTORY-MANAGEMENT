using Microsoft.AspNetCore.Mvc;
using ENTITY___LAYER;
using BUSINESS___LAYER;

namespace CIISS___INVENTORY_MANAGEMENT.Controllers
{
    public class AccessController : Controller
    {
        private readonly ILogger<AccessController> _logger;

        public AccessController(ILogger<AccessController> logger)
        {
            _logger = logger;
        }

        public IActionResult Log_In()
        {
            return View();
        }

        public IActionResult Change_Password()
        {
            return View();
        }

        public IActionResult Reset_Password()
        {
            return View();
        }

        [HttpGet]
        public ActionResult Access_Controller_Log_In(string E_Mail_Usuario, string Password_Usuario)
        {
            Class_Entity_Usuario Obj_Class_Entity_Usuario = new Class_Entity_Usuario();

            Obj_Class_Entity_Usuario = new Class_Business_Usuario().Class_Business_Usuario_Listar().Where(Obj_Class_Entity_Usuario_Alter => Obj_Class_Entity_Usuario_Alter.E_Mail_Usuario == E_Mail_Usuario && Obj_Class_Entity_Usuario_Alter.Password_Usuario == Class_Business_Recurso.Convert_SHA_256(Password_Usuario)).FirstOrDefault();

            if (Obj_Class_Entity_Usuario == null)
            {
                ViewBag.Error = "Correo o Contraseña Incorrecta";
                return View();
            }
            else
            {
                ViewBag.Error = null;
                return RedirectToAction("Index", "Home");
            }
        }
    }
}