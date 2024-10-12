using System.Collections.Generic;
using DATA___LAYER;
using ENTITY___LAYER;

namespace BUSINESS___LAYER
{
    public class Class_Business_Insumo
    {
        private Class_Data_Insumo Obj_Class_Data_Insumo = new Class_Data_Insumo();

        public List<Class_Entity_Insumo> Class_Business_Insumo_Listar()
        {
            return Obj_Class_Data_Insumo.Class_Data_Insumo_Listar();
        }

        public int Class_Business_Insumo_Registrar(Class_Entity_Insumo Obj_Class_Entity_Insumo, out string Message)
        {
            Message = string.Empty;
            if (Obj_Class_Entity_Insumo.Object_ID_Categoria_Insumo.ID_Categoria_Insumo == 0)
            {
                Message = "Campo Requerido: Categoría del Insumo";
            }
            else
            {
                if (Obj_Class_Entity_Insumo.Object_ID_Proveedor_Insumo.ID_Proveedor_Insumo == 0)
                {
                    Message = "Campo Requerido: Proveedor del Insumo";
                }
                else
                {
                    if (string.IsNullOrEmpty(Obj_Class_Entity_Insumo.Nombre_Insumo) || string.IsNullOrWhiteSpace(Obj_Class_Entity_Insumo.Nombre_Insumo))
                    {
                        Message = "Campo Requerido: Nombre del Insumo";
                    }
                    else
                    {
                        if (string.IsNullOrEmpty(Obj_Class_Entity_Insumo.Descripcion_Insumo) || string.IsNullOrWhiteSpace(Obj_Class_Entity_Insumo.Descripcion_Insumo))
                        {
                            Message = "Campo Requerido: Descripción del Insumo";
                        }
                        else
                        {
                            if (string.IsNullOrEmpty(Obj_Class_Entity_Insumo.Unidad_Medida_Insumo) || string.IsNullOrWhiteSpace(Obj_Class_Entity_Insumo.Unidad_Medida_Insumo))
                            {
                                Message = "Campo Requerido: Unidad de Medida del Insumo";
                            }
                            else
                            {
                                if (Obj_Class_Entity_Insumo.Precio_Insumo <= 0)
                                {
                                    Message = "Campo Requerido: Precio del Insumo";
                                }
                                else
                                {
                                    if (Obj_Class_Entity_Insumo.Stock_Insumo < 0)
                                    {
                                        Message = "Campo Requerido: Stock del Insumo";
                                    }
                                    else
                                    {
                                        if (string.IsNullOrEmpty(Obj_Class_Entity_Insumo.Fecha_Vencimiento_Insumo) || string.IsNullOrWhiteSpace(Obj_Class_Entity_Insumo.Fecha_Vencimiento_Insumo))
                                        {
                                            Message = "Campo Requerido: Fecha de Vencimiento del Insumo";
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            if (string.IsNullOrEmpty(Message))
            {
                return Obj_Class_Data_Insumo.Class_Data_Insumo_Registrar(Obj_Class_Entity_Insumo, out Message);
            }
            else
            {
                return 0;
            }
        }

        public bool Class_Business_Insumo_Editar(Class_Entity_Insumo Obj_Class_Entity_Insumo, out string Message)
        {
            Message = string.Empty;
            if (Obj_Class_Entity_Insumo.Object_ID_Categoria_Insumo.ID_Categoria_Insumo == 0)
            {
                Message = "Campo Requerido: Categoría del Insumo";
            }
            else
            {
                if (Obj_Class_Entity_Insumo.Object_ID_Proveedor_Insumo.ID_Proveedor_Insumo == 0)
                {
                    Message = "Campo Requerido: Proveedor del Insumo";
                }
                else
                {
                    if (string.IsNullOrEmpty(Obj_Class_Entity_Insumo.Nombre_Insumo) || string.IsNullOrWhiteSpace(Obj_Class_Entity_Insumo.Nombre_Insumo))
                    {
                        Message = "Campo Requerido: Nombre del Insumo";
                    }
                    else
                    {
                        if (string.IsNullOrEmpty(Obj_Class_Entity_Insumo.Descripcion_Insumo) || string.IsNullOrWhiteSpace(Obj_Class_Entity_Insumo.Descripcion_Insumo))
                        {
                            Message = "Campo Requerido: Descripción del Insumo";
                        }
                        else
                        {
                            if (string.IsNullOrEmpty(Obj_Class_Entity_Insumo.Unidad_Medida_Insumo) || string.IsNullOrWhiteSpace(Obj_Class_Entity_Insumo.Unidad_Medida_Insumo))
                            {
                                Message = "Campo Requerido: Unidad de Medida del Insumo";
                            }
                            else
                            {
                                if (Obj_Class_Entity_Insumo.Precio_Insumo <= 0)
                                {
                                    Message = "Campo Requerido: Precio del Insumo";
                                }
                                else
                                {
                                    if (Obj_Class_Entity_Insumo.Stock_Insumo < 0)
                                    {
                                        Message = "Campo Requerido: Stock del Insumo";
                                    }
                                    else
                                    {
                                        if (string.IsNullOrEmpty(Obj_Class_Entity_Insumo.Fecha_Vencimiento_Insumo) || string.IsNullOrWhiteSpace(Obj_Class_Entity_Insumo.Fecha_Vencimiento_Insumo))
                                        {
                                            Message = "Campo Requerido: Fecha de Vencimiento del Insumo";
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            if (string.IsNullOrEmpty(Message))
            {
                return Obj_Class_Data_Insumo.Class_Data_Insumo_Editar(Obj_Class_Entity_Insumo, out Message);
            }
            else
            {
                return false;
            }
        }

        public bool Class_Business_Insumo_Registrar_Imagen(Class_Entity_Insumo Obj_Class_Entity_Insumo, out string Message)
        {
            return Obj_Class_Data_Insumo.Class_Data_Insumo_Registrar_Imagen(Obj_Class_Entity_Insumo, out Message);
        }

        public bool Class_Business_Insumo_Eliminar(int ID_Insumo, out string Message)
        {
            return Obj_Class_Data_Insumo.Class_Data_Insumo_Eliminar(ID_Insumo, out Message);
        }
    }
}