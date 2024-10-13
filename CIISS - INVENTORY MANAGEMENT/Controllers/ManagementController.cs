using CIISS___INVENTORY_MANAGEMENT.Models;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
using ENTITY___LAYER;
using BUSINESS___LAYER;
using Newtonsoft.Json;
using System.Globalization;

namespace CIISS___INVENTORY_MANAGEMENT.Controllers
{
    public class ManagementController : Controller
    {
        private readonly ILogger<ManagementController> _logger;

        public ManagementController(ILogger<ManagementController> logger)
        {
            _logger = logger;
        }

        public IActionResult Category()
        {
            return View();
        }

        public IActionResult Supplier()
        {
            return View();
        }

        public IActionResult Supply()
        {
            return View();
        }

        //+++++++++++++++++++++++Http_Request_Methods_Categoria_Insumo+++++++++++++++++++++++//
        #region Http_Request_Methods_Categoria_Insumo
        [HttpGet]
        public JsonResult Management_Controller_Categoria_Insumo_Listar()
        {
            object data;

            data = new Class_Business_Categoria_Insumo().Class_Business_Categoria_Insumo_Listar();

            return Json(new { data = data });
        }

        [HttpPost]
        public JsonResult Management_Controller_Categoria_Insumo_Registrar(Class_Entity_Categoria_Insumo Obj_Class_Entity_Categoria_Insumo)
        {
            object result;
            string message = string.Empty;

            result = new Class_Business_Categoria_Insumo().Class_Business_Categoria_Insumo_Registrar(Obj_Class_Entity_Categoria_Insumo, out message);

            return Json(new { result = result, message = message });
        }

        [HttpPut]
        public JsonResult Management_Controller_Categoria_Insumo_Editar(Class_Entity_Categoria_Insumo Obj_Class_Entity_Categoria_Insumo)
        {
            object result;
            string message = string.Empty;

            result = new Class_Business_Categoria_Insumo().Class_Business_Categoria_Insumo_Editar(Obj_Class_Entity_Categoria_Insumo, out message);

            return Json(new { result = result, message = message });
        }

        [HttpDelete]
        public JsonResult Management_Controller_Categoria_Insumo_Eliminar(int ID_Categoria_Insumo)
        {
            bool result = false;
            string message = string.Empty;

            result = new Class_Business_Categoria_Insumo().Class_Business_Categoria_Insumo_Eliminar(ID_Categoria_Insumo, out message);

            return Json(new { result = result, message = message });
        }
        #endregion

        //+++++++++++++++++++++++Http_Request_Methods_Proveedor_Insumo+++++++++++++++++++++++//
        #region Http_Request_Methods_Proveedor_Insumo
        [HttpGet]
        public JsonResult Management_Controller_Proveedor_Insumo_Listar()
        {
            object data;

            data = new Class_Business_Proveedor_Insumo().Class_Business_Proveedor_Insumo_Listar();

            return Json(new { data = data });
        }

        [HttpPost]
        public JsonResult Management_Controller_Proveedor_Insumo_Registrar(Class_Entity_Proveedor_Insumo Obj_Class_Entity_Proveedor_Insumo)
        {
            object result;
            string message = string.Empty;

            result = new Class_Business_Proveedor_Insumo().Class_Business_Proveedor_Insumo_Registrar(Obj_Class_Entity_Proveedor_Insumo, out message);

            return Json(new { result = result, message = message });
        }

        [HttpPut]
        public JsonResult Management_Controller_Proveedor_Insumo_Editar(Class_Entity_Proveedor_Insumo Obj_Class_Entity_Proveedor_Insumo)
        {
            object result;
            string message = string.Empty;

            result = new Class_Business_Proveedor_Insumo().Class_Business_Proveedor_Insumo_Editar(Obj_Class_Entity_Proveedor_Insumo, out message);

            return Json(new { result = result, message = message });
        }

        [HttpDelete]
        public JsonResult Management_Controller_Proveedor_Insumo_Eliminar(int ID_Proveedor_Insumo)
        {
            bool result = false;
            string message = string.Empty;

            result = new Class_Business_Proveedor_Insumo().Class_Business_Proveedor_Insumo_Eliminar(ID_Proveedor_Insumo, out message);

            return Json(new { result = result, message = message });
        }
        #endregion

        //+++++++++++++++++++++++Http_Request_Methods_Insumo+++++++++++++++++++++++//
        #region Http_Request_Methods_Insumo
        [HttpGet]
        public JsonResult Management_Controller_Insumo_Listar()
        {
            object data;

            data = new Class_Business_Insumo().Class_Business_Insumo_Listar();

            return Json(new { data = data });
        }

        [HttpPost]
        public JsonResult Management_Controller_Insumo_Registrar(string Obj_Class_Entity_Insumo, IFormFile Obj_IFormFile)
        {
            string message = string.Empty;
            bool successful_operation = true;
            bool successful_save_image = true;

            Class_Entity_Insumo Obj_Class_Entity_Insumo_Alter = new Class_Entity_Insumo();
            Obj_Class_Entity_Insumo_Alter = JsonConvert.DeserializeObject<Class_Entity_Insumo>(Obj_Class_Entity_Insumo);

            // **

            decimal Precio_Insumo;

            if (decimal.TryParse(Obj_Class_Entity_Insumo_Alter.Precio_Insumo_String, NumberStyles.AllowDecimalPoint, new CultureInfo("es-PE"), out Precio_Insumo))
            {
                Obj_Class_Entity_Insumo_Alter.Precio_Insumo = Precio_Insumo;
            }
            else
            {
                return Json(new { successful_operation = false, message = "El Formato Numérico del Precio del Insumo debe ser ##.##" });
            }

            // **

            int ID_Auto_Generated = new Class_Business_Insumo().Class_Business_Insumo_Registrar(Obj_Class_Entity_Insumo_Alter, out message);

            if (ID_Auto_Generated != 0)
            {
                Obj_Class_Entity_Insumo_Alter.ID_Insumo = ID_Auto_Generated;
            }
            else
            {
                successful_operation = false;
            }

            if (successful_operation)
            {
                if (Obj_IFormFile != null)
                {
                    string Ruta_Imagen_Insumo = "C:\\Users\\HP\\Documentos\\CIISS - INVENTORY MANAGEMENT\\CIISS - INVENTORY MANAGEMENT\\CIISS - INVENTORY MANAGEMENT\\wwwroot\\Supply_Images";
                    string Extension_Imagen_Insumo = Path.GetExtension(Obj_IFormFile.FileName);
                    string Nombre_Imagen_Insumo = string.Concat(Obj_Class_Entity_Insumo_Alter.ID_Insumo.ToString(), Extension_Imagen_Insumo);

                    try
                    {
                        string FileNameWithPath = Path.Combine(Ruta_Imagen_Insumo, Nombre_Imagen_Insumo);
                        using (var stream = new FileStream(FileNameWithPath, FileMode.Create))
                        {
                            Obj_IFormFile.CopyTo(stream);
                        }
                    }
                    catch (Exception Error)
                    {
                        string Message = Error.Message;
                        successful_save_image = false;
                    }

                    if (successful_save_image)
                    {
                        Obj_Class_Entity_Insumo_Alter.Ruta_Imagen_Insumo = Ruta_Imagen_Insumo;
                        Obj_Class_Entity_Insumo_Alter.Nombre_Imagen_Insumo = Nombre_Imagen_Insumo;
                        bool Answer = new Class_Business_Insumo().Class_Business_Insumo_Registrar_Imagen(Obj_Class_Entity_Insumo_Alter, out message);
                    }
                    else
                    {
                        message = "El Registro de los Datos del Insumo se Realizó Exitosamente, sin Embargo, hubo Problemas al Registrar la Imagen del Insumo";
                    }
                }
            }
            return Json(new { successful_operation = successful_operation, iD_Auto_Generated = Obj_Class_Entity_Insumo_Alter.ID_Insumo, message = message });
        }

        [HttpPut]
        public JsonResult Management_Controller_Insumo_Editar(string Obj_Class_Entity_Insumo, IFormFile Obj_IFormFile)
        {
            string message = string.Empty;
            bool successful_operation = true;
            bool successful_save_image = true;

            Class_Entity_Insumo Obj_Class_Entity_Insumo_Alter = new Class_Entity_Insumo();
            Obj_Class_Entity_Insumo_Alter = JsonConvert.DeserializeObject<Class_Entity_Insumo>(Obj_Class_Entity_Insumo);

            // **

            decimal Precio_Insumo;

            if (decimal.TryParse(Obj_Class_Entity_Insumo_Alter.Precio_Insumo_String, NumberStyles.AllowDecimalPoint, new CultureInfo("es-PE"), out Precio_Insumo))
            {
                Obj_Class_Entity_Insumo_Alter.Precio_Insumo = Precio_Insumo;
            }
            else
            {
                return Json(new { successful_operation = false, message = "El Formato Numérico del Precio del Insumo debe ser ##.##" });
            }

            // **

            successful_operation = new Class_Business_Insumo().Class_Business_Insumo_Editar(Obj_Class_Entity_Insumo_Alter, out message);

            if (successful_operation)
            {
                if (Obj_IFormFile != null)
                {
                    string Ruta_Imagen_Insumo = "C:\\Users\\HP\\Documentos\\CIISS - INVENTORY MANAGEMENT\\CIISS - INVENTORY MANAGEMENT\\CIISS - INVENTORY MANAGEMENT\\wwwroot\\Supply_Images";
                    string Extension_Imagen_Insumo = Path.GetExtension(Obj_IFormFile.FileName);
                    string Nombre_Imagen_Insumo = string.Concat(Obj_Class_Entity_Insumo_Alter.ID_Insumo.ToString(), Extension_Imagen_Insumo);

                    try
                    {
                        string FileNameWithPath = Path.Combine(Ruta_Imagen_Insumo, Nombre_Imagen_Insumo);
                        using (var stream = new FileStream(FileNameWithPath, FileMode.Create))
                        {
                            Obj_IFormFile.CopyTo(stream);
                        }
                    }
                    catch (Exception Error)
                    {
                        string Message = Error.Message;
                        successful_save_image = false;
                    }

                    if (successful_save_image)
                    {
                        Obj_Class_Entity_Insumo_Alter.Ruta_Imagen_Insumo = Ruta_Imagen_Insumo;
                        Obj_Class_Entity_Insumo_Alter.Nombre_Imagen_Insumo = Nombre_Imagen_Insumo;
                        bool Answer = new Class_Business_Insumo().Class_Business_Insumo_Registrar_Imagen(Obj_Class_Entity_Insumo_Alter, out message);
                    }
                    else
                    {
                        message = "La Actualización de los Datos del Insumo se Realizó Exitosamente, sin Embargo, hubo Problemas al Actualizar la Imagen del Insumo";
                    }
                }
            }
            return Json(new { successful_operation = successful_operation, iD_Auto_Generated = Obj_Class_Entity_Insumo_Alter.ID_Insumo, message = message });
        }

        [HttpGet]
        public JsonResult Management_Controller_Insumo_Imagen(int ID_Insumo)
        {
            bool conversion;
            Class_Entity_Insumo Obj_Class_Entity_Insumo = new Class_Business_Insumo().Class_Business_Insumo_Listar().Where(Obj_Class_Entity_Insumo_Alter => Obj_Class_Entity_Insumo_Alter.ID_Insumo == ID_Insumo).FirstOrDefault();
            string Base_64_Imagen_Insumo = Class_Business_Recurso.Convert_Base_64(Path.Combine(Obj_Class_Entity_Insumo.Ruta_Imagen_Insumo, Obj_Class_Entity_Insumo.Nombre_Imagen_Insumo), out conversion);
            return Json(new { conversion = conversion, base_64_Imagen_Insumo = Base_64_Imagen_Insumo, extension_Imagen_Insumo = Path.GetExtension(Obj_Class_Entity_Insumo.Nombre_Imagen_Insumo) });
        }

        [HttpDelete]
        public JsonResult Management_Controller_Insumo_Eliminar(int ID_Insumo)
        {
            bool result = false;
            string message = string.Empty;

            result = new Class_Business_Insumo().Class_Business_Insumo_Eliminar(ID_Insumo, out message);

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