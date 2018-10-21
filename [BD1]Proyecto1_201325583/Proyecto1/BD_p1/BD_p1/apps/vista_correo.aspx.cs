using Datos;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BD_p1.apps
{
    public partial class vista_correo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["cuenta"] != null)
            {
                string[] msg = (string[])Session["msg"];
                //cambiar de estado al mensaje
                Mensaje.cambiarEstado(1, Convert.ToInt32(msg[0]));
                //ahora realizar el query para todo el mensaje
                string[] mensaje = Usuario.vista_correo(Convert.ToInt32(msg[0])); //tam 9
                et_asunto.Text = mensaje[6];

                string mostrar = "De: " + mensaje[8] + "\n";
                if (mensaje[3].Equals("para") || mensaje[3].Equals("cc"))
                {
                    mostrar += "Para: " + mensaje[5] + "\n";
                }
                mostrar += mensaje[1] + "\n\n";
                mostrar += mensaje[7] + "\n\n\n\nArchivos:\n";
                

                List<string> archivos = Mensaje.getArchivos(Convert.ToInt32(mensaje[4]));
                if (archivos != null)
                {
                    for (int i = 0; i < archivos.Count; i++)
                    {
                        DirectoryInfo di = new DirectoryInfo(archivos[i]);
                        mostrar += di.Name + "\n";
                    }
                }

                txt_texto.Text = mostrar;
            }
        }
    }
}