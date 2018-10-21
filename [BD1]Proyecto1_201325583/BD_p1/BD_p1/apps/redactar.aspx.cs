using Datos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BD_p1.apps
{
    public partial class redactar : System.Web.UI.Page
    {
        private string username = "";
        private string dominio = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuario"] != null)
            {
                username = Session["usuario"].ToString();
                char[] d = { '@' };
                char[] a = { '.' };
                string[] tmp = Session["cuenta"].ToString().Split(d, StringSplitOptions.RemoveEmptyEntries);
                string[] aux = tmp[1].Split(a);
                dominio = aux[0];
            }
        }

        protected void lb_enviar_Click(object sender, EventArgs e)
        {
            //pasos para enviar correo
            /**
             * 1. Realizar una separacion de correos con (,)
             * 2. Validar si el correo que se ingreso es de un patron correcto y si existe en la base de datos
             * 3. Si es correcto crear el mensaje
             * 4. Enviar el mensaje a cada uno de los correos que existe
             * 5. Asignar los archivos adjuntos
             * 6. Asignar el mensaje como enviado del usuario que este en inicio de sesion
             * */

            //PASO 1
            char[] delimit = { ',' };
            string[] spl_para = txt_para.Text.Split(delimit, StringSplitOptions.RemoveEmptyEntries);
            string[] spl_cc = txt_cc.Text.Split(delimit, StringSplitOptions.RemoveEmptyEntries);
            string[] spl_bcc = txt_bcc.Text.Split(delimit, StringSplitOptions.RemoveEmptyEntries);
            
            //PASO 2
            if (spl_para.Length > 0 || spl_cc.Length > 0 || spl_bcc.Length > 0)
            {
                if (usuarios_validos(spl_para) || usuarios_validos(spl_cc) || usuarios_validos(spl_bcc))
                {
                    //PASO 3
                    int codMsg = Mensaje.crear_mensaje(txt_asunto.Text, txt_texto.Text);
                    //PASO 4
                    enviarA(spl_para, codMsg, "to");
                    enviarA(spl_cc, codMsg, "cc");
                    enviarA(spl_bcc, codMsg, "bcc");
                    //PASO 5
                    string[] pArchivos = new string[adjuntar.PostedFiles.Count];
                    if (adjuntar.HasFiles)
                    {
                        string fn = string.Empty;
                        for (int i = 0; i < adjuntar.PostedFiles.Count; i++)
                        {
                            fn = System.IO.Path.GetFileName(adjuntar.PostedFiles[i].FileName);
                            adjuntar.SaveAs("C:\\ArchivosAdjunto\\" + fn);
                            //asignando los archivos adjuntos al mensaje
                            Mensaje.asignar_archivo(codMsg, "C:\\ArchivosAdjunto\\" + fn);
                        }
                    }
                    //PASO 6
                    int cod_carpeta = Usuario.buscar_carpeta("enviados", username, "", 0);
                    
                    int dia = DateTime.Now.Day;
                    int mes = DateTime.Now.Month;
                    int year = DateTime.Now.Year;
                    int hora = DateTime.Now.Hour;
                    int min = DateTime.Now.Minute;
                    int seg = DateTime.Now.Second;
                    
                    string fecha = getFecha(dia, mes, year, hora, min, seg);
                    Mensaje.asignar_mensaje("to", fecha, codMsg, cod_carpeta, null);

                    _default.MessageBox("Mensaje enviado", Page, this.GetType());
                    this.txt_para.Text = "";
                    this.txt_cc.Text = "";
                    this.txt_bcc.Text = "";
                    this.txt_asunto.Text = "";
                    this.txt_texto.Text = "";
                }
                else
                {
                    _default.MessageBox("Probleams al enviar correo a usuario que no existe", Page, this.GetType());
                }
            }
            else
            {
                _default.MessageBox("Correo no enviado", Page, this.GetType());
            }
        }

        public bool usuarios_validos(string[] correos)
        {
            Regex rex = new Regex("^[_a-z0-9-]+(.[_a-z0-9-]+)*@[a-z0-9-]+(.[a-z0-9-]+)*(.[a-z]{2,4})$");
            char[] delimit_ = { '@' };
            char[] delimit = { '.' };
            bool existe = false;
            for (int i = 0; (i < correos.Length) && !existe; i++)
            {
                if (rex.IsMatch(correos[i]))
                {
                    string[] usr = correos[i].Split(delimit_, StringSplitOptions.RemoveEmptyEntries);
                    string[] dom = usr[1].Split(delimit, StringSplitOptions.RemoveEmptyEntries);
                    existe = Usuario.correo_existe(usr[0], dom[0]);
                    if (existe) { return existe; }
                }
            }
            return existe;
        }

        private void enviarA(string[] correos, int mensaje, string tipo_envio)
        {
            char[] delimit_ = { '@' };
            for (int i = 0; i < correos.Length; i++)
            {
                //usuario@dominio.com
                //descomponer para tener el usuario y dominio del correo
                string[] usr = correos[i].Split(delimit_, StringSplitOptions.RemoveEmptyEntries);
                //ahora el usuario esta en usr[0], dominio esta en dom[0]
                //ahora buscar la carpeta entrada del usuario en la raiz nivel 0
                int cod_carpeta = Usuario.buscar_carpeta("entrada", usr[0], "", 0);
                //tipo_envio
                //fecha
                //codigo mensaje
                //codigo carpeta
                //cuenta del usuario de quien se lo envia
                int dia = DateTime.Now.Day;
                int mes = DateTime.Now.Month;
                int year = DateTime.Now.Year;
                int hora = DateTime.Now.Hour;
                int min = DateTime.Now.Minute;
                int seg = DateTime.Now.Second;
                
                string fecha = getFecha(dia, mes, year, hora, min, seg);
                Mensaje.asignar_mensaje(tipo_envio, fecha, mensaje, cod_carpeta, username);
            }
        }

        private string getFecha(int dia, int mes, int year, int hora, int min, int seg)
        {
            string fecha = year.ToString() + "-";
            if (mes < 10)
            {
                fecha += "0" + mes.ToString() + "-";
            }
            else
            {
                fecha += mes.ToString() + "-";
            }
            if (dia < 10)
            {
                fecha += "0" + dia.ToString() + "T";
            }
            else
            {
                fecha += dia.ToString() + "T";
            }
            if (hora < 10)
            {
                fecha += "0" + hora.ToString() + ":";
            }
            else
            {
                fecha += hora.ToString() + ":";
            }
            if (min < 10)
            {
                fecha += "0" + min.ToString() + ":";
            }
            else
            {
                fecha += min.ToString() + ":";
            }
            if (seg < 10)
            {
                fecha += "0" + seg.ToString();
            }
            else
            {
                fecha += seg.ToString();
            }
            return fecha;
        }

        protected void lb_guardar_Click(object sender, EventArgs e)
        {
            /**
             * Para guardar el correo que se iba a mandar seguir los pasos
             * 1. Crear mensaje
             * 2. Asignarle los archivos adjuntos
             * 3. buscar la carpeta borradores del usuario
             * 4. asignarle el mensaje
             * */
            char[] delimit = { ',' };
            string[] spl_para = txt_para.Text.Split(delimit, StringSplitOptions.RemoveEmptyEntries);
            string[] spl_cc = txt_cc.Text.Split(delimit, StringSplitOptions.RemoveEmptyEntries);
            string[] spl_bcc = txt_bcc.Text.Split(delimit, StringSplitOptions.RemoveEmptyEntries);
            
            //Verificar si por lo menos hay un correo 
            if (spl_para.Length > 0 || spl_cc.Length > 0 || spl_bcc.Length > 0)
            {
                //PASO 1
                int codMsg = Mensaje.crear_mensaje(txt_asunto.Text, txt_texto.Text);
                //PASO 2
                string[] pArchivos = new string[adjuntar.PostedFiles.Count];
                if (adjuntar.HasFiles)
                {
                    string fn = string.Empty;
                    for (int i = 0; i < adjuntar.PostedFiles.Count; i++)
                    {
                        fn = System.IO.Path.GetFileName(adjuntar.PostedFiles[i].FileName);
                        adjuntar.SaveAs("C:\\ArchivosAdjunto\\" + fn);
                        //asignando los archivos adjuntos al mensaje
                        Mensaje.asignar_archivo(codMsg, "C:\\ArchivosAdjunto\\" + fn);
                    }
                }
                //PASO 3
                int cod_carpeta = Usuario.buscar_carpeta("borradores", username, "", 0);

                int dia = DateTime.Now.Day;
                int mes = DateTime.Now.Month;
                int year = DateTime.Now.Year;
                int hora = DateTime.Now.Hour;
                int min = DateTime.Now.Minute;
                int seg = DateTime.Now.Second;
                //PASO 4
                string fecha = getFecha(dia, mes, year, hora, min, seg);
                Mensaje.asignar_mensaje("to", fecha, codMsg, cod_carpeta, null);

                _default.MessageBox("Mensaje guardado en borradores", Page, this.GetType());
                Response.Redirect("usuario.aspx");
            }
        }
    }
}