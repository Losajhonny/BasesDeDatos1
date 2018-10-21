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
            if (Session["cuenta"] != null)
            {
                string[] credencial = obtener_credencial(Session["cuenta"].ToString());
                username = credencial[0];
                dominio = credencial[1];
            }
        }

        protected void lb_enviar_Click(object sender, EventArgs e)
        {
            enviarMsg();
        }

        protected void lb_guardar_Click(object sender, EventArgs e)
        {
            guardarMsg();
        }
        
        public void adjuntar_archivos(int mensaje)
        {
            string[] pArchivos = new string[adjuntar.PostedFiles.Count];
            if (adjuntar.HasFiles)
            {
                string fn = string.Empty;
                for (int i = 0; i < adjuntar.PostedFiles.Count; i++)
                {
                    fn = System.IO.Path.GetFileName(adjuntar.PostedFiles[i].FileName);
                    adjuntar.SaveAs("C:\\ArchivosAdjunto\\" + fn);
                    //asignando los archivos adjuntos al mensaje
                    Mensaje.asignar_archivo(mensaje, "C:\\ArchivosAdjunto\\" + fn);
                }
            }
        }

        public string obtener_fecha()
        {
            int dia = DateTime.Now.Day;
            int mes = DateTime.Now.Month;
            int year = DateTime.Now.Year;
            int hora = DateTime.Now.Hour;
            int min = DateTime.Now.Minute;
            int seg = DateTime.Now.Second;

            string fecha = getFecha(dia, mes, year, hora, min, seg);
            return fecha;
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

        public static string[] obtener_credencial(string correo)
        {
            char[] a = { '@' };
            char[] p = { '.' };
            string[] credencial = new string[2];
            string[] usr = correo.Split(a, StringSplitOptions.RemoveEmptyEntries);
            string[] dom = usr[1].Split(p, StringSplitOptions.RemoveEmptyEntries);
            credencial[0] = usr[0];
            credencial[1] = dom[0];
            return credencial;
        }

        public string[] obtener_lista_correos(string correos)
        {
            char[] c = { ',' };
            string[] lista = correos.Split(c, StringSplitOptions.RemoveEmptyEntries);
            return lista;
        }

        public bool existen_correo(string[] credencial)
        {
            bool existe = Usuario.existe_correo(credencial[0], credencial[1]);
            return existe;
        }

        public bool usuarios_validos(string[] correos)
        {
            Regex rex = new Regex("^[_a-z0-9-]+(.[_a-z0-9-]+)*@[a-z0-9-]+(.[a-z0-9-]+)*(.[a-z]{2,4})$");
            bool esValido = false;
            for (int i = 0; i < correos.Length; i++)
            {
                if (rex.IsMatch(correos[i]))
                {
                    esValido = existen_correo(obtener_credencial(correos[i]));
                    if (esValido) { return esValido; }
                }
            }
            return esValido;
        }

        public void enviarMsg()
        {
            string[] para = obtener_lista_correos(txt_para.Text.Replace(" ", ""));
            string[] cc = obtener_lista_correos(txt_cc.Text.Replace(" ", ""));
            string[] bcc = obtener_lista_correos(txt_bcc.Text.Replace(" ", ""));

            if (usuarios_validos(para) || usuarios_validos(cc) || usuarios_validos(bcc))
            {
                int mensaje = Mensaje.crear_mensaje(txt_asunto.Text, txt_texto.Text);
                //asignacion del mensaje para los correos
                enviar_mensaje(para, "entrada", "para", mensaje, txt_para.Text.Replace(" ", ""));
                enviar_mensaje(cc, "entrada", "cc", mensaje, txt_cc.Text.Replace(" ", ""));
                enviar_mensaje(bcc, "entrada", "bcc", mensaje, txt_bcc.Text.Replace(" ", ""));
                //adjuntar los archivos
                adjuntar_archivos(mensaje);
                //ahora enviar a la carpeta de enviados
                string[] correo = { username + "@" + dominio + ".com" };

                //en enviados la lista es la union de todas las listas
                string lista_enviados = txt_para.Text.Replace(" ", "") + "," + txt_cc.Text.Replace(" ", "")
                    + txt_bcc.Text.Replace(" ", "");
                enviar_mensaje(correo, "enviados", "para", mensaje, lista_enviados);
                _default.MessageBox("Mensaje enviado", Page, this.GetType());
                this.txt_para.Text = "";
                this.txt_cc.Text = "";
                this.txt_bcc.Text = "";
                this.txt_asunto.Text = "";
                this.txt_texto.Text = "";
            }
            else
            {
                _default.MessageBox("Hay usuarios que no existen o no son validos", Page, this.GetType());
            }
        }

        public void guardarMsg()
        {
            string[] para = obtener_lista_correos(txt_para.Text.Replace(" ", ""));
            string[] cc = obtener_lista_correos(txt_cc.Text.Replace(" ", ""));
            string[] bcc = obtener_lista_correos(txt_bcc.Text.Replace(" ", ""));
            if (usuarios_validos(para) || usuarios_validos(cc) || usuarios_validos(bcc)
                || !txt_asunto.Text.Equals("") || !txt_texto.Text.Equals("") || adjuntar.HasFiles)
            {
                int mensaje = Mensaje.crear_mensaje(txt_asunto.Text, txt_texto.Text);
                //adjunatar los archivos
                adjuntar_archivos(mensaje);
                string[] correo = { username + "@" + dominio + ".com" };

                string lista = "para:" + txt_para.Text.Replace(" ", "") + ";cc:" + txt_cc.Text.Replace(" ", "")
                    + ";bcc:" + txt_bcc.Text.Replace(" ", "");
                enviar_mensaje(correo, "borradores", "para", mensaje, lista);
                _default.MessageBox("Mensaje guardado en borradores", Page, this.GetType());
                this.txt_para.Text = "";
                this.txt_cc.Text = "";
                this.txt_bcc.Text = "";
                this.txt_asunto.Text = "";
                this.txt_texto.Text = "";
                Response.Redirect("usuario.aspx");
            }
            else
            {
                _default.MessageBox("Mensaje no se puede guardar", Page, this.GetType());
            }
        }

        //envia un mensaje a las carpetas que estan en la raiz
        public void enviar_mensaje(string[] correos, string nombre_carpeta, string tipo_envio, int mensaje, string lista)
        {
            for (int i = 0; i < correos.Length; i++)
            {
                string[] credencial = obtener_credencial(correos[i]);
                int carpeta = Carpeta.obtener_carpeta(nombre_carpeta, credencial[0], null, 0);
                string fecha = obtener_fecha();
                //obtener lista de correos
                Mensaje.asignar_mensaje(tipo_envio, fecha, mensaje, carpeta, username, lista);
            }
        }
    }
}