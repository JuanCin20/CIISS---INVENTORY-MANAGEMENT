using CIISS___INVENTORY_MANAGEMENT.Models;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
using ENTITY___LAYER;
using BUSINESS___LAYER;
using Newtonsoft.Json;
using System.Globalization;

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
        public JsonResult See_Dashboard()
        {
            Class_Entity_Dashboard Obj_Class_Entity_Dashboard = new Class_Business_Dashboard().Class_Business_See_Dashboard();

            return Json(new { result = Obj_Class_Entity_Dashboard });
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}