namespace ENTITY___LAYER
{
    public class Class_Entity_Usuario
    {
        public int ID_Usuario { get; set; }
        public Class_Entity_Tipo_Usuario Object_ID_Tipo_Usuario { get; set; }
        public string Nombre_Usuario { get; set; }
        public string Apellido_Usuario { get; set; }
        public string E_Mail_Usuario { get; set; }
        public string Password_Usuario { get; set; }
        public bool Reestablecer_Password_Usuario { get; set; }
        public string Ruta_Imagen_Usuario { get; set; }
        public string Nombre_Imagen_Usuario { get; set; }
        public string Base_64_Imagen_Usuario { get; set; } // ?
        public string Extension_Imagen_Usuario { get; set; } // ?
    }
}