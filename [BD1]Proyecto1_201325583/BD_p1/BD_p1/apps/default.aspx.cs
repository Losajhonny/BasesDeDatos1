using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Datos;
using System.Text;
using System.Text.RegularExpressions;

namespace BD_p1.apps
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_registrar_Click(object sender, EventArgs e)
        {
            Response.Redirect("registrar.aspx");
        }

        protected void btn_login_Click(object sender, EventArgs e)
        {
            Regex rex = new Regex("^[_a-z0-9-]+(.[_a-z0-9-]+)*@[a-z0-9-]+(.[a-z0-9-]+)*(.[a-z]{2,4})$");
            string log = Usuario.logear(this.txt_usuario.Text, this.txt_password.Text);
            if (log != null && rex.IsMatch(txt_usuario.Text))
            {
                Session["usuario"] = log;
                Session["cuenta"] = txt_usuario.Text;
                Response.Redirect("usuario.aspx");
            }
            else
            {
                //string m = "<h1><font size=1 color=black>Usuario o password incorrecto</font></h1>";
                //HttpContext.Current.Response.Write(m);
                string message = "Usuario o password incorrecto";
                MessageBox(message, Page, this.GetType());
            }
        }

        public static void MessageBox(string message, Page pag, Type obj)
        {
            ScriptManager.RegisterStartupScript(pag, obj, "IDMessageBox", "window.alert('" + message.Replace("<br>", "\\n").Replace("'", "\\'") + "')", true);
        }

         public void RegisterAlertScript(String sText)
        {
            String csname1 = "PopupScript" + DateTime.Now;
            Type cstype = this.GetType();
            Page page = HttpContext.Current.Handler as Page;
            ClientScriptManager cs = page.ClientScript;
            if (!cs.IsStartupScriptRegistered(cstype, csname1))
            {
                StringBuilder cstext1 = new StringBuilder();
                cstext1.Append("<script type=text/javascript> alert('" + sText + "') </");
                cstext1.Append("script>");
                cs.RegisterStartupScript(cstype, csname1, cstext1.ToString());
            }
        }
    }
}