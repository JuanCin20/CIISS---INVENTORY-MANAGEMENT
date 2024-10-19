using CIISS___INVENTORY_MANAGEMENT.Models;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
using ENTITY___LAYER;
using BUSINESS___LAYER;
using System.Data;
using ClosedXML.Excel;
using Microsoft.AspNetCore.Authorization;

namespace CIISS___INVENTORY_MANAGEMENT.Controllers
{
    // [Authorize]
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

        public IActionResult Index()
        {
            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [HttpGet]
        public JsonResult Home_Controller_Dashboard_Listar(string Initial_Fecha_Movimiento_Inventario, string Final_Fecha_Movimiento_Inventario, int ID_Movimiento_Inventario)
        {
            object data;

            data = new Class_Business_Dashboard().Class_Business_Dashboard_Listar(Initial_Fecha_Movimiento_Inventario, Final_Fecha_Movimiento_Inventario, ID_Movimiento_Inventario);

            return Json(new { data = data });
        }

        [HttpGet]
        public JsonResult Home_Controller_Dashboard_Card()
        {
            Class_Entity_Dashboard Obj_Class_Entity_Dashboard = new Class_Business_Dashboard().Class_Business_Dashboard_Card();

            return Json(new { result = Obj_Class_Entity_Dashboard });
        }

        [HttpPost]
        public FileResult Home_Controller_Dashboard_Export(string Initial_Fecha_Movimiento_Inventario, string Final_Fecha_Movimiento_Inventario, int ID_Movimiento_Inventario)
        {
            List<Class_Entity_Dashboard> Obj_List = new List<Class_Entity_Dashboard>();
            Obj_List = new Class_Business_Dashboard().Class_Business_Dashboard_Listar(Initial_Fecha_Movimiento_Inventario, Final_Fecha_Movimiento_Inventario, ID_Movimiento_Inventario);
            DataTable Obj_DataTable = new DataTable();

            Obj_DataTable.Locale = new System.Globalization.CultureInfo("es-PE");
            Obj_DataTable.Columns.Add("ID_Movimiento_Inventario", typeof(int));
            Obj_DataTable.Columns.Add("Tipo_Movimiento_Inventario", typeof(string));
            Obj_DataTable.Columns.Add("Nombre_Insumo", typeof(string));
            Obj_DataTable.Columns.Add("Cantidad_Movimiento_Inventario", typeof(int));
            Obj_DataTable.Columns.Add("Precio_Insumo", typeof(decimal));
            Obj_DataTable.Columns.Add("Total_Transaction", typeof(decimal));
            Obj_DataTable.Columns.Add("Fecha_Movimiento_Inventario", typeof(string));
            Obj_DataTable.Columns.Add("Usuario_Transaction", typeof(string));

            foreach (Class_Entity_Dashboard Obj_Class_Entity_Dashboard in Obj_List)
            {
                Obj_DataTable.Rows.Add(new object[] {
                Obj_Class_Entity_Dashboard.ID_Movimiento_Inventario,
                Obj_Class_Entity_Dashboard.Tipo_Movimiento_Inventario,
                Obj_Class_Entity_Dashboard.Nombre_Insumo,
                Obj_Class_Entity_Dashboard.Cantidad_Movimiento_Inventario,
                Obj_Class_Entity_Dashboard.Precio_Insumo,
                Obj_Class_Entity_Dashboard.Total_Transaction,
                Obj_Class_Entity_Dashboard.Fecha_Movimiento_Inventario,
                Obj_Class_Entity_Dashboard.Usuario_Transaction,
            });
            }

            Obj_DataTable.TableName = "Data";

            using (XLWorkbook Obj_XLWorkbook = new XLWorkbook())
            {
                Obj_XLWorkbook.Worksheets.Add(Obj_DataTable);
                using (MemoryStream Obj_MemoryStream = new MemoryStream())
                {
                    Obj_XLWorkbook.SaveAs(Obj_MemoryStream);
                    return File(Obj_MemoryStream.ToArray(), "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "Report - " + DateTime.Now.ToString() + ".xlsx");
                }
            }
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}