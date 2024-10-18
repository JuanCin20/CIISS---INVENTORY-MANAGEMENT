using CIISS___INVENTORY_MANAGEMENT.Models;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
using ENTITY___LAYER;
using BUSINESS___LAYER;

namespace CIISS___INVENTORY_MANAGEMENT.Controllers
{
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
        public JsonResult Home_Controller_Dashboard_Listar(string Initial_Fecha_Movimiento_Inventario, string Final_Fecha_Movimiento_Inventario, string ID_Movimiento_Inventario)
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

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}