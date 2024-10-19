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
                ViewBag.Error = "Verifique sus Credenciales";
                return View("Log_In", "Access");
            }
            else
            {
                if (Obj_Class_Entity_Usuario.Reestablecer_Password_Usuario)
                {
                    TempData["ID_Usuario"] = Obj_Class_Entity_Usuario.ID_Usuario;
                    ViewBag.Error = null;
                    return View("Change_Password", "Access");
                }
                else
                {
                    // FormsAuthentication.SetAuthCookie(Obj_Class_Entity_Usuario.E_Mail_Usuario, false);
                    ViewBag.Error = null;
                    return RedirectToAction("Index", "Home");
                }
            }
        }

        [HttpPost]
        public ActionResult Access_Controller_Change_Password(int ID_Usuario, string Password_Usuario, string Password_Usuario_01, string Password_Usuario_02)
        {
            Class_Entity_Usuario Obj_Class_Entity_Usuario = new Class_Entity_Usuario();

            Obj_Class_Entity_Usuario = new Class_Business_Usuario().Class_Business_Usuario_Listar().Where(Obj_Class_Entity_Usuario_Alter => Obj_Class_Entity_Usuario_Alter.ID_Usuario == ID_Usuario).FirstOrDefault();

            if (Obj_Class_Entity_Usuario.Password_Usuario != Class_Business_Recurso.Convert_SHA_256(Password_Usuario))
            {
                TempData["ID_Usuario"] = ID_Usuario;
                ViewBag.Error = "La Contraseña Actual es Incorrecta";
                return View("Change_Password", "Access");
            }

            Password_Usuario_01 = Class_Business_Recurso.Convert_SHA_256(Password_Usuario_01);

            string Message = string.Empty;

            bool Answer = new Class_Business_Usuario().Class_Business_Usuario_Change_Password(ID_Usuario, Password_Usuario_01, out Message);

            if (Answer)
            {
                ViewBag.Error = null;
                return RedirectToAction("Log_In", "Access");
            }
            else
            {
                TempData["ID_Usuario"] = ID_Usuario;
                ViewBag.Error = Message;
                return View("Change_Password", "Access");
            }
        }

        [HttpPost]
        public ActionResult Access_Controller_Reset_Password(string E_Mail_Usuario)
        {
            Class_Entity_Usuario Obj_Class_Entity_Usuario = new Class_Entity_Usuario();

            Obj_Class_Entity_Usuario = new Class_Business_Usuario().Class_Business_Usuario_Listar().Where(Obj_Class_Entity_Usuario_Alter => Obj_Class_Entity_Usuario_Alter.E_Mail_Usuario == E_Mail_Usuario).FirstOrDefault();

            if (Obj_Class_Entity_Usuario == null)
            {
                ViewBag.Error = "No se Encontró a un Usuario Relacionado con este Correo";
                return View("Reset_Password", "Access");
            }

            string Message = string.Empty;
            bool Answer = new Class_Business_Usuario().Class_Business_Usuario_Reset_Password(Obj_Class_Entity_Usuario.ID_Usuario, E_Mail_Usuario, out Message);

            if (Answer)
            {
                ViewBag.Error = null;
                return RedirectToAction("Log_In", "Access");
            }
            else
            {
                ViewBag.Error = Message;
                return View("Reset_Password", "Access");
            }
        }

        public ActionResult Access_Controller_Log_Out()
        {
            return RedirectToAction("Log_In", "Access");
        }
    }
}