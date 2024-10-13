using System.Net.Mail;
using System.Net;
using System.Security.Cryptography;
using System.Text;
using System;
using System.IO;

namespace BUSINESS___LAYER
{
    public class Class_Business_Recurso
    {
        public static string Generate_Password()
        {
            string Usuario_Password = Guid.NewGuid().ToString("N").Substring(0, 6);
            return Usuario_Password;
        }

        // * Encriptación de Texto
        public static string Convert_SHA_256(string Password_Usuario)
        {
            StringBuilder Obj_StringBuilder = new StringBuilder();

            // * Usar la Referencia de "System.Security.Cryptography"
            using (SHA256 Obj_SHA256 = SHA256Managed.Create())
            {
                Encoding Obj_Encoding = Encoding.UTF8;
                byte[] Result = Obj_SHA256.ComputeHash(Obj_Encoding.GetBytes(Password_Usuario));

                foreach (byte Obj_byte in Result)
                    Obj_StringBuilder.Append(Obj_byte.ToString("x2"));
            }
            return Obj_StringBuilder.ToString();
        }

        public static bool Send_E_Mail(string E_Mail_Usuario, string E_Mail_Topic, string E_Mail_Message)
        {
            bool Result = false;
            try
            {
                MailMessage Obj_MailMessage = new MailMessage();
                Obj_MailMessage.To.Add(E_Mail_Usuario);
                Obj_MailMessage.From = new MailAddress("JuanCin080604@gmail.com");
                Obj_MailMessage.Subject = E_Mail_Topic;
                Obj_MailMessage.Body = E_Mail_Message;
                Obj_MailMessage.IsBodyHtml = true;
                var Simple_Mail_Transfer_Protocol = new SmtpClient()
                {
                    Credentials = new NetworkCredential("JuanCin080604@gmail.com", "bjsp vvjc setz tsuv"),
                    Host = "smtp.gmail.com",
                    Port = 587,
                    EnableSsl = true
                };
                Simple_Mail_Transfer_Protocol.Send(Obj_MailMessage);
                Result = true;
            }
            catch (Exception Error)
            {
                Result = false;
                Console.WriteLine(Error.Message);
            }
            return Result;
        }

        public static string Convert_Base_64(string Ruta_Imagen, out bool Conversion)
        {
            string Base_64 = string.Empty;
            Conversion = true;
            try
            {
                byte[] Bytes = File.ReadAllBytes(Ruta_Imagen);
                Base_64 = Convert.ToBase64String(Bytes);
            }
            catch (Exception Error)
            {
                Conversion = false;
                Console.WriteLine(Error.Message);
            }
            return Base_64;
        }
    }
}