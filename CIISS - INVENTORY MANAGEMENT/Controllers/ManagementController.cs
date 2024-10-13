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

            Class_Entity_Insumo obj_class_entity_insumo_alter = new Class_Entity_Insumo();
            obj_class_entity_insumo_alter = JsonConvert.DeserializeObject<Class_Entity_Insumo>(Obj_Class_Entity_Insumo);

            decimal Precio_Insumo;

            if (decimal.TryParse(obj_class_entity_insumo_alter.Precio_Insumo_String, NumberStyles.AllowDecimalPoint, new CultureInfo("es-PE"), out Precio_Insumo))
            {
                obj_class_entity_insumo_alter.Precio_Insumo = Precio_Insumo;
            }
            else
            {
                return Json(new { successful_operation = false, message = "El Formato Numérico del Precio del Insumo debe ser ##.##" });
            }

            int id_insumo_generated = new Class_Business_Insumo().Class_Business_Insumo_Registrar(obj_class_entity_insumo_alter, out message);

            if (id_insumo_generated != 0)
            {
                obj_class_entity_insumo_alter.ID_Insumo = id_insumo_generated;
            }
            else
            {
                successful_operation = false;
            }

            if (successful_operation)
            {
                if (Obj_IFormFile != null)
                {
                    string Ruta_Imagen_Insumo = "C:\\Users\\HP\\Documentos\\CIISS - INVENTORY MANAGEMENT\\CIISS - INVENTORY MANAGEMENT\\CIISS - INVENTORY MANAGEMENT\\Images";
                    string Image_Extension = Path.GetExtension(Obj_IFormFile.FileName);
                    string Nombre_Imagen_Insumo = string.Concat(obj_class_entity_insumo_alter.ID_Insumo.ToString(), Image_Extension);

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
                        obj_class_entity_insumo_alter.Ruta_Imagen_Insumo = Ruta_Imagen_Insumo;
                        obj_class_entity_insumo_alter.Nombre_Imagen_Insumo = Nombre_Imagen_Insumo;
                        bool Answer = new Class_Business_Insumo().Class_Business_Insumo_Registrar_Imagen(obj_class_entity_insumo_alter, out message);
                    }
                    else
                    {
                        message = "El Registro del Insumo se Realizó Exitosamente, sin Embargo, hubo Problemas al Registrar la Imagen del Insumo";
                    }
                }
            }
            return Json(new { successful_operation = successful_operation, id_insumo_generated = obj_class_entity_insumo_alter.ID_Insumo, message = message });
        }

        [HttpPut]
        public JsonResult Management_Controller_Insumo_Editar(string Obj_Class_Entity_Insumo, IFormFile Obj_IFormFile)
        {
            string message = string.Empty;
            bool Successful_Operation = true;
            bool Successful_Save_Image = true;

            Class_Entity_Insumo Obj_Class_Entity_Insumo_Alter = new Class_Entity_Insumo();
            Obj_Class_Entity_Insumo_Alter = JsonConvert.DeserializeObject<Class_Entity_Insumo>(Obj_Class_Entity_Insumo);

            decimal Precio_Insumo;

            if (decimal.TryParse(Obj_Class_Entity_Insumo_Alter.Precio_Insumo_String, NumberStyles.AllowDecimalPoint, new CultureInfo("es-PE"), out Precio_Insumo))
            {
                Obj_Class_Entity_Insumo_Alter.Precio_Insumo = Precio_Insumo;
            }
            else
            {
                return Json(new { Successful_Operation = false, message = "El Formato Numérico del Precio del Insumo debe ser ##.##" });
            }

            Successful_Operation = new Class_Business_Insumo().Class_Business_Insumo_Editar(Obj_Class_Entity_Insumo_Alter, out message);

            if (Successful_Operation)
            {
                if (Obj_IFormFile != null)
                {
                    string Ruta_Imagen_Insumo = "C:\\Users\\HP\\Documentos\\CIISS - INVENTORY MANAGEMENT\\CIISS - INVENTORY MANAGEMENT\\CIISS - INVENTORY MANAGEMENT\\Images";
                    string Image_Extension = Path.GetExtension(Obj_IFormFile.FileName);
                    string Nombre_Imagen_Insumo = string.Concat(Obj_Class_Entity_Insumo_Alter.ID_Insumo.ToString(), Image_Extension);

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
                        Successful_Save_Image = false;
                    }

                    if (Successful_Save_Image)
                    {
                        Obj_Class_Entity_Insumo_Alter.Ruta_Imagen_Insumo = Ruta_Imagen_Insumo;
                        Obj_Class_Entity_Insumo_Alter.Nombre_Imagen_Insumo = Nombre_Imagen_Insumo;
                        bool Answer = new Class_Business_Insumo().Class_Business_Insumo_Registrar_Imagen(Obj_Class_Entity_Insumo_Alter, out message);
                    }
                    else
                    {
                        message = "El Registro del Insumo se Realizó Exitosamente, sin Embargo, hubo Problemas al Registrar la Imagen del Insumo";
                    }
                }
            }
            return Json(new { Successful_Operation = Successful_Operation, ID_Insumo_Generated = Obj_Class_Entity_Insumo_Alter.ID_Insumo, message = message });
        }

        [HttpGet]
        public JsonResult Imagen_Insumo(int ID_Insumo)
        {
            bool Conversion;
            Class_Entity_Insumo Obj_Class_Entity_Insumo = new Class_Business_Insumo().Class_Business_Insumo_Listar().Where(Obj_Class_Entity_Insumo_Alter => Obj_Class_Entity_Insumo_Alter.ID_Insumo == ID_Insumo).FirstOrDefault();
            string Base64_String = Class_Business_Recurso.Conversion_Base64(Path.Combine(Obj_Class_Entity_Insumo.Ruta_Imagen_Insumo, Obj_Class_Entity_Insumo.Nombre_Imagen_Insumo), out Conversion);
            return Json(new { Conversion = Conversion, Base64_String = Base64_String, Image_Extension = Path.GetExtension(Obj_Class_Entity_Insumo.Nombre_Imagen_Insumo) });
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