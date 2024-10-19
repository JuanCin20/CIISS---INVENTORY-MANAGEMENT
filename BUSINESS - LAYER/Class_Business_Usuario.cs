using System.Collections.Generic;
using DATA___LAYER;
using ENTITY___LAYER;

namespace BUSINESS___LAYER
{
    public class Class_Business_Usuario
    {
        private Class_Data_Usuario Obj_Class_Data_Usuario = new Class_Data_Usuario();

        public List<Class_Entity_Usuario> Class_Business_Usuario_Listar()
        {
            return Obj_Class_Data_Usuario.Class_Data_Usuario_Listar();
        }

        public int Class_Business_Usuario_Registrar(Class_Entity_Usuario Obj_Class_Entity_Usuario, out string Message)
        {
            Message = string.Empty;
            if (string.IsNullOrEmpty(Obj_Class_Entity_Usuario.Nombre_Usuario) || string.IsNullOrWhiteSpace(Obj_Class_Entity_Usuario.Nombre_Usuario))
            {
                Message = "Error: Nombre_Usuario";
            }
            else
            {
                if (string.IsNullOrEmpty(Obj_Class_Entity_Usuario.Apellido_Usuario) || string.IsNullOrWhiteSpace(Obj_Class_Entity_Usuario.Apellido_Usuario))
                {
                    Message = "Error: Apellido_Usuario";
                }
                else
                {
                    if (string.IsNullOrEmpty(Obj_Class_Entity_Usuario.E_Mail_Usuario) || string.IsNullOrWhiteSpace(Obj_Class_Entity_Usuario.E_Mail_Usuario))
                    {
                        Message = "Error: E_Mail_Usuario";
                    }
                }
            }

            if (string.IsNullOrEmpty(Message))
            {
                string Password_Usuario = Class_Business_Recurso.Generate_Password();
                string E_Mail_Topic = "Registro de Cuenta";
                string E_Mail_Message = "<div style=\"display: flex; flex-direction: column; align-items: center; gap: 5px; background-color: rgb(148, 148, 148);\" class=\"Container\">\r\n        <div style=\"width: 100%; background-color: rgb(35, 10, 145);\" class=\"Sub_Container_01\">\r\n            <h1 style=\"text-align: center; color: rgb(255, 255, 255); font-family: 'Lucida Console', 'Courier New', monospace;\">Sistema de Inventario</h1>\r\n        </div>\r\n        <div class=\"Sub_Container_02\">\r\n            <div style=\"text-align: center;\" class=\"Image_Container\">\r\n                <img style=\"width: 250px; height: 250px;\" src=\"https://cdn-icons-png.flaticon.com/256/10996/10996271.png\" alt=\"Image_Error\">\r\n            </div>\r\n        </div>\r\n        <div style=\"width: 100%; background-color: rgb(0, 0, 0);\" class=\"Sub_Container_03\">\r\n            <h2 style=\"text-align: center; color: rgb(255, 255, 255); font-family: 'Lucida Console', 'Courier New', monospace;\">Su Cuenta ha sido Registrada Exitosamente</h2>\r\n            <p style=\" text-align: center; color: rgb(255, 0, 0); font-family: 'Lucida Console' , 'Courier New' , monospace;\">Su Contraseña de Acceso es: !Password_Usuario!</p>\r\n            <hr>\r\n            <h5 style=\"text-align: center; color: rgb(255, 255, 255); font-family: 'Lucida Console', 'Courier New', monospace;\">© 2024 Tec-Samples</h5>\r\n        </div>\r\n    </div>";
                E_Mail_Message = E_Mail_Message.Replace("!Password_Usuario!", Password_Usuario);

                bool Result = Class_Business_Recurso.Send_E_Mail(Obj_Class_Entity_Usuario.E_Mail_Usuario, E_Mail_Topic, E_Mail_Message);

                if (Result)
                {
                    Obj_Class_Entity_Usuario.Password_Usuario = Class_Business_Recurso.Convert_SHA_256(Password_Usuario);
                    return Obj_Class_Data_Usuario.Class_Data_Usuario_Registrar(Obj_Class_Entity_Usuario, out Message);
                }
                else
                {
                    Message = "Error: E_Mail_Usuario";
                    return 0;
                }
            }
            else
            {
                return 0;
            }
        }

        public bool Class_Business_Usuario_Change_Password(int ID_Usuario, string New_Password_Usuario, out string Message)
        {
            return Obj_Class_Data_Usuario.Class_Data_Usuario_Change_Password(ID_Usuario, New_Password_Usuario, out Message);
        }

        public bool Class_Business_Usuario_Reset_Password(int ID_Usuario, string E_Mail_Usuario, out string Message)
        {
            Message = string.Empty;
            string Password_Usuario = Class_Business_Recurso.Generate_Password();
            bool Result = Obj_Class_Data_Usuario.Class_Data_Usuario_Reset_Password(ID_Usuario, Class_Business_Recurso.Convert_SHA_256(Password_Usuario), out Message);

            if (Result)
            {
                string E_Mail_Topic = "Contraseña Reestablecida";
                string E_Mail_Message = "<div style=\"display: flex; flex-direction: column; align-items: center; gap: 5px; background-color: rgb(148, 148, 148);\" class=\"Container\">\r\n        <div style=\"width: 100%; background-color: rgb(35, 10, 145);\" class=\"Sub_Container_01\">\r\n            <h1 style=\"text-align: center; color: rgb(255, 255, 255); font-family: 'Lucida Console', 'Courier New', monospace;\">Sistema de Inventario</h1>\r\n        </div>\r\n        <div class=\"Sub_Container_02\">\r\n            <div style=\"text-align: center;\" class=\"Image_Container\">\r\n                <img style=\"width: 250px; height: 250px;\" src=\"https://cdn-icons-png.flaticon.com/256/10996/10996271.png\" alt=\"Image_Error\">\r\n            </div>\r\n        </div>\r\n        <div style=\"width: 100%; background-color: rgb(0, 0, 0);\" class=\"Sub_Container_03\">\r\n            <h2 style=\"text-align: center; color: rgb(255, 255, 255); font-family: 'Lucida Console', 'Courier New', monospace;\">Su Cuenta ha sido Recuperada Exitosamente</h2>\r\n            <p style=\" text-align: center; color: rgb(255, 0, 0); font-family: 'Lucida Console' , 'Courier New' , monospace;\">Su Nueva Contraseña de Acceso es: !Password_Usuario!</p>\r\n            <hr>\r\n            <h5 style=\"text-align: center; color: rgb(255, 255, 255); font-family: 'Lucida Console', 'Courier New', monospace;\">© 2024 Tec-Samples</h5>\r\n        </div>\r\n    </div>";
                E_Mail_Message = E_Mail_Message.Replace("!Password_Usuario!", Password_Usuario);

                bool Result_Alter = Class_Business_Recurso.Send_E_Mail(E_Mail_Usuario, E_Mail_Topic, E_Mail_Message);

                if (Result_Alter)
                {
                    return true;
                }
                else
                {
                    Message = "Error: E_Mail_Usuario";
                    return false;
                }
            }
            else
            {
                Message = "Error: Password_Usuario";
                return false;
            }
        }

        public bool Class_Business_Usuario_Editar(Class_Entity_Usuario Obj_Class_Entity_Usuario, out string Message)
        {
            Message = string.Empty;
            if (string.IsNullOrEmpty(Obj_Class_Entity_Usuario.Nombre_Usuario) || string.IsNullOrWhiteSpace(Obj_Class_Entity_Usuario.Nombre_Usuario))
            {
                Message = "Error: Nombre_Usuario";
            }
            else
            {
                if (string.IsNullOrEmpty(Obj_Class_Entity_Usuario.Apellido_Usuario) || string.IsNullOrWhiteSpace(Obj_Class_Entity_Usuario.Apellido_Usuario))
                {
                    Message = "Error: Apellido_Usuario";
                }
                else
                {
                    if (string.IsNullOrEmpty(Obj_Class_Entity_Usuario.E_Mail_Usuario) || string.IsNullOrWhiteSpace(Obj_Class_Entity_Usuario.E_Mail_Usuario))
                    {
                        Message = "Error: E_Mail_Usuario";
                    }
                }
            }

            if (string.IsNullOrEmpty(Message))
            {
                return Obj_Class_Data_Usuario.Class_Data_Usuario_Editar(Obj_Class_Entity_Usuario, out Message);
            }
            else
            {
                return false;
            }
        }

        public bool Class_Business_Usuario_Registrar_Imagen(Class_Entity_Usuario Obj_Class_Entity_Usuario, out string Message)
        {
            return Obj_Class_Data_Usuario.Class_Data_Usuario_Registrar_Imagen(Obj_Class_Entity_Usuario, out Message);
        }

        public bool Class_Business_Usuario_Eliminar(int ID_Usuario, out string Message)
        {
            return Obj_Class_Data_Usuario.Class_Data_Usuario_Eliminar(ID_Usuario, out Message);
        }
    }
}