using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace P2
{
    public partial class administrador : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void btn_image_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("administrador.aspx");
        }
    }
}