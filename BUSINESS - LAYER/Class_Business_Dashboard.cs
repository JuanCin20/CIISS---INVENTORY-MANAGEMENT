using System.Collections.Generic;
using DATA___LAYER;
using ENTITY___LAYER;

namespace BUSINESS___LAYER
{
    public class Class_Business_Dashboard
    {
        private Class_Data_Dashboard Obj_Class_Data_Dashboard = new Class_Data_Dashboard();

        public Class_Entity_Dashboard Class_Business_See_Dashboard()
        {
            return Obj_Class_Data_Dashboard.Class_Data_See_Dashboard();
        }
    }
}